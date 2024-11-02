using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_ThongKeTaoDeLuyenTap : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {
            var getTracNghiem = (from tnt in db.tbTracNghiem_Tests
                                 join u in db.admin_Users on tnt.username_id equals u.username_id
                                 where u.username_active == true && u.groupuser_id == 3
                                 group u by tnt.username_id into k
                                 select new
                                 {
                                     username_id = k.Key,
                                     username_fullname = (from gv in db.admin_Users where gv.username_id == Convert.ToInt32(k.Key) select gv.username_fullname).First(),
                                     count = k.Count(),
                                 }).OrderByDescending(x => x.count);

            rpTracNghiem.DataSource = getTracNghiem;
            rpTracNghiem.DataBind();
        }
        else
        {
            Response.Redirect("/admin-login");
        }
    }

    protected void rpTracNghiem_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpDanhSachLop = e.Item.FindControl("rpDanhSachLop") as Repeater;
        Repeater rpModalChiTiet = e.Item.FindControl("rpModalChiTiet") as Repeater;
        int username_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "username_id").ToString());
        var getData = from t in db.tbTracNghiem_Tests
                      join blt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals blt.luyentap_id
                      join u in db.admin_Users on t.username_id equals u.username_id
                      where u.username_id == username_id && blt.luyentap_status == 2
                      group t by t.khoi_id into k
                      select new
                      {
                          username_id = username_id,
                          username_fullname = (from gv in db.admin_Users where gv.username_id == username_id select gv.username_fullname).First(),
                          khoi_id = k.Key,
                          khoi_name = "Khối " + k.Key,
                          tongduyet = (from ct in db.tbTracNghiem_Tests
                                       join blt in db.tbTracNghiem_BaiLuyenTaps on ct.luyentap_id equals blt.luyentap_id
                                       where ct.username_id == username_id && ct.khoi_id == k.Key && ct.hidden == true && blt.luyentap_status == 2
                                       select ct).Count(),
                          tongde = (from ct in db.tbTracNghiem_Tests
                                    join blt in db.tbTracNghiem_BaiLuyenTaps on ct.luyentap_id equals blt.luyentap_id
                                    where ct.username_id == username_id && ct.khoi_id == k.Key && blt.luyentap_status == 2
                                    select ct).Count(),
                      };

        rpDanhSachLop.DataSource = getData;
        rpDanhSachLop.DataBind();
        rpModalChiTiet.DataSource = getData;
        rpModalChiTiet.DataBind();

    }

    protected void rpModalChiTiet_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpChiTiet = e.Item.FindControl("rpChiTiet") as Repeater;
        int username_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "username_id").ToString());
        int khoi_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "khoi_id").ToString());
        var getDetail = from t in db.tbTracNghiem_Tests
                        join blt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals blt.luyentap_id
                        join u in db.admin_Users on t.username_id equals u.username_id
                        join m in db.tbTKB_Mons on t.monhoc_id equals m.mon_id
                        where u.username_id == username_id && blt.luyentap_status == 2 && t.khoi_id == khoi_id
                        select new
                        {
                            blt.luyentap_name,
                            t.test_createdate,
                            m.mon_name,
                            khoi_name = "Khối " + t.khoi_id,
                            soluongcauhoi = t.test_soluongcauhoi,
                            thoigianlambai = Convert.ToInt32(t.test_thoigianlambai) / 60 + " phút",
                            tinhtrang = t.hidden == false ? "<span class='text-danger'> Chưa hiển thị </span>" : "Đã hiển thị"
                        };
        rpChiTiet.DataSource = getDetail;
        rpChiTiet.DataBind();
    }
}