using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_ThongKeDuyetCauHoiTracNghiem : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
        var getTracNghiem = (from u in db.admin_Users
                             where u.username_active == true && u.groupuser_id == 3 && u.username_capday.Contains("trung học")
                             select new
                             {
                                 u.username_id,
                                 u.username_fullname,
                                 countdanhap = (from qs in db.tbTracNghiem_Questions
                                                where qs.username_id == u.username_id && qs.hidden == false
                                                select qs).Count(),
                                 countdaduyet = (from qs in db.tbTracNghiem_Questions
                                                 where qs.username_id == u.username_id && qs.hidden == false && qs.question_active == true
                                                 select qs).Count(),
                                 countphanhoi = (from qs in db.tbTracNghiem_Questions
                                                 where qs.username_id == u.username_id && qs.hidden == false && qs.question_trangthaiduyet != null
                                                 select qs).Count(),
                             }).OrderByDescending(x => x.countdanhap).ThenByDescending(x => x.countdaduyet);

        rpDanhSach.DataSource = getTracNghiem;
        rpDanhSach.DataBind();
        var getcauHoiDaDuyet = (from u in db.admin_Users
                                where u.username_active == true && u.groupuser_id == 3 && u.username_capday.Contains("trung học")
                                select new
                                {
                                    u.username_id,
                                    u.username_fullname,
                                    countdaduyet = (from qs in db.tbTracNghiem_Questions
                                                    where qs.nguoiduyet_id == u.username_id && qs.hidden == false && qs.question_active == true
                                                    select qs).Count(),
                                    countphanhoi = (from qs in db.tbTracNghiem_Questions
                                                    where qs.nguoiduyet_id == u.username_id && qs.hidden == false && qs.question_trangthaiduyet != null
                                                    select qs).Count(),
                                }).OrderByDescending(x => x.countdaduyet);

        rpDanhSachDuyet.DataSource = getcauHoiDaDuyet;
        rpDanhSachDuyet.DataBind();
    }

    protected void btnChiTiet_ServerClick(object sender, EventArgs e)
    {
        //get những câu hỏi của giáo viên duyệt
        var getCauHoi = from ch in db.tbTracNghiem_Questions
                        join ls in db.tbTracNghiem_Lessons on ch.lesson_id equals ls.lesson_id
                        join c in db.tbTracNghiem_Chapters on ls.chapter_id equals c.chapter_id
                        join mh in db.tbTKB_Mons on c.monhoc_id equals mh.mon_id
                        join k in db.tbKhois on c.khoi_id equals k.khoi_id
                        where ch.nguoiduyet_id == Convert.ToInt32(txtUserID.Value) && ch.hidden == false && ch.question_type == "Trắc nghiệm"
                        orderby ls.lesson_id ascending, ch.question_id ascending
                        select new
                        {
                            ch.question_id,
                            k.khoi_name,
                            mh.mon_name,
                            ls.lesson_name,
                            ls.lesson_id,
                            noidungcauhoi = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("mp3") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                            nguoinhap = (from gv in db.admin_Users where gv.username_id == ch.username_id select gv.username_fullname).First(),
                        };
        rpDanhSachCauHoiDaDuyet.DataSource = getCauHoi;
        rpDanhSachCauHoiDaDuyet.DataBind();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setActive('" + txtUserID.Value + "')", true);
    }
}