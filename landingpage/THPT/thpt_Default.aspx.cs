using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class landingpage_THPT_thpt_Default : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        // slide
        rpSlide.DataSource = from sl in db.tbLandingPage_TungCap_Slides where sl.tungcap_slide_name == "THPT" select sl;
        rpSlide.DataBind();
        // slogan
        rpSlogan.DataSource = from sl in db.tbLandingPage_TungCap_Slogans where sl.slogan_name == "THPT" select sl;
        rpSlogan.DataBind();
        // video
        rpVideo.DataSource = from v in db.tbLandingPage_TungCap_videos where v.tungcap_video_name == "THPT" select v;
        rpVideo.DataBind();
        // quy trình tiêu đề
        rpQuyTrinhTieuDe.DataSource = from td in db.tbLandingPage_TungCap_QuyTrinhs where td.tungcap_quytrinh_name == "THPT" select td;
        rpQuyTrinhTieuDe.DataBind();
        // quy trình 1
        rpQuyTrinh1.DataSource = from qt1 in db.tbLandingPage_TungCap_QuyTrinhs where qt1.tungcap_quytrinh_name == "THPT" select qt1;
        rpQuyTrinh1.DataBind();
        // quy trình 2
        rpQuyTrinh2.DataSource = from qt1 in db.tbLandingPage_TungCap_QuyTrinhs where qt1.tungcap_quytrinh_name == "THPT" select qt1;
        rpQuyTrinh2.DataBind();
        // quy trình 3
        rpQuyTrinh3.DataSource = from qt1 in db.tbLandingPage_TungCap_QuyTrinhs where qt1.tungcap_quytrinh_name == "THPT" select qt1;
        rpQuyTrinh3.DataBind();
        // Image đăng ký 
        rpDangKyKhoaHoc.DataSource = from dk in db.tbLandingPage_QuangCaos select dk;
        rpDangKyKhoaHoc.DataBind();
    }
}