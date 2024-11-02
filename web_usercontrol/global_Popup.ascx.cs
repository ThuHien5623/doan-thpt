using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
public partial class web_usercontrol_global_Popup : System.Web.UI.UserControl
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public DateTime startTime;
    public DateTime endTime;
    public TimeSpan elapsedtime;
    public int idGame;
    public int sao;
    public int idChildren;
    string soDienThoai;
    string matKhau;
    int chiTietBaiTap;
    public int idStudent;
    public int vitribaitap_id, baitap_id, sach_id, lop_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = HttpContext.Current.Request.Url.AbsolutePath;
        string[] arr = url.Split('-');
        vitribaitap_id = Convert.ToInt32(arr[arr.Length - 1]);
        baitap_id = Convert.ToInt32(arr[arr.Length - 2]);
        sach_id = Convert.ToInt32(arr[arr.Length - 3]);
        lop_id = Convert.ToInt32(arr[arr.Length - 4]);
        nameBaiTapModal.InnerHtml = "Bai" + ":  " + baitap_id + "-" + vitribaitap_id;
        if (Request.Cookies["taikhoan"] != null && !string.IsNullOrEmpty(Request.Cookies["taikhoan"].Value))
        {
            soDienThoai = Request.Cookies["taikhoan"].Value;
        }

    }

    protected void loadServerPopup_ServerClick(object sender, EventArgs e)
    {

        var idAccount = (from ch in db.tbAccounts where ch.account_sodienthoai == soDienThoai select ch.account_id).FirstOrDefault();
        var idAccountChildren = (from ck in db.tbAccount_Childrens
                                 where ck.account_id == idAccount && ck.children_active == true
                                 select ck.children_id).FirstOrDefault();
        if (Convert.ToInt32(txtSao.Value) != 0)
        {


            var getBaiTapHienTai = (from at in db.tbChiTietBaiTaps
                                    where at.chitietbaitap_id == vitribaitap_id && at.baitap_id == baitap_id
                                    select at).FirstOrDefault();

            var idBaiTapConLai = (from at in db.tbChiTietBaiTaps
                                  where at.chitietbaitap_vitribaitap > getBaiTapHienTai.chitietbaitap_vitribaitap && at.baitap_id == baitap_id
                                  //select at).FirstOrDefault(); // lấy được số 3
                                  select new
                                  {
                                      at.baitap_id,
                                      at.chitietbaitap_id,
                                      at.chitietbaitap_vitribaitap,
                                      at.chitietbaitap_linkbaitap,
                                      sao = (from ls in db.tbLichSuLamBaiHocSinhs
                                             where ls.chitietbaitap_id == at.chitietbaitap_id && ls.children_id == idStudent
                                             select ls.lichsulambai_sao).FirstOrDefault() ?? 0,
                                      status = (from ls1 in db.tbLichSuLamBaiHocSinhs
                                                where ls1.chitietbaitap_id == at.chitietbaitap_id && ls1.children_id == idStudent
                                                select ls1.lichsulambai_status).FirstOrDefault() ?? "disable",
                                  }).FirstOrDefault();
            var getidhientai = (from lshs in db.tbLichSuLamBaiHocSinhs where lshs.children_id == idAccountChildren && lshs.chitietbaitap_id == getBaiTapHienTai.chitietbaitap_vitribaitap select lshs).FirstOrDefault();
            getidhientai.lichsulambai_thoigianketthuc = DateTime.Now;

            if (idBaiTapConLai != null)
            {
                var childrenIdDaCo = from kt in db.tbLichSuLamBaiHocSinhs
                                     where kt.children_id == idAccountChildren && kt.chitietbaitap_id == idBaiTapConLai.chitietbaitap_id
                                     select kt;
                string linkbaitapValue = idBaiTapConLai.chitietbaitap_linkbaitap;
                int saoValue = idBaiTapConLai.sao;
                int baitapid = Convert.ToInt32(idBaiTapConLai.baitap_id);
                int vitribaitapValue = Convert.ToInt32(idBaiTapConLai.chitietbaitap_vitribaitap);
                int chitiet = Convert.ToInt32(idBaiTapConLai.chitietbaitap_id);
                var inforBaitapNext = new
                {
                    LinkBaiTap = linkbaitapValue,
                    Sao = saoValue,
                    BaitapId = baitapid,
                    VitriBaiTap = vitribaitapValue,
                    ChitietBaiTap = chitiet
                };
                string infoJson = new JavaScriptSerializer().Serialize(inforBaitapNext);
                HttpCookie infoCookie = new HttpCookie("next");
                infoCookie.HttpOnly = false;
                infoCookie.Value = infoJson;
                infoCookie.Expires = DateTime.Now.AddMinutes(365); // Thời gian sống của cookie (đơn vị là phút)
                Response.Cookies.Add(infoCookie);

                if (childrenIdDaCo.Count() == 0)
                {
                    tbLichSuLamBaiHocSinh insertLichSuLamBaiHS = new tbLichSuLamBaiHocSinh();
                    insertLichSuLamBaiHS.children_id = idAccountChildren;
                    insertLichSuLamBaiHS.chitietbaitap_id = idBaiTapConLai.chitietbaitap_id;
                    insertLichSuLamBaiHS.lichsulambai_status = "active";
                    db.tbLichSuLamBaiHocSinhs.InsertOnSubmit(insertLichSuLamBaiHS);
                    db.SubmitChanges();
                }
            }
            else
            {
                var baiTapPosition = (from ot in db.tbBaiTaps
                                      where ot.baitap_id == baitap_id && ot.lop_id == lop_id && ot.sach_id == sach_id
                                      select ot.baitap_Position).FirstOrDefault();

                var baiTapPositionMoi = (from qt in db.tbBaiTaps
                                         where qt.baitap_Position > baiTapPosition && qt.lop_id == lop_id && qt.sach_id == sach_id
                                         select qt.baitap_id).FirstOrDefault();

                var idChiTietBTMoi = (from pt in db.tbChiTietBaiTaps
                                      where pt.baitap_id == Convert.ToInt32(baiTapPositionMoi)
                                      select pt).FirstOrDefault();

                var childrenIdDaCo = from kt in db.tbLichSuLamBaiHocSinhs where kt.children_id == idAccountChildren && kt.chitietbaitap_id == idChiTietBTMoi.chitietbaitap_id select kt;
                if (childrenIdDaCo.Count() == 0)
                {
                    tbLichSuLamBaiHocSinh insertLichSuLamBaiHS = new tbLichSuLamBaiHocSinh();
                    insertLichSuLamBaiHS.children_id = idAccountChildren;
                    insertLichSuLamBaiHS.chitietbaitap_id = idChiTietBTMoi.chitietbaitap_id;
                    insertLichSuLamBaiHS.lichsulambai_status = "active";
                    db.tbLichSuLamBaiHocSinhs.InsertOnSubmit(insertLichSuLamBaiHS);
                    db.SubmitChanges();
                }

            }
            var getidhocsinh = (from lshs in db.tbLichSuLamBaiHocSinhs where lshs.children_id == idAccountChildren && lshs.chitietbaitap_id == getBaiTapHienTai.chitietbaitap_vitribaitap select lshs).FirstOrDefault();
            DateTime? batdau = getidhocsinh.lichsulambai_thoigianbatdau;
            DateTime? ketthuc = getidhocsinh.lichsulambai_thoigianketthuc;
            TimeSpan khoangcach = (DateTime)ketthuc - (DateTime)batdau;
            double tongSoGiay = khoangcach.TotalSeconds;
            tbLichSuLamBaiHocSinh lichSuLamBaiHocSinh = db.tbLichSuLamBaiHocSinhs.Where(x => x.children_id == idAccountChildren && x.chitietbaitap_id == vitribaitap_id).FirstOrDefault();
            if (lichSuLamBaiHocSinh.lichsulambai_status == "active")
            {
                lichSuLamBaiHocSinh.lichsulambai_solanlambai = 1;
                lichSuLamBaiHocSinh.lichsulambai_status = "select";
                lichSuLamBaiHocSinh.lichsulambai_thoigianlambai = Convert.ToString(tongSoGiay);
                lichSuLamBaiHocSinh.lichsulambai_sao = Convert.ToInt32(txtSao.Value);
            }
            else
            {
                lichSuLamBaiHocSinh.lichsulambai_solanlambai++;
                lichSuLamBaiHocSinh.lichsulambai_status = "select";
                lichSuLamBaiHocSinh.lichsulambai_thoigianlambai = Convert.ToString(tongSoGiay);
                if (lichSuLamBaiHocSinh.lichsulambai_sao == null)
                    lichSuLamBaiHocSinh.lichsulambai_sao = Convert.ToInt32(txtSao.Value);
                else if (lichSuLamBaiHocSinh.lichsulambai_sao < Convert.ToInt32(txtSao.Value))
                {
                    lichSuLamBaiHocSinh.lichsulambai_sao = Convert.ToInt32(txtSao.Value);
                }
            }
            db.SubmitChanges();
        }
        //else
        //{
        //    tbLichSuLamBaiHocSinh lichSuLamBaiHocSinh = db.tbLichSuLamBaiHocSinhs.Where(x => x.children_id == idAccountChildren && x.chitietbaitap_id == vitribaitap_id).FirstOrDefault();
        //    lichSuLamBaiHocSinh.lichsulambai_solanlambai++;
        //    db.SubmitChanges();
        //}
    }

    protected void returnTrangChu_ServerClick(object sender, EventArgs e)
    {
        var idAccount = (from ch in db.tbAccounts where ch.account_sodienthoai == soDienThoai select ch.account_id).FirstOrDefault();
        var idAccountChildren = (from ck in db.tbAccount_Childrens
                                 where ck.account_id == idAccount && ck.children_active == true
                                 select ck.lop_id).FirstOrDefault();
        if (Convert.ToInt32(idAccountChildren) < 1)
        {
            var url = "/app-mam-non";
            Response.Redirect(url);

        }
        else if (Convert.ToInt32(idAccountChildren) < 6)
        {
            var url = "/app-tieu-hoc-trang-chu";
            Response.Redirect(url);
        }
        else if (Convert.ToInt32(idAccountChildren) < 10)
        {
            var url = "/app-THCS";
            Response.Redirect(url);
        }
        else
        {
            var url = "/app-THPT";
            Response.Redirect(url);
        }
    }
}