using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_DanhSachBaiKiemTra : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int _id;
    public int _idUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {
            var user = (from u in db.admin_Users
                        where u.username_username == Request.Cookies["UserName"].Value
                        select u).FirstOrDefault();
            _idUser = user.username_id;
            getdata();
        }
        else
        {
            Response.Redirect("/admin-login");
        }
    }
    private void getdata()
    {
        int?[] arrMon = { 3, 4, 7, 8, 10, 52 };
        var getdata = (from test in db.tbTracNghiem_Tests
                       join khoi in db.tbKhois on test.khoi_id equals khoi.khoi_id
                       //join mh in db.tbMonHocs on test.monhoc_id equals mh.monhoc_id
                       join mh in db.tbTKB_Mons on test.monhoc_id equals mh.mon_id
                       join lt in db.tbTracNghiem_BaiLuyenTaps on test.luyentap_id equals lt.luyentap_id
                       where test.username_id == _idUser
                       && test.luyentap_id != null && test.hidden == false
                       && lt.luyentap_status == 1
                       orderby test.test_createdate descending
                       select new
                       {
                           test.test_id,
                           khoi.khoi_name,
                           lt.luyentap_name,
                           lt.luyentap_id,
                           test.test_createdate,
                           mh.mon_name,
                           test.test_link,
                           bkt_loai = lt.luyentap_baitaptuluan == "kiem tra kieu moi" ? "BKT cấu trúc mới" : lt.luyentap_baitaptuluan == "kiem tra trac nghiem" ? "BKT trắc nghiệm" : lt.luyentap_baitaptuluan == "kiem tra trac nghiem tu chon" ? "BKT trắc nghiệm tự chọn" : "",
                           bkt_tinhtrang = lt.luyentap_baitaptuluan == "kiem tra kieu moi" && test.monhoc_id == 1 && (from ch in db.tbTracNghiem_Questions
                                                                                                                      where ch.baikiemtra_id == test.test_id
                                                                                                                      select ch).Count() == 22 ? "Đã nhập đủ câu hỏi" :
                           lt.luyentap_baitaptuluan == "kiem tra kieu moi" && arrMon.Contains(test.monhoc_id) && (from ch in db.tbTracNghiem_Questions
                                                                                                                  where ch.baikiemtra_id == test.test_id
                                                                                                                  select ch).Count() == 28 ? "Đã nhập đủ câu hỏi" : lt.luyentap_baitaptuluan == "kiem tra kieu moi" && (from ch in db.tbTracNghiem_Questions
                                                                                                                                                                                                                        where ch.baikiemtra_id == test.test_id
                                                                                                                                                                                                                        select ch).Count() < 28 ? "Đang nhập thiếu câu hỏi" : lt.luyentap_baitaptuluan == "kiem tra trac nghiem" ? "Đã nhập " + (from ch in db.tbTracNghiem_Questions
                                                                                                                                                                                                                                                                                                                                                 where ch.baikiemtra_id == test.test_id
                                                                                                                                                                                                                                                                                                                                                 select ch).Count() + " câu hỏi" : "",
                           link_detail = lt.luyentap_baitaptuluan == "kiem tra kieu moi" ? "/admin-tao-bai-kiem-tra-kieu-moi-" + test.test_id : lt.luyentap_baitaptuluan == "kiem tra trac nghiem" ? "/admin-tao-bai-kiem-tra-trac-nghiem-" + test.test_id : "",
                           link_xemde = lt.luyentap_baitaptuluan == "kiem tra kieu moi" ? "/admin-xem-truoc-bai-kiem-tra-kieu-moi-" + test.test_id : lt.luyentap_baitaptuluan == "kiem tra trac nghiem" ? "/admin-xem-truoc-bai-kiem-tra-trac-nghiem-" + test.test_id : lt.luyentap_baitaptuluan == "kiem tra trac nghiem tu chon" ? "/admin-xem-truoc-bai-kiem-tra-tu-chon-" + test.test_id : "",
                           style_link = lt.luyentap_baitaptuluan == "kiem tra trac nghiem tu chon" ? "display:none" : "",
                       });
        grvList.DataSource = getdata;
        grvList.DataBind();

    }
    protected void build_url_Click(object sender, EventArgs e)
    {
        var test = (from t in db.tbTracNghiem_Tests
                    where t.test_id == Convert.ToInt32(id_key.Value)
                    select t).SingleOrDefault();

        string[] arrList = test.test_link.Split('/');
        string str_first = arrList[0];
        string str_sec = arrList[1];
        //string duongdan = "http://tracnghiem.vietnhatschool.edu.vn/" + "truy-cap-" + str_first + "-" + _idUser + "/" + str_sec;
        string duongdan = "https://vietnhatschool.edu.vn/bai-kiem-tra-chi-tiet/" + str_sec;
        url.Value = duongdan;
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "geturl()", true);
    }

    protected void btnChiTiet_ServerClick(object sender, EventArgs e)
    {
        try
        {
            List<object> selectedId = grvList.GetSelectedFieldValues(new string[] { "test_id" });
            if (selectedId.Count == 1)
            {
                foreach (var item in selectedId)
                {
                    _id = Convert.ToInt32(item);
                }
                Response.Redirect("/admin-de-luyen-tap-chi-tiet-" + _id);
            }
            else if (selectedId.Count == 0)
            {
                alert.alert_Warning(Page, "Chưa chọn bài luyện tập để xem!", "");
            }
            else if (selectedId.Count > 1)
            {
                alert.alert_Warning(Page, "Chỉ được chọn 1 bài luyện tập để xem!", "");
            }
        }
        catch (Exception)
        {
            alert.alert_Error(Page, "Lỗi! Xin vui lòng liên hệ tổ IT!", "");
        }

    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "test_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                tbTracNghiem_Test del = (from t in db.tbTracNghiem_Tests
                                         where t.test_id == Convert.ToInt32(item)
                                         select t).Single();
                del.hidden = true;
                db.SubmitChanges();
            }
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Xóa thành công!','','success').then(function(){grvList.Refresh();})", true);
        }
        else
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
    }

    protected void btnChuyenLuyenTap_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "test_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                tbTracNghiem_BaiLuyenTap del = (from t in db.tbTracNghiem_Tests
                                                join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
                                                where t.test_id == Convert.ToInt32(item)
                                                select lt).Single();
                del.luyentap_status = 1;
                db.SubmitChanges();
            }
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Chuyển thành công!','','success').then(function(){grvList.Refresh();})", true);
        }
        else
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
    }
}