using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class landingpage_THPT_thpt_HuongDanBaiTap : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        // video mới nhất
        rpVideoMoiNhat.DataSource = (from v in db.tbLandingPage_VideoHuongDans
                                     where v.videohuongdan_id == Convert.ToInt32(RouteData.Values["id"])
                                     select v);
        rpVideoMoiNhat.DataBind();
        // Danh sách video cũ
        rpListVideo.DataSource = from v in db.tbLandingPage_VideoHuongDans
                                 where v.videohuongdan_cap == "THPT" && v.videohuongdan_id != Convert.ToInt32(RouteData.Values["id"])
                                 select v;
        rpListVideo.DataBind();
    }
}