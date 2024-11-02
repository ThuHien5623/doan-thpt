using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_usercontrol_global_LandingPage_Menu_THCS : System.Web.UI.UserControl
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int id_video;
    protected void Page_Load(object sender, EventArgs e)
    {
        // get video mới nhất
        var getVideoMoiNhat = (from v in db.tbLandingPage_VideoHuongDans
                               where v.videohuongdan_cap == "THCS"
                               orderby v.videohuongdan_id descending select v).Take(1);
        id_video = getVideoMoiNhat.First().videohuongdan_id;
    }
}