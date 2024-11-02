using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_Favorite : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public static int khoi_id, mon_id;
    public string tenbai, link_baitap, video_heart;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["taikhoan"] != null)
        {
            var checkHocSinh = (from hs in db.tbAccounts where hs.account_sodienthoai == Request.Cookies["taikhoan"].Value select hs);
            if (checkHocSinh.Count() > 0)
            {
                // Kiểm tra học sinh hiện tại đã học lớp mấy
                var checkHocSinhTrongLop = from hstl in db.tbAccount_Childrens
                                           where hstl.account_id == checkHocSinh.First().account_id && hstl.children_active == true
                                           select hstl;
                if (Session["khoi"] != null)
                {
                    khoi_id = Convert.ToInt32(Session["khoi"].ToString());
                    if (khoi_id == 10)
                        btnLop10.Style["border"] = "3px solid #af0000";
                    if (khoi_id == 11)
                        btnLop11.Style["border"] = "3px solid #af0000";
                    if (khoi_id == 12)
                        btnLop12.Style["border"] = "3px solid #af0000";
                }
                else
                {
                    if (checkHocSinhTrongLop.First().lop_id == 10)
                    {
                        btnLop10.Style["border"] = "3px solid #af0000";
                        khoi_id = 10;
                    }
                    if (checkHocSinhTrongLop.First().lop_id == 11)
                    {
                        btnLop11.Style["border"] = "3px solid #af0000";
                        khoi_id = 11;
                    }
                    if (checkHocSinhTrongLop.First().lop_id == 12)
                    {
                        btnLop12.Style["border"] = "3px solid #af0000";
                        khoi_id = 12;
                    }
                }
                var getMon = from m in db.tbTKB_Mons
                             join mhck in db.tbMonHocCuaKhois on m.mon_id equals mhck.mon_id
                             where mhck.khoi_id == khoi_id
                             orderby m.mon_id
                             select new
                             {
                                 m.mon_id,
                                 m.mon_name,
                                 m.mon_image,
                                 khoi_id = khoi_id,
                                 mon_active = m.mon_id == Convert.ToInt32(Request.Cookies["monhoc"].Value) ? "style='border: 2px solid #af0000'" : ""
                             };
                rpMon.DataSource = getMon;
                rpMon.DataBind();
                if (!IsPostBack)
                {
                    //Bài yêu thích gần nhất
                    getVideoGanNhat(khoi_id, Convert.ToInt32(Request.Cookies["monhoc"].Value));
                    // video yêu thích
                    getDanhSachBaiHoc(khoi_id, Convert.ToInt32(Request.Cookies["monhoc"].Value));
                    getBaiLuyenTapYeuThich(khoi_id, Convert.ToInt32(Request.Cookies["monhoc"].Value));
                }
            }
        }
        else Response.Redirect("/thpt-trang-chu");
    }
    protected void getVideoGanNhat(int khoi, int mon)
    {
        var checkBaiGanNhat = (from v in db.tbTracNghiem_VideoLuyenTaps
                               join yt in db.tbTracNghiem_Video_Hearts on v.videoluyentap_id equals yt.videoluyentap_id
                               where v.monhoc_id == mon && v.videoluyentap_lop == khoi.ToString() && yt.video_heart_class == "fa fa-heart"
                               orderby v.videoluyentap_id descending
                               select v);
        if (checkBaiGanNhat.Count() > 0)
        {
            tenbai = checkBaiGanNhat.First().videoluyentap_tenbai;
            link_baitap = checkBaiGanNhat.First().videoluyentap_video_path;
        }
    }
    protected void getDanhSachBaiHoc(int khoi, int mon)
    {
        var checktaikhoan = (from tb in db.tbAccounts where tb.account_sodienthoai == Request.Cookies["taikhoan"].Value select tb).FirstOrDefault();
        var getVideoLuyenTap = from v in db.tbTracNghiem_VideoLuyenTaps
                               join yt in db.tbTracNghiem_Video_Hearts on v.videoluyentap_id equals yt.videoluyentap_id
                               where v.monhoc_id == mon && v.videoluyentap_lop == khoi.ToString() && yt.video_heart_class == "fa fa-heart"
                               select new
                               {
                                   v.videoluyentap_id,
                                   v.videoluyentap_image_path,
                                   v.videoluyentap_tenbai,
                                   active = (from xemvideo in db.tbTracNghiem_HocSinh_DaXemVideos where xemvideo.videoluyentap_id == v.videoluyentap_id select xemvideo).Count() > 0 ? "active" : "",
                                   video_heart_class = "fa fa-heart",
                                   video_star_class = (from s in db.tbTracNghiem_Video_Stars where s.videoluyentap_id == v.videoluyentap_id && s.account_id == checktaikhoan.account_id select s).Count() > 0 ? "fa fa-star" : "fa fa-star-o",
                                   video_view_count = (from v1 in db.tbTracNghiem_HocSinh_DaXemVideos where v1.videoluyentap_id == v.videoluyentap_id && v1.account_id == checktaikhoan.account_id select v1).Count()
                               };
        rpListVideo.DataSource = getVideoLuyenTap;
        rpListVideo.DataBind();
    }
    protected void getMon(int khoi, int mon)
    {
        var getMon = from m in db.tbTKB_Mons
                     join mhck in db.tbMonHocCuaKhois on m.mon_id equals mhck.mon_id
                     where mhck.khoi_id == khoi
                     orderby m.mon_id
                     select new
                     {
                         m.mon_id,
                         m.mon_name,
                         m.mon_image,
                         khoi_id = khoi_id,
                         mon_active = m.mon_id == mon ? "style='border: 2px solid #af0000'" : ""
                     };
        rpMon.DataSource = getMon;
        rpMon.DataBind();
    }

    protected void btnLop10_ServerClick(object sender, EventArgs e)
    {
        btnLop10.Style["border"] = "3px solid #af0000";
        btnLop11.Style["border"] = "";
        btnLop12.Style["border"] = "";
        khoi_id = 10;
        Session["khoi"] = "10";
        mon_id = Convert.ToInt32(Request.Cookies["monhoc"].Value);
        getMon(khoi_id, mon_id);
        //Bài yêu thích gần nhất
        getVideoGanNhat(khoi_id, mon_id);
        // get lại môn học
        getDanhSachBaiHoc(khoi_id, mon_id);
        // get bài luyện tập yêu thích
        getBaiLuyenTapYeuThich(khoi_id, mon_id);
    }

    protected void btnLop11_ServerClick(object sender, EventArgs e)
    {
        btnLop10.Style["border"] = "";
        btnLop11.Style["border"] = "3px solid #af0000";
        btnLop12.Style["border"] = "";
        khoi_id = 11;
        Session["khoi"] = "11";
        mon_id = Convert.ToInt32(Request.Cookies["monhoc"].Value);
        getMon(khoi_id, mon_id);
        getDanhSachBaiHoc(khoi_id, mon_id);
        //Bài yêu thích gần nhất
        getVideoGanNhat(khoi_id, mon_id);
    }

    protected void btnLop12_ServerClick(object sender, EventArgs e)
    {
        btnLop10.Style["border"] = "";
        btnLop11.Style["border"] = "";
        btnLop12.Style["border"] = "3px solid #af0000";
        khoi_id = 12;
        Session["khoi"] = "12";
        mon_id = Convert.ToInt32(Request.Cookies["monhoc"].Value);
        getMon(khoi_id, mon_id);
        getDanhSachBaiHoc(khoi_id, mon_id);
        //Bài yêu thích gần nhất
        getVideoGanNhat(khoi_id, mon_id);
    }
    protected void btnChiTietMon_ServerClick(object sender, EventArgs e)
    {
        HttpCookie ck = new HttpCookie("monhoc");
        string s = ck.Value;
        ck.Value = txtMonID.Value;
        ck.Expires = DateTime.Now.AddDays(365);
        Response.Cookies.Add(ck);
        mon_id = Convert.ToInt16(txtMonID.Value);
        getMon(khoi_id, mon_id);
        getVideoGanNhat(khoi_id, mon_id);
        getDanhSachBaiHoc(khoi_id, mon_id);
        getBaiLuyenTapYeuThich(khoi_id, mon_id);
        getBaiKiemTraYeuThich(khoi_id, mon_id);
    }
    //Get bài luyện tập
    protected void getBaiLuyenTapYeuThich(int khoi_id, int mon_id)
    {
        var checktaikhoan = (from tb in db.tbAccounts
                             join hstl in db.tbAccount_Childrens on tb.account_id equals hstl.account_id
                             where tb.account_sodienthoai == Request.Cookies["taikhoan"].Value
                             select new
                             {
                                 tb.account_id,
                                 hstl.children_id
                             }).FirstOrDefault();
        var getBaiTap = from bt in db.tbTracNghiem_BaiLuyenTaps
                        join t in db.tbTracNghiem_Tests on bt.luyentap_id equals t.luyentap_id
                        join yt in db.tbTracNghiem_LuyenTap_Hearts on bt.luyentap_id equals yt.luyentap_id
                        where bt.luyentap_status == 2 && t.khoi_id == khoi_id && t.monhoc_id == mon_id && yt.account_id == checktaikhoan.account_id
                        select new
                        {
                            bt.luyentap_id,
                            imgBaiTap = bt.luyentap_path,
                            bt.luyentap_name,
                            t.test_link,
                            count_view = (from rt in db.tbTracNghiem_ResultTests
                                          join t1 in db.tbTracNghiem_Tests on rt.test_id equals t1.test_id
                                          where t1.luyentap_id == bt.luyentap_id && rt.hstl_id == checktaikhoan.children_id
                                          select rt).Count(),
                            luyentap_heart_class = (from lth in db.tbTracNghiem_LuyenTap_Hearts
                                                    where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.account_id
                                                    select lth).Count() > 0 ?
                                                    (from lth in db.tbTracNghiem_LuyenTap_Hearts
                                                     where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.account_id
                                                     select lth).FirstOrDefault().luyentap_heart_class == "fa fa-heart" ? "fa fa-heart" : "fa fa-heart-o"
                                                     : "fa fa-heart-o",
                            luyentap_star_class = (from s in db.tbTracNghiem_LuyenTap_Stars where s.luyentap_id == bt.luyentap_id select s).Count() > 0 ? "fa fa-star" : "fa fa-star-o"
                        };
        rpList_BaiLuyenTap.DataSource = getBaiTap;
        rpList_BaiLuyenTap.DataBind();
    }
    //get bài keirem tra
    protected void getBaiKiemTraYeuThich(int khoi_id, int mon_id)
    {
        var checktaikhoan = (from tb in db.tbAccounts
                             join hstl in db.tbAccount_Childrens on tb.account_id equals hstl.account_id
                             where tb.account_sodienthoai == Request.Cookies["taikhoan"].Value
                             select new
                             {
                                 tb.account_id,
                                 hstl.children_id
                             }).FirstOrDefault();
        var getBaiTap = from bt in db.tbTracNghiem_BaiLuyenTaps
                        join t in db.tbTracNghiem_Tests on bt.luyentap_id equals t.luyentap_id
                        join yt in db.tbTracNghiem_LuyenTap_Hearts on bt.luyentap_id equals yt.luyentap_id
                        where bt.luyentap_status == 1 && t.khoi_id == khoi_id && t.monhoc_id == mon_id && yt.account_id == checktaikhoan.account_id
                        select new
                        {
                            bt.luyentap_id,
                            imgBaiTap = bt.luyentap_path,
                            bt.luyentap_name,
                            t.test_link,
                            count_view = (from rt in db.tbTracNghiem_ResultTests
                                          join t1 in db.tbTracNghiem_Tests on rt.test_id equals t1.test_id
                                          where t1.luyentap_id == bt.luyentap_id && rt.hstl_id == checktaikhoan.children_id
                                          select rt).Count(),
                            luyentap_heart_class = (from lth in db.tbTracNghiem_LuyenTap_Hearts
                                                    where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.account_id
                                                    select lth).Count() > 0 ?
                                                    (from lth in db.tbTracNghiem_LuyenTap_Hearts
                                                     where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.account_id
                                                     select lth).FirstOrDefault().luyentap_heart_class == "fa fa-heart" ? "fa fa-heart" : "fa fa-heart-o"
                                                     : "fa fa-heart-o",
                            luyentap_star_class = (from s in db.tbTracNghiem_LuyenTap_Stars where s.luyentap_id == bt.luyentap_id select s).Count() > 0 ? "fa fa-star" : "fa fa-star-o"
                        };
        rpBaiKiemTraYeuThich.DataSource = getBaiTap;
        rpBaiKiemTraYeuThich.DataBind();
    }
}