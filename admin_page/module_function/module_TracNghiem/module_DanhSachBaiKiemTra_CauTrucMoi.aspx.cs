using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_DanhSachBaiKiemTra_CauTrucMoi : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int _id, test_id;
    public int _idUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {
            if (!IsPostBack)
            {
                Session["_id"] = 0;
            }
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
        var getdata = (from test in db.tbTracNghiem_BaiKiemTras
                       join khoi in db.tbKhois on test.khoi_id equals khoi.khoi_id
                       join mh in db.tbTKB_Mons on test.monhoc_id equals mh.mon_id
                       where test.hidden == false && test.username_id == _idUser
                       select new
                       {
                           test.baikiemtra_id,
                           khoi.khoi_name,
                           test.baikiemtra_name,
                           test.baikiemtra_ngaytao,
                           mh.mon_name,
                           status = test.monhoc_id == 1 && (from ch in db.tbTracNghiem_BaiKiemTra_Questions
                                                            where ch.baikiemtra_id == test.baikiemtra_id
                                                            select ch).Count() == 22 ? "Đã nhập đủ câu hỏi" :
                           arrMon.Contains(test.monhoc_id) && (from ch in db.tbTracNghiem_BaiKiemTra_Questions
                                                               where ch.baikiemtra_id == test.baikiemtra_id
                                                               select ch).Count() == 28 ? "Đã nhập đủ câu hỏi" : (from ch in db.tbTracNghiem_BaiKiemTra_Questions
                                                                                                                  where ch.baikiemtra_id == test.baikiemtra_id
                                                                                                                  select ch).Count() < 28 ? "Đang nhập thiếu câu hỏi" : "",
                           //tinhtrang = test.hidden == true ? "Đã hiển thị" : "Chưa hiển thị",
                           test.baikiemtra_tinhtrang,
                       }).OrderByDescending(test => test.baikiemtra_ngaytao);
        grvList.DataSource = getdata;
        grvList.DataBind();

    }

    protected void btnChiTiet_ServerClick(object sender, EventArgs e)
    {
        try
        {
            List<object> selectedId = grvList.GetSelectedFieldValues(new string[] { "baikiemtra_id" });
            if (selectedId.Count == 1)
            {
                foreach (var item in selectedId)
                {
                    _id = Convert.ToInt32(item);
                }
                Response.Redirect("/admin-danh-sach-bai-kiem-tra-kieu-moi-" + _id);
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
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "baikiemtra_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                tbTracNghiem_BaiKiemTra del = (from t in db.tbTracNghiem_BaiKiemTras
                                               where t.baikiemtra_id == Convert.ToInt32(item)
                                               select t).Single();
                del.hidden = true;
                //db.tbTracNghiem_BaiKiemTras.DeleteOnSubmit(del);
                db.SubmitChanges();
            }
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Xóa thành công!','','success').then(function(){grvList.Refresh();})", true);
        }
        else
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
    }
    protected void btnHidden_ServerClick(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "baikiemtra_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                tbTracNghiem_BaiKiemTra update = (from t in db.tbTracNghiem_BaiKiemTras where t.baikiemtra_id == Convert.ToInt32(item) select t).FirstOrDefault();
                update.baikiemtra_tinhtrang = "Đã hiển thị";
                db.SubmitChanges();
                alert.alert_Success(Page, "Đã chuyển bài luyện tập lên Sổ LLĐT", "");
            }
        }
    }
    //protected void btnChuyenLuyenTap_Click(object sender, EventArgs e)
    //{
    //    List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "test_id" });
    //    if (selectedKey.Count > 0)
    //    {
    //        foreach (var item in selectedKey)
    //        {
    //            tbTracNghiem_BaiLuyenTap del = (from t in db.tbTracNghiem_Tests
    //                                            join lt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals lt.luyentap_id
    //                                            where t.test_id == Convert.ToInt32(item)
    //                                            select lt).Single();
    //            del.luyentap_status = 1;
    //            db.SubmitChanges();
    //        }
    //        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Chuyển thành công!','','success').then(function(){grvList.Refresh();})", true);
    //    }
    //    else
    //        alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
    //}
    protected void btnCapNhat_ServerClick(object sender, EventArgs e)
    {
        test_id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "baikiemtra_id" }));
        Session["_id"] = test_id;
        var getData = (from blt in db.tbTracNghiem_BaiKiemTras
                       where blt.baikiemtra_id == test_id
                       select new
                       {
                           blt.baikiemtra_name
                       }).Single();
        txtTenBaiLuyenTap.Text = getData.baikiemtra_name;
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Detail", "popupControl.Show();", true);
    }

    protected void btnCapNhatTen_Click(object sender, EventArgs e)
    {
        tbTracNghiem_BaiKiemTra upd = (from blt in db.tbTracNghiem_BaiKiemTras
                                       where blt.baikiemtra_id == Convert.ToInt32(Session["_id"].ToString())
                                       select blt).Single();
        upd.baikiemtra_name = txtTenBaiLuyenTap.Text;
        db.SubmitChanges();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Lưu thành công!','','success').then(function(){grvList.Refresh();popupControl.Hide()})", true);
    }

    protected void btnXemChiTiet_ServerClick(object sender, EventArgs e)
    {
        loadData();
    }
    private void loadData()
    {
        test_id = Convert.ToInt32(txtBaiKiemTraID.Value);
        var getTracNghiem = from bkt in db.tbTracNghiem_BaiKiemTras
                            join ch in db.tbTracNghiem_BaiKiemTra_Questions on bkt.baikiemtra_id equals ch.baikiemtra_id
                            where bkt.baikiemtra_id == test_id && ch.question_group == "part1" && ch.hidden == false
                            select new
                            {
                                ch.question_id,
                                noidungcauhoi = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content
                            };
        rpCauHoi.DataSource = getTracNghiem;
        rpCauHoi.DataBind();
        //câu hỏi đúng sai
        var getCauHoiDungSai = from bkt in db.tbTracNghiem_BaiKiemTras
                               join ch in db.tbTracNghiem_BaiKiemTra_Questions on bkt.baikiemtra_id equals ch.baikiemtra_id
                               where bkt.baikiemtra_id == test_id && ch.question_group == "part2"
                               select new
                               {
                                   ch.question_id,
                                   question_content = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                               };
        rpCauHoiDungSai.DataSource = getCauHoiDungSai;
        rpCauHoiDungSai.DataBind();
        //get câu hỏi tự luận
        var getCauHoiTuLuan = from bkt in db.tbTracNghiem_BaiKiemTras
                              join ch in db.tbTracNghiem_BaiKiemTra_Questions on bkt.baikiemtra_id equals ch.baikiemtra_id
                              join da in db.tbTracNghiem_BaiKiemTra_Answers on ch.question_id equals da.question_id
                              where bkt.baikiemtra_id == test_id && ch.question_group == "part3"
                              select new
                              {
                                  ch.question_id,
                                  da.answer_id,
                                  da.answer_content,
                                  question_content = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                              };
        rpCauHoiTuLuan.DataSource = getCauHoiTuLuan;
        rpCauHoiTuLuan.DataBind();
    }
    public class Dapan
    {
        public string answer_content { get; set; }
        public string name_label { get; set; }
    }
    protected void rpCauHoi_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from ct in db.tbTracNghiem_BaiKiemTra_Answers
                               where ct.question_id == question_id && ct.answer_content != null
                               select new
                               {
                                   ct.answer_id,
                                   answer_content = ct.answer_content.Contains("style=") ? "<div class='content_image'>" + ct.answer_content + "</div>" : ct.answer_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ct.answer_content + "'>" : ct.answer_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ct.answer_content + "'> </audio>" : ct.answer_content,
                               };
        List<Dapan> dapan = new List<Dapan>();
        int index = 1;
        foreach (var item in getDataCauTraLoi)
        {
            dapan.Add(new Dapan()
            {
                answer_content = item.answer_content,
                name_label = index == 1 ? "A" : index == 2 ? "B" : index == 3 ? "C" : "D",
            });
            index++;
        };
        rpCauTraLoi.DataSource = dapan;
        rpCauTraLoi.DataBind();
    }
    protected void rpCauHoiDungSai_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpCauHoiDungSaiChiTiet = e.Item.FindControl("rpCauHoiDungSaiChiTiet") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getCauHoiChiTiet = from ct in db.tbTracNghiem_BaiKiemTra_Answers
                               where ct.question_id == question_id
                               select new
                               {
                                   ct.answer_id,
                                   answer_content = ct.answer_content.Contains("style=") ? "<div class='content_image'>" + ct.answer_content + "</div>" : ct.answer_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ct.answer_content + "'>" : ct.answer_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ct.answer_content + "'> </audio>" : ct.answer_content,
                               };
        List<Dapan> dapan = new List<Dapan>();
        int index = 1;
        foreach (var item in getCauHoiChiTiet)
        {
            dapan.Add(new Dapan()
            {
                answer_content = item.answer_content,
                name_label = index == 1 ? "A" : index == 2 ? "B" : index == 3 ? "C" : "D",
            });
            index++;
        };
        rpCauHoiDungSaiChiTiet.DataSource = dapan;
        rpCauHoiDungSaiChiTiet.DataBind();
    }

    protected void btnXoaCauHoi_ServerClick(object sender, EventArgs e)
    {
        var getCauHoi = (from ch in db.tbTracNghiem_BaiKiemTra_Questions
                         where ch.question_id == Convert.ToInt32(txtCauHoiID.Value)
                         select ch).Single();
        var checkDapAn = (from da in db.tbTracNghiem_BaiKiemTra_Answers
                          join ch in db.tbTracNghiem_BaiKiemTra_Questions on da.question_id equals ch.question_id
                          where ch.question_id == Convert.ToInt32(txtCauHoiID.Value)
                          select da);
        db.tbTracNghiem_BaiKiemTra_Answers.DeleteAllOnSubmit(checkDapAn);
        db.tbTracNghiem_BaiKiemTra_Questions.DeleteOnSubmit(getCauHoi);
        db.SubmitChanges();
        alert.alert_Success(Page, "Xóa thành công", "");
        loadData();
    }
}