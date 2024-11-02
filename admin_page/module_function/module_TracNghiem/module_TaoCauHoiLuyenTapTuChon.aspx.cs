using DevExpress.Web.ASPxHtmlEditor;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_TaoCauHoiLuyenTapTuChon : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
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
            divHien.Visible = false;
            edtnoidung.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            var getkhoi = from ldt in db.tbKhois
                          join gvdk in db.tbGiaoVienDayKhois on ldt.khoi_id equals gvdk.khoi_id
                          where gvdk.username_id == checkTaiKhoan.username_id
                          select ldt;
            ddlKhoi.Items.Clear();
            ddlKhoi.AppendDataBoundItems = true;
            ddlKhoi.Items.Insert(0, "Chọn khối");
            ddlKhoi.DataValueField = "khoi_id";
            ddlKhoi.DataTextField = "khoi_name";
            ddlKhoi.DataSource = getkhoi;
            ddlKhoi.DataBind();
            ddlMon.Items.Insert(0, "Chọn môn");
            ddlChuong.Items.Insert(0, "Chọn chương");
        }
        if (ddlChuong.SelectedValue != "Chọn chương")
        {
            getdata();
        }

    }
    private void getdata()
    {
        var gdtCauhoi = from gdtCH in db.tbTracNghiem_Questions
                        join c in db.tbTracNghiem_Lessons on gdtCH.lesson_id equals c.lesson_id
                        //join name in db.admin_Users on gdtCH.username_id equals name.username_id
                        join ch in db.tbTracNghiem_Chapters on gdtCH.chapter_id equals ch.chapter_id
                        where ch.chapter_id == Convert.ToInt32(ddlChuong.SelectedValue)
                        && gdtCH.hidden == false
                        //&& gdtCH.lesson_id == Convert.ToInt32(RouteData.Values["baihoc_id"])
                        //orderby gdtCH.question_id descending
                        orderby gdtCH.question_type ascending 
                        select new
                        {
                            //c.chapter_id,
                            question_content = gdtCH.question_content.Contains("style=") ? "<div class='content_image'>" + gdtCH.question_content + "</div>" : gdtCH.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' style='width:200px;height:200px' src='" + gdtCH.question_content + "'>" : gdtCH.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + gdtCH.question_content + "'>" : gdtCH.question_content.Contains("mp3") ? " <audio controls> <source src = '" + gdtCH.question_content + "'> </audio>" : gdtCH.question_content,
                            //gdtCH.question_createdate,
                            //question_level = gdtCH.question_level,
                            c.lesson_name,
                            // name.username_fullname,
                            gdtCH.question_id,
                            //gdtCH.question_dangcauhoi
                            gdtCH.question_dangcauhoi,
                            gdtCH.question_level,
                            gdtCH.question_type,
                        };
        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" +  + "')", true);
        grvList.DataSource = gdtCauhoi;
        grvList.DataBind();
    }
    protected void ddlKhoi_SelectedIndexChanged(object sender, EventArgs e)
    {
        var listMon = from gvdm in db.tbTKB_GiaoVienDayMon_Tests
                      join m in db.tbTKB_Mons on gvdm.mon_id equals m.mon_id
                      join l in db.tbLops on gvdm.lop_id equals l.lop_id
                      where gvdm.username_id == user_id && gvdm.lop_id != null
                      && l.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue)
                      select m;
        _idKhoi = Convert.ToInt32(ddlKhoi.SelectedValue);
        ddlMon.Items.Clear();
        ddlMon.AppendDataBoundItems = true;
        ddlMon.Items.Insert(0, "Chọn môn");
        ddlMon.DataValueField = "mon_id";
        ddlMon.DataTextField = "mon_name";
        ddlMon.DataSource = listMon;
        ddlMon.DataBind();
        ddlChuong.Items.Clear();
        ddlChuong.Items.Insert(0, "Chọn chương");
    }

    protected void ddlMon_SelectedIndexChanged(object sender, EventArgs e)
    {
        //var getChuong = from ch in db.tbTracNghiem_Chapters
        //                join mh in db.tbMonHocs on ch.monhoc_id equals mh.monhoc_id
        //                where ch.monhoc_id == Convert.ToInt32(ddlMon.SelectedValue)
        //                && ch.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue)
        //                && ch.hidden == true

        //                select ch;
        var listChuDe = from c in db.tbTracNghiem_Chapters
                        where c.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue)
                        && c.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
                        select c;
        ddlChuong.Items.Clear();
        ddlChuong.AppendDataBoundItems = true;
        ddlChuong.Items.Insert(0, "Chọn chương");
        ddlChuong.DataValueField = "chapter_id";
        ddlChuong.DataTextField = "chapter_name";
        ddlChuong.DataSource = listChuDe;
        ddlChuong.DataBind();
        _idMonHoc = Convert.ToInt32(ddlMon.SelectedValue);
        // ManageDivTracNghiem();
    }

    //protected void ManageDivTracNghiem()
    //{
    //    var getMon = (from mh in db.tbMonHocs
    //                  join mhck in db.tbMonHocCuaKhois on mh.monhoc_id equals mhck.monhoc_id
    //                  where mhck.khoi_id == _idKhoi
    //                  && mh.monhoc_id == _idMonHoc
    //                  select mh).First().monhoc_name;
    //}

    protected void btnLuu_Click(object sender, EventArgs e)
    {
        if (ddlKhoi.SelectedValue == "Chọn khối")
        {
            alert.alert_Warning(Page, "Vui lòng chọn khối", "");
        }
        else if (ddlMon.SelectedValue == "Chọn môn")
        {
            alert.alert_Warning(Page, "Vui lòng chọn môn", "");
        }
        else if (ddlChuong.SelectedValue == "Chọn chương")
        {
            alert.alert_Warning(Page, "Vui lòng chọn chương", "");
        }
        else
        {
            List<object> seclectedKey = grvList.GetSelectedFieldValues(new string[] { "question_id" });
            if (seclectedKey.Count() == 0 && divTracNghiem.Visible == true)
            {
                alert.alert_Error(Page, "Bạn chưa chọn câu hỏi", "");
            }
            else
            {
                if (Request.Cookies["UserName"] != null)
                {
                    string[] arrList = new string[100];
                    string str_code = "";
                    string str_first = "";
                    bool is_link = true;
                    if (txtLink.Value != "")
                    {
                        arrList = txtLink.Value.Split('=');
                        try
                        {
                            string str_init = arrList[0];
                            str_code = arrList[1];
                            str_first = "https://www.youtube.com/embed/";
                            if ((str_init != "https://www.youtube.com/watch?v") || (str_code.Length != 11))
                                is_link = false;
                        }
                        catch
                        {
                            is_link = false;
                        }

                    }

                    if (is_link)
                    {
                        var checkuserid = (from u in db.admin_Users where u.username_username == Request.Cookies["UserName"].Value select u).First();
                        tbTracNghiem_BaiLuyenTap insert = new tbTracNghiem_BaiLuyenTap();
                        insert.luyentap_name = txtTenBai.Value;
                        insert.luyentap_linkvideo = str_first + str_code;
                        insert.luyentap_status = 1;
                        insert.username_id = checkuserid.username_id;
                        insert.luyentap_baitaptuluan = edtnoidung.Html;
                        db.tbTracNghiem_BaiLuyenTaps.InsertOnSubmit(insert);
                        db.SubmitChanges();

                        tbTracNghiem_Test test = new tbTracNghiem_Test();
                        test.question_id = String.Join(",", seclectedKey);
                        test.test_createdate = DateTime.Now;
                        test.username_id = checkuserid.username_id;
                        test.khoi_id = Convert.ToInt32(ddlKhoi.SelectedValue);
                        test.monhoc_id = Convert.ToInt32(ddlMon.SelectedValue);
                        test.luyentap_id = insert.luyentap_id;
                        test.hidden = false;
                        db.tbTracNghiem_Tests.InsertOnSubmit(test);
                        db.SubmitChanges();
                        test.test_link = "bai-luyen-tap-chi-tiet-" + Convert.ToInt32(ddlKhoi.SelectedValue) + "/" + cls_ToAscii.ToAscii(txtTenBai.Value.ToLower()) + "-" + test.test_id ;
                        db.SubmitChanges();
                        //}
                        foreach (var item in seclectedKey)
                        {
                            tbTracNghiem_TestDetail cttest = new tbTracNghiem_TestDetail();
                            cttest.test_id = test.test_id;
                            cttest.question_id = Convert.ToInt32(item);
                            cttest.hidden = false;
                            db.tbTracNghiem_TestDetails.InsertOnSubmit(cttest);
                            db.SubmitChanges();
                        }
                        alert.alert_Success(Page, "Cập nhật thành công!", "");
                        getdata();
                    }
                    else
                    {
                        alert.alert_Error(Page, "Đường dẫn Youtube sai định dạng!", "");
                    }
                }
            }
        }
    }

    protected void btnHienTracNghiem_Click(object sender, EventArgs e)
    {
        divHien.Visible = false;
        divTracNghiem.Visible = true;
    }
    protected void btnTatTracNghiem_Click(object sender, EventArgs e)
    {
        divHien.Visible = true;
        divTracNghiem.Visible = false;
    }
}