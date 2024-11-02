using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_LichSuBaiLuyenTap : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public static int luyentap_id, mon_id, khoi_id;
    public string bailuyentap_name;
    public int STT = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        khoi_id = Convert.ToInt32(RouteData.Values["khoi-id"]);
        mon_id = Convert.ToInt32(RouteData.Values["mon-id"]);
        luyentap_id = Convert.ToInt32(RouteData.Values["luyentap-id"]);
        bailuyentap_name = (from lt in db.tbTracNghiem_BaiLuyenTaps where lt.luyentap_id == luyentap_id select lt).FirstOrDefault().luyentap_name;
        getThanhTich(mon_id, luyentap_id);
    }
    protected void getThanhTich(int mon, int bailuyentap)
    {
        // get Lớp get môn
        lblLop.Text = khoi_id + "";
        mon = mon_id;
        lblMon.Text = (from m in db.tbTKB_Mons where m.mon_id == mon select m).FirstOrDefault().mon_name.ToString();
        // Thành tích luyện tập từng bài
        var checktaikhoan = (from tb in db.tbAccounts
                             join hstl in db.tbAccount_Childrens on tb.account_id equals hstl.account_id
                             where tb.account_sodienthoai == Request.Cookies["taikhoan"].Value
                             select new
                             {
                                 tb.account_id,
                                 hstl.children_id
                             }).FirstOrDefault();
        var getDataTungBai = (from rt in db.tbTracNghiem_ResultTests
                              join t in db.tbTracNghiem_Tests on rt.test_id equals t.test_id
                              join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
                              join cr in db.tbAccount_Childrens on rt.hstl_id equals cr.children_id
                              join a in db.tbAccounts on cr.account_id equals a.account_id
                              where t.monhoc_id == mon && lt.luyentap_id == bailuyentap && a.account_id == checktaikhoan.account_id
                              select new
                              {
                                  cr.children_id,
                                  cr.children_fullname,
                                  rt.resulttest_result,
                                  rt.resulttest_datetime,
                                  ThoiGianLamBai = (from rt1 in db.tbTracNghiem_ResultTests
                                                    where rt1.hstl_id == cr.children_id
                                                    orderby rt1.result_thoigianlambai
                                                    select rt1).FirstOrDefault().result_thoigianlambai,

                              });
        rpThanhTich.DataSource = getDataTungBai;
        rpThanhTich.DataBind();
    }
}