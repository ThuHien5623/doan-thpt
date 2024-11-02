using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_TaoDeKiemTraNgauNhien : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    int question_id;
    public int STT = 1;
    public int STTT = 1;
    public int user_id;
    private static int _idKhoi;
    private static int _idMonHoc;
    protected void Page_Load(object sender, EventArgs e)
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
            getChuong();
        }
        if (lkChuong.Text != "")
        {
            string _id = lkChuong.Text;
            string[] arrListStr = _id.Split(',');
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
                //lkBai.DataSource = list.OrderBy(x => x.lesson_id);
                //lkBai.DataBind();
                rpLesson.DataSource = list.OrderBy(x => x.lesson_id);
                rpLesson.DataBind();
            }
        }
        if (txtLessonID.Value!="")
        {
            loadCauHoiTracNghiem();
        }
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
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "HiddenLoadingIcon()", true);
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
    protected void ManageDivTracNghiem()
    {
        //var getMon = (from mh in db.tbMonHocs
        //              join mhck in db.tbMonHocCuaKhois on mh.monhoc_id equals mhck.monhoc_id
        //              where mhck.khoi_id == _idKhoi
        //              && mh.monhoc_id == _idMonHoc
        //              select mh).First().monhoc_name;
    }
    protected void btnLuu_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "question_id" });
        tbTracNghiem_BaiLuyenTap insert = new tbTracNghiem_BaiLuyenTap();
        insert.luyentap_name = txtTenBai.Value;
        insert.luyentap_status = 1; // tạo bài luyện tập luyentap_status =2, tạo bài thi luyentap_status = 1
        insert.username_id = user_id;
        insert.luyentap_baitaptuluan = "kiem tra trac nghiem tu chon";
        db.tbTracNghiem_BaiLuyenTaps.InsertOnSubmit(insert);
        db.SubmitChanges();
        tbTracNghiem_Test test = new tbTracNghiem_Test();
        test.question_id = String.Join(",", selectedKey);
        test.test_createdate = DateTime.Now;
        test.username_id = user_id;
        test.khoi_id = Convert.ToInt32(ddlKhoi.SelectedValue);
        test.monhoc_id = Convert.ToInt32(ddlMon.SelectedValue);
        test.luyentap_id = insert.luyentap_id;
        test.hidden = false;
        test.test_thoigianlambai = Convert.ToInt32(txtThoiGian.Value) * 60 + "";

        db.tbTracNghiem_Tests.InsertOnSubmit(test);
        db.SubmitChanges();
        test.test_link = "slldt-bai-kiem-tra-trac-nghiem-chi-tiet-" + test.test_id;
        db.SubmitChanges();
        alert.alert_Success(Page, "Tạo đề thành công!", "");
        setNULL();
    }
    
    public void setNULL()
    {
        txtLessonID.Value = "";
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
    private void loadCauHoiTracNghiem()
    {
        string[] listLesson = txtLessonID.Value.Split(',');
        var getTracNghiem = from ch in db.tbTracNghiem_Questions
                            join ls in db.tbTracNghiem_Lessons on ch.lesson_id equals ls.lesson_id
                            where listLesson.Contains(ls.lesson_id + "") && ch.hidden == false && ch.question_type == "Trắc nghiệm"
                            select new
                            {
                                ch.question_id,
                                noidungcauhoi = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                                ch.question_dangcauhoi,
                                ch.question_level,
                            };
        grvList.DataSource = getTracNghiem;
        grvList.DataBind();
        //setChecked()
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setChecked()", true);
    }
    protected void btnXemCauHoi_ServerClick(object sender, EventArgs e)
    {
        loadCauHoiTracNghiem();
    }
}