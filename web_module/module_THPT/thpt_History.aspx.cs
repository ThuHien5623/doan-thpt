using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_History : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public static int khoi_id, hocsinh_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["taikhoan"] != null)
        {
            var checkHocSinh = (from hs in db.tbAccounts where hs.account_sodienthoai == Request.Cookies["taikhoan"].Value select hs);
            if (checkHocSinh.Count() > 0)
            {
                // Kiểm tra học sinh hiện tại đã học lớp mấy
                var checkHocSinhTrongLop = from hstl in db.tbAccount_Childrens
                                           where hstl.account_id == checkHocSinh.First().account_id && hstl.children_active == true
                                           select hstl;
                hocsinh_id = checkHocSinhTrongLop.FirstOrDefault().children_id;
                if (Session["khoi"] != null)
                {
                    khoi_id = Convert.ToInt32(Session["khoi"].ToString());
                    if (khoi_id == 10)
                        btnLop10.Style["border"] = "3px solid #af0000";
                    if (khoi_id == 11)
                        btnLop11.Style["border"] = "3px solid #af0000";
                    if (khoi_id == 12)
                        btnLop12.Style["border"] = "3px solid #af0000";
                }
                else
                {
                    if (checkHocSinhTrongLop.First().lop_id == 10)
                    {
                        btnLop10.Style["border"] = "3px solid #af0000";
                        khoi_id = 10;
                    }
                    if (checkHocSinhTrongLop.First().lop_id == 11)
                    {
                        btnLop11.Style["border"] = "3px solid #af0000";
                        khoi_id = 11;
                    }
                    if (checkHocSinhTrongLop.First().lop_id == 12)
                    {
                        btnLop12.Style["border"] = "3px solid #af0000";
                        khoi_id = 12;
                    }
                }
                if (!IsPostBack)
                {
                    var getMon = from m in db.tbTKB_Mons
                                 join mhck in db.tbMonHocCuaKhois on m.mon_id equals mhck.mon_id
                                 where mhck.khoi_id == khoi_id
                                 orderby m.mon_id
                                 select new
                                 {
                                     m.mon_id,
                                     m.mon_name,
                                     m.mon_image,
                                     khoi_id = khoi_id,
                                     mon_active = m.mon_id == Convert.ToInt32(Request.Cookies["monhoc"].Value) ? "style='border: 2px solid #af0000'" : ""
                                 };
                    rpMon.DataSource = getMon;
                    rpMon.DataBind();
                    loadDropdown();
                }
            }
        }
        else Response.Redirect("/thpt-trang-chu");
    }
    //load môn học
    private void loadMonHoc()
    {
        var getMon = from m in db.tbTKB_Mons
                     join mhck in db.tbMonHocCuaKhois on m.mon_id equals mhck.mon_id
                     where mhck.khoi_id == khoi_id
                     orderby m.mon_id
                     select new
                     {
                         m.mon_id,
                         m.mon_name,
                         m.mon_image,
                         khoi_id = khoi_id,
                         mon_active = m.mon_id == Convert.ToInt32(Request.Cookies["monhoc"].Value) ? "style='border: 2px solid #af0000'" : ""
                     };
        rpMon.DataSource = getMon;
        rpMon.DataBind();
    }
    //load dropdown list
    private void loadDropdown()
    {
        ddlBaiLuyenTap.DataSource = from lt in db.tbTracNghiem_BaiLuyenTaps
                                    join t in db.tbTracNghiem_Tests on lt.luyentap_id equals t.luyentap_id
                                    where t.monhoc_id == Convert.ToInt32(Request.Cookies["monhoc"].Value) && t.khoi_id == khoi_id && lt.luyentap_status == 2
                                    select new
                                    {
                                        lt.luyentap_name,
                                        lt.luyentap_id
                                    };
        ddlBaiLuyenTap.DataTextField = "luyentap_name";
        ddlBaiLuyenTap.DataValueField = "luyentap_id";
        ddlBaiLuyenTap.DataBind();
        ddlBaiKiemTra.DataSource = from lt in db.tbTracNghiem_BaiLuyenTaps
                                   join t in db.tbTracNghiem_Tests on lt.luyentap_id equals t.luyentap_id
                                   where t.monhoc_id == Convert.ToInt32(Request.Cookies["monhoc"].Value) && t.khoi_id == khoi_id && lt.luyentap_status == 1
                                   select new
                                   {
                                       lt.luyentap_name,
                                       lt.luyentap_id
                                   };
        ddlBaiKiemTra.DataTextField = "luyentap_name";
        ddlBaiKiemTra.DataValueField = "luyentap_id";
        ddlBaiKiemTra.DataBind();
        if (ddlBaiLuyenTap.SelectedValue != null && ddlBaiKiemTra.SelectedValue != "")
            getThanhTichBaiLuyenTap(Convert.ToInt32(Request.Cookies["monhoc"].Value), Convert.ToInt32(ddlBaiLuyenTap.SelectedItem.Value));
        if (ddlBaiKiemTra.SelectedValue != null && ddlBaiKiemTra.SelectedValue != "")
            getThanhTichBaiKiemTra(Convert.ToInt32(Request.Cookies["monhoc"].Value), Convert.ToInt32(ddlBaiKiemTra.SelectedItem.Value));
    }
    protected void getThanhTichBaiLuyenTap(int mon, int bailuyentap)
    {
        // Thành tích luyện tập từng bài
        var getDataTungBai = (from rt in db.tbTracNghiem_ResultTests
                              join t in db.tbTracNghiem_Tests on rt.test_id equals t.test_id
                              join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
                              join cr in db.tbAccount_Childrens on rt.hstl_id equals cr.children_id
                              join a in db.tbAccounts on cr.account_id equals a.account_id
                              where t.monhoc_id == mon
                               && t.khoi_id == khoi_id
                               && lt.luyentap_id == bailuyentap
                               && rt.hstl_id == hocsinh_id
                              orderby rt.resulttest_id descending
                              //group rt by rt.hstl_id into g
                              select new
                              {
                                  children_id = cr.children_id,
                                  children_fullname = cr.children_fullname,
                                  rt.resulttest_result,
                                  rt.resulttest_datetime,
                                  rt.result_thoigianlambai,
                              });
        if (getDataTungBai.Count() > 0)
        {
            rpThanhTichBaiLuyenTap.DataSource = getDataTungBai;
            rpThanhTichBaiLuyenTap.DataBind();
        }
        else
        {
            rpThanhTichBaiLuyenTap.DataSource = null;
            rpThanhTichBaiLuyenTap.DataBind();
        }
    }
    protected void getThanhTichBaiKiemTra(int mon, int bailuyentap)
    {
        // Thành tích luyện tập từng bài
        var getDataTungBai = (from rt in db.tbTracNghiem_ResultTests
                              join t in db.tbTracNghiem_Tests on rt.test_id equals t.test_id
                              join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
                              join cr in db.tbAccount_Childrens on rt.hstl_id equals cr.children_id
                              join a in db.tbAccounts on cr.account_id equals a.account_id
                              where t.monhoc_id == mon
                               && t.khoi_id == khoi_id
                               && lt.luyentap_id == bailuyentap
                               && rt.hstl_id == hocsinh_id
                              orderby rt.resulttest_id descending
                              //group rt by rt.hstl_id into g
                              select new
                              {
                                  children_id = cr.children_id,
                                  children_fullname = cr.children_fullname,
                                  rt.resulttest_result,
                                  rt.resulttest_datetime,
                                  rt.result_thoigianlambai,
                              });
        if (getDataTungBai.Count() > 0)
        {
            rpThanhTichBaiKiemTra.DataSource = getDataTungBai;
            rpThanhTichBaiKiemTra.DataBind();
        }
        else
        {
            rpThanhTichBaiKiemTra.DataSource = null;
            rpThanhTichBaiKiemTra.DataBind();
        }
    }
    protected void ddlBaiLuyenTap_SelectedIndexChanged(object sender, EventArgs e)
    {
        getThanhTichBaiLuyenTap(Convert.ToInt32(Request.Cookies["monhoc"].Value), Convert.ToInt32(ddlBaiLuyenTap.SelectedItem.Value));
    }

    protected void ddlBaiKiemTra_SelectedIndexChanged(object sender, EventArgs e)
    {
        getThanhTichBaiKiemTra(Convert.ToInt32(Request.Cookies["monhoc"].Value), Convert.ToInt32(ddlBaiKiemTra.SelectedItem.Value));
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "$('#pills-profile-tab').click();", true);
    }

    protected void btnChiTietMon_ServerClick(object sender, EventArgs e)
    {
        HttpCookie ck = new HttpCookie("monhoc");
        string s = ck.Value;
        ck.Value = txtMonID.Value;
        ck.Expires = DateTime.Now.AddDays(365);
        Response.Cookies.Add(ck);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "location.href = 'app-tai-khoan-lich-su-thpt';", true);
    }


    protected void btnLop10_ServerClick(object sender, EventArgs e)
    {
        btnLop10.Style["border"] = "3px solid #af0000";
        btnLop11.Style["border"] = "";
        btnLop12.Style["border"] = "";
        khoi_id = 10;
        Session["khoi"] = "10";
        loadDropdown();
        loadMonHoc();
    }

    protected void btnLop11_ServerClick(object sender, EventArgs e)
    {
        btnLop10.Style["border"] = "";
        btnLop11.Style["border"] = "3px solid #af0000";
        btnLop12.Style["border"] = "";
        khoi_id = 11;
        Session["khoi"] = "11";
        loadDropdown();
        loadMonHoc();
    }

    protected void btnLop12_ServerClick(object sender, EventArgs e)
    {
        btnLop10.Style["border"] = "";
        btnLop11.Style["border"] = "";
        btnLop12.Style["border"] = "3px solid #af0000";
        khoi_id = 12;
        Session["khoi"] = "12";
        loadDropdown();
        loadMonHoc();
    }
}