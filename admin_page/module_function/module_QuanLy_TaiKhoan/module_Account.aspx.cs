using DevExpress.Web.ASPxHtmlEditor;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_WebSite_module_Account : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int _id;
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
        var getData = from nc in db.tbAccounts orderby nc.account_id descending select nc;
        //orderby nc.dangky_id descending
        // đẩy dữ liệu vào gridivew
        grvList.DataSource = getData;
        grvList.DataBind();
    }
    private void setNULL()
    {
        txtSoDienThoai.Text = "";
        txtHoTenHocSinh.Text = "";
        txtLop.Text = "";
        txtGoi.Text = "";
    }
    protected void btnThem_Click(object sender, EventArgs e)
    {
        // Khi nhấn nút thêm thì mật định session id = 0 để thêm mới
        Session["_id"] = 0;
        // gọi hàm setNull để trả toàn bộ các control về rỗng
        setNULL();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "popupControl.Show();", true);
        //loadData();
    }

    protected void btnChiTiet_Click(object sender, EventArgs e)
    {
        // get value từ việc click vào gridview
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "account_id" }));
        // đẩy id vào session
        Session["_id"] = _id;
        var getData = (from nc in db.tbAccounts
                       where nc.account_id == _id
                       select nc
                       ).Single();
        txtSoDienThoai.Text = getData.account_sodienthoai;
        //txtLop.Text = getData.dangky_lop;
        //txtGoi.Text = getData.dangky_goi;
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Detail", "popupControl.Show(); ", true);
        loadData();
    }
    public bool checknull()
    {
        if (txtSoDienThoai.Text != "")
            return true;
        else return false;
    }
    protected void btnLuu_Click(object sender, EventArgs e)
    {
    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
    }

    protected void btnKhoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "account_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                lock_TaiKhoan(Convert.ToInt32(item), false);
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Đã khóa thành công','','success').then(function(){grvList.Refresh();})", true);
            }
        }
        else
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
    }

    protected void btnMoKhoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "account_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                lock_TaiKhoan(Convert.ToInt32(item), true);
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Đã khóa thành công','','success').then(function(){grvList.Refresh();})", true);
            }
        }
        else
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
    }
    protected void lock_TaiKhoan(int item, bool khoa)
    {
        tbAccount getData = (from nc in db.tbAccounts
                             where nc.account_id == item
                             select nc
                      ).FirstOrDefault();
        getData.account_active = khoa;
        db.SubmitChanges();
    }
}
