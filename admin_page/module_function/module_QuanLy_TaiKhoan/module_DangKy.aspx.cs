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
        var getData = from nc in db.tbDangKies
                          //join bg in db.tbLandingPage_BangGias on nc.dangky_goi equals bg.banggia_id+""
                      where nc.dangky_tinhtrang == "Đang chờ"
                      //orderby nc.dangky_id descending
                      select new
                      {
                          nc.dangky_id,
                          nc.dangky_sodienthoai,
                          nc.dangky_hotenhocsinh,
                          nc.dangky_lop,
                          nc.dangky_tinhtrang,
                          nc.dangky_goi
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
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "dangky_id" }));
        // đẩy id vào session
        Session["_id"] = _id;
        var getData = (from nc in db.tbDangKies
                       where nc.dangky_id == _id
                       select new
                       {
                           nc.dangky_sodienthoai,
                           nc.dangky_hotenhocsinh,
                           nc.dangky_lop,
                           nc.dangky_goi
                       }).Single();
        txtSoDienThoai.Text = getData.dangky_sodienthoai;
        txtHoTenHocSinh.Text = getData.dangky_hotenhocsinh;
        txtLop.Text = getData.dangky_lop;
        txtGoi.Text = getData.dangky_goi;
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
        cls_DangKy cls = new cls_DangKy();
        // -------Code dưới này dùng chung cho 4 cấp--------
        var getdk = (from ch in db.tbDangKies 
                     where ch.dangky_id == Convert.ToInt32(Session["_id"]) select ch).FirstOrDefault();
        tbAccount account = new tbAccount();
        account.account_sodienthoai = getdk.dangky_sodienthoai;
        account.account_matkhau = "12378248145104161527610811213823414203124130";
        account.account_active = true;
        account.account_goi = txtGoi.Text;
        db.tbAccounts.InsertOnSubmit(account);
        db.SubmitChanges();
        tbDangKy update = db.tbDangKies.Where(x => x.dangky_id == Convert.ToInt32(Session["_id"])).FirstOrDefault();
        update.dangky_tinhtrang = "Đã duyệt";
        db.SubmitChanges();
        tbAccount_Children account_Children = new tbAccount_Children();
        account_Children.children_fullname = getdk.dangky_hotenhocsinh;
        account_Children.children_active = true;
        account_Children.lop_id = Convert.ToInt32(getdk.dangky_lop);
        account_Children.account_id = account.account_id;
        account_Children.children_image = "/images/user_noimage.jpg";
        db.tbAccount_Childrens.InsertOnSubmit(account_Children);
        db.SubmitChanges();
        //----- Kết thúc đoạn code trên------
        // ---- Code dưới này dùng cho bên tiểu học --------
        //var gettg = (from ch in db.tbAccount_Childrens where ch.account_id == account.account_id select ch.children_id).FirstOrDefault();
        //tbThoiGian thoiGian = new tbThoiGian();
        //thoiGian.children_id = gettg;
        ////thoiGian.sach_id = 1;
        ////thoiGian.thoigian_caidat = 60;
        ////thoiGian.thoigian_hengio = 180;
        ////thoiGian.thoigian_conlai = 3600;
        //db.tbThoiGians.InsertOnSubmit(thoiGian);
        //db.SubmitChanges();
        // Code dưới dành cho tiểu học
        if (Convert.ToInt16(getdk.dangky_lop) <= 5)
        {
            var getctbt = (from ctbt in db.tbChiTietBaiTaps
                           join ac in db.tbAccount_Childrens on ctbt.lop_id equals ac.lop_id
                           where ac.account_id == account.account_id
                           orderby ctbt.chitietbaitap_id ascending
                           select ctbt);
            tbLichSuLamBaiHocSinh lichsu = new tbLichSuLamBaiHocSinh();
            lichsu.children_id = account_Children.children_id;
            lichsu.chitietbaitap_id = getctbt.First().chitietbaitap_id;
            //lichsu.chitietbaitap_id = 1;
            lichsu.lichsulambai_status = "acvive";
            db.tbLichSuLamBaiHocSinhs.InsertOnSubmit(lichsu);
            db.SubmitChanges();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Duyệt thành công','','success').then(function(){grvList.Refresh();})", true);
        }
            //----- Kết thúc đoạn code trên------
        //làm thế nào để thông báo với account đăng ký? a Đức: sau khi duyệt xong thì lấy số đt 

    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
        cls_DangKy cls;
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "dangky_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                cls = new cls_DangKy();
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
