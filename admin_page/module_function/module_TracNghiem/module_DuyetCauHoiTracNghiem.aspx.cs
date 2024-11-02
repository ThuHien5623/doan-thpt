using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_DuyetCauHoiTracNghiem : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected int _idUser, _idNamHoc;
    cls_Alert alert = new cls_Alert();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {
            var getUser = (from u in db.admin_Users
                           where u.username_username == Request.Cookies["UserName"].Value
                           select u).FirstOrDefault();
            _idUser = getUser.username_id;
            if (!IsPostBack)
            {
                //Load giáo viên
                var listGV = from u in db.admin_Users
                             where u.groupuser_id == 3 && u.username_active == true && u.bophan_id != 100 && u.username_capday.Contains("Trung học")
                             select u;
                ddlGiaoVien.DataSource = listGV;
                ddlGiaoVien.DataBind();
            }
            txtTongDuyet.Text = (from qs in db.tbTracNghiem_Questions
                                 where qs.nguoiduyet_id == _idUser && qs.hidden == false && qs.question_active == true
                                 select qs).Count() + "";
        }
        else
        {
            Response.Redirect("/admin-login");
        }
    }

    public class Thang
    {
        public string thang { get; set; }
        public string soluong { get; set; }
    }

    protected void rpTracNghiem_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpThang = e.Item.FindControl("rpThang") as Repeater;
        int username_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "username_id").ToString());
        List<Thang> dapan = new List<Thang>();
        for (int i = 1; i <= 12; i++)
        {
            var getThang = (from tn in db.tbTracNghiem_Questions
                            where tn.username_id == username_id && Convert.ToDateTime(tn.question_createdate).Month == i && Convert.ToDateTime(tn.question_createdate).Year == DateTime.Now.Year
                            select tn).Count();
            dapan.Add(new Thang
            {
                soluong = getThang + ""
            });

        }
        rpThang.DataSource = dapan;
        rpThang.DataBind();
    }

    protected void rpDanhSachCauHoi_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpDapAn = e.Item.FindControl("rpDapAn") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from t in db.tbTracNghiem_Answers
                               where t.question_id == question_id
                               select new
                               {
                                   t.answer_id,
                                   t.answer_content,
                                   t.answer_true,
                                   t.question_id,
                                   mystyle = t.answer_true == true ? "style='background: #e4a70f;'" : ""
                               };
        rpDapAn.DataSource = getDataCauTraLoi;
        rpDapAn.DataBind();
    }

    protected void ddlGiaoVien_SelectedIndexChanged(object sender, EventArgs e)
    {
        var getData = from gvmh in db.tbTKB_GiaoVienDayMon_Tests
                      join mh in db.tbTKB_Mons on gvmh.mon_id equals mh.mon_id
                      where gvmh.username_id == Convert.ToInt32(ddlGiaoVien.SelectedItem.Value)
                      group mh by mh.mon_id into k
                      select new
                      {
                          mon_id = k.Key,
                          mon_name = k.First().mon_name,
                      };
        ddlMon.DataSource = getData;
        ddlMon.DataBind();
    }
    private void loadData()
    {
        var getCauHoi = from ch in db.tbTracNghiem_Questions
                        join ls in db.tbTracNghiem_Lessons on ch.lesson_id equals ls.lesson_id
                        join c in db.tbTracNghiem_Chapters on ls.chapter_id equals c.chapter_id
                        join mh in db.tbTKB_Mons on c.monhoc_id equals mh.mon_id
                        join k in db.tbKhois on c.khoi_id equals k.khoi_id
                        where (ch.username_id == Convert.ToInt32(ddlGiaoVien.SelectedItem.Value) && ch.hidden == false && ch.question_type == "Trắc nghiệm"
                        && c.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue) && c.monhoc_id == Convert.ToInt32(ddlMon.SelectedItem.Value)
                        && ch.question_active == null && ch.question_trangthaiduyet == null) //|| (ch.username_id == Convert.ToInt32(ddlGiaoVien.SelectedItem.Value) && ch.hidden == false && ch.question_type == "Trắc nghiệm"
                        //&& c.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue) && c.monhoc_id == Convert.ToInt32(ddlMon.SelectedItem.Value)
                        //&& ch.question_trangthaiduyet == null)
                        orderby ls.lesson_id ascending, ch.question_id ascending
                        select new
                        {
                            ch.question_id,
                            k.khoi_name,
                            mh.mon_name,
                            ls.lesson_name,
                            ls.lesson_id,
                            noidungcauhoi = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("mp3") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                        };
        rpDanhSachCauHoi.DataSource = getCauHoi;
        rpDanhSachCauHoi.DataBind();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "HiddenLoadingIcon()", true);
    }
    protected void btnXemCauHoi_ServerClick(object sender, EventArgs e)
    {
        loadData();
    }

    protected void btnDuyet_ServerClick(object sender, EventArgs e)
    {
        try
        {
            tbTracNghiem_Question duyet = db.tbTracNghiem_Questions.Where(x => x.question_id == Convert.ToInt32(txtQuestionID.Value)).Single();
            duyet.question_active = true;
            duyet.nguoiduyet_id = _idUser;
            db.SubmitChanges();
            alert.alert_Success(Page, "Duyệt thành công!", "");
            loadData();
        }
        catch { }
    }
    protected void btnLuuPhanHoi_Click(object sender, EventArgs e)
    {
        try
        {
            tbTracNghiem_Question duyet = db.tbTracNghiem_Questions.Where(x => x.question_id == Convert.ToInt32(txtQuestionID.Value)).Single();
            duyet.question_trangthaiduyet = txtPhanHoi.Value;
            db.SubmitChanges();
            alert.alert_Success(Page, "Gửi phản hồi thành công!", "");
            loadData();
        }
        catch { }
    }
}