using DevExpress.Web.ASPxHtmlEditor;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_TaoDeLuyenTapTuLuan : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    int question_id;
    public int STT = 1;
    public int STTT = 1;
    public int user_id;
    private static int _idKhoi;
    private static int _idMonHoc;
    string listID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {
            var checkTaiKhoan = (from u in db.admin_Users
                                 where u.username_username == Request.Cookies["UserName"].Value
                                 select u).FirstOrDefault();
            user_id = checkTaiKhoan.username_id;
            if (!IsPostBack)
            {
                var getkhoi = from ldt in db.tbKhois
                              join gvdk in db.tbGiaoVienDayKhois on ldt.khoi_id equals gvdk.khoi_id
                              where gvdk.username_id == checkTaiKhoan.username_id
                              select ldt;
                ddlKhoi.DataValueField = "khoi_id";
                ddlKhoi.DataTextField = "khoi_name";
                ddlKhoi.DataSource = getkhoi;
                ddlKhoi.DataBind();
                if (ddlKhoi.SelectedValue != "")
                {
                    var listMon = from gvdm in db.tbTKB_GiaoVienDayMon_Tests
                                  join m in db.tbTKB_Mons on gvdm.mon_id equals m.mon_id
                                  join l in db.tbLops on gvdm.lop_id equals l.lop_id
                                  where gvdm.username_id == user_id && gvdm.lop_id != null && l.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue)
                                  group gvdm by gvdm.mon_id into k
                                  select new
                                  {
                                      mon_id = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_id).FirstOrDefault(),
                                      mon_name = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_name).FirstOrDefault(),
                                  };
                    ddlMon.DataSource = listMon;
                    ddlMon.DataTextField = "mon_name";
                    ddlMon.DataValueField = "mon_id";
                    ddlMon.DataBind();
                }

            }
            getChuong();
            if (lkChuong.Text != "")
            {
                string _id = lkChuong.Text;
                string[] arrListStr = _id.Split(';');
                var list = from le in db.tbTracNghiem_Lessons
                           join ch in db.tbTracNghiem_Chapters on le.chapter_id equals ch.chapter_id
                           where ch.chapter_name == ""
                           && ch.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue)
                           && ch.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
                           //&& ch.hidden == false
                           select new
                           {
                               le.lesson_name,
                               le.lesson_id,
                               ch.chapter_id
                           };
                foreach (string item in arrListStr)
                {
                    var list1 = from le in db.tbTracNghiem_Lessons
                                join ch in db.tbTracNghiem_Chapters on le.chapter_id equals ch.chapter_id
                                where ch.chapter_name == item.ToString().Trim()
                                 && ch.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue)
                               && ch.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
                                //  orderby le.lesson_id ascending
                                //&& ch.hidden == false
                                select new
                                {
                                    le.lesson_name,
                                    le.lesson_id,
                                    ch.chapter_id
                                };
                    list = list.Union(list1);
                }
                //lkBai.DataSource = list.OrderBy(x => x.lesson_id);
                //lkBai.DataBind();
                rpLesson.DataSource = list.OrderBy(x => x.lesson_id);
                rpLesson.DataBind();
            }
            loadDataDe();
            //next page ds câu hỏi
            if (txtLessonID.Value != "")
            {
                string[] arrLesson = txtLessonID.Value.Split(',');
                var getQuestion = from gdtCH in db.tbTracNghiem_Questions
                                  join c in db.tbTracNghiem_Lessons on gdtCH.lesson_id equals c.lesson_id
                                  join ch in db.tbTracNghiem_Chapters on gdtCH.chapter_id equals ch.chapter_id
                                  where gdtCH.question_type == "Tự luận"
                                  && arrLesson.Contains(c.lesson_id + "")
                                  && ch.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue)
                                  && ch.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
                                  && gdtCH.hidden == false
                                  select new
                                  {
                                      gdtCH.question_id,
                                      gdtCH.question_dangcauhoi,
                                      gdtCH.question_level,
                                      question_content = gdtCH.question_content.Contains("style=") ?
                                                                         "<div class='content_image'>" + gdtCH.question_content + "</div>"
                                                                         : gdtCH.question_content.Contains("jpg") ?
                                                                         "<img class='tracnghiem-answer__image' src='" + gdtCH.question_content + "'>" :
                                                                         gdtCH.question_content.Contains("png") ?
                                                                         "<img class='tracnghiem-answer__image' src='" + gdtCH.question_content + "'>" :
                                                                         gdtCH.question_content.Contains("mp3") ? " <audio controls> <source src = '" + gdtCH.question_content + "'> </audio>" : gdtCH.question_content,
                                  };

                grvDanhSachCauHoi.DataSource = getQuestion;
                grvDanhSachCauHoi.DataBind();
            }
        }
        else
        {
            Response.Redirect("/admin-login");
        }
    }
    private void loadDataDe()
    {
        var getDe = from te in db.tbTracNghiem_Tests
                    join m in db.tbTKB_Mons on te.monhoc_id equals m.mon_id
                    join k in db.tbKhois on te.khoi_id equals k.khoi_id
                    join u in db.admin_Users on te.username_id equals u.username_id
                    join lt in db.tbTracNghiem_BaiLuyenTaps on te.luyentap_id equals lt.luyentap_id
                    where te.username_id == user_id && lt.luyentap_status == 2 && lt.luyentap_baitaptuluan == "luyện tập tự luận"
                    orderby te.test_id descending
                    select new
                    {
                        te.test_id,
                        te.test_createdate,
                        m.mon_name,
                        k.khoi_name,
                        te.test_link,
                        u.username_fullname,
                        lt.luyentap_name,
                        tinhtrang = te.hidden == false ? "Chưa hiển thị" : "Đã hiện thị"

                    };
        grvDeLuyenTap.DataSource = getDe;
        grvDeLuyenTap.DataBind();
    }
    private void getChuong()
    {
        if (ddlMon.SelectedValue != "")
        {
            var listChuDe = from c in db.tbTracNghiem_Chapters
                            where c.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue)
                            && c.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
                            select c;
            lkChuong.DataSource = listChuDe;
            lkChuong.DataBind();
        }
    }
    protected void ddlKhoi_SelectedIndexChanged(object sender, EventArgs e)
    {
        //var listChuDe = from c in db.tbTracNghiem_Chapters
        //                where c.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue)
        //                && c.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
        //                select c;
        //lkChuong.DataSource = listChuDe;
        //lkChuong.DataBind();

        //get ds môn học gv dạy của khối-lớp
        var listMon = from gvdm in db.tbTKB_GiaoVienDayMon_Tests
                      join m in db.tbTKB_Mons on gvdm.mon_id equals m.mon_id
                      join l in db.tbLops on gvdm.lop_id equals l.lop_id
                      where gvdm.username_id == user_id && gvdm.lop_id != null && l.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue)
                      group gvdm by gvdm.mon_id into k
                      select new
                      {
                          mon_id = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_id).FirstOrDefault(),
                          mon_name = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_name).FirstOrDefault(),
                      };
        ddlMon.DataSource = listMon;
        ddlMon.DataTextField = "mon_name";
        ddlMon.DataValueField = "mon_id";
        ddlMon.DataBind();
        getChuong();
    }
    protected void ddlMon_SelectedIndexChanged(object sender, EventArgs e)
    {
        //var listChuDe = from c in db.tbTracNghiem_Chapters
        //                where c.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue) && c.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
        //                select c;
        //lkChuong.DataSource = listChuDe;
        //lkChuong.DataBind();
        getChuong();
        _idMonHoc = Convert.ToInt32(ddlMon.SelectedValue);
    }

    protected void btnLuu_Click(object sender, EventArgs e)
    {
        //alert.alert_Error(Page, "success", "");
        List<object> selectedKey = grvDanhSachCauHoi.GetSelectedFieldValues(new string[] { "question_id" });

        if (selectedKey.Count() <= 0)
        {
            alert.alert_Warning(Page, "Vui lòng chọn câu hỏi", "");
        }
        else
        {
            foreach (var item in selectedKey)
            {
                if (listID == "")
                    listID = item.ToString();
                else listID = listID + "," + item.ToString();
            }
            // alert.alert_Warning(Page, listID + "", "");
            LuuKetQuaTracNghiem();
        }
        //LuuKetQuaTracNghiem();

    }

    protected void LuuKetQuaTracNghiem()
    {

        var checkuserid = (from u in db.admin_Users where u.username_username == Request.Cookies["UserName"].Value select u).First();
        tbTracNghiem_BaiLuyenTap insert = new tbTracNghiem_BaiLuyenTap();
        insert.luyentap_name = txtTenBai.Value;
        // tạo bài luyện tập luyentap_status =1, tạo bài thi luyentap_status = 2
        insert.luyentap_status = 2;
        insert.username_id = checkuserid.username_id;
        //insert.luyentap_tilecauhoi = txtTiLeTungBai.Value;
        insert.luyentap_danhsachbai = txtLessonID.Value;
        insert.luyentap_baitaptuluan = "luyện tập tự luận";
        db.tbTracNghiem_BaiLuyenTaps.InsertOnSubmit(insert);
        db.SubmitChanges();

        tbTracNghiem_Test test = new tbTracNghiem_Test();
        test.question_id = listID;
        test.test_createdate = DateTime.Now;
        test.username_id = checkuserid.username_id;
        test.khoi_id = Convert.ToInt32(ddlKhoi.SelectedValue);
        test.monhoc_id = Convert.ToInt32(ddlMon.SelectedValue);
        test.luyentap_id = insert.luyentap_id;
        test.hidden = false;
        test.test_thoigianlambai = Convert.ToInt32(txtThoiGian.Value) * 60 + "";
        //test.test_soluongcauhoi = Convert.ToInt32(txtSoCauHoi.Value);
        //if (rdZalo.Checked == true)
        //    test.test_link_nopbai = "zalo";
        //else
        test.test_link_nopbai = txtLinkNopBai.Value;
        db.tbTracNghiem_Tests.InsertOnSubmit(test);
        db.SubmitChanges();
        test.test_link = "bai-luyen-tap-chi-tiet-tu-luan-" + Convert.ToInt32(ddlKhoi.SelectedValue) + "/" + cls_ToAscii.ToAscii(txtTenBai.Value.ToLower()) + "-" + test.test_id;
        db.SubmitChanges();

        db.SubmitChanges();
        alert.alert_Success(Page, "Tạo đề thành công!", "");
        setNULL();
        loadDataDe();
    }
    public void setNULL()
    {
        //txtLockInsert.Value = "0";
        txtLessonID.Value = "";
    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvDeLuyenTap.GetSelectedFieldValues(new string[] { "test_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                var user_test = (from u in db.tbTracNghiem_Tests
                                 where u.test_id == Convert.ToInt32(item)
                                 select u).FirstOrDefault();
                if (user_test.username_id != user_id)
                {
                    alert.alert_Warning(Page, "Không thể xóa bài luyện tập của giáo viên khác ", "");
                }
                else
                {
                    tbTracNghiem_Test del = db.tbTracNghiem_Tests.Where(x => x.test_id == Convert.ToInt32(item)).FirstOrDefault();
                    db.tbTracNghiem_Tests.DeleteOnSubmit(del);
                    try
                    {
                        db.SubmitChanges();
                        alert.alert_Success(Page, "Xoá  thành công!", "");
                    }
                    catch (Exception ex)
                    {
                        alert.alert_Error(Page, "Xoá không thành công!", "");
                    }
                }
            }
            loadDataDe();
        }
        else
        {
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
        }
    }
    protected void rpCauHoiDetals_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Random rnd = new Random();
        int seed = rnd.Next();
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from t in db.tbTracNghiem_Answers
                               where t.question_id == question_id
                               select new
                               {
                                   t.answer_id,
                                   t.answer_content,
                                   t.answer_true,
                                   t.question_id
                               };
        List<Dapan> dapan = new List<Dapan>();
        int index = 1;
        foreach (var item in getDataCauTraLoi)
        {
            dapan.Add(new Dapan()
            {
                answer_content = item.answer_content,
                name_label = index == 1 ? "A" : index == 2 ? "B" : index == 3 ? "C" : "D",
            });
            index++;
        };
        rpCauTraLoi.DataSource = dapan;
        rpCauTraLoi.DataBind();
    }
    public class Dapan
    {
        public string answer_content { get; set; }
        public string name_label { get; set; }
    }


    protected void btnMoKhoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvDeLuyenTap.GetSelectedFieldValues(new string[] { "test_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                tbTracNghiem_Test update = db.tbTracNghiem_Tests.Where(x => x.test_id == Convert.ToInt32(item)).FirstOrDefault();
                if (update.username_id != user_id)
                {
                    alert.alert_Warning(Page, "Không thể mở bài luyện tập của giáo viên khác ", "");
                }
                else
                {
                    update.hidden = true;
                    try
                    {
                        db.SubmitChanges();
                        alert.alert_Success(Page, "Đã mở bài cho học sinh!", "");
                    }
                    catch (Exception ex)
                    {
                        alert.alert_Error(Page, "Lỗi!", "");
                    }
                }
            }
            loadDataDe();
        }
        else
        {
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
        }
    }

    protected void btnXemCauHoi_ServerClick(object sender, EventArgs e)
    {
        //hiển thị ds các câu hỏi tự luận theo ds bài đã chọn lên gridview
        string[] arrLesson = txtLessonID.Value.Split(',');
        var getQuestion = from gdtCH in db.tbTracNghiem_Questions
                          join c in db.tbTracNghiem_Lessons on gdtCH.lesson_id equals c.lesson_id
                          join ch in db.tbTracNghiem_Chapters on gdtCH.chapter_id equals ch.chapter_id
                          where gdtCH.question_type == "Tự luận"
                          && arrLesson.Contains(c.lesson_id + "")
                          && ch.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue)
                          && ch.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
                          && gdtCH.hidden == false 
                          select new
                          {
                              gdtCH.question_id,
                              gdtCH.question_dangcauhoi,
                              gdtCH.question_level,
                              question_content = gdtCH.question_content.Contains("style=") ?
                                                                 "<div class='content_image'>" + gdtCH.question_content + "</div>"
                                                                 : gdtCH.question_content.Contains("jpg") ?
                                                                 "<img class='tracnghiem-answer__image' src='" + gdtCH.question_content + "'>" :
                                                                 gdtCH.question_content.Contains("png") ?
                                                                 "<img class='tracnghiem-answer__image' src='" + gdtCH.question_content + "'>" :
                                                                 gdtCH.question_content.Contains("mp3") ? " <audio controls> <source src = '" + gdtCH.question_content + "'> </audio>" : gdtCH.question_content,
                          };

        grvDanhSachCauHoi.DataSource = getQuestion;
        grvDanhSachCauHoi.DataBind();
    }
}