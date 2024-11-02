using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_XepHangHocSinhLamBaiTapVeNha : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int user_id;
    private int namhoc_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {
            var getUser = (from u in db.admin_Users
                           where u.username_username == Request.Cookies["UserName"].Value
                           select u).FirstOrDefault();
            var checkNamHoc = (from nh in db.tbHoctap_NamHocs orderby nh.namhoc_id descending select nh).First();
            user_id = getUser.username_id;
            namhoc_id = checkNamHoc.namhoc_id;
            if (!IsPostBack)
            {
                //get ds các lớp gv dạy
                var listLop = from l in db.tbLops
                              join gvtl in db.tbGiaoVienTrongLops on l.lop_id equals gvtl.lop_id
                              where gvtl.taikhoan_id == user_id && gvtl.namhoc_id == checkNamHoc.namhoc_id
                              select l;
                ddlLop.DataSource = listLop;
                ddlLop.DataBind();
            }
        }
        else
        {
            Response.Redirect("/admin-login");
        }
    }

    protected void ddlLop_SelectedIndexChanged(object sender, EventArgs e)
    {
        var listMon = (from mh in db.tbTKB_Mons
                       join mhtl in db.tbTKB_GiaoVienDayMon_Tests on mh.mon_id equals mhtl.mon_id
                       where mhtl.lop_id == Convert.ToInt32(ddlLop.SelectedItem.Value) && mh.mon_position != null && mhtl.username_id == user_id
                       orderby mh.mon_loai ascending
                       select mh);
        ddlMon.DataSource = listMon;
        ddlMon.DataBind();
    }

    protected void ddlMon_SelectedIndexChanged(object sender, EventArgs e)
    {
        var getKhoi = (from l in db.tbLops where l.lop_id == Convert.ToInt32(ddlLop.SelectedItem.Value) select l).FirstOrDefault();

        var listBaiLuyenTap = (from tn in db.tbTracNghiem_Tests
                               //join l in db.tbLops on tn.khoi_id equals l.khoi_id
                               //join mh in db.tbTKB_Mons on tn.monhoc_id equals mh.mon_id
                               join blt in db.tbTracNghiem_BaiLuyenTaps on tn.luyentap_id equals blt.luyentap_id
                               where tn.monhoc_id == Convert.ToInt32(ddlMon.SelectedItem.Value) && tn.username_id == user_id
                               && tn.khoi_id == getKhoi.khoi_id && blt.luyentap_status == 2 && tn.hidden == true
                               select new
                               {
                                   blt.luyentap_id,
                                   blt.luyentap_name,
                               });
        ddlBaiLuyenTap.DataSource = listBaiLuyenTap;
        ddlBaiLuyenTap.DataBind();
    }

    protected void ddlBaiLuyenTap_SelectedIndexChanged(object sender, EventArgs e)
    {
        var getDanhSach = from hs in db.tbHocSinhs
                          join rs in db.tbTracNghiem_ResultTests on hs.hocsinh_taikhoan equals rs.hocsinh_code
                          join t in db.tbTracNghiem_Tests on rs.test_id equals t.test_id
                          join blt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals blt.luyentap_id
                          where blt.luyentap_id == Convert.ToInt32(ddlBaiLuyenTap.SelectedItem.Value)
                          group new { rs, blt, hs, t } by new { rs.hocsinh_code, blt.luyentap_id, t.test_id } into g
                          select new
                          {
                              hocsinh_code = g.Key.hocsinh_code,
                              luyentap_name = g.First().blt.luyentap_name,
                              hocsinh_name = g.First().hs.hocsinh_hohocsinh + g.First().hs.hocsinh_name,
                              socaudung = (from rs in db.tbTracNghiem_ResultTests
                                           where rs.test_id == g.Key.test_id && rs.hocsinh_code == g.Key.hocsinh_code
                                           select rs).Max(x => Convert.ToInt32(x.resulttest_result)),
                              solanlambai = g.Count(),
                              tongsocau = (from t in db.tbTracNghiem_Tests where t.test_id == g.Key.test_id select t).First().test_soluongcauhoi,
                              thoigianngannhat = (from rs in db.tbTracNghiem_ResultTests
                                                  where rs.test_id == g.Key.test_id && rs.hocsinh_code == g.Key.hocsinh_code
                                                  select rs).Min(x => x.result_thoigianlambai),
                          };
        var sortedRecords = (getDanhSach.OrderByDescending(rs => Convert.ToInt32(rs.socaudung)).ThenBy(rs => rs.solanlambai).ThenBy(rs => rs.thoigianngannhat));
        rpXepHangHocSinh.DataSource = sortedRecords;
        rpXepHangHocSinh.DataBind();
        rpModalChiTiet.DataSource = getDanhSach;
        rpModalChiTiet.DataBind();
    }

    protected void rpModalChiTiet_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpChiTietLamBai = e.Item.FindControl("rpChiTietLamBai") as Repeater;
        string hocsinh_code = DataBinder.Eval(e.Item.DataItem, "hocsinh_code").ToString();
        var getChiTiet = from ct in db.tbTracNghiem_ResultTests
                         join hs in db.tbHocSinhs on ct.hocsinh_code equals hs.hocsinh_taikhoan
                         join t in db.tbTracNghiem_Tests on ct.test_id equals t.test_id
                         join blt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals blt.luyentap_id
                         where ct.hocsinh_code == hocsinh_code && blt.luyentap_id == Convert.ToInt32(ddlBaiLuyenTap.SelectedItem.Value)
                         select new {
                             hs.hocsinh_id,
                             hocsinh_code = hocsinh_code,
                             hocsinh_name = hs.hocsinh_hohocsinh + hs.hocsinh_name,
                             ct.resulttest_datetime,
                             ct.result_thoigianlambai,
                             ct.resulttest_result
                         };
        rpChiTietLamBai.DataSource = getChiTiet;
        rpChiTietLamBai.DataBind();
    }
}