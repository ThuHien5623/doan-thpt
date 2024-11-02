using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_DanhMucKhoi : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public static int khoi_id, mon_id;
    public int STT = 1;
    // public string fullname;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["taikhoan"] != null)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["monhoc"] == null)
                {
                    HttpCookie ck = new HttpCookie("monhoc");
                    string s = ck.Value;
                    ck.Value = "1";
                    ck.Expires = DateTime.Now.AddDays(365);
                    Response.Cookies.Add(ck);
                }
                khoi_id = Convert.ToInt32(RouteData.Values["khoi-id"].ToString());
                mon_id = Convert.ToInt32(Request.Cookies["monhoc"].Value);
                var getMon = from m in db.tbTKB_Mons
                             join mhck in db.tbMonHocCuaKhois on m.mon_id equals mhck.mon_id
                             where mhck.khoi_id == khoi_id
                             orderby m.mon_id
                             select new
                             {
                                 m.mon_id,
                                 m.mon_image,
                                 m.mon_name,
                                 khoi_id = khoi_id,
                                 mon_active = m.mon_id == Convert.ToInt32(Request.Cookies["monhoc"].Value) ? "style='border: 2px solid #af0000'" : ""
                             };
                rpMon.DataSource = getMon;
                rpMon.DataBind();

                btnXemTatCa.HRef = "/app-luyen-tap-thpt-" + khoi_id + "-" + mon_id;
                //get bài luyện tập chưa làm
                getBaiLuyenTapChuaLam(khoi_id, Convert.ToInt32(Request.Cookies["monhoc"].Value));
                // get video luyện tập
                getVideoLuyenTap(khoi_id, Convert.ToInt32(Request.Cookies["monhoc"].Value));
                // get bài luyện tập
                getBaiLuyenTap(khoi_id, Convert.ToInt32(Request.Cookies["monhoc"].Value));
                // get bài kiểm tra
                //getBaiKiemTra(khoi_id, Convert.ToInt32(Request.Cookies["monhoc"].Value));
                // get Thành tích của môn học 
                ddlBaiLuyenTap.DataSource = from lt in db.tbTracNghiem_BaiLuyenTaps
                                            join t in db.tbTracNghiem_Tests on lt.luyentap_id equals t.luyentap_id
                                            where t.monhoc_id == Convert.ToInt32(Request.Cookies["monhoc"].Value) && t.khoi_id == khoi_id
                                            select new
                                            {
                                                lt.luyentap_name,
                                                lt.luyentap_id
                                            };
                ddlBaiLuyenTap.DataTextField = "luyentap_name";
                ddlBaiLuyenTap.DataValueField = "luyentap_id";
                ddlBaiLuyenTap.DataBind();
                if (ddlBaiLuyenTap.SelectedValue != null)
                {
                    getThanhTich(Convert.ToInt32(Request.Cookies["monhoc"].Value), Convert.ToInt32(ddlBaiLuyenTap.SelectedItem.Value));
                }
            }
        }
        else Response.Redirect("/thpt-trang-chu");
    }
    protected void getVideoLuyenTap(int khoi, int mon)
    {
        khoi = khoi_id;
        mon = mon_id;
        if (Request.Cookies["taikhoan"] != null)
        {
            // Lưu ý phải get được môn hiện tại trong lịch sử đã xem video
            // Trường hợp không có trong bảng lịch sử thì mặc định video đầu tiên của môn đó
            var getHocSinhDaXemVideo = (from hs in db.tbDangKies
                                        join xemvd in db.tbTracNghiem_HocSinh_DaXemVideos on hs.dangky_id equals xemvd.account_id
                                        join vd in db.tbTracNghiem_VideoLuyenTaps on xemvd.videoluyentap_id equals vd.videoluyentap_id
                                        join mh in db.tbTKB_Mons on vd.monhoc_id equals mh.mon_id
                                        where mh.mon_id == mon
                                        && hs.dangky_taikhoan == Request.Cookies["taikhoan"].Value
                                        && vd.videoluyentap_lop == Convert.ToInt32(RouteData.Values["khoi-id"]) + ""
                                        select new
                                        {
                                            vd.videoluyentap_lop,
                                            vd.monhoc_id,
                                            vd.videoluyentap_id,
                                            vd.videoluyentap_image_path,
                                            vd.videoluyentap_tenbai,
                                            xemvd.hocsinhdaxemvideo_id
                                        });
            if (getHocSinhDaXemVideo.Count() == 0)
            {
                var getVideoDauTienCuaMon = (from vd in db.tbTracNghiem_VideoLuyenTaps
                                             where vd.monhoc_id == mon && vd.videoluyentap_lop == RouteData.Values["khoi-id"].ToString()
                                             orderby vd.videoluyentap_position
                                             select vd).Take(1);
                // Đã có video thì lấy video đầu tiên của môn đó
                if (getVideoDauTienCuaMon != null)
                {
                    rpVideoLuyentap.DataSource = getVideoDauTienCuaMon;
                    rpVideoLuyentap.DataBind();
                }
                // Chưa có video thì cho hiển thị rỗng
                else
                {
                    rpVideoLuyentap.DataSource = null;
                    rpVideoLuyentap.DataBind();
                }
            }
            else
            {
                rpVideoLuyentap.DataSource = getHocSinhDaXemVideo.OrderByDescending(x => x.hocsinhdaxemvideo_id).Take(1);
                rpVideoLuyentap.DataBind();
            }
        }
    }
    protected void getBaiLuyenTap(int khoi, int mon)
    {
        khoi = khoi_id;
        mon = mon_id;
        var checktaikhoan = (from tb in db.tbDangKies
                             where tb.dangky_taikhoan == Request.Cookies["taikhoan"].Value
                             select tb).FirstOrDefault();
                            
        var getBaiTap = from bt in db.tbTracNghiem_BaiLuyenTaps
                        join t in db.tbTracNghiem_Tests on bt.luyentap_id equals t.luyentap_id
                        where bt.luyentap_status == 2 && t.khoi_id == khoi && t.monhoc_id == mon && t.hidden==true
                        select new
                        {
                            bt.luyentap_id,
                            imgBaiTap = bt.luyentap_path,
                            bt.luyentap_name,
                            t.test_link,
                            count_view = (from rt in db.tbTracNghiem_ResultTests
                                          join t1 in db.tbTracNghiem_Tests on rt.test_id equals t1.test_id
                                          where t1.luyentap_id == bt.luyentap_id && rt.hstl_id == checktaikhoan.dangky_id
                                          select rt).Count(),
                            //luyentap_heart_class = (from lth in db.tbTracNghiem_LuyenTap_Hearts
                            //                        where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.dangky_id
                            //                        select lth).Count() > 0 ?
                            //                        (from lth in db.tbTracNghiem_LuyenTap_Hearts
                            //                         where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.dangky_id
                            //                         select lth).FirstOrDefault().luyentap_heart_class == "fa fa-heart" ? "fa fa-heart" : "fa fa-heart-o"
                            //                         : "fa fa-heart-o",
                            //luyentap_star_class = (from s in db.tbTracNghiem_LuyenTap_Stars
                            //                       where s.luyentap_id == bt.luyentap_id
                            //                       select s).Count() > 0 ? "fa fa-star" : "fa fa-star-o"
                        };
        rpBaiLuyenTap.DataSource = getBaiTap;
        rpBaiLuyenTap.DataBind();
    }
    //get Bài luyện tập chưa làm
    protected void getBaiLuyenTapChuaLam(int khoi, int mon)
    {
        khoi = khoi_id;
        mon = mon_id;
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
                        where bt.luyentap_status == 2 && t.khoi_id == khoi && t.monhoc_id == mon
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
                            //luyentap_heart_class = (from lth in db.tbTracNghiem_LuyenTap_Hearts
                            //                        where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.account_id
                            //                        select lth).Count() > 0 ?
                            //                        (from lth in db.tbTracNghiem_LuyenTap_Hearts
                            //                         where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.account_id
                            //                         select lth).FirstOrDefault().luyentap_heart_class == "fa fa-heart" ? "fa fa-heart" : "fa fa-heart-o"
                            //                         : "fa fa-heart-o",
                            //luyentap_star_class = (from s in db.tbTracNghiem_LuyenTap_Stars
                            //                       where s.luyentap_id == bt.luyentap_id
                            //                       select s).Count() > 0 ? "fa fa-star" : "fa fa-star-o"
                        };
        var getBT = from bt in getBaiTap where bt.count_view == 0 select bt;

        //rpBaiLuyentapChuaLam.DataSource = getBT;
        //rpBaiLuyentapChuaLam.DataBind();
    }
    //get Bài kiểm tra
    //protected void getBaiKiemTra(int khoi, int mon)
    //{
    //    //get Bài tập đã làm lần cuối cho tới bài tiếp theo
    //    khoi = khoi_id;
    //    mon = mon_id;
    //    if (Request.Cookies["taikhoan"] != null)
    //    {
    //        var checkHocSinhDaLamBai = from rt in db.tbTracNghiem_ResultTests
    //                                   join t in db.tbTracNghiem_Tests on rt.test_id equals t.test_id
    //                                   join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
    //                                   join cr in db.tbDangKies on rt.hstl_id equals cr.dangky_id
    //                                   where cr.dangky_taikhoan == Request.Cookies["taikhoan"].Value
    //                                    && t.monhoc_id == mon
    //                                    && t.khoi_id == khoi
    //                                    && lt.luyentap_status == 1
    //                                   select new
    //                                   {
    //                                       t.test_id,
    //                                       lt.luyentap_name,
    //                                       lt.luyentap_id
    //                                   };
    //        // Học sinh chưa làm bài thì lấy bài đầu tiên của môn học active
    //        if (checkHocSinhDaLamBai.Count() == 0)
    //        {
    //            var getBaiTapLanCuoi = from rt in db.tbTracNghiem_BaiLuyenTaps
    //                                   join t in db.tbTracNghiem_Tests on rt.luyentap_id equals t.luyentap_id
    //                                   where t.monhoc_id == mon
    //                                   && t.khoi_id == Convert.ToInt32(RouteData.Values["khoi-id"])
    //                                     && rt.luyentap_status == 1
    //                                   select new
    //                                   {
    //                                       t.test_link,
    //                                       rt.luyentap_name,
    //                                       rt.luyentap_id,
    //                                       t.test_id,
    //                                   };
    //            rpBaiKiemTra.DataSource = getBaiTapLanCuoi;
    //            rpBaiKiemTra.DataBind();
    //        }
    //        // Học sinh đã làm bài tập thì sẽ cho hiển thì các bài tiếp theo
    //        else
    //        {
    //            int id_luyentaphientai = Convert.ToInt32(checkHocSinhDaLamBai.OrderByDescending(x => x.luyentap_id).FirstOrDefault().luyentap_id);
    //            var checkHocSinhDaLamBaiTiepTheo = from rt in db.tbTracNghiem_ResultTests
    //                                               join t in db.tbTracNghiem_Tests on rt.test_id equals t.test_id
    //                                               join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
    //                                               join cr in db.tbDangKies on rt.hstl_id equals cr.dangky_id
    //                                               where
    //                                               //a.account_sodienthoai == Request.Cookies["taikhoan"].Value
    //                                                 t.monhoc_id == mon
    //                                                && t.khoi_id == Convert.ToInt32(RouteData.Values["khoi-id"])
    //                                                && lt.luyentap_id > id_luyentaphientai
    //                                                && lt.luyentap_status == 1
    //                                               group lt by new { lt.luyentap_name, lt.luyentap_id } into g
    //                                               select new
    //                                               {
    //                                                   g.Key.luyentap_name,
    //                                                   g.Key.luyentap_id,
    //                                                   test_link = from t in db.tbTracNghiem_Tests where t.luyentap_id == g.Key.luyentap_id select t.test_link,
    //                                                   test_id = from t in db.tbTracNghiem_Tests where t.luyentap_id == g.Key.luyentap_id select t.test_id,
    //                                               };
    //            rpBaiKiemTra.DataSource = checkHocSinhDaLamBaiTiepTheo;
    //            rpBaiKiemTra.DataBind();
    //        }
    //    }
    //}
    protected void btnChiTietMon_ServerClick(object sender, EventArgs e)
    {
        HttpCookie ck = new HttpCookie("monhoc");
        string s = ck.Value;
        ck.Value = txtMonID.Value;
        ck.Expires = DateTime.Now.AddDays(365);
        Response.Cookies.Add(ck);
        khoi_id = Convert.ToInt32(RouteData.Values["khoi-id"]);
        mon_id = Convert.ToInt32(txtMonID.Value);
        var getMon = from m in db.tbTKB_Mons
                     join mhck in db.tbMonHocCuaKhois on m.mon_id equals mhck.mon_id
                     where mhck.khoi_id == khoi_id
                     orderby m.mon_id
                     select new
                     {
                         m.mon_id,
                         m.mon_image,
                         m.mon_name,
                         khoi_id = khoi_id,
                         mon_active = m.mon_id == mon_id ? "style='border: 2px solid #af0000'" : ""
                     };
        rpMon.DataSource = getMon;
        rpMon.DataBind();

        getBaiLuyenTapChuaLam(khoi_id, mon_id);
        getVideoLuyenTap(khoi_id, mon_id);
        getBaiLuyenTap(khoi_id, mon_id);
        //getBaiKiemTra(khoi_id, mon_id);
        ddlBaiLuyenTap.DataSource = from lt in db.tbTracNghiem_BaiLuyenTaps
                                    join t in db.tbTracNghiem_Tests on lt.luyentap_id equals t.luyentap_id
                                    where t.monhoc_id == Convert.ToInt32(txtMonID.Value) && t.khoi_id == Convert.ToInt32(RouteData.Values["khoi-id"])
                                    select lt;
        ddlBaiLuyenTap.DataTextField = "luyentap_name";
        ddlBaiLuyenTap.DataValueField = "luyentap_id";
        ddlBaiLuyenTap.DataBind();
        getThanhTich(Convert.ToInt32(Request.Cookies["monhoc"].Value), Convert.ToInt32(ddlBaiLuyenTap.SelectedItem.Value));

        //getDanhSachBaiLuyenTap(Convert.ToInt32(txtMonID.Value));
    }
    protected void getThanhTich(int mon, int bailuyentap)
    {
        // get Lớp get môn
        lblLop.Text = khoi_id + "";
        mon = mon_id;
        lblMon.Text = (from m in db.tbTKB_Mons where m.mon_id == mon select m).FirstOrDefault().mon_name.ToString();
        // Thành tích luyện tập từng bài
        var getDataTungBai = (from rt in db.tbTracNghiem_ResultTests
                              join t in db.tbTracNghiem_Tests on rt.test_id equals t.test_id
                              join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
                              join hs in db.tbDangKies on rt.hstl_id equals hs.dangky_id
                              where t.monhoc_id == mon
                               && t.khoi_id == khoi_id
                               && lt.luyentap_id == bailuyentap
                              group rt by rt.hstl_id into g
                              select new
                              {
                                  children_id = g.Key,
                                  children_fullname = (from cr1 in db.tbDangKies
                                                       where cr1.dangky_id == g.Key
                                                       select cr1.dangky_hotenhocsinh).FirstOrDefault(),
                                  solanlambai = g.Count(),
                                  ketqua = (from ct in db.tbTracNghiem_ResultTests
                                            join t1 in db.tbTracNghiem_Tests on ct.test_id equals t1.test_id
                                            join lt1 in db.tbTracNghiem_BaiLuyenTaps on t1.luyentap_id equals lt1.luyentap_id
                                            join hsct in db.tbDangKies on ct.hstl_id equals hsct.dangky_id
                                            where ct.hstl_id == g.Key && lt1.luyentap_id == bailuyentap
                                            select Convert.ToInt32(ct.resulttest_result)).Max(),
                                  thoigianngannhat = (from r1 in db.tbTracNghiem_ResultTests
                                                      join t1 in db.tbTracNghiem_Tests on r1.test_id equals t1.test_id
                                                      join lt1 in db.tbTracNghiem_BaiLuyenTaps on t1.luyentap_id equals lt1.luyentap_id
                                                      join hsct in db.tbDangKies on r1.hstl_id equals hsct.dangky_id
                                                      where r1.hstl_id == g.Key && lt1.luyentap_id == bailuyentap
                                                      //where r1.test_id == Convert.ToInt32(txtLuyenTapID.Value) && r1.hocsinh_code == g.Key
                                                      select r1).Min(x => x.result_thoigianlambai),
                              });
        rpThanhTich.DataSource = getDataTungBai.OrderByDescending(x => x.ketqua).ThenBy(x => x.solanlambai).ThenBy(x => x.thoigianngannhat);
        rpThanhTich.DataBind();
    }
    protected void ddlBaiLuyenTap_SelectedIndexChanged(object sender, EventArgs e)
    {
        getThanhTich(Convert.ToInt32(Request.Cookies["monhoc"].Value), Convert.ToInt32(ddlBaiLuyenTap.SelectedItem.Value));
    }
}