using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxHtmlEditor;

public partial class admin_page_module_function_module_QuanLyCauHoiTuLuan : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    int _id;
    public int id_user;
    public string title_BaiHoc, image;
    protected void Page_Load(object sender, EventArgs e)
    {
        var checkTaiKhoan = (from u in db.admin_Users
                             where u.username_username == Request.Cookies["UserName"].Value
                             select u).FirstOrDefault();
        id_user = checkTaiKhoan.username_id;
        if (!IsPostBack)
        {
            edtContent.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            edtGiaiThich.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            edtDacta.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            Session["_id"] = 0;
        }
        loadData();
    }

    private void loadData()
    {
        var getCH_TL = from ch in db.tbTracNghiem_Questions
                           // join u in db.admin_Users on ch.username_id equals u.username_id
                           //join k in db.tbGiaoVienDayKhois on u.username_id equals k.username_id
                           //join m in db.tbGiaoVienDayMons on u.username_id equals m.username_id
                       join c in db.tbTracNghiem_Chapters on ch.chapter_id equals c.chapter_id
                       join b in db.tbTracNghiem_Lessons on ch.lesson_id equals b.lesson_id
                       where ch.username_id == id_user
                       //  && k.khoi_id == Convert.ToInt32(RouteData.Values["khoi_id"])
                       //&& m.monhoc_id == Convert.ToInt32(RouteData.Values["mon_id"])
                       && ch.chapter_id == Convert.ToInt32(RouteData.Values["chuong_id"])
                       && ch.lesson_id == Convert.ToInt32(RouteData.Values["baihoc_id"])
                       && ch.question_type == "Tự luận"
                       orderby ch.question_id descending
                       select new
                       {
                           c.chapter_id,
                           question_content = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "'</div>" : ch.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("mp3") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                           ch.question_createdate,
                           question_level = ch.question_level,
                           b.lesson_name,
                           ch.question_id,
                           ch.question_dangcauhoi,
                       };
        grvList.DataSource = getCH_TL;
        grvList.DataBind();
    }

    protected void btnLuu_Click(object sender, EventArgs e)
    {
        //luu file image
        SavefileImage();
        // đếm số đáp án chọn.
        if (edtContent.Html == "" && ddlLoaiCauHoi.SelectedValue == "Nhận biết")
        {
            alert.alert_Error(Page, "Bạn chưa nhập nội dung câu hỏi", "");
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked()", true);
        }
        else
        {
            if (Session["_id"].ToString() == "0")
            {
                //tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
                themdata();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + image + "')", true);
                Session["_id"] = "0";
                btnLuu.Text = "Lưu";
                btnLuuvaThemmoi.Text = "Lưu và thêm mới";
                //if (ddlLoaiCauHoi.SelectedValue != "Nhận biết")
                //{
                //    themcauhoi.question_content = image;
                //}
                //else
                //{
                //    themcauhoi.question_content = edtContent.Html;
                //}
            }
            else
            {
                updatedata();
                Session["_id"] = "0";
                btnLuu.Text = "Lưu";
                btnLuuvaThemmoi.Text = "Lưu và thêm mới";
            }
            datarong();
        }
    }
    protected void btnLuuvaThemmoi_Click1(object sender, EventArgs e)
    {
        SavefileImage();
        if (edtContent.Html == "" && image == null)
        {
            alert.alert_Error(Page, "Bạn chưa nhập nội dung câu hỏi", "");
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked()", true);
        }
        else
        {
            if (Session["_id"].ToString() == "0")
            {
                //tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
                themdata();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();", true);
                Session["_id"] = "0";
            }
            else
            {
                updatedata();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();", true);
                Session["_id"] = "0";
                btnLuu.Text = "Lưu";
                btnLuuvaThemmoi.Text = "Lưu và thêm mới";
            }
            datarong();
        }
    }
    protected void btnChiTiet_Click(object sender, EventArgs e)
    {
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "question_id" }));
        Session["_id"] = _id;
        var chitiet = (from ct in db.tbTracNghiem_Questions
                       where ct.question_id == _id
                       select new
                       {
                           ct.username_id,
                           ct.question_content,
                           ct.question_dangcauhoi,
                           ct.question_level,
                           ct.question_giaithich,
                           ct.question_dacta,
                           ct.question_diem,
                       }).Single();
        if (chitiet.username_id == id_user)
        {
            txtLoaiCauHoi.Value = chitiet.question_level + "";
            ddlLoaiCauHoi.Text = chitiet.question_dangcauhoi + "";
            edtGiaiThich.Html = chitiet.question_giaithich;
            edtDacta.Html = chitiet.question_dacta;
            txtDiem.Value = chitiet.question_diem;
            if (!chitiet.question_content.Contains("uploadimages"))
            {
                txtKieuCauHoi.Value = "0";
                edtContent.Html = chitiet.question_content;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setChecked();DisplayQuestion();", true);
            }
            else
            {
                if (!chitiet.question_content.Contains("mp3"))
                {
                    image = chitiet.question_content;
                    txtKieuCauHoi.Value = "1";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + image + "'),lockAudio()", true);
                }
                else
                {
                    txtKieuCauHoi.Value = "1";
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + image + "'),lockImg()", true);
                }
            }
            btnLuu.Text = "Cập nhật";
            btnLuuvaThemmoi.Text = "Cập nhật và thêm mới";
        }
        else
        {
            alert.alert_Error(Page, "Sai thông tin người dùng", "");
        }
    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "question_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                tbTracNghiem_Question del = db.tbTracNghiem_Questions.Where(x => x.question_id == Convert.ToInt32(item)).FirstOrDefault();
                db.tbTracNghiem_Questions.DeleteOnSubmit(del);
                try
                {
                    db.SubmitChanges();
                    alert.alert_Success(Page, "Xoá  thành công!", "");
                    loadData();
                }
                catch (Exception ex)
                {
                    alert.alert_Error(Page, "Xoá không thành công!", "");
                }
            }
        }
        else
        {
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
        }
    }
    protected void btnTaiLaiTrang_Click(object sender, EventArgs e)
    {
        loadData();
        datarong();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "grvList.UnselectRows();setForm()", true);
    }

    private void datarong()
    {
        edtGiaiThich.Html = "";
        edtDacta.Html = "";
        edtContent.Html = "";
        ddlLoaiCauHoi.Text = "Nhận biết";
        //txtLoaiCauHoi.Value = "Dễ";
        txtDiem.Value = "";
        btnLuu.Text = "Lưu";
        btnLuuvaThemmoi.Text = "Lưu và thêm mới";
    }
    private void themdata()
    {
        tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
        if (edtContent.Html == "" && txtKieuCauHoi.Value != "0")
        {
            themcauhoi.question_content = image;
        }
        else
        {
            themcauhoi.question_content = edtContent.Html;
        }
        themcauhoi.question_createdate = DateTime.Now;
        themcauhoi.question_level = txtLoaiCauHoi.Value;
        themcauhoi.username_id = id_user;
        themcauhoi.chapter_id = Convert.ToInt32(RouteData.Values["chuong_id"]);
        themcauhoi.question_type = "Tự luận";
        themcauhoi.hidden = false;
        themcauhoi.question_dangcauhoi = ddlLoaiCauHoi.SelectedValue;
        themcauhoi.question_giaithich = edtGiaiThich.Html;
        themcauhoi.question_dacta = edtDacta.Html;
        themcauhoi.lesson_id = Convert.ToInt32(RouteData.Values["baihoc_id"]);
        themcauhoi.question_diem = txtDiem.Value;
        db.tbTracNghiem_Questions.InsertOnSubmit(themcauhoi);
        db.SubmitChanges();
        Session["_id"] = themcauhoi.question_id;
        db.SubmitChanges();
        alert.alert_Success(Page, "Lưu thành công", "");
        loadData();
    }
    private void updatedata()
    {
        var chitiet = (from ct in db.tbTracNghiem_Questions
                       where ct.question_id == Convert.ToInt32(Session["_id"].ToString())
                       select ct).Single();
        if (txtKieuCauHoi.Value != "0")
        {
            if (image != null)
            {
                chitiet.question_content = image;
            }
        }
        else
        {
            chitiet.question_content = edtContent.Html;
        }
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + chitiet.question_content + "')", true);
        chitiet.question_level = txtLoaiCauHoi.Value;
        chitiet.question_dangcauhoi = ddlLoaiCauHoi.SelectedValue;
        chitiet.question_giaithich = edtGiaiThich.Html;
        chitiet.question_dacta = edtDacta.Html;
        chitiet.question_diem = txtDiem.Value;
        db.SubmitChanges();
        alert.alert_Success(Page, "Cập nhật thành công", "");
        btnLuu.Text = "Cập nhật";
        btnLuuvaThemmoi.Text = "Cập nhật và thêm mới";
        loadData();
    }
    private void SavefileImage()
    {
        if (Page.IsValid && FileUpload1.HasFile)
        {
            String folderUser;
            string url;
            string filename;
            string fileName_save;
            if (txtKieuCauHoi.Value == "1")
            {
                //lưu hình ảnh
                folderUser = Server.MapPath("~/uploadimages/anh_cauhoitracnghiem/");
                if (!Directory.Exists(folderUser))
                {
                    Directory.CreateDirectory(folderUser);
                }
                url = "/uploadimages/anh_cauhoitracnghiem/";
                HttpFileCollection hfc = Request.Files;
                filename = DateTime.Now.ToString("yyyyMMdd_") + FileUpload1.FileName;
                fileName_save = Path.Combine(Server.MapPath("~/uploadimages/anh_cauhoitracnghiem"), filename);
                FileUpload1.SaveAs(fileName_save);
                image = url + filename;
            }
            else if (txtKieuCauHoi.Value == "2")
            {
                //lưu video
                folderUser = Server.MapPath("~/uploadimages/video_cauhoitracnghiem/");
                if (!Directory.Exists(folderUser))
                {
                    Directory.CreateDirectory(folderUser);
                }
                url = "/uploadimages/video_cauhoitracnghiem/";
                HttpFileCollection hfc = Request.Files;
                filename = DateTime.Now.ToString("yyyyMMdd_") + FileUpload1.FileName;
                fileName_save = Path.Combine(Server.MapPath("~/uploadimages/video_cauhoitracnghiem"), filename);
                FileUpload1.SaveAs(fileName_save);
                image = url + filename;
            }
        }
    }
}