using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_ThongKeTracNghiem : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        var getTracNghiem = (from tn in db.tbTracNghiem_Questions
                             join u in db.admin_Users on tn.username_id equals u.username_id
                             where u.username_active == true && u.groupuser_id == 3 && Convert.ToDateTime(tn.question_createdate).Year == DateTime.Now.Year
                             group u by tn.username_id into k
                             select new
                             {

                                 username_id = k.Key,
                                 username_fullname = (from gv in db.admin_Users where gv.username_id == Convert.ToInt32(k.Key) select gv.username_fullname).First(),
                                 count = k.Count(),
                                 myclass = k.Count() > 150 ? "" : "row-yellow",
                             }).OrderByDescending(x => x.count);

        rpTracNghiem.DataSource = getTracNghiem;
        rpTracNghiem.DataBind();
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
                            where tn.username_id == username_id && Convert.ToDateTime(tn.question_createdate).Month == i && Convert.ToDateTime(tn.question_createdate).Year==DateTime.Now.Year
                            select tn).Count();
            dapan.Add(new Thang
            {
                soluong = getThang + ""
            });

        }
        rpThang.DataSource = dapan;
        rpThang.DataBind();
    }

    protected void btnChiTiet_ServerClick(object sender, EventArgs e)
    {
        var getCauHoi = from ch in db.tbTracNghiem_Questions
                        join ls in db.tbTracNghiem_Lessons on ch.lesson_id equals ls.lesson_id
                        join c in db.tbTracNghiem_Chapters on ls.chapter_id equals c.chapter_id
                        join mh in db.tbTKB_Mons on c.monhoc_id equals mh.mon_id
                        join k in db.tbKhois on c.khoi_id equals k.khoi_id
                        where ch.username_id == Convert.ToInt32(txtUserID.Value) && ch.hidden == false && ch.question_type== "Trắc nghiệm"
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
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setActive('"+txtUserID.Value+"')", true);
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
                                   t.question_id
                               };
        rpDapAn.DataSource = getDataCauTraLoi;
        rpDapAn.DataBind();
    }
}