using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_DanhSachBaiLuyenTap : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int _id;
    private static int _idUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {
            if (!IsPostBack)
            {
                var user = (from u in db.admin_Users
                            where u.username_username == Request.Cookies["UserName"].Value
                            select u).FirstOrDefault();
                _idUser = user.username_id;
            }
            getdata();
        }
        else
        {
            Response.Redirect("/admin-login");
        }
    }
    private void getdata()
    {
        var getdata = (from test in db.tbTracNghiem_Tests
                       join l in db.tbLops on test.khoi_id equals l.lop_id
                       //join mh in db.tbMonHocs on test.monhoc_id equals mh.monhoc_id
                       join mh in db.tbTKB_Mons on test.monhoc_id equals mh.mon_id
                       join lt in db.tbTracNghiem_BaiLuyenTaps on test.luyentap_id equals lt.luyentap_id
                       where test.username_id == _idUser
                       && test.luyentap_id != null
                       && lt.luyentap_status == 2
                       select new
                       {
                           test.test_id,
                           l.lop_name,
                           lt.luyentap_name,
                           lt.luyentap_id,
                           test.test_createdate,
                           mh.mon_name,
                           test_soluongcauhoi = test.test_soluongcauhoi + " câu",
                           test_thoigianlambai = Convert.ToInt32(test.test_thoigianlambai) / 60 + " phút",
                           tinhtrang = test.hidden == false ? "Chưa hiển thị" : "Đã hiển thị"
                       }).OrderByDescending(test => test.test_createdate);
        grvList.DataSource = getdata;
        grvList.DataBind();

    }
    protected void build_url_Click(object sender, EventArgs e)
    {
        var test = (from t in db.tbTracNghiem_Tests
                        //join btk in db.tbTracNghiem_BaiThiCates on t.baithicate_id equals btk.baithicate_id
                    where t.test_id == Convert.ToInt32(id_key.Value)
                    select new
                    {
                        //t.test_id,
                        //t.khoi_id,
                        //btk.baithicate_name,
                        t.test_link,
                    }).SingleOrDefault();

        string[] arrList = test.test_link.Split('/');
        string str_first = arrList[0];
        string str_sec = arrList[1];
        //string duongdan = "http://tracnghiem.vietnhatschool.edu.vn/" + "truy-cap-" + str_first + "-" + _idUser + "/" + str_sec;
        string duongdan = "http://localhost:56960/" + "truy-cap-" + str_first + "-" + _idUser + "/" + str_sec;
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
                _id = Convert.ToInt32(selectedId[0]);
                var check = (from t in db.tbTracNghiem_Tests
                             where t.test_id == _id
                             select t).Single();
                if (check.test_soluongcauhoi == null)
                    Response.Redirect("/admin-de-luyen-tap-format-moi-chi-tiet-" + _id);
                else
                    Response.Redirect("/admin-de-luyen-tap-chi-tiet-" + _id);
                //admin-de-luyen-tap-format-moi-chi-tiet-
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
                db.tbTracNghiem_Tests.DeleteOnSubmit(del);
                db.SubmitChanges();
            }
            alert.alert_Success(Page, "Xóa thành công!", "");
            getdata();
        }
        else
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
    }

    protected void btnChuyenLamBai_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "test_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                tbTracNghiem_Test update = (from t in db.tbTracNghiem_Tests
                                            where t.test_id == Convert.ToInt32(item)
                                            select t).Single();
                update.hidden = true;
                db.SubmitChanges();
            }
            alert.alert_Success(Page, "Chuyển thành công!", "");
            getdata();
        }
        else
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
    }
}