using DevExpress.Web.ASPxHtmlEditor;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_App_SLLDT_module_SLLDT_VideoHocTap : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int _id;
    private string _image;
    public string image;
    public string url;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["_id"] = 0;
        }
        loadData();
    }
    protected void loadData()
    {
        // load data đổ vào var danh sách
        var getData = from vd in db.tbTracNghiem_VideoLuyenTaps orderby vd.videoluyentap_id descending select vd;
        grvList.DataSource = getData;
        grvList.DataBind();

        ddlKhoi.DataSource = from k in db.tbLops where k.lop_id > 9 select k;
        ddlKhoi.DataBind();

        var getMon = from m in db.tbTKB_Mons
                     join k in db.tbMonHocCuaKhois on m.mon_id equals k.mon_id
                     where k.khoi_id > 9
                     group m by m.mon_id into k
                     select new
                     {
                         mon_id = k.First().mon_id,
                         mon_name = k.First().mon_name
                     };
        ddlMon.DataSource = getMon;
        ddlMon.DataBind();
    }
    private void setNULL()
    {
        txtLink.Text = "";
        txtTenBai.Text = "";
        ddlKhoi.Value = "";
        ddlMon.Value = "";
    }
    protected void btnThem_Click(object sender, EventArgs e)
    {
        // Khi nhấn nút thêm thì mật định session id = 0 để thêm mới
        Session["_id"] = 0;
        setNULL();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "popupControl.Show();", true);
        loadData();
    }

    protected void btnChiTiet_Click(object sender, EventArgs e)
    {
        // get value từ việc click vào gridview
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "videoluyentap_id" }));
        // đẩy id vào session
        Session["_id"] = _id;
        var getData = (from vd in db.tbTracNghiem_VideoLuyenTaps
                       where vd.videoluyentap_id == _id
                       select new
                       {
                           vd.videoluyentap_id,
                           vd.videoluyentap_lop,
                           vd.monhoc_id,
                           vd.videoluyentap_monhoc,
                           vd.videoluyentap_video_path,
                           vd.videoluyentap_tenbai,
                           vd.videoluyentap_image_path,
                       }).Single();
        txtLink.Text = getData.videoluyentap_video_path;
        txtTenBai.Text = getData.videoluyentap_tenbai;
        ddlMon.Text = getData.videoluyentap_monhoc;
        ddlKhoi.Value = getData.videoluyentap_lop;
        image = getData.videoluyentap_image_path;
        if (getData.videoluyentap_image_path == null)
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Detail", "popupControl.Show();showImg1_1('" + "/admin_images/up-img.png" + "'); ", true);
        else
            image = getData.videoluyentap_image_path;
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Detail", "popupControl.Show();showImg1_1('" + getData.videoluyentap_image_path + "'); ", true);
        loadData();
    }

    public bool checknull()
    {
        if (txtLink.Text != "" || txtTenBai.Text != "")
            return true;
        else return false;
    }

    protected void btnLuu_Click(object sender, EventArgs e)
    {
        if (Page.IsValid && FileUpload1.HasFile)
        {
            if (Convert.ToInt32(ddlKhoi.Value) < 10)
            {
                url = "/images/banner-video/khoi0" + ddlKhoi.Value + "/";
            }
            else
            {
                url = "/images/banner-video/khoi" + ddlKhoi.Value + "/";
            }
            String folderUser = Server.MapPath("~" + url);
            if (!Directory.Exists(folderUser))
            {
                Directory.CreateDirectory(folderUser);
            }
            HttpFileCollection hfc = Request.Files;
            string filename = FileUpload1.FileName;
            string fileName_save = Path.Combine(Server.MapPath(url), filename);
            FileUpload1.SaveAs(fileName_save);
            image = url + filename;
        }
        cls_VideoHocTap cls = new cls_VideoHocTap();

        if (checknull() == false)
            alert.alert_Warning(Page, "Vui lòng nhập đầy đủ thông tin!", "");
        else
        {
            var getPosition = (from p in db.tbTracNghiem_VideoLuyenTaps
                               where p.videoluyentap_lop == (ddlKhoi.Value + "") && p.monhoc_id == Convert.ToInt32(ddlMon.Value)
                               orderby p.videoluyentap_id descending
                               select p).FirstOrDefault();
            int position = Convert.ToInt32(getPosition.videoluyentap_position) + 1;

            if (Session["_id"].ToString() == "0")
            {
                if (image == null)
                {
                    image = "/images/520x350.jpg";
                }
                if (cls.insert_Data(txtTenBai.Text, txtLink.Text, Convert.ToInt32(ddlMon.Value), image, (ddlKhoi.Value + ""), ddlMon.Text, position))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Thêm thành công','','success').then(function(){grvList.Refresh();})", true);
                    popupControl.ShowOnPageLoad = false;
                    loadData();
                }
                else alert.alert_Error(Page, "Thêm thất bại", "");
            }
            else
            {
                if (image == null)
                {
                    _image = (from vd in db.tbTracNghiem_VideoLuyenTaps
                              where vd.videoluyentap_id == Convert.ToInt32(Session["_id"].ToString())
                              select vd.videoluyentap_image_path).FirstOrDefault();
                }
                else
                {
                    _image = image;
                }
                if (cls.Update_Data(Convert.ToInt32(Session["_id"].ToString()), txtTenBai.Text, txtLink.Text, Convert.ToInt32(ddlMon.Value), _image, (ddlKhoi.Value + ""), ddlMon.Text, position))
                {
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Cập nhật thành công','','success').then(function(){grvList.Refresh();})", true);
                    popupControl.ShowOnPageLoad = false;
                    loadData();
                }
                else alert.alert_Error(Page, "Cập nhật thất bại", "");
            }
        }
        loadData();
    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "videoluyentap_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                cls_VideoHocTap cls = new cls_VideoHocTap();
                tbTracNghiem_VideoLuyenTap checkImage = (from i in db.tbTracNghiem_VideoLuyenTaps where i.videoluyentap_id == Convert.ToInt32(item) select i).SingleOrDefault();
                string pathToFiles = Server.MapPath(checkImage.videoluyentap_image_path);
                delete(pathToFiles);
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
    public void delete(string sFileName)
    {
        if (sFileName != String.Empty)
        {
            if (File.Exists(sFileName))

                File.Delete(sFileName);
        }
    }
}