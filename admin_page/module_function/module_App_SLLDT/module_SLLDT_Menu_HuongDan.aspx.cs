using DevExpress.Web.ASPxHtmlEditor;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_SLLDT_Menu_HuongDan : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    DataTable dtSchool;
    private int _id;
    public string title, summary, content, image;
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
        var getData = from nc in db.tbLandingPage_VideoHuongDans
                      orderby nc.videohuongdan_id descending
                      select nc;

        // đẩy dữ liệu vào gridivew
        grvList.DataSource = getData;
        grvList.DataBind();
    }
    private void setNULL()
    {
        txtCap.Text = "";
        txtLink.Text = "";
        txtTieuDe.Text = "";
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
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "videohuongdan_id" }));
        // đẩy id vào session
        Session["_id"] = _id;
        var getData = (from nc in db.tbLandingPage_VideoHuongDans
                       where nc.videohuongdan_id == _id
                       select nc
                       ).Single();
        txtCap.Text = getData.videohuongdan_cap;
        txtTieuDe.Text = getData.videohuongdan_title;
        txtLink.Text = getData.videohuongdan_video_path;
        image = getData.videohuongdan_image_path;
        if (getData.videohuongdan_image_path == null)
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Detail", "popupControl.Show();showImg1_1('" + "/admin_images/Preview-icon.png" + "'); ", true);
        else
            image = getData.videohuongdan_image_path;
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Detail", "popupControl.Show();showImg1_1('" + getData.videohuongdan_image_path + "'); ", true);
        loadData();
    }
    public bool checknull()
    {
        if (txtCap.Text != "")
            return true;
        else return false;
    }
    protected void btnLuu_Click(object sender, EventArgs e)
    {

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
            image = ulr + filename;
        }
        cls_LandingPage_Video_HuongDan cls = new cls_LandingPage_Video_HuongDan();

        if (checknull() == false)
            alert.alert_Warning(Page, "Vui lòng nhập đầy đủ thông tin!", "");
        else
        {

            if (Session["_id"].ToString() == "0")
            {
                if (image == null)
                {
                    image = "/images/520x350.jpg";
                }

                if (cls.insert_Data(txtTieuDe.Text,txtCap.Text,txtLink.Text, image))
                {
                    alert.alert_Success(Page, "Thêm thành công", "");
                    popupControl.ShowOnPageLoad = false;
                    loadData();
                }
                else alert.alert_Error(Page, "Thêm thất bại", "");
            }
            else
                if (cls.Update_Data(Convert.ToInt32(Session["_id"].ToString()), txtTieuDe.Text, txtCap.Text, txtLink.Text, image))
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Cập nhật thành công','','success').then(function(){grvList.Refresh();})", true);
                popupControl.ShowOnPageLoad = false;
                loadData();
            }
            else alert.alert_Error(Page, "Cập nhật thất bại", "");
        }
        loadData();
    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "videohuongdan_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                cls_LandingPage_Video_HuongDan cls = new cls_LandingPage_Video_HuongDan();
                tbLandingPage_VideoHuongDan checkImage = (from i in db.tbLandingPage_VideoHuongDans where i.videohuongdan_id == Convert.ToInt32(item) select i).SingleOrDefault();
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