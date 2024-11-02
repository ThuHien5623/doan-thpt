using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_DoiMatKhau : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public string matkhau;
    cls_Alert alert = new cls_Alert();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btnDoiMatKhau_ServerClick(object sender, EventArgs e)
    {
        if (txtMatKhauMoi.Value == txtNhapLaiMatKhauMoi.Value)
        {
            cls_security md5 = new cls_security();
            string passmd5 = md5.HashCode(txtMatKhauCu.Value);
            tbAccount getThongTinTaiKhoan = (from ac in db.tbAccounts
                                             where ac.account_sodienthoai == Request.Cookies["taikhoan"].Value && ac.account_matkhau == passmd5
                                             select ac).FirstOrDefault();
            if (getThongTinTaiKhoan != null)
            {
                string passmoimahoa = md5.HashCode(txtMatKhauMoi.Value);
                getThongTinTaiKhoan.account_matkhau = passmoimahoa;
                db.SubmitChanges();
                alert.alert_Success(Page, "Đổi mật khẩu thành công", "");
            }
            else
            {
                alert.alert_Error(Page, "Mật khẩu cũ không đúng", "");
            }
        }
        else
        {
            alert.alert_Error(Page, "Không khớp mật khẩu mới!", "");
        }
    }
}