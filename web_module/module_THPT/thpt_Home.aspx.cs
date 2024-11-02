using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_Home : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    protected void Page_Load(object sender, EventArgs e)
    {
        //sau nay cap nhat them khoi
        var getSlide = from sl in db.tbLandingPage_TungCap_Slides where sl.tungcap_slide_name == "THPT" select sl;
        rpSlide.DataSource = getSlide;
        rpSlide.DataBind();

        //lblSoLuongHocSinhLop10.Text = (from hstl in db.tbAccount_Childrens where hstl.lop_id == 10 select hstl).Count() + "";
        lblSoLuongHocSinhLop10.Text = (from hstl in db.tbDangKies where hstl.dangky_lop == "10" select hstl).Count() + "";
        lblSoLuongHocSinhLop11.Text = (from hstl in db.tbDangKies where hstl.dangky_lop == "11" select hstl).Count() + "";
        lblSoLuongHocSinhLop12.Text = (from hstl in db.tbDangKies where hstl.dangky_lop == "12" select hstl).Count() + "";
        //lblSoLuongHocSinhLop11.Text = (from hstl in db.tbAccount_Childrens where hstl.lop_id == 11 select hstl).Count() + "";
        //lblSoLuongHocSinhLop12.Text = (from hstl in db.tbAccount_Childrens where hstl.lop_id == 12 select hstl).Count() + "";
        var getThongBaoKiemTra = from tb in db.tb_SLLDT_ThongBaos orderby tb.thongbao_id descending select tb;
        rpThongBaoBaiKiemTra.DataSource = getThongBaoKiemTra;
        rpThongBaoBaiKiemTra.DataBind();
        var getImageDangKy = from dk in db.tbLandingPage_QuangCaos select dk;
        //rpDangKyHocVaThiOnline.DataSource = getImageDangKy;
        //rpDangKyHocVaThiOnline.DataBind();

        // Check Học sinh đang học lớp mấy
        var checkHocSinh = (from hs in db.tbDangKies where hs.dangky_taikhoan == Request.Cookies["taikhoan"].Value select hs);
        if (checkHocSinh.Count() > 0)
        {
            if (Convert.ToInt32(checkHocSinh.First().dangky_lop) == 10)
            {
                id_Lop10.Style["border"] = "3px solid red";
            }
            else if(Convert.ToInt32(checkHocSinh.First().dangky_lop) == 11)
            {
                id_Lop11.Style["border"] = "3px solid red";
            }
            else if(Convert.ToInt32(checkHocSinh.First().dangky_lop) == 12)
            {
                id_Lop12.Style["border"] = "3px solid red";
            }
        }

    }
    protected void btnKhoi_Click(object sender, EventArgs e)
    {
        var checkHocSinh = (from hs in db.tbDangKies where hs.dangky_taikhoan == Request.Cookies["taikhoan"].Value select hs);
        if (checkHocSinh.First().dangky_lop == txtKhoi_id.Value)
        {
            Response.Redirect("/app-danh-muc-khoi-thpt-"+ checkHocSinh.First().dangky_lop);
        }
        else
        {
            alert.alert_Error(Page,"Tài khoản không đăng ký lớp này!!!","");
        }
    }
}