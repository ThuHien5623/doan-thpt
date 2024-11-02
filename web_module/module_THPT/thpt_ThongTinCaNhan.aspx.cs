using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_ThongTinCaNhan : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public string lop, sdt, gioitinh, name, image1;
    public DateTime ngaysinh;
    cls_Alert alert = new cls_Alert();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var getThongTinHocSinh = (from ac in db.tbAccounts
                                      join acchil in db.tbAccount_Childrens on ac.account_id equals acchil.account_id
                                      join l in db.tbLops on acchil.lop_id equals l.lop_id
                                      where acchil.children_active == true && ac.account_sodienthoai == Request.Cookies["taikhoan"].Value && ac.account_active == true
                                      select new
                                      {
                                          name = acchil.children_fullname,
                                          sodienthoai = ac.account_sodienthoai,
                                          gioitinh = acchil.children_gioitinh,
                                          acchil.children_image,
                                          lop = acchil.lop_id,
                                      }).FirstOrDefault();
            txtHoTen.Value = getThongTinHocSinh.name;
            image1 = getThongTinHocSinh.children_image;
            imgPreview1.Src = image1;
            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Detail", "showImg1('" + image1 + "'); ", true);
            txtLop.Value = getThongTinHocSinh.lop + "";
            //if (getThongTinHocSinh.ngaysinh != null)
            //    dteNgaySinh.Value = (DateTime)getThongTinHocSinh.ngaysinh + "";
            gioitinh = getThongTinHocSinh.gioitinh;
            if (gioitinh == "Nam")
                rdNam.Checked = true;
            else
                rdNu.Checked = true;
            txtSoDienThoai.Value = getThongTinHocSinh.sodienthoai;
        }
    }

    protected void btnLuu_ServerClick(object sender, EventArgs e)
    {
        if (Convert.ToInt16(txtLop.Value) < 10)
        {
            alert.alert_Error(Page, "Vui lòng nhập đúng với cấp học THPT", "");
        }
        else
        {
            if (Page.IsValid && FileUpload1.HasFile)
            {
                String folderUser = Server.MapPath("~/uploadimages/avatar-hoc-sinh/");
                if (!Directory.Exists(folderUser))
                {
                    Directory.CreateDirectory(folderUser);
                }
                //string filename;
                string ulr = "/uploadimages/avatar-hoc-sinh/";
                HttpFileCollection hfc = Request.Files;
                string filename = Path.GetRandomFileName() + Path.GetExtension(FileUpload1.FileName);
                string fileName_save = Path.Combine(Server.MapPath("~/uploadimages/avatar-hoc-sinh"), filename);
                FileUpload1.SaveAs(fileName_save);
                image1 = ulr + filename;
            }
            tbAccount getThongTinHocSinh = (from ac in db.tbAccounts
                                            where ac.account_sodienthoai == Request.Cookies["taikhoan"].Value && ac.account_active == true
                                            select ac).FirstOrDefault();
            tbAccount_Children update = (from cr in db.tbAccount_Childrens
                                         where cr.account_id == getThongTinHocSinh.account_id
                                         select cr).FirstOrDefault();
            update.children_fullname = txtHoTen.Value;
            update.lop_id = Convert.ToInt32(txtLop.Value);
            update.children_image = image1;
            if (rdNam.Checked == true)
                update.children_gioitinh = "Nam";
            else
                update.children_gioitinh = "Nữ";
            db.SubmitChanges();
            alert.alert_Success(Page, "Đã cập nhật thông tin cá nhân", "");
            imgPreview1.Src = image1;
        }
    }
}