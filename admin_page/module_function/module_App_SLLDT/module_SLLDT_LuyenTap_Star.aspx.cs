using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_App_SLLDT_module_SLLDT_LuyenTap_Star : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var getnNhanVien = from u in db.admin_Users
                               where u.username_active == true
                               select u;
            ddlGiaoVien.DataSource = getnNhanVien;
            ddlGiaoVien.DataBind();
        }
    }


    protected void ddlGiaoVien_SelectedIndexChanged(object sender, EventArgs e)
    {
        var getbaihoc = from blt in db.tbTracNghiem_BaiLuyenTaps
                        where blt.username_id == Convert.ToInt32(ddlGiaoVien.SelectedItem.Value)
                        select new
                        {
                            luyentap_star_class = (from s in db.tbTracNghiem_LuyenTap_Stars where s.luyentap_id == blt.luyentap_id select s).Count() > 0 ? "fa fa-star" : "fa fa-star-o",
                            blt.luyentap_id,
                            blt.luyentap_name,
                        };
        rpList_BaiLuyenTap.DataSource = getbaihoc;
        rpList_BaiLuyenTap.DataBind();
    }

    protected void btnThem_ServerClick(object sender, EventArgs e)
    {
        var getkiemtra = (from s in db.tbTracNghiem_LuyenTap_Stars where s.luyentap_id == Convert.ToInt32(txtLuyenTap_id.Value) select s).FirstOrDefault();
        if (getkiemtra == null)
        {
            tbTracNghiem_LuyenTap_Star insert = new tbTracNghiem_LuyenTap_Star();
            insert.luyentap_id = Convert.ToInt32(txtLuyenTap_id.Value);
            insert.luyentap_star_class = "fa fa-heart";
            db.tbTracNghiem_LuyenTap_Stars.InsertOnSubmit(insert);
            db.SubmitChanges();
        }
        else
        {
            if (getkiemtra.luyentap_star_class == "fa fa-heart-o")
            {
                getkiemtra.luyentap_star_class = "fa fa-heart";
                db.SubmitChanges();
            }
            else
            {
                getkiemtra.luyentap_star_class = "fa fa-heart-o";
                db.SubmitChanges();
            }
        }
        var getbaihoc = from blt in db.tbTracNghiem_BaiLuyenTaps
                        where blt.username_id == Convert.ToInt32(ddlGiaoVien.SelectedItem.Value)
                        select new
                        {
                            luyentap_star_class = (from s in db.tbTracNghiem_LuyenTap_Stars where s.luyentap_id == blt.luyentap_id select s).Count() > 0 ? "fa fa-star" : "fa fa-star-o",
                            blt.luyentap_id,
                            blt.luyentap_name,
                        };
        rpList_BaiLuyenTap.DataSource = getbaihoc;
        rpList_BaiLuyenTap.DataBind();
    }
}