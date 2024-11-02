using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_web_tracnghiem_web_DanhSachBaiLuyenTap : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    protected void Page_Load(object sender, EventArgs e)
    {
        int _idKhoi = Convert.ToInt32(RouteData.Values["id_khoi"]);
        int _idMon = Convert.ToInt32(RouteData.Values["id_mon"]);

        var getData = from t in db.tbTracNghiem_Tests
                      join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
                      where t.khoi_id == _idKhoi && t.monhoc_id == _idMon && lt.luyentap_status == 1//bài luyện tập
                      && t.hidden == false
                      orderby t.test_id descending
                      select new
                      {
                          t.monhoc_id,
                          t.test_id,
                          lt.luyentap_id,
                          lt.luyentap_name,
                          khoi_id = _idKhoi,
                          t.test_createdate,
                          tongcauhoi = (from ct in db.tbTracNghiem_TestDetails
                                        where ct.test_id == t.test_id
                                        select ct).Count(),
                      };

        rpTracNghiem.DataSource = getData;
        rpTracNghiem.DataBind();

    }
}