using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class landingpage_THPT_thpt_Contact : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    public string hoten, sodienthoai, email, lop, goi;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var getLop = from l in db.tbLops where l.lop_ghichu == "THPT" && l.lop_active == true select l;
            ddlLop.Items.Clear();
            ddlLop.AppendDataBoundItems = true;
            ddlLop.Items.Add("Chọn lớp");
            ddlLop.DataSource = getLop;
            ddlLop.DataTextField = "lop_name";
            ddlLop.DataValueField = "lop_id";
            ddlLop.DataBind();
        }
    }

    protected void btnDangKy_ServerClick(object sender, EventArgs e)
    {
        if (db.tbDangKies.Any(ch => ch.dangky_taikhoan == txtTaiKhoan.Value))
        {
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Tài khoản đã tồn tại!','Vui lòng nhập lại tài khoản','error')", true);
        }
        else if (txtMatKhau.Value != txtNhapLaiMatKhau.Value)
        {
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Mật khẩu không khớp!','Vui lòng nhập lại mật khẩu','error')", true);
        }
        else if (ddlLop.SelectedValue == "Chọn lớp")
        {
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Vui lòng chọn lớp!','','error')", true);
        }
        else
        {
            tbDangKy dangky = new tbDangKy();
            dangky.dangky_sodienthoai = txtSoDienThoai.Value;
            dangky.dangky_hotenhocsinh = txtHoTen.Value;
            dangky.dangky_lop = ddlLop.SelectedValue;
            dangky.dangky_taikhoan = txtTaiKhoan.Value;
            dangky.dangky_matkhau = txtMatKhau.Value;
            db.tbDangKies.InsertOnSubmit(dangky);
            db.SubmitChanges();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Đăng ký thành công!','','success').then(function(){window.location='/thpt-trang-chu';})", true);
        }
    }
}