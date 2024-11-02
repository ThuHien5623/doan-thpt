using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_RenewPackage : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rpGoiThanhToan.DataSource = from g in db.tbLandingPage_BangGiaChiTiets where g.banggia_id == 3 select g;
            rpGoiThanhToan.DataBind();
            rpThongTinThanhToan.DataSource = from tt in db.tbLangdingPage_ThongTinThanhToans select tt;
            rpThongTinThanhToan.DataBind();
            // Đổ thông tin lên thanh toán
            var checkAccount = (from ac in db.tbAccounts
                                join cr in db.tbAccount_Childrens on ac.account_id equals cr.account_id
                                where ac.account_sodienthoai == Request.Cookies["taikhoan"].Value
                                select new { 
                                 cr.children_fullname,
                                 ac.account_sodienthoai,
                                 cr.lop_id,
                                }).FirstOrDefault();
            lblHoTen.Text = checkAccount.children_fullname;
            lblSoDienThoai.Text = checkAccount.account_sodienthoai;
            lblLop.Text = checkAccount.lop_id+"";
        }
    }
    protected void btnXacNhan_ServerClick(object sender, EventArgs e)
    {
        // check tài khoản gia hạn
        var checkAccount = (from ac in db.tbAccounts
                           where ac.account_sodienthoai == Request.Cookies["taikhoan"].Value
                           select ac).FirstOrDefault();
        if (checkAccount!=null)
        {
            tbAccount_LichSu_GiaHan giahan = new tbAccount_LichSu_GiaHan();
            giahan.account_sodienthoai = checkAccount.account_sodienthoai;
            giahan.account_id = checkAccount.account_id;
            giahan.lichsugianhan_goigiahan = txtGoiGiaHan.Value;
            giahan.lichsugianhan_tinhtrang = "Đang chờ";
            db.tbAccount_LichSu_GiaHans.InsertOnSubmit(giahan);
            db.SubmitChanges();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Đã gia hạn thành công!','Vui lòng đợi xác nhận từ quản trị','success').then(function(){window.location='/thpt-trang-chu';})", true);
        }

    }
}