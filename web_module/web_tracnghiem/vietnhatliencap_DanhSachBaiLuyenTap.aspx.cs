using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_web_tracnghiem_vietnhatliencap_DanhSachBaiLuyenTap : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int hocsinh_id;
    private string hocsinh_code;
    protected void Page_Load(object sender, EventArgs e)
    {
        //try
        //{
        //string[] arrListStr = Request.Cookies["PhuHuynhVietNhat"].Value.Split(',');

        //if (arrListStr[0] == "hocsinh")// nếu là học sinh đăng nhập
        //{
        //    var checkHS = (from hs in db.tbHocSinhs
        //                   where hs.hocsinh_taikhoan == arrListStr[1]
        //                   select hs).Single();
        //    hocsinh_id = checkHS.hocsinh_id;
        //    hocsinh_code = checkHS.hocsinh_taikhoan;

        //    var checkNamHoc = (from nh in db.tbHoctap_NamHocs orderby nh.namhoc_id descending select nh).First();
        //    var checkHocSinh = (from hs in db.tbHocSinhs
        //                        join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
        //                        join l in db.tbLops on hstl.lop_id equals l.lop_id
        //                        where hstl.namhoc_id == checkNamHoc.namhoc_id && hs.hidden == false && hs.hocsinh_id == hocsinh_id
        //                        orderby hstl.hstl_id
        //                        select hstl).FirstOrDefault();
        //int _idKhoi = Convert.ToInt32(RouteData.Values["id_khoi"]);
        //int _idMon = Convert.ToInt32(RouteData.Values["id_mon"]);
        int _idKhoi = 10;
        int _idMon = 6;
        var getData = from t in db.tbTracNghiem_Tests
                      join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
                      where t.khoi_id == _idKhoi && t.monhoc_id == _idMon && lt.luyentap_status == 2//bài luyện tập
                      && t.hidden == true
                      orderby t.test_id descending
                      select new
                      {
                          t.monhoc_id,
                          t.test_id,
                          lt.luyentap_id,
                          lt.luyentap_name,
                          khoi_id = _idKhoi,
                          t.test_createdate,
                          t.test_link,
                          tongcauhoi = t.test_soluongcauhoi,
                          solanlam = 3,//(from rs in db.tbTracNghiem_ResultTests
                                      //where rs.test_id == t.test_id && rs.hstl_id == checkHocSinh.hstl_id
                                      //select rs).Count(),
                          thoigianlambai = (Convert.ToInt32(t.test_thoigianlambai) / 60) + "p",
                          tinhtrang = (from rs in db.tbTracNghiem_ResultTests
                                       where rs.test_id == t.test_id && rs.hocsinh_code == hocsinh_code
                                       select rs).Count() == 0 ? "Chưa làm bài" : (from rs in db.tbTracNghiem_ResultTests
                                                                                   where rs.test_id == t.test_id && rs.hocsinh_code == hocsinh_code
                                                                                   select rs).Count() < 3 && (from rs in db.tbTracNghiem_ResultTests
                                                                                                              where rs.test_id == t.test_id && rs.hocsinh_code == hocsinh_code
                                                                                                              select rs).Count() > 0 ? "Chưa làm đủ số lần" : "Đã làm " + (from rs in db.tbTracNghiem_ResultTests
                                                                                                                                                                           where rs.test_id == t.test_id && rs.hocsinh_code == hocsinh_code
                                                                                                                                                                           select rs).Count().ToString() + " lần",

                      };

        rpTracNghiem.DataSource = getData;
        rpTracNghiem.DataBind();
        //}
        //catch (Exception)
        //{
        //    Response.Redirect("/trang-chu");
        //}
        //}
        //else
        //{
        //    alert.alert_Warning(Page, "Vui lòng đăng nhập tài khoản học sinh để vào làm bài!", "");
        //}
    }
}