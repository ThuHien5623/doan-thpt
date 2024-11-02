using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_web_tracnghiem_web_LamBaiKiemTra : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int tongSoCau = 0;
    Random rnd = new Random();
    cls_Alert alert = new cls_Alert();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["HocSinh"] != null)
        {
            int seed = rnd.Next();
            //get ds câu hỏi trắc nghiệm
            var getDataDetails = from td in db.tbTracNghiem_TestDetails
                                 join q in db.tbTracNghiem_Questions
                                 on td.question_id equals q.question_id
                                 where td.test_id == Convert.ToInt32(RouteData.Values["id_test"])
                                 select new
                                 {
                                     td.question_id,
                                     noidungcauhoi = q.question_content.Contains("style=") ? "<div class='content_image'>" + q.question_content + "</div>" : q.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("mp3") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content,
                                     q.question_type,
                                 };
            if (getDataDetails.Any(x => x.question_type == "Trắc nghiệm"))
            {
                var listResult = getDataDetails.Where(x => x.question_type == "Trắc nghiệm").OrderBy(x => (~(x.question_id & seed)) & (x.question_id | seed));
                rpCauHoi.DataSource = listResult;
                rpCauHoi.DataBind();
                tongSoCau = listResult.Count();
                lbTitleFirst.Text = "I/ Trắc nghiệm";
                rpResult.DataSource = listResult;
                rpResult.DataBind();
            }
            if (getDataDetails.Any(x => x.question_type == "Tự luận"))
            {
                lbTitleSecond.Text = "II/ Tự luận";
                rpTuLuan.DataSource = getDataDetails.Where(x => x.question_type == "Tự luận").OrderBy(x => (~(x.question_id & seed)) & (x.question_id | seed));
                rpTuLuan.DataBind();
            }
            Session["linktest"] = "";
            var getThoiGian = (from test in db.tbTracNghiem_Tests
                               where test.test_id == Convert.ToInt32(RouteData.Values["id_test"])
                               select test).First();
            txtThoiGian.Value = getThoiGian.test_thoigianlambai;
        }
        else
        {
            string test_link = HttpContext.Current.Request.Url.PathAndQuery.Remove(0, 1);
            Session["linktest"] = test_link;
            Response.Redirect("/login-account");
        }
    }

    protected void rpCauHoi_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        int seed = rnd.Next();
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from t in db.tbTracNghiem_Answers
                               where t.question_id == question_id && t.answer_content != null
                               select new
                               {
                                   t.answer_id,
                                   t.answer_content,
                                   t.answer_true,
                                   t.question_id
                               };
        rpCauTraLoi.DataSource = getDataCauTraLoi.OrderBy(x => (~(x.answer_id & seed)) & (x.answer_id | seed));
        rpCauTraLoi.DataBind();
    }

    protected void btnLuuKetQua_ServerClick(object sender, EventArgs e)
    {
        var checkHocSinh = (from hs in db.tbHocSinhs
                            join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                            join l in db.tbLops on hstl.lop_id equals l.lop_id
                            where hs.hocsinh_code == Request.Cookies["HocSinh"].Value
                            orderby hstl.hstl_id descending
                            select new
                            {
                                hs.hocsinh_id,
                                l.lop_id,
                                hstl.hstl_id,
                            }).FirstOrDefault();

        tbTracNghiem_ResultTest insert = new tbTracNghiem_ResultTest();
        insert.resulttest_result = txtSoCauDung.Value;
        insert.hocsinh_code = Request.Cookies["HocSinh"].Value;
        insert.resulttest_datetime = DateTime.Now;
        insert.test_id = Convert.ToInt32(RouteData.Values["id_test"]);
        insert.result_thoigianlambai = txtFinish.Value;
        //insert.lop_id = Convert.ToInt32(RouteData.Values["id_khoi"]);
        insert.lop_id = checkHocSinh.lop_id;
        insert.hstl_id = checkHocSinh.hstl_id;
        insert.result_type = "bai thi";
        db.tbTracNghiem_ResultTests.InsertOnSubmit(insert);
        db.SubmitChanges();

        //khai báo biến chứa ds ID câu tl được checked
        string[] arrAnswerChecked = txtDSCauTraLoi.Value.Split(',');
        //khai báo biến chứa ds ID câu hỏi
        string[] arrQuestionID = txtDSCauHoi.Value.Split(',');
        string[] arrResult = txtResultChecked.Value.Split(',');
        for (int index = 0; index < arrQuestionID.Length; index++)
        {
            tbTracNghiem_ResultChiTiet insertDetail = new tbTracNghiem_ResultChiTiet();
            insertDetail.resulttest_id = insert.resulttest_id;
            insertDetail.question_id = Convert.ToInt32(arrQuestionID[index]);
            insertDetail.answer_true_id = (from t in db.tbTracNghiem_Answers
                                           where t.question_id == Convert.ToInt32(arrQuestionID[index]) && t.answer_true == true
                                           select t.answer_id).FirstOrDefault() + "";
            if (arrAnswerChecked[index] == "")
                insertDetail.answer_checked_id = "0";
            else
                insertDetail.answer_checked_id = arrAnswerChecked[index];
            if (arrResult[index] == "")
                insertDetail.answer_true = "False";
            else
                insertDetail.answer_true = arrResult[index];
            db.tbTracNghiem_ResultChiTiets.InsertOnSubmit(insertDetail);
            db.SubmitChanges();
        }
    }

    protected void btnExit_ServerClick(object sender, EventArgs e)
    {

        var getId = (from hs in db.tbHocSinhs
                     join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                     join l in db.tbLops on hstl.lop_id equals l.lop_id
                     where hs.hocsinh_code == Request.Cookies["HocSinh"].Value.ToLower()
                     orderby hstl.hstl_id descending
                     select l).FirstOrDefault();

        Response.Redirect("/trac-nghiem");
    }
}