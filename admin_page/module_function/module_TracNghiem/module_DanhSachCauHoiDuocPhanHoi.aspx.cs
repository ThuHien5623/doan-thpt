using DevExpress.Web.ASPxHtmlEditor;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_DanhSachCauHoiDuocPhanHoi : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int _id;
    private static int _idUser;
    public string image;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {

            if (!IsPostBack)
            {
                edtContent.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDapAnA.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDapAnB.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDapAnC.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDapAnD.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtGiaiThich.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                var user = (from u in db.admin_Users
                            where u.username_username == Request.Cookies["UserName"].Value
                            select u).FirstOrDefault();
                _idUser = user.username_id;
            }
            getdata();
        }
        else
        {
            Response.Redirect("/admin-login");
        }
    }
    private void getdata()
    {
        var getCH_TN = from ch in db.tbTracNghiem_Questions
                       join u in db.admin_Users on ch.username_id equals u.username_id
                       join c in db.tbTracNghiem_Chapters on ch.chapter_id equals c.chapter_id
                       join b in db.tbTracNghiem_Lessons on ch.lesson_id equals b.lesson_id
                       where ch.question_type == "Trắc nghiệm" && ch.hidden == false
                       && ch.username_id == _idUser && ch.question_trangthaiduyet != null
                       orderby ch.question_id descending
                       select new
                       {
                           c.chapter_id,
                           question_content = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("mp3") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                           ch.question_createdate,
                           question_level = ch.question_level,
                           b.lesson_name,
                           ch.question_id,
                           ch.question_dangcauhoi,
                           ch.question_trangthaiduyet,
                       };
        grvList.DataSource = getCH_TN;
        grvList.DataBind();
    }

    protected void btnXemCauHoi_ServerClick(object sender, EventArgs e)
    {
        //get chi tiết câu hỏi
        //try
        //{
        int countDADung = 0;
        _id = Convert.ToInt32(txtCauHoiID.Value);
        var chitiet = (from ct in db.tbTracNghiem_Questions
                           //join dt in db.tbTracNghiem_DacTas on Convert.ToInt32(ct.question_dacta) equals dt.dacta_id
                       where ct.question_id == _id
                       select new
                       {
                           ct.username_id,
                           ct.question_content,
                           ct.question_type,
                           ct.question_dangcauhoi,
                           ct.question_level,
                           ct.question_giaithich,
                           //dt.dacta_content,
                           dacta_content = ct.question_dacta != "0" ? (from dt in db.tbTracNghiem_DacTas
                                                                       where dt.dacta_id + "" == ct.question_dacta
                                                                       select dt.dacta_content).FirstOrDefault() : "Không có dữ liệu",
                           ct.question_dacta,
                       }).Single();

        //txtLoaiCauHoi.Value = chitiet.question_level + "";
        //ddlLoaiCauHoi.Text = chitiet.question_dangcauhoi + "";
        edtGiaiThich.Html = chitiet.question_giaithich;
        //ddlDacTa.Text = chitiet.dacta_content;
        if (!chitiet.question_content.Contains("uploadimages"))
        {
            //txtKieuCauHoi.Value = "0";
            edtContent.Html = chitiet.question_content;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();", true);
        }
        else
        {
            if (!chitiet.question_content.Contains("mp3"))
            {
                image = chitiet.question_content;
                //txtKieuCauHoi.Value = "1";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + image + "'),lockAudio()", true);
            }
            else
            {
                //txtKieuCauHoi.Value = "1";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + image + "'),lockImg()", true);
            }
        }
        var chitietquestion = (from ctCH in db.tbTracNghiem_Answers
                               where ctCH.question_id == _id
                               select ctCH);
        edtDapAnA.Html = chitietquestion.First().answer_content;
        if (chitietquestion.First().answer_true == true)
        {
            DaA.Checked = true;
            countDADung++;
        }
        else
            DaA.Checked = false;
        edtDapAnB.Html = chitietquestion.Skip(1).First().answer_content;
        if (chitietquestion.Skip(1).First().answer_true == true)
        {
            DaB.Checked = true;
            countDADung++;
        }
        else
            DaB.Checked = false;
        edtDapAnC.Html = chitietquestion.Skip(2).First().answer_content;
        if (chitietquestion.Skip(2).First().answer_true == true)
        {
            DaC.Checked = true;
            countDADung++;
        }
        else
            DaC.Checked = false;
        edtDapAnD.Html = chitietquestion.Skip(3).First().answer_content;
        if (chitietquestion.Skip(3).First().answer_true == true)
        {
            DaD.Checked = true;
            countDADung++;
        }
        else
            DaD.Checked = false;

        //}
        //catch { }
    }

    protected void btnCapNhat_Click(object sender, EventArgs e)
    {
        int dem_DapAnChecked = 0;
        if (DaA.Checked == true)
        {
            dem_DapAnChecked = 1;
        }
        if (DaB.Checked == true)
        {
            dem_DapAnChecked = dem_DapAnChecked + 1;
        }
        if (DaC.Checked == true)
        {
            dem_DapAnChecked = dem_DapAnChecked + 1;
        }
        if (DaD.Checked == true)
        {
            dem_DapAnChecked = dem_DapAnChecked + 1;
        }
        if (edtContent.Html == "" && image == null)
        {
            alert.alert_Error(Page, "Bạn chưa nhập nội dung câu hỏi", "");
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked()", true);
        }
        else if (DaA.Checked == false && DaB.Checked == false && DaC.Checked == false && DaD.Checked == false)
        {
            alert.alert_Error(Page, "Bạn cần chọn câu trả lời đúng", "");
        }
        else if (edtDapAnA.Html == "" || edtDapAnB.Html == "")
        {
            alert.alert_Error(Page, "Bạn cần nhập tối thiếu 2 nội dung đáp án theo thứ tự A,B,...", "");
        }
        else if (dem_DapAnChecked > 1)
        {
            alert.alert_Error(Page, "Bạn chỉ được chọn 1 đáp đúng", "");
        }

        else
        {
            var chitiet = (from ct in db.tbTracNghiem_Questions
                           where ct.question_id == Convert.ToInt32(txtCauHoiID.Value)
                           select ct).Single();
            //if (txtKieuCauHoi.Value != "0")
            //{
            //    if (image != null)
            //    {
            //        chitiet.question_content = image;
            //    }
            //}
            //else
            //{
            chitiet.question_content = edtContent.Html;
            //}
            //chitiet.question_level = txtLoaiCauHoi.Value;
            //chitiet.question_dangcauhoi = ddlLoaiCauHoi.SelectedValue;
            chitiet.question_giaithich = edtGiaiThich.Html;
            chitiet.question_trangthaiduyet = null;
            //if (ddlDacTa.SelectedValue == "Chọn đặc tả" || ddlDacTa.SelectedValue == "Không có dữ liệu")
            //    chitiet.question_dacta = "0";
            //else
            //    chitiet.question_dacta = ddlDacTa.SelectedValue;
            //chitiet.question_dacta = ddlDacTa.SelectedValue;
            db.SubmitChanges();
            // update bẳng answer
            //b1: tìm những đáp án của ch có trong bảng và xóa hết
            var xoaDA = from xDa in db.tbTracNghiem_Answers
                        where xDa.question_id == Convert.ToInt32(txtCauHoiID.Value)
                        select xDa;
            xoaDA.First().answer_content = edtDapAnA.Html;
            if (DaA.Checked == true)
                xoaDA.First().answer_true = true;
            else
                xoaDA.First().answer_true = false;
            xoaDA.Skip(1).Take(1).First().answer_content = edtDapAnB.Html;
            if (DaB.Checked == true)
                xoaDA.Skip(1).Take(1).First().answer_true = true;
            else
                xoaDA.Skip(1).Take(1).First().answer_true = false;
            xoaDA.Skip(2).Take(1).First().answer_content = edtDapAnC.Html;
            if (DaC.Checked == true)
                xoaDA.Skip(2).Take(1).First().answer_true = true;
            else
                xoaDA.Skip(2).Take(1).First().answer_true = false;
            xoaDA.Skip(3).Take(1).First().answer_content = edtDapAnD.Html;
            if (DaD.Checked == true)
                xoaDA.Skip(3).Take(1).First().answer_true = true;
            else
                xoaDA.Skip(3).Take(1).First().answer_true = false;

            db.SubmitChanges();
            alert.alert_Success(Page, "Cập nhật thành công", "");
            getdata();
            edtDapAnA.Html = "";
            edtDapAnB.Html = "";
            edtDapAnC.Html = "";
            edtDapAnD.Html = "";
            edtGiaiThich.Html = "";
            //ddlDacTa.Text = "";
            DaA.Checked = false;
            DaB.Checked = false;
            DaC.Checked = false;
            DaD.Checked = false;
            edtContent.Html = "";
        }
    }
}