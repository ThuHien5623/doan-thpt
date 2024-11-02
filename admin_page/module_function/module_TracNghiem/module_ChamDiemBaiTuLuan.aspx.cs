﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_ThongKeHocSinhLamBaiLuyenTap : System.Web.UI.Page
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
        if (ddlMon.SelectedIndex != -1)
        {
            var getLop = (from l in db.tbLops
                          where l.lop_id == Convert.ToInt32(ddlLop.SelectedItem.Value)
                          select l).FirstOrDefault();
            //get ds bài luyện tập
            var getDanhSachBaiLuyenTap = from blt in db.tbTracNghiem_BaiLuyenTaps
                                         join test in db.tbTracNghiem_Tests on blt.luyentap_id equals test.luyentap_id
                                         where test.khoi_id == getLop.khoi_id && test.monhoc_id == Convert.ToInt32(ddlMon.SelectedItem.Value)
                                         && blt.luyentap_status == 2 && test.hidden == true && blt.luyentap_baitaptuluan == "luyện tập tự luận"
                                         select new
                                         {
                                             blt.luyentap_id,
                                             blt.luyentap_name,
                                             test.test_id,
                                             dalam = (from rs in db.tbTracNghiem_ResultTests
                                                      join hs in db.tbHocSinhs on rs.hocsinh_code equals hs.hocsinh_taikhoan
                                                      join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                                                      join l in db.tbLops on hstl.lop_id equals l.lop_id
                                                      where rs.test_id == test.test_id && hstl.namhoc_id == namhoc_id && hstl.hidden == false && hs.hidden == false
                                                       && l.lop_id == Convert.ToInt32(ddlLop.SelectedItem.Value)
                                                      group rs by rs.hocsinh_code into k
                                                      select k).Count(),
                                             tonghs = (from hs in db.tbHocSinhs
                                                       join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                                                       join l in db.tbLops on hstl.lop_id equals l.lop_id
                                                       where hstl.namhoc_id == namhoc_id && hstl.hidden == false && hs.hidden == false
                                                       && l.lop_id == Convert.ToInt32(ddlLop.SelectedItem.Value)
                                                       select hs).Count(),

                                         };
            rpDanhSachBaiLuyenTap.DataSource = getDanhSachBaiLuyenTap;
            rpDanhSachBaiLuyenTap.DataBind();
            rpDanhSachHocSinh.DataSource = null;
            rpDanhSachHocSinh.DataBind();
            rpModalChiTiet.DataSource = null;
            rpModalChiTiet.DataBind();
        }
    }

    protected void ddlMon_SelectedIndexChanged(object sender, EventArgs e)
    {
        var getLop = (from l in db.tbLops
                      where l.lop_id == Convert.ToInt32(ddlLop.SelectedItem.Value)
                      select l).FirstOrDefault();
        //get ds bài luyện tập
        var getDanhSachBaiLuyenTap = from blt in db.tbTracNghiem_BaiLuyenTaps
                                     join test in db.tbTracNghiem_Tests on blt.luyentap_id equals test.luyentap_id
                                     where test.khoi_id == getLop.khoi_id && test.monhoc_id == Convert.ToInt32(ddlMon.SelectedItem.Value)
                                     && blt.luyentap_status == 2 && test.hidden == true && blt.luyentap_baitaptuluan == "luyện tập tự luận"
                                     select new
                                     {
                                         blt.luyentap_id,
                                         blt.luyentap_name,
                                         test.test_id,
                                         dalam = (from rs in db.tbTracNghiem_ResultTests
                                                  join hs in db.tbHocSinhs on rs.hocsinh_code equals hs.hocsinh_taikhoan
                                                  join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                                                  join l in db.tbLops on hstl.lop_id equals l.lop_id
                                                  where rs.test_id == test.test_id && hstl.namhoc_id == namhoc_id && hstl.hidden == false && hs.hidden == false
                                                   && l.lop_id == Convert.ToInt32(ddlLop.SelectedItem.Value)
                                                  group rs by rs.hocsinh_code into k
                                                  select k).Count(),
                                         tonghs = (from hs in db.tbHocSinhs
                                                   join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                                                   join l in db.tbLops on hstl.lop_id equals l.lop_id
                                                   where hstl.namhoc_id == namhoc_id && hstl.hidden == false && hs.hidden == false
                                                   && l.lop_id == Convert.ToInt32(ddlLop.SelectedItem.Value)
                                                   select hs).Count(),

                                     };
        rpDanhSachBaiLuyenTap.DataSource = getDanhSachBaiLuyenTap;
        rpDanhSachBaiLuyenTap.DataBind();
    }

    protected void btnXemChiTiet_ServerClick(object sender, EventArgs e)
    {
        var getDanhSach = from hs in db.tbHocSinhs
                          join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                          //join rs in db.tbTracNghiem_ResultTests on hs.hocsinh_taikhoan equals rs.hocsinh_code
                          //join t in db.tbTracNghiem_Tests on rs.test_id equals t.test_id
                          join l in db.tbLops on hstl.lop_id equals l.lop_id
                          where hs.hidden == false  && hstl.namhoc_id == namhoc_id && hstl.hidden == false
                           && l.lop_id == Convert.ToInt32(ddlLop.SelectedItem.Value)
                          //group rs by rs.hocsinh_code into g
                          select new
                          {
                              hs.hocsinh_code,
                              hocsinh_name = hs.hocsinh_hohocsinh + hs.hocsinh_name
                          };
        rpDanhSachHocSinh.DataSource = getDanhSach;//.OrderByDescending(r => Convert.ToInt32(r.ketqua)).ThenBy(r => r.solanlambai).ThenBy(r => r.thoigianngannhat); ;
        rpDanhSachHocSinh.DataBind();
        rpModalChiTiet.DataSource = getDanhSach;
        rpModalChiTiet.DataBind();
        txtDSHSDaLamBai.Value = string.Join("|", getDanhSach.Select(x => x.hocsinh_code));
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setActive('" + txtLuyenTapID.Value + "')", true);
    }

    protected void rpModalChiTiet_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpChiTietLamBai = e.Item.FindControl("rpChiTietLamBai") as Repeater;
        string hocsinh_code = DataBinder.Eval(e.Item.DataItem, "hocsinh_code").ToString();
        var getChiTiet = from ct in db.tbTracNghiem_ResultTests
                         join hs in db.tbHocSinhs on ct.hocsinh_code equals hs.hocsinh_taikhoan
                         where ct.hocsinh_code == hocsinh_code && ct.test_id == Convert.ToInt32(txtLuyenTapID.Value)
                         select new
                         {
                             hs.hocsinh_id,
                             hocsinh_code = hocsinh_code,
                             hocsinh_name = hs.hocsinh_hohocsinh + hs.hocsinh_name,
                             resulttest_datetime = Convert.ToDateTime(ct.resulttest_datetime).ToShortDateString(),
                             ct.result_thoigianlambai,
                             ct.resulttest_result,

                         };
        //txtNgayLam.Value = string.Join("|", getChiTiet.Select(x => x.resulttest_datetime));
        //txtSoCauDung.Value = string.Join("|", getChiTiet.Select(x => x.resulttest_result));
        rpChiTietLamBai.DataSource = getChiTiet;
        rpChiTietLamBai.DataBind();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setActive('" + txtLuyenTapID.Value + "')", true);
    }

    protected void btnLuuDiem_ServerClick(object sender, EventArgs e)
    {

        var checkNamHoc = (from nh in db.tbHoctap_NamHocs orderby nh.namhoc_id descending select nh).First();
        var checkHocSinh = (from hs in db.tbHocSinhs
                            join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                            join l in db.tbLops on hstl.lop_id equals l.lop_id
                            where hs.hocsinh_code == txtHocSinhCode.Value && hstl.namhoc_id == checkNamHoc.namhoc_id
                            orderby hstl.hstl_id descending
                            select new
                            {
                                hs.hocsinh_mahocphi,
                                hs.hocsinh_id,
                                l.lop_id,
                                hstl.hstl_id,
                            }).FirstOrDefault();

        //tbTracNghiem_ResultTest insert = new tbTracNghiem_ResultTest();
        //insert.resulttest_result = "0";
        //insert.hocsinh_code = checkHocSinh.hocsinh_mahocphi;
        //insert.resulttest_datetime = DateTime.Now;
        //insert.test_id = Convert.ToInt32(RouteData.Values["id_test"]);
        //insert.result_thoigianlambai = txtFinish.Value;
        //insert.lop_id = checkHocSinh.lop_id;
        //insert.hstl_id = checkHocSinh.hstl_id;
        //insert.result_type = "bai luyen tap";
        //insert.namhoc_id = checkNamHoc.namhoc_id;
        //db.tbTracNghiem_ResultTests.InsertOnSubmit(insert);
        //db.SubmitChanges();
        //alert.alert_Success(Page, "Hoàn thành", "");
    }
}