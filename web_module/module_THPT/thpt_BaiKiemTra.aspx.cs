using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_BaiKiemTra : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int khoi_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        khoi_id = Convert.ToInt32(RouteData.Values["khoi-id"]);
        getBaiKiemTra(Convert.ToInt32(Request.Cookies["monhoc"].Value));
    }
    protected void getBaiKiemTra(int mon)
    {
        //get Bài tập đã làm lần cuối cho tới bài tiếp theo

        if (Request.Cookies["taikhoan"] != null)
        {
            var checkHocSinhDaLamBai = from rt in db.tbTracNghiem_ResultTests
                                       join t in db.tbTracNghiem_Tests on rt.test_id equals t.test_id
                                       join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
                                       join hs in db.tbDangKies on rt.hstl_id equals hs.dangky_id
                                       where hs.dangky_taikhoan == Request.Cookies["taikhoan"].Value
                                        && t.monhoc_id == mon
                                        && t.khoi_id == Convert.ToInt32(RouteData.Values["khoi-id"])
                                        && lt.luyentap_status == 1
                                       select new
                                       {
                                           t.test_id,
                                           lt.luyentap_name,
                                           lt.luyentap_id
                                       };
            // Học sinh chưa làm bài thì lấy bài đầu tiên của môn học active
            if (checkHocSinhDaLamBai.Count() == 0)
            {
                var getBaiTapLanCuoi = from rt in db.tbTracNghiem_BaiLuyenTaps
                                       join t in db.tbTracNghiem_Tests on rt.luyentap_id equals t.luyentap_id
                                       where t.monhoc_id == mon
                                       && t.khoi_id == Convert.ToInt32(RouteData.Values["khoi-id"])
                                         && rt.luyentap_status == 1
                                       select new
                                       {
                                           t.test_link,
                                           rt.luyentap_name,
                                           rt.luyentap_id,
                                           t.test_id,
                                       };
                rpBaiKiemTra.DataSource = getBaiTapLanCuoi;
                rpBaiKiemTra.DataBind();
            }
            // Học sinh đã làm bài tập thì sẽ cho hiển thì các bài tiếp theo
            else
            {
                int id_luyentaphientai = Convert.ToInt32(checkHocSinhDaLamBai.OrderByDescending(x => x.luyentap_id).FirstOrDefault().luyentap_id);
                var checkHocSinhDaLamBaiTiepTheo = from rt in db.tbTracNghiem_ResultTests
                                                   join t in db.tbTracNghiem_Tests on rt.test_id equals t.test_id
                                                   join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
                                                   join cr in db.tbDangKies on rt.hstl_id equals cr.dangky_id
                                                   where
                                                   //a.account_sodienthoai == Request.Cookies["taikhoan"].Value
                                                     t.monhoc_id == mon
                                                    && t.khoi_id == Convert.ToInt32(RouteData.Values["khoi-id"])
                                                    && lt.luyentap_id > id_luyentaphientai
                                                    && lt.luyentap_status == 1
                                                   group lt by new { lt.luyentap_name, lt.luyentap_id } into g
                                                   select new
                                                   {
                                                       g.Key.luyentap_name,
                                                       g.Key.luyentap_id,
                                                       test_link = from t in db.tbTracNghiem_Tests where t.luyentap_id == g.Key.luyentap_id select t.test_link,
                                                       test_id = from t in db.tbTracNghiem_Tests where t.luyentap_id == g.Key.luyentap_id select t.test_id,
                                                   };
                rpBaiKiemTra.DataSource = checkHocSinhDaLamBaiTiepTheo;
                rpBaiKiemTra.DataBind();
            }
        }
        else Response.Redirect("/thpt-trang-chu");
    }
}