using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_web_tracnghiem_web_MonHocCuaKhoi : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        var getMonHoc = from mhck in db.tbMonHocCuaKhois
                        join mh in db.tbTKB_Mons on mhck.monhoc_id equals mh.mon_id
                        where mhck.khoi_id == Convert.ToInt32(RouteData.Values["id"])
                        //orderby mh.monhoc_name ascending
                        select new
                        {
                            mh.mon_id,
                            mh.mon_name,
                            mhck.khoi_id
                        };

        rpMonHoc.DataSource = getMonHoc;
        rpMonHoc.DataBind();
    }
}