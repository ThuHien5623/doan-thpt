using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_QuanLyModuleTracNghiem : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    public int id_user;
    protected void Page_Load(object sender, EventArgs e)
    {
        var checkTaiKhoan = (from u in db.admin_Users
                             where u.username_username == Request.Cookies["UserName"].Value
                             select u).FirstOrDefault();
        id_user = checkTaiKhoan.username_id;
        if (!IsPostBack)
        {
            Session["chude"] = 0;
            Session["bai"] = 0;
            ddlKhoi.Enabled = true;
            ddlBai.Enabled = false;
            ddlMon.Enabled = false;
            ddlChuDe.Enabled = false;
            // đổ khối
            //var listKhoi = from gvdk in db.tbGiaoVienDayKhois
            //               join k in db.tbKhois on gvdk.khoi_id equals k.khoi_id
            //               where gvdk.username_id == checkTaiKhoan.username_id
            //               orderby k.khoi_name ascending
            //               select k;
            //var listNV = from nv in db.tbNhanViens select nv;
            //if (listKhoi.Count() != 0)
            //{
            //    ddlKhoi.Items.Clear();
            //    ddlKhoi.Items.Insert(0, "");
            //    ddlKhoi.AppendDataBoundItems = true;
            //    ddlKhoi.DataTextField = "khoi_name";
            //    ddlKhoi.DataValueField = "khoi_id";
            //    ddlKhoi.DataSource = listKhoi;
            //    ddlKhoi.DataBind();
            //    //đổ môn
            //}
            //else
            //{
            //    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "showError()", true);
            //}
            List<Thang> dapan = new List<Thang>();
            for (int i = 1; i <= 14; i++)
            {
                if (i == 13)
                {
                    var getDaDuyet = (from tn in db.tbTracNghiem_Questions
                                      where tn.username_id == id_user && tn.hidden == false && tn.question_active == true
                                      select tn).Count();
                    dapan.Add(new Thang
                    {
                        soluong = getDaDuyet + ""
                    });
                }
                else if (i == 14)
                {
                    var getPhanHoi = (from tn in db.tbTracNghiem_Questions
                                      where tn.username_id == id_user && tn.hidden == false && tn.question_trangthaiduyet != null
                                      select tn).Count();
                    dapan.Add(new Thang
                    {
                        soluong = getPhanHoi + ""
                    });
                }
                else
                {
                    var getThang = (from tn in db.tbTracNghiem_Questions
                                    where tn.username_id == id_user && Convert.ToDateTime(tn.question_createdate).Month == i && Convert.ToDateTime(tn.question_createdate).Year == DateTime.Now.Year
                                    select tn).Count();
                    dapan.Add(new Thang
                    {
                        soluong = getThang + ""
                    });

                }
            }
            rpThongKeTracNghiem.DataSource = dapan;
            rpThongKeTracNghiem.DataBind();

            //đếm số câu hỏi cho từng bài
            var getDanhSachBai = from ls in db.tbTracNghiem_Lessons
                                 join c in db.tbTracNghiem_Chapters on ls.chapter_id equals c.chapter_id
                                 join k in db.tbKhois on ls.khoi_id equals k.khoi_id
                                 join q in db.tbTracNghiem_Questions on ls.lesson_id equals q.lesson_id
                                 where q.username_id == id_user
                                 group new { q, c, ls} by new{ q.lesson_id, ls.lesson_name, c.chapter_id } into k
                                 select new
                                 {
                                     lesson_name = k.Key.lesson_name,
                                     chapter_name = k.First().c.chapter_name,
                                     khoi_id = k.First().c.khoi_id,
                                     khoi_name = (from k1 in db.tbKhois
                                                 where k1.khoi_id == k.First().ls.khoi_id
                                                 select k1.khoi_name).First(),
                                     count = (from qs in db.tbTracNghiem_Questions
                                             join l in db.tbTracNghiem_Lessons on qs.lesson_id equals l.lesson_id
                                             where qs.lesson_id == k.Key.lesson_id && qs.hidden==false && qs.question_type== "Trắc nghiệm"
                                              select qs).Count(),
                                 };
            rpDanhSachBai.DataSource = getDanhSachBai.OrderBy(x=>x.khoi_id);
            rpDanhSachBai.DataBind();
        }

    }
    public class Thang
    {
        public string thang { get; set; }
        public string soluong { get; set; }
    }
    protected void ddlKhoi_SelectedIndexChanged(object sender, EventArgs e)
    {
        // đổ lại ds môn
        //var listMon = from gvdm in db.tbTKB_GiaoVienDayMon_Tests
        //              join m in db.tbTKB_Mons on gvdm.mon_id equals m.mon_id
        //              join l in db.tbLops on gvdm.lop_id equals l.lop_id
        //              where gvdm.username_id == id_user && gvdm.lop_id != null && m.mon_name != "Tất cả"
        //              group gvdm by gvdm.mon_id into g
        //              select new
        //              {
        //                  mon_id = g.Key,
        //                  mon_name = (from mh in db.tbTKB_Mons where mh.mon_id == Convert.ToInt32(g.Key) select mh.mon_name).FirstOrDefault(),
        //              };
        var listMon = from gvdm in db.tbTracNghiem_GiaoVienDayMons
                      join m in db.tbTKB_Mons on gvdm.mon_id equals m.mon_id
                      //join l in db.tbLops on gvdm.lop_id equals l.lop_id
                      where gvdm.username_id == id_user
                      select m;
        if (listMon.Count() > 0)
        {
            ddlMon.Items.Clear();
            ddlMon.Items.Insert(0, "");
            ddlMon.AppendDataBoundItems = true;
            ddlMon.DataSource = listMon;
            ddlMon.DataTextField = "mon_name";
            ddlMon.DataValueField = "mon_id";
            ddlMon.DataBind();
            ddlMon.Enabled = true;
        }
        else
        {
            ddlMon.Items.Clear();
            ddlMon.Items.Insert(0, "Không có dữ liệu");
            ddlMon.AppendDataBoundItems = true;
            ddlMon.DataSource = null;
            ddlMon.DataBind();
            ddlMon.Enabled = false;
        }
    }

    protected void ddlMon_SelectedIndexChanged(object sender, EventArgs e)
    {
        var listChuDe = from c in db.tbTracNghiem_Chapters
                        where c.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue) && c.monhoc_id == Convert.ToInt32(ddlMon.SelectedValue)
                        select c;
        if (listChuDe.Count() > 0)
        {
            ddlChuDe.Items.Clear();
            ddlChuDe.Items.Insert(0, "");
            ddlChuDe.AppendDataBoundItems = true;
            ddlChuDe.DataSource = listChuDe;
            ddlChuDe.DataTextField = "chapter_name";
            ddlChuDe.DataValueField = "chapter_id";
            ddlChuDe.DataBind();
            ddlChuDe.Enabled = true;
        }
        else
        {
            ddlChuDe.Items.Clear();
            ddlChuDe.Items.Insert(0, "Không có dữ liệu");
            ddlChuDe.AppendDataBoundItems = true;
            ddlChuDe.DataSource = null;
            ddlChuDe.DataBind();
            ddlChuDe.Enabled = false;
        }
    }
    protected void ddlChuDe_SelectedIndexChanged(object sender, EventArgs e)
    {
        var listBai = from l in db.tbTracNghiem_Lessons
                      where l.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue)
                      && l.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
                      && l.chapter_id == Convert.ToInt16(ddlChuDe.SelectedValue)
                      select l;
        if (listBai.Count() > 0)
        {
            ddlBai.Items.Clear();
            ddlBai.Items.Insert(0, "");
            ddlBai.AppendDataBoundItems = true;
            ddlBai.DataSource = listBai;
            ddlBai.DataTextField = "lesson_name";
            ddlBai.DataValueField = "lesson_id";
            ddlBai.DataBind();
            ddlBai.Enabled = true;
        }
        else
        {
            ddlBai.Items.Clear();
            ddlBai.Items.Insert(0, "Không có dữ liệu");
            ddlBai.AppendDataBoundItems = true;
            ddlBai.DataSource = null;
            ddlBai.DataBind();
            ddlBai.Enabled = false;
        }

    }

    protected void btnThemChuDe_ServerClick(object sender, EventArgs e)
    {
        if (ddlKhoi.SelectedValue != "")
        {
            if (ddlMon.SelectedValue != "")
            {
                Session["chude"] = 0;
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "popupControl.Show();", true);
            }
            else
                alert.alert_Error(Page, "Vui lòng chọn môn", " ");
        }
        else
            alert.alert_Error(Page, "Vui lòng chọn khối", " ");
    }

    protected void btnLuu_Click(object sender, EventArgs e)
    {
        if (Session["chude"].ToString() == "0")
        {
            tbTracNghiem_Chapter insert = new tbTracNghiem_Chapter();
            insert.chapter_name = txtTenChuDe.Text;
            insert.khoi_id = Convert.ToInt32(ddlKhoi.SelectedValue);
            insert.monhoc_id = Convert.ToInt32(ddlMon.SelectedValue);
            db.tbTracNghiem_Chapters.InsertOnSubmit(insert);
            db.SubmitChanges();
            alert.alert_Success(Page, "Thêm thành công", "");
        }
        else
        {
            tbTracNghiem_Chapter updadte = (from c in db.tbTracNghiem_Chapters where c.chapter_id == Convert.ToInt32(Session["chude"].ToString()) select c).Single();
            updadte.chapter_name = txtTenChuDe.Text;
            db.SubmitChanges();
            alert.alert_Success(Page, "Cập nhật thành công", "");
        }
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "popupControl.Hide();", true);
        var listChuDe = from c in db.tbTracNghiem_Chapters
                        where c.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue) && c.monhoc_id == Convert.ToInt32(ddlMon.SelectedValue)
                        select c;
        ddlChuDe.Items.Clear();
        ddlChuDe.Items.Insert(0, "");
        ddlChuDe.AppendDataBoundItems = true;
        ddlChuDe.DataSource = listChuDe;
        ddlChuDe.DataTextField = "chapter_name";
        ddlChuDe.DataValueField = "chapter_id";
        ddlChuDe.DataBind();
        ddlChuDe.Enabled = true;
    }

    protected void btnLuuBai_Click(object sender, EventArgs e)
    {
        if (Session["bai"].ToString() == "0")
        {
            tbTracNghiem_Lesson insertBai = new tbTracNghiem_Lesson();
            insertBai.chapter_id = Convert.ToInt32(ddlChuDe.SelectedValue);
            insertBai.lesson_name = txtTenBai.Text;
            insertBai.khoi_id = Convert.ToInt32(ddlKhoi.SelectedValue);
            insertBai.monhoc_id = Convert.ToInt32(ddlMon.SelectedValue);
            db.tbTracNghiem_Lessons.InsertOnSubmit(insertBai);
            db.SubmitChanges();
            alert.alert_Success(Page, "Thêm thành công", "");
        }
        else
        {
            tbTracNghiem_Lesson update = (from ls in db.tbTracNghiem_Lessons where ls.lesson_id == Convert.ToInt32(Session["bai"].ToString()) select ls).Single();
            update.lesson_name = txtTenBai.Text;
            db.SubmitChanges();
            alert.alert_Success(Page, "Cập nhật thành công", "");
        }
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "popupThemBai.Hide();", true);
        var listBai = from l in db.tbTracNghiem_Lessons
                      where l.khoi_id == Convert.ToInt16(ddlKhoi.SelectedValue)
                      && l.monhoc_id == Convert.ToInt16(ddlMon.SelectedValue)
                      && l.chapter_id == Convert.ToInt16(ddlChuDe.SelectedValue)
                      select l;
        ddlBai.Items.Clear();
        ddlBai.Items.Insert(0, "");
        ddlBai.AppendDataBoundItems = true;
        ddlBai.DataSource = listBai;
        ddlBai.DataTextField = "lesson_name";
        ddlBai.DataValueField = "lesson_id";
        ddlBai.DataBind();
        ddlBai.Enabled = true;
    }

    protected void btnThemBai_Click(object sender, EventArgs e)
    {
        if (ddlKhoi.SelectedValue != "")
        {
            if (ddlMon.SelectedValue != "")
            {
                if (ddlChuDe.SelectedValue != "")
                {
                    Session["bai"] = 0;
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "popupThemBai.Show();", true);
                }
                else
                    alert.alert_Error(Page, "Vui lòng chọn chủ đề", " ");
            }
            else
                alert.alert_Error(Page, "Vui lòng chọn môn", " ");
        }
        else
            alert.alert_Error(Page, "Vui lòng chọn khối", " ");
    }
    protected void btnThemCauHoiTracNghiem_ServerClick(object sender, EventArgs e)
    {
        if (ddlKhoi.SelectedValue != "" && ddlMon.SelectedValue != "" && ddlChuDe.SelectedValue != "" && ddlBai.SelectedValue != "")
        {
            int ID_khoi = Convert.ToInt32(ddlKhoi.SelectedValue);
            int ID_Mon = Convert.ToInt32(ddlMon.SelectedValue);
            int ID_Chuong = Convert.ToInt32(ddlChuDe.SelectedValue);
            int ID_Bai = Convert.ToInt32(ddlBai.SelectedValue);
            Response.Redirect("admin-quan-ly-cau-hoi-trac-nghiem-" + ID_khoi + "-" + ID_Mon + "-" + ID_Chuong + "-" + ID_Bai);
        }
        else
            alert.alert_Error(Page, "Vui lòng đủ dữ liệu", " ");
    }
    protected void btnThemCauHoiTuLuan_ServerClick(object sender, EventArgs e)
    {
        if (ddlKhoi.SelectedValue != "" && ddlMon.SelectedValue != "" && ddlChuDe.SelectedValue != "" && ddlBai.SelectedValue != "")
        {
            int ID_khoi = Convert.ToInt16(ddlKhoi.SelectedValue);
            int ID_Mon = Convert.ToInt16(ddlMon.SelectedValue);
            int ID_Chuong = Convert.ToInt16(ddlChuDe.SelectedValue);
            int ID_Bai = Convert.ToInt16(ddlBai.SelectedValue);
            Response.Redirect("admin-quan-ly-cau-hoi-tu-luan-" + ID_khoi + "-" + ID_Mon + "-" + ID_Chuong + "-" + ID_Bai);
        }
        else
            alert.alert_Error(Page, "Vui lòng đủ dữ liệu", " ");
    }
    protected void btnCapNhatChuDe_Click(object sender, EventArgs e)
    {
        if (ddlKhoi.SelectedValue != "")
        {
            if (ddlMon.SelectedValue != "")
            {
                if (ddlChuDe.SelectedValue != "")
                {
                    Session["chude"] = Convert.ToInt32(ddlChuDe.SelectedValue);
                    var getChuong = (from c in db.tbTracNghiem_Chapters where c.chapter_id == Convert.ToInt32(ddlChuDe.SelectedValue) select c).Single();
                    txtTenChuDe.Text = getChuong.chapter_name;
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "popupControl.Show();", true);
                }
                else
                    alert.alert_Error(Page, "Vui lòng chọn chương", " ");
            }
            else
                alert.alert_Error(Page, "Vui lòng chọn môn", " ");
        }
        else
            alert.alert_Error(Page, "Vui lòng chọn khối", " ");
    }

    protected void btnCapNhatBai_Click(object sender, EventArgs e)
    {
        if (ddlKhoi.SelectedValue != "")
        {
            if (ddlMon.SelectedValue != "")
            {
                if (ddlChuDe.SelectedValue != "")
                {
                    if (ddlBai.SelectedValue != "")
                    {
                        Session["bai"] = Convert.ToInt32(ddlBai.SelectedValue);
                        var getBai = (from ls in db.tbTracNghiem_Lessons where ls.lesson_id == Convert.ToInt32(ddlBai.SelectedValue) select ls).Single();
                        txtTenBai.Text = getBai.lesson_name;
                        //txtKhoiID.Value = getBai.lesson_chude;
                        //txtKhoiName.Value = getBai.lesson_chude_name;
                        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "popupThemBai.Show()", true);
                    }
                    else
                        alert.alert_Error(Page, "Vui lòng chọn bài", " ");
                }
                else
                    alert.alert_Error(Page, "Vui lòng chọn chủ đề", " ");
            }
            else
                alert.alert_Error(Page, "Vui lòng chọn môn", " ");
        }
        else
            alert.alert_Error(Page, "Vui lòng chọn khối", " ");
    }

    protected void btnXemTruocCauHoi_Click(object sender, EventArgs e)
    {
        if (ddlBai.SelectedValue != "")
        {
            var getDataDetails = from q in db.tbTracNghiem_Questions
                                 where q.lesson_id == Convert.ToInt32(ddlBai.SelectedValue)
                                 && q.question_type == "Trắc nghiệm" && q.hidden == false
                                 select new
                                 {
                                     q.question_id,
                                     noidungcauhoi = q.question_content.Contains("style=") ? "<div class='content_image'>" + q.question_content + "</div>" : q.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("mp3") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content
                                 };
            rpCauHoi.DataSource = getDataDetails;
            rpCauHoi.DataBind();
        }
        else
        {
            alert.alert_Warning(Page, "Vui lòng chọn đủ dữ liệu", "");
        }
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Insert", "HiddenLoadingIcon();", true);
    }
    protected void rpCauHoi_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from t in db.tbTracNghiem_Answers
                               where t.question_id == question_id && t.answer_content != null
                               select t;
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
    public class Dapan
    {
        public string answer_content { get; set; }
        public string name_label { get; set; }
    }
    protected void btnThemCauHoiTracNghiem2_Click(object sender, EventArgs e)
    {
        if (ddlKhoi.SelectedValue != "" || ddlMon.SelectedValue != "" || ddlChuDe.SelectedValue != "" || ddlBai.SelectedValue != "")
        {
            int ID_khoi = Convert.ToInt32(ddlKhoi.SelectedValue);
            int ID_Mon = Convert.ToInt32(ddlMon.SelectedValue);
            int ID_Chuong = Convert.ToInt32(ddlChuDe.SelectedValue);
            int ID_Bai = Convert.ToInt32(ddlBai.SelectedValue);
            Response.Redirect("admin-quan-ly-trac-nghiem-phan-hai-" + ID_khoi + "-" + ID_Mon + "-" + ID_Chuong + "-" + ID_Bai);
        }
        else
            alert.alert_Error(Page, "Vui lòng đủ dữ liệu", " ");
    }

    protected void btnThemCauHoiTracNghiem3_Click(object sender, EventArgs e)
    {
        if (ddlKhoi.SelectedValue != "" || ddlMon.SelectedValue != "" || ddlChuDe.SelectedValue != "" || ddlBai.SelectedValue != "")
        {
            int ID_khoi = Convert.ToInt32(ddlKhoi.SelectedValue);
            int ID_Mon = Convert.ToInt32(ddlMon.SelectedValue);
            int ID_Chuong = Convert.ToInt32(ddlChuDe.SelectedValue);
            int ID_Bai = Convert.ToInt32(ddlBai.SelectedValue);
            Response.Redirect("admin-quan-ly-trac-nghiem-phan-ba-" + ID_khoi + "-" + ID_Mon + "-" + ID_Chuong + "-" + ID_Bai);
        }
        else
            alert.alert_Error(Page, "Vui lòng đủ dữ liệu", " ");
    }
}