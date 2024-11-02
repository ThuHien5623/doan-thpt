using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for adminmodule
/// </summary>
public class adminmodule
{
    public adminmodule()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public List<string> UrlRoutes()
    {
        List<string> list = new List<string>();
        //Module SEO
        //list.Add("moduleseo|admin-seo|~/admin_page/module_function/module_SEO.aspx");
        //Module quản lí tài khoản
        //list.Add("moduledangky|admin-dang-ki|~/admin_page/module_function/module_QuanLy_TaiKhoan/module_DangKy.aspx");
        //list.Add("modulequanlitaikhoan|admin-quan-li-tai-khoan|~/admin_page/module_function/module_QuanLy_TaiKhoan/module_Account.aspx");
        //list.Add("moduleagiahan|admin-gia-han|~/admin_page/module_function/module_QuanLy_TaiKhoan/module_GiaHan.aspx");

        ////Module quản lý LandingPage và App Sổ LLĐT
        //list.Add("moduleslldtslide|admin-landingpage-slide|~/admin_page/module_function/module_App_SLLDT/module_SLLDT_Slide.aspx");
        //list.Add("moduleslldtslogan|admin-landingpage-slogan|~/admin_page/module_function/module_App_SLLDT/module_SLLDT_Slogan.aspx");
        //list.Add("moduleslldtvideo|admin-landingpage-video|~/admin_page/module_function/module_App_SLLDT/module_SLLDT_Video.aspx");
        //list.Add("moduleslldtquytrinh|admin-landingpage-quy-trinh|~/admin_page/module_function/module_App_SLLDT/module_SLLDT_QuyTrinh.aspx");
        //list.Add("moduleslldtquangcao|admin-landingpage-quang-cao|~/admin_page/module_function/module_App_SLLDT/module_SLLDT_QuangCao.aspx");
        //list.Add("moduleslldtthongbao|admin-slldt-thong-bao|~/admin_page/module_function/module_App_SLLDT/module_SLLDT_ThongBao.aspx");
        //list.Add("moduleslldtluyentapstar|admin-slldt-luyen-tap-star|~/admin_page/module_function/module_App_SLLDT/module_SLLDT_LuyenTap_Star.aspx");
        //list.Add("modulehuongdanbaitap|admin-menu-huong-dan|~/admin_page/module_function/module_App_SLLDT/module_SLLDT_Menu_HuongDan.aspx");
        //list.Add("modulebanggia|admin-bang-gia|~/admin_page/module_function/module_GioiThieu4Cap/module_BangGia.aspx");


        //module trắc nghiệm
        list.Add("moduledanhsachbailuyentap|admin-danh-sach-bai-luyen-tap|~/admin_page/module_function/module_TracNghiem/module_DanhSachBaiLuyenTap.aspx");
        list.Add("moduletaobailuyentapngaunhien|admin-tao-bai-luyen-tap-ngau-nhien|~/admin_page/module_function/module_TracNghiem/module_TaoDeLuyenTapNgauNhien_Ver2.aspx");
        list.Add("moduletaovideohoctap|admin-tao-video-hoc-tap|~/admin_page/module_function/module_TracNghiem/module_SLLDT_VideoHocTap.aspx");
        list.Add("modulexemchitietbai|admin-de-luyen-tap-chi-tiet-{test_id}|~/admin_page/module_function/module_TracNghiem/module_BaiLuyenTap_ChiTiet_Ver2.aspx");





        list.Add("moduletaobailuyentapformatmoi|admin-tao-bai-luyen-tap-format-moi|~/admin_page/module_function/module_TracNghiem/module_TaoDeLuyenTapNgauNhien_FormatMoi.aspx");
        list.Add("moduletaobailuyentaptuluan|admin-tao-bai-luyen-tap-tu-luan|~/admin_page/module_function/module_TracNghiem/module_TaoDeLuyenTapTuLuan.aspx");
        //list.Add("moduletaobailuyentapngaunhien|admin-tao-bai-luyen-tap-ngau-nhien|~/admin_page/module_function/module_TracNghiem/module_TaoDeLuyenTap_Version2.aspx");
        list.Add("moduletaobailuyentaptuchon|admin-tao-bai-luyen-tap-tu-chon|~/admin_page/module_function/module_TracNghiem/module_TaoCauHoiLuyenTapTuChon.aspx");
        //list.Add("modulexemmatrandethi|truy-cap-bai-luyen-tap-chi-tiet-{id_khoi}-{user_id}/{name}-{id_test}|~/admin_page/module_function/module_TracNghiem/module_MaTranDeThi_Detail_Version2.aspx");
        list.Add("modulexemmatrandethi|truy-cap-bai-luyen-tap-chi-tiet-{id_khoi}/{name}-{id_test}-{user_id}|~/admin_page/module_function/module_TracNghiem/module_MaTranDeThi_Detail_Version2.aspx");
        list.Add("modulegiaoviendaykhoi|admin-quan-ly-giao-vien-day-khoi|~/admin_page/module_function/module_GiaoVien/module_ThemGiaoVienDayKhoi.aspx");
        list.Add("moduledacta|admin-dac-ta|~/admin_page/module_function/module_TracNghiem/module_DacTa.aspx");
        //list.Add("modulexemchitietbai|admin-de-luyen-tap-chi-tiet-{test_id}|~/admin_page/module_function/module_TracNghiem/module_BaiLuyenTap_ChiTiet.aspx");
        //list.Add("modulexemchitietbai|admin-de-luyen-tap-chi-tiet-{test_id}|~/admin_page/module_function/module_TracNghiem/module_BaiLuyenTap_ChiTiet_Ver2.aspx");
        list.Add("modulexemchitietbaiformatmoi|admin-de-luyen-tap-format-moi-chi-tiet-{test_id}|~/admin_page/module_function/module_TracNghiem/module_BaiLuyenTap_ChiTiet_FormatMoi.aspx");
        list.Add("modulethemcauhoituluan|admin-quan-ly-cau-hoi-tu-luan-{khoi_id}-{mon_id}-{chuong_id}-{baihoc_id}|~/admin_page/module_function/module_TracNghiem/module_QuanLyCauHoiTuLuan.aspx");
        list.Add("modulethemcauhoitracnghiem|admin-quan-ly-cau-hoi-trac-nghiem-{khoi_id}-{mon_id}-{chuong_id}-{baihoc_id}|~/admin_page/module_function/module_TracNghiem/module_QuanLyCauHoiTracNghiem.aspx");
        list.Add("modulecauhoitracnghiemphan2|admin-quan-ly-trac-nghiem-phan-hai-{khoi_id}-{mon_id}-{chuong_id}-{baihoc_id}|~/admin_page/module_function/module_TracNghiem/module_QuanLyCauHoiTracNghiem_Part2.aspx");
        list.Add("modulecauhoitracnghiemphan3|admin-quan-ly-trac-nghiem-phan-ba-{khoi_id}-{mon_id}-{chuong_id}-{baihoc_id}|~/admin_page/module_function/module_TracNghiem/module_QuanLyCauHoiTracNghiem_Part3.aspx");
        list.Add("modulequanlymoduletracnghiem|admin-quan-ly-module-trac-nghiem|~/admin_page/module_function/module_TracNghiem/module_QuanLyModuleTracNghiem.aspx");
        list.Add("modulequanlydanhsachbaikiemtra|admin-danh-sach-bai-kiem-tra|~/admin_page/module_function/module_TracNghiem/module_DanhSachBaiKiemTra.aspx");
        list.Add("moduletaobaikiemtrangaunhien|admin-tao-bai-kiem-tra-ngau-nhien|~/admin_page/module_function/module_TracNghiem/module_TaoDeKiemTraNgauNhien.aspx");
        list.Add("moduletaodekiemtratuchon|admin-tao-bai-kiem-tra-tu-chon|~/admin_page/module_function/module_TracNghiem/module_TaoDeKiemTra_TuChon.aspx");
        list.Add("modulequanlybaikiemtrakieumoi|admin-danh-sach-bai-kiem-tra-kieu-moi|~/admin_page/module_function/module_TracNghiem/module_DanhSachBaiKiemTra_CauTrucMoi.aspx");
        list.Add("moduletaodekiemtrakieumoichitiet|admin-tao-bai-kiem-tra-kieu-moi-{id}|~/admin_page/module_function/module_TracNghiem/module_TaoDeKiemTra_CauTrucMoi.aspx");
        list.Add("moduletaodetracnghiemmacdinh|admin-tao-bai-kiem-tra-trac-nghiem-{id}|~/admin_page/module_function/module_TracNghiem/module_TaoDeKiemTra_TracNghiem.aspx");
        list.Add("modulecemtruocbaikiemtrakieumoi|admin-xem-truoc-bai-kiem-tra-kieu-moi-{id}|~/admin_page/module_function/module_TracNghiem/module_XemTruocBaiKiemTra_CauTrucMoi.aspx");
        list.Add("modulecemtruocbaikiemtratracnghiem|admin-xem-truoc-bai-kiem-tra-trac-nghiem-{id}|~/admin_page/module_function/module_TracNghiem/module_XemTruocBaiKiemTra_TracNghiem.aspx");
        list.Add("modulecemtruocbaikiemtratuchon|admin-xem-truoc-bai-kiem-tra-tu-chon-{id}|~/admin_page/module_function/module_TracNghiem/module_XemTruocBaiKiemTra_TuChon.aspx");
        return list;
    }
}