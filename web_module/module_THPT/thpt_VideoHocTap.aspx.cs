using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_VideoHocTap : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int khoi_id, mon_id;
    public string tenbai, link_baitap, video_heart;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["taikhoan"] != null)
        {
            //var checktaikhoan = (from tb in db.tbAccounts where tb.account_sodienthoai == Request.Cookies["taikhoan"].Value select tb).FirstOrDefault();
            var checktaikhoan = (from tb in db.tbDangKies where tb.dangky_taikhoan == Request.Cookies["taikhoan"].Value select tb).FirstOrDefault();
            khoi_id = Convert.ToInt32(RouteData.Values["khoi"]);
            mon_id = Convert.ToInt32(RouteData.Values["mon"]);
            // Kiểm tra tài khoản đã có yêu thích bài học này chưa
            //tbTracNghiem_Video_Heart checktaikhoanyeuthich = (from tkyt in db.tbTracNghiem_Video_Hearts
            //                                                  where tkyt.account_id == checktaikhoan.account_id && tkyt.videoluyentap_id == Convert.ToInt32(RouteData.Values["video"])
            //                                                  select tkyt).FirstOrDefault();
            //if (checktaikhoanyeuthich == null)
            //    video_heart = "fa fa-heart-o";
            //else
            //    video_heart = checktaikhoanyeuthich.video_heart_class;
            tbTracNghiem_VideoLuyenTap getVideoDangHoc = (from v in db.tbTracNghiem_VideoLuyenTaps
                                                          where v.videoluyentap_id == Convert.ToInt32(RouteData.Values["video"])
                                                          select v).FirstOrDefault();
            tenbai = getVideoDangHoc.videoluyentap_tenbai;
            link_baitap = getVideoDangHoc.videoluyentap_video_path;
            if (!IsPostBack)
            {
                // Thêm mỗi lần xem video
                tbTracNghiem_HocSinh_DaXemVideo insert_view = new tbTracNghiem_HocSinh_DaXemVideo();
                insert_view.account_id = checktaikhoan.dangky_id;
                insert_view.videoluyentap_id = getVideoDangHoc.videoluyentap_id;
                insert_view.hocsinhdaxemvideo_tinhtrang = "Đã xem";
                db.tbTracNghiem_HocSinh_DaXemVideos.InsertOnSubmit(insert_view);
                db.SubmitChanges();
            }
            getDanhSachBaiHoc();
        }
        else Response.Redirect("/thpt-trang-chu");
    }
    protected void getDanhSachBaiHoc()
    {
        //var checktaikhoan = (from tb in db.tbAccounts where tb.account_sodienthoai == Request.Cookies["taikhoan"].Value select tb).FirstOrDefault();
        var checktaikhoan = (from tb in db.tbDangKies where tb.dangky_taikhoan == Request.Cookies["taikhoan"].Value select tb).FirstOrDefault();
        var getVideoLuyenTap = from v in db.tbTracNghiem_VideoLuyenTaps
                               where v.monhoc_id == mon_id && v.videoluyentap_lop == khoi_id.ToString()
                               orderby v.videoluyentap_position
                               select new
                               {
                                   v.videoluyentap_id,
                                   v.videoluyentap_image_path,
                                   v.videoluyentap_tenbai,
                                   active = (from xemvideo in db.tbTracNghiem_HocSinh_DaXemVideos
                                             join v1 in db.tbTracNghiem_VideoLuyenTaps on xemvideo.videoluyentap_id equals v1.videoluyentap_id
                                             where v1.monhoc_id == mon_id && v1.videoluyentap_lop == khoi_id.ToString() && xemvideo.account_id == checktaikhoan.dangky_id
                                             orderby xemvideo.hocsinhdaxemvideo_id descending
                                             select xemvideo).FirstOrDefault().videoluyentap_id == v.videoluyentap_id ? "active" : "",
                                   //video_heart_class = (from h in db.tbTracNghiem_Video_Hearts where h.videoluyentap_id == v.videoluyentap_id && h.account_id == checktaikhoan.account_id select h).Count() > 0 ? (from h in db.tbTracNghiem_Video_Hearts where h.videoluyentap_id == v.videoluyentap_id && h.account_id == checktaikhoan.account_id select h).FirstOrDefault().video_heart_class : "fa fa-heart-o",
                                   //video_star_class = (from s in db.tbTracNghiem_Video_Stars where s.videoluyentap_id == v.videoluyentap_id && s.account_id == checktaikhoan.account_id select s).Count() > 0 ? "fa fa-star" : "fa fa-star-o",
                                   video_view_count = (from v1 in db.tbTracNghiem_HocSinh_DaXemVideos where v1.videoluyentap_id == v.videoluyentap_id && v1.account_id == checktaikhoan.dangky_id select v1).Count()
                               };
        rpDanhSach.DataSource = getVideoLuyenTap;
        rpDanhSach.DataBind();
    }
    protected void btnHeart_ServerClick(object sender, EventArgs e)
    {
    //    // kiểm tra tài khoản này đã có yêu thích chưa
    //    var checktaikhoan = (from tb in db.tbAccounts where tb.account_sodienthoai == Request.Cookies["taikhoan"].Value select tb).FirstOrDefault();
    //    tbTracNghiem_Video_Heart checktaikhoanyeuthich = (from tkyt in db.tbTracNghiem_Video_Hearts
    //                                                      where tkyt.account_id == checktaikhoan.account_id && tkyt.videoluyentap_id == Convert.ToInt32(RouteData.Values["video"])
    //                                                      select tkyt).FirstOrDefault();
    //    if (checktaikhoanyeuthich == null)
    //    {
    //        tbTracNghiem_Video_Heart insert = new tbTracNghiem_Video_Heart();
    //        //insert.children_id = 1;
    //        insert.account_id = checktaikhoan.account_id;
    //        insert.videoluyentap_id = Convert.ToInt32(RouteData.Values["video"]);
    //        insert.video_heart_class = "fa fa-heart";
    //        db.tbTracNghiem_Video_Hearts.InsertOnSubmit(insert);
    //        db.SubmitChanges();
    //        video_heart = "fa fa-heart";
    //    }
    //    else
    //    {
    //        // Kiểm tra trường class đang là gì để bỏ thích hay bật thích
    //        if (checktaikhoanyeuthich.video_heart_class == "fa fa-heart")
    //        {
    //            checktaikhoanyeuthich.video_heart_class = "fa fa-heart-o";
    //            db.SubmitChanges();
    //            video_heart = "fa fa-heart-o";
    //        }
    //        else
    //        {
    //            checktaikhoanyeuthich.video_heart_class = "fa fa-heart";
    //            db.SubmitChanges();
    //            video_heart = "fa fa-heart";
    //        }
    //    }
    //    getDanhSachBaiHoc();
    }
}