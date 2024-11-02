using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;

public partial class web_module_web_tracnghiem_vietnhatliencap_LamBaiLuyenTap_TuLuan : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int tongSoCau = 0, stt = 1;
    Random rnd = new Random();
    cls_Alert alert = new cls_Alert();
    private int hocsinh_id, test_id;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["PhuHuynhVietNhat"] != null)
        {
            string[] arrListStr = Request.Cookies["PhuHuynhVietNhat"].Value.Split(',');

            if (arrListStr[0] == "hocsinh")// nếu là học sinh đăng nhập
            {
                var checkHS = (from hs in db.tbHocSinhs
                               where hs.hocsinh_taikhoan == arrListStr[1]
                               select hs).Single();
                hocsinh_id = checkHS.hocsinh_id;
            }
            test_id = Convert.ToInt32(RouteData.Values["id_test"]);
            if (!IsPostBack)
            {

                var getData = from lt in db.tbTracNghiem_BaiLuyenTaps
                              join t in db.tbTracNghiem_Tests on lt.luyentap_id equals t.luyentap_id
                              where t.test_id == test_id
                              select new
                              {
                                  lt.luyentap_danhsachbai,
                                  lt.luyentap_tilecauhoi,
                                  t.test_thoigianlambai,
                                  t.test_soluongcauhoi,
                                  t.question_id,
                              };
                txtThoiGian.Value = getData.FirstOrDefault().test_thoigianlambai; // thời gian làm bài 
                //string[] arrIdAnswer = getData.FirstOrDefault().luyentap_danhsachbai.Split(',');
                //string[] arrRatio = getData.FirstOrDefault().luyentap_tilecauhoi.Split(';'); //40/40/30
                tongSoCau = Convert.ToInt32(getData.FirstOrDefault().test_soluongcauhoi);
                txtTongCauHoi.Value = tongSoCau + "";
                string[] arrQuestion = getData.FirstOrDefault().question_id.Split(',');
                var getDataDetails = from q in db.tbTracNghiem_Questions
                                     where arrQuestion.Contains(q.question_id + "")
                                     select new
                                     {
                                         q.question_id,
                                         question_content = q.question_content.Contains("style=") ? "<div class='content_image'>" + q.question_content + "</div>" : q.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("mp3") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content
                                     };
                rpCauHoi.DataSource = getDataDetails;
                rpCauHoi.DataBind();

            }
        }
        else
        {
            //string test_link = HttpContext.Current.Request.Url.PathAndQuery.Remove(0, 1);
            //Session["linktest"] = test_link; https://vjis.edu.vn/
            Response.Redirect("/login-account");
        }
    }
    protected void btnLuuKetQua_ServerClick(object sender, EventArgs e)
    {
        //int _idKhoi = Convert.ToInt32(RouteData.Values["id_khoi"]);
        var checkNamHoc = (from nh in db.tbHoctap_NamHocs orderby nh.namhoc_id descending select nh).First();
        var checkHocSinh = (from hs in db.tbHocSinhs
                            join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                            join l in db.tbLops on hstl.lop_id equals l.lop_id
                            where hs.hocsinh_id == hocsinh_id && hstl.namhoc_id == checkNamHoc.namhoc_id
                            orderby hstl.hstl_id descending
                            select new
                            {
                                hs.hocsinh_mahocphi,
                                hs.hocsinh_id,
                                l.lop_id,
                                hstl.hstl_id,
                            }).FirstOrDefault();

        tbTracNghiem_ResultTest insert = new tbTracNghiem_ResultTest();
        insert.resulttest_result = "0";
        insert.hocsinh_code = checkHocSinh.hocsinh_mahocphi;
        insert.resulttest_datetime = DateTime.Now;
        insert.test_id = Convert.ToInt32(RouteData.Values["id_test"]);
        insert.result_thoigianlambai = txtFinish.Value;
        insert.lop_id = checkHocSinh.lop_id;
        insert.hstl_id = checkHocSinh.hstl_id;
        insert.result_type = "bai luyen tap";
        insert.namhoc_id = checkNamHoc.namhoc_id;
        db.tbTracNghiem_ResultTests.InsertOnSubmit(insert);
        db.SubmitChanges();

        //var checkLink = (from t in db.tbTracNghiem_Tests
        //                 where t.test_id == test_id
        //                 select t.test_link_nopbai).FirstOrDefault();
        //if (checkLink != "zalo")
        //    Response.Redirect(checkLink);
        //else
        alert.alert_Success(Page, "Hoàn thành", "");
    }

}
