using DevExpress.Web.ASPxHtmlEditor;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_WebSite_module_DangKy : System.Web.UI.Page
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
        var getData = from nc in db.tbAccount_LichSu_GiaHans
                      join a in db.tbAccounts on nc.account_id equals a.account_id
                      join cr in db.tbAccount_Childrens on a.account_id equals cr.account_id
                      join l in db.tbLops on cr.lop_id equals l.lop_id
                      //join bg in db.tbLandingPage_BangGias on nc.dangky_goi equals bg.banggia_id+""
                      where nc.lichsugianhan_tinhtrang == "Đang chờ"
                      //orderby nc.dangky_id descending
                      select new
                      {
                          nc.lichsugianhan_id,
                          cr.children_fullname,
                          a.account_sodienthoai,
                          l.lop_name,
                          nc.lichsugianhan_goigiahan,
                          nc.lichsugianhan_tinhtrang
                      };
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
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "lichsugianhan_id" }));
        // đẩy id vào session
        Session["_id"] = _id;
        var getData = (from nc in db.tbAccount_LichSu_GiaHans
                       join a in db.tbAccounts on nc.account_id equals a.account_id
                       join cr in db.tbAccount_Childrens on a.account_id equals cr.account_id
                       join l in db.tbLops on cr.lop_id equals l.lop_id
                       //join bg in db.tbLandingPage_BangGias on nc.dangky_goi equals bg.banggia_id+""
                       where nc.lichsugianhan_id == _id
                       select new
                       {
                           nc.lichsugianhan_id,
                           cr.children_fullname,
                           a.account_sodienthoai,
                           l.lop_name,
                           nc.lichsugianhan_goigiahan,
                           nc.lichsugianhan_tinhtrang
                       }
                       ).Single();
        txtSoDienThoai.Text = getData.account_sodienthoai;
        txtHoTenHocSinh.Text = getData.children_fullname;
        txtLop.Text = getData.lop_name;
        txtGoi.Text = getData.lichsugianhan_goigiahan;
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
        // Kiểm tra gói gia hạn
        tbAccount_LichSu_GiaHan checkGiaHan = (from gh in db.tbAccount_LichSu_GiaHans
                                               where gh.lichsugianhan_id == Convert.ToInt32(Session["_id"])
                                               select gh).FirstOrDefault();
        checkGiaHan.lichsugianhan_tinhtrang = "Đã duyệt";
        db.SubmitChanges();
        tbAccount getAccount = (from ch in db.tbAccount_LichSu_GiaHans
                                join a in db.tbAccounts on ch.account_id equals a.account_id
                                where ch.lichsugianhan_id == Convert.ToInt32(Session["_id"])
                                select a).FirstOrDefault();
        // cập nhật vào ngày gia hạn
        getAccount.account_ngaygiahan = DateTime.Now;
        if (getAccount.account_solan_giahan == null)
            getAccount.account_solan_giahan = 1;
        else
            getAccount.account_solan_giahan = getAccount.account_solan_giahan + 1;
        // gói gia hạn sẽ được tính lên cho ngày kết thúc
        if (checkGiaHan.lichsugianhan_goigiahan.Contains("1 tuần"))
            getAccount.account_ngayketthuc = getAccount.account_ngayketthuc.Value.AddDays(7);
        if (checkGiaHan.lichsugianhan_goigiahan.Contains("1 tháng"))
            getAccount.account_ngayketthuc = getAccount.account_ngayketthuc.Value.AddDays(30);
        if (checkGiaHan.lichsugianhan_goigiahan.Contains("6 tháng"))
            getAccount.account_ngayketthuc = getAccount.account_ngayketthuc.Value.AddDays(180);
        if (checkGiaHan.lichsugianhan_goigiahan.Contains("1 năm"))
            getAccount.account_ngayketthuc = getAccount.account_ngayketthuc.Value.AddDays(365);
        if (checkGiaHan.lichsugianhan_goigiahan.Contains("trọn gói"))
            getAccount.account_ngayketthuc = null;
        db.SubmitChanges();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Gia hạn thành công','','success').then(function(){grvList.Refresh();})", true);
    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
        cls_GiaHan cls;
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "lichsugianhan_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                cls = new cls_GiaHan();
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

    protected void btnKhoa_Click(object sender, EventArgs e)
    {
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "dangky_id" }));
        var dangKyStatus = (from nc in db.tbDangKies where nc.dangky_id == _id select nc).FirstOrDefault();
        if (dangKyStatus.dangky_tinhtrang == "Đang chờ")
        {
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Tài khoản chưa được kích hoạt','','warning').then(function(){grvList.Refresh();})", true);
        }
        else
        {
            var accountIsActive = (from yt in db.tbAccounts where yt.account_sodienthoai == dangKyStatus.dangky_sodienthoai select yt.account_active).FirstOrDefault();
            if (accountIsActive == true)
            {
                tbAccount update = db.tbAccounts.Where(x => x.account_sodienthoai == dangKyStatus.dangky_sodienthoai).FirstOrDefault();
                update.account_active = false;
                db.SubmitChanges();
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Khóa thành công','','success').then(function(){grvList.Refresh();})", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Tài khoản đã khóa','','error').then(function(){grvList.Refresh();})", true);
            }
        }
    }

    protected void btnMoKhoa_Click(object sender, EventArgs e)
    {
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "dangky_id" }));
        var dangKyStatus = (from nc in db.tbDangKies where nc.dangky_id == _id select nc).FirstOrDefault();
        var accountStatus = (from ch in db.tbAccounts where ch.account_sodienthoai == dangKyStatus.dangky_sodienthoai select ch).FirstOrDefault();
        if (accountStatus == null)
        {
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Tài khoản chưa duyệt','','success').then(function(){grvList.Refresh();})", true);
        }
        else
        {
            if (accountStatus.account_active == false)
            {
                tbAccount update = db.tbAccounts.Where(x => x.account_sodienthoai == dangKyStatus.dangky_sodienthoai).FirstOrDefault();
                update.account_active = true;
                db.SubmitChanges();
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Mở khóa thành công','','success').then(function(){grvList.Refresh();})", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Mở khóa thất bại','','error').then(function(){grvList.Refresh();})", true);
            }
        }
    }
}
