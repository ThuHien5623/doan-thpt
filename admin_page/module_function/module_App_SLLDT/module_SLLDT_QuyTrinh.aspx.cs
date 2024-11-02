﻿using DevExpress.Web.ASPxHtmlEditor;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_SLLDT_QuyTrinh : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    DataTable dtSchool;
    private int _id;
    public string image, image1, image2, image3;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["_id"] = 0;
        }
        loadData();
    }
    private void loadData()
    {
        // load data đổ vào var danh sách
        var getData = from nc in db.tbLandingPage_TungCap_QuyTrinhs
                      select nc;
        // đẩy dữ liệu vào gridivew
        grvList.DataSource = getData;
        grvList.DataBind();

    }
    private void setNULL()
    {
        txtTitle.Text = "";
       
    }
    protected void btnThem_Click(object sender, EventArgs e)
    {
        // Khi nhấn nút thêm thì mật định session id = 0 để thêm mới
        Session["_id"] = 0;
        // gọi hàm setNull để trả toàn bộ các control về rỗng
        setNULL();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "popupControl.Show();", true);
        loadData();
    }

    protected void btnChiTiet_Click(object sender, EventArgs e)
    {
        // get value từ việc click vào gridview
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "tungcap_quytrinh_id" }));
        // đẩy id vào session
        Session["_id"] = _id;
        var getData = (from nc in db.tbLandingPage_TungCap_QuyTrinhs
                       where nc.tungcap_quytrinh_id == _id
                       select nc).Single();
        txtTitle.Text = getData.tungcap_quytrinh_name;
        image = getData.tungcap_quytrinh_title;
        image1 = getData.tungcap_quytrinh_image_1;
        image2 = getData.tungcap_quytrinh_image_2;
        image3 = getData.tungcap_quytrinh_image_3;
       
        if (getData.tungcap_quytrinh_title == null)
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Detail", "popupControl.Show();showImg('" + "/admin_images/Preview-icon.png" + "'); ", true);
        else
            image = getData.tungcap_quytrinh_title;
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Detail", "popupControl.Show();showImg('" + getData.tungcap_quytrinh_title + "');showImg1('" + getData.tungcap_quytrinh_image_1 + "');showImg2('" + getData.tungcap_quytrinh_image_2 + "');showImg3('" + getData.tungcap_quytrinh_image_3 + "'); ", true);
        loadData();
    }
    protected void btnLuu_Click(object sender, EventArgs e)
    {
        // Upload file tiêu đề
        if (Page.IsValid && FileUpload.HasFile)
        {
            String folderUser = Server.MapPath("~/uploadimages/slldt_ThongBao/");
            if (!Directory.Exists(folderUser))
            {
                Directory.CreateDirectory(folderUser);
            }
            //string filename;
            string ulr = "/uploadimages/slldt_ThongBao/";
            HttpFileCollection hfc = Request.Files;
            string filename = Path.GetRandomFileName() + Path.GetExtension(FileUpload.FileName);
            string fileName_save = Path.Combine(Server.MapPath("~/uploadimages/slldt_ThongBao"), filename);
            FileUpload.SaveAs(fileName_save);
            image = ulr + filename;
        }
        // Upload file image 1
        if (Page.IsValid && FileUpload1.HasFile)
        {
            String folderUser = Server.MapPath("~/uploadimages/slldt_ThongBao/");
            if (!Directory.Exists(folderUser))
            {
                Directory.CreateDirectory(folderUser);
            }
            //string filename;
            string ulr = "/uploadimages/slldt_ThongBao/";
            HttpFileCollection hfc = Request.Files;
            string filename = Path.GetRandomFileName() + Path.GetExtension(FileUpload1.FileName);
            string fileName_save = Path.Combine(Server.MapPath("~/uploadimages/slldt_ThongBao"), filename);
            FileUpload1.SaveAs(fileName_save);
            image1 = ulr + filename;
        }
        // Upload file image 2
        if (Page.IsValid && FileUpload2.HasFile)
        {
            String folderUser = Server.MapPath("~/uploadimages/slldt_ThongBao/");
            if (!Directory.Exists(folderUser))
            {
                Directory.CreateDirectory(folderUser);
            }
            //string filename;
            string ulr = "/uploadimages/slldt_ThongBao/";
            HttpFileCollection hfc = Request.Files;
            string filename = Path.GetRandomFileName() + Path.GetExtension(FileUpload2.FileName);
            string fileName_save = Path.Combine(Server.MapPath("~/uploadimages/slldt_ThongBao"), filename);
            FileUpload2.SaveAs(fileName_save);
            image2 = ulr + filename;
        }
        // Upload file image 3
        if (Page.IsValid && FileUpload3.HasFile)
        {
            String folderUser = Server.MapPath("~/uploadimages/slldt_ThongBao/");
            if (!Directory.Exists(folderUser))
            {
                Directory.CreateDirectory(folderUser);
            }
            //string filename;
            string ulr = "/uploadimages/slldt_ThongBao/";
            HttpFileCollection hfc = Request.Files;
            string filename = Path.GetRandomFileName() + Path.GetExtension(FileUpload3.FileName);
            string fileName_save = Path.Combine(Server.MapPath("~/uploadimages/slldt_ThongBao"), filename);
            FileUpload3.SaveAs(fileName_save);
            image3 = ulr + filename;
        }
        cls_SLLDT_QuyTrinh cls = new cls_SLLDT_QuyTrinh();
        if (Session["_id"].ToString() == "0")
        {
            if (image == null)
            {
                image = "/images/520x350.jpg";
            }

            if (cls.insert_Data(txtTitle.Text, image, image1, image2, image3))
            {
                alert.alert_Success(Page, "Thêm thành công", "");
                popupControl.ShowOnPageLoad = false;
                loadData();
            }
            else alert.alert_Error(Page, "Thêm thất bại", "");
        }
        else
            if (cls.Update_Data(Convert.ToInt32(Session["_id"].ToString()), txtTitle.Text, image, image1,image2,image3))
        {
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Cập nhật thành công','','success').then(function(){grvList.Refresh();})", true);
            popupControl.ShowOnPageLoad = false;
            loadData();
        }
        else alert.alert_Error(Page, "Cập nhật thất bại", "");

        loadData();
    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "tungcap_quytrinh_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                cls_SLLDT_QuyTrinh cls = new cls_SLLDT_QuyTrinh();
                tbLandingPage_TungCap_QuyTrinh checkImage = (from i in db.tbLandingPage_TungCap_QuyTrinhs where i.tungcap_quytrinh_id == Convert.ToInt32(item) select i).SingleOrDefault();
                if (cls.delete_Data(Convert.ToInt32(item)))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Xóa thành công','','success').then(function(){grvList.Refresh();})", true);

                }
                else
                    alert.alert_Error(Page, "Xóa thất bại", "");
            }
        }
        else
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
    }
}