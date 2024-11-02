using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for webui
/// </summary>
public class webui
{
    public webui()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public List<string> UrlRoutes()
    {
        List<string> list = new List<string>();

        // THPT
        list.Add("webTHPTgioithieu|thpt-trang-chu|~/landingpage/THPT/thpt_Default.aspx");
        list.Add("webTHPTlienhe|thpt-lien-he|~/landingpage/THPT/thpt_Contact.aspx");
        list.Add("webTHPTloginthpt|app-login-thpt|~/landingpage/THPT/thpt_Login.aspx");
        list.Add("modulelienhethpt|app-lien-he-thpt|~/web_module/module_THPT/thpt_LienHe.aspx");
        list.Add("modulequanlitaikhoanthpt|app-quan-li-tai-khoan-thpt|~/web_module/module_THPT/thpt_AccountManager.aspx");

        list.Add("moduledanhmucthpt|app-thpt|~/web_module/module_THPT/thpt_Home.aspx");
        list.Add("moduledanhmuckhoithpt|app-danh-muc-khoi-thpt-{khoi-id}|~/web_module/module_THPT/thpt_DanhMucKhoi.aspx");
        list.Add("modulevideohoctapthpt|app-video-hoc-tap-thpt-{khoi}-{mon}-{video}|~/web_module/module_THPT/thpt_VideoHocTap.aspx");
        list.Add("moduleluyentapthpt|app-luyen-tap-thpt-{khoi}-{mon}|~/web_module/module_THPT/thpt_LuyenTap.aspx");
        list.Add("weblambailuyentapchitiet|bai-luyen-tap-chi-tiet-{id_khoi}/{name}-{id_test}|~/web_module/web_tracnghiem/vietnhatliencap_LamBaiLuyenTap_Ver2Copy.aspx");


        //list.Add("soLLDT_baikiemtrakieutracnghiemchitiet|slldt-bai-kiem-tra-trac-nghiem-chi-tiet-{id}|~/web_module/web_tracnghiem/vietnhatliencap_BaiKiemTra_TracNghiem.aspx");
        //list.Add("modulebaikiemtrathpt|app-bai-kiem-tra-thpt-{khoi-id}|~/web_module/module_THPT/thpt_BaiKiemTra.aspx");

        //list.Add("webTHPThuongdanbaitap|thpt-huong-dan-bai-tap-{id}|~/landingpage/THPT/thpt_HuongDanBaiTap.aspx");
        //list.Add("webTHPTbanggia|thpt-bang-gia|~/landingpage/THPT/thpt_Price.aspx");
        //APP THPT

        //list.Add("moduledoimatkhauthpt|app-doi-mat-khau-thpt|~/web_module/module_THPT/thpt_DoiMatKhau.aspx");
        //list.Add("modulelamkiemtrathpt|app-lam-kiem-tra-thpt|~/web_module/module_THPT/thpt_LamKiemTra.aspx");
        //list.Add("modulelamluyentapthpt|app-lam-luyen-tap-thpt|~/web_module/module_THPT/thpt_LamLuyenTap.aspx");
        //list.Add("moduletongtincanhanthpt|app-thong-tin-ca-nhan-thpt|~/web_module/module_THPT/thpt_ThongTinCaNhan.aspx");
        //list.Add("moduletaikhoanyeuthichthpt|app-tai-khoan-yeu-thich-thpt|~/web_module/module_THPT/thpt_Favorite.aspx");
        //list.Add("moduletaikhoanlichsuthpt|app-tai-khoan-lich-su-thpt|~/web_module/module_THPT/thpt_History.aspx");
        //list.Add("modulelichsubaikiemtrathpt|app-lich-su-bai-kiem-tra-thpt|~/web_module/module_THPT/thcs_LichSuBaiKiemTra.aspx");
        //list.Add("modulelichsubailuyentapthpt|app-lich-su-bai-luyen-tap-thpt-{khoi-id}-{mon-id}-{luyentap-id}|~/web_module/module_THPT/thpt_LichSuBaiLuyenTap.aspx");
        //list.Add("modulegiahangoithpt|app-gia-han-goi-thpt|~/web_module/module_THPT/thpt_RenewPackage.aspx");

        //trắc nghiệm
        //list.Add("weblogintracnghiem|login-account|~/web_module/web_tracnghiem/Login.aspx");
        //list.Add("webtrangchutracnghiem|trac-nghiem|~/Default_MutipleChoice.aspx");
        ////list.Add("weblambailuyentaptuluan|bai-luyen-tap-chi-tiet-tu-luan-{id_khoi}/{name}-{id_test}|~/web_module/web_tracnghiem/vietnhatliencap_LamBaiLuyenTap_TuLuan.aspx");
        //list.Add("weblambaikiemtrachitiet|bai-kiem-tra-chi-tiet/{name}-{id_test}|~/web_module/web_tracnghiem/web_LamBaiKiemTra.aspx");
        //list.Add("webresultexercices|result-exercises|~/web_module/web_tracnghiem/web_KetQuaLuyenTap.aspx");
        //list.Add("webclasssubject|subject-of-grade/{id}|~/web_module/web_tracnghiem/web_MonHocCuaKhoi.aspx");
        //list.Add("soLLDT_baikiemtracautrucmoichitiet|slldt-bai-kiem-tra-kieu-moi-chi-tiet-{id}|~/web_module/web_tracnghiem/vietnhatliencap_BaiKiemTra_CauTrucMoi.aspx");

        //bài kiểm tra
        //list.Add("modulebaikiemtratieuhoc|bai-kiem-tra-tieu-hoc-{dekiemtra-id}-{lop-id}-{sach-id}|~/web_module/module_TieuHoc/tieuhoc_BaiKiemTra.aspx");
        return list;
    }
}