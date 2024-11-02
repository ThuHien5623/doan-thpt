using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_ThongKeGiaoVienNhapTracNghiem : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    int currentMonth;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {
            //lấy các tháng từ đầu năm đến tháng hiện tại
            currentMonth = DateTime.Now.Month   ;
            //List<int> months = new List<int> { currentMonth };
            List<int> months = Enumerable.Repeat(1, currentMonth).ToList();
            //rpThang.DataSource = months;
            //rpThang.DataBind();

            var getTracNghiem = (from tn in db.tbTracNghiem_Questions
                                 join u in db.admin_Users on tn.username_id equals u.username_id
                                 where u.username_active == true && u.groupuser_id == 3 && Convert.ToDateTime(tn.question_createdate).Year == DateTime.Now.Year
                                 group u by tn.username_id into k
                                 select new
                                 {

                                     username_id = k.Key,
                                     username_fullname = (from gv in db.admin_Users where gv.username_id == Convert.ToInt32(k.Key) select gv.username_fullname).First(),
                                     count = k.Count(),
                                     countdaduyet = (from qs in db.tbTracNghiem_Questions
                                                     where qs.username_id == Convert.ToInt32(k.Key) && qs.hidden == false && qs.question_active == true
                                                     select qs).Count(),
                                     myclass = k.Count() > currentMonth*100 ? "" : "row-yellow",
                                     tinhtrang = k.Count() >= 500 ? "<span style='color:#28a745'> Hoàn thành </span>" : "<span style='color:#ffc107'> Chưa hoàn thành </span>",
                                 }).OrderByDescending(x => x.count);

            rpTracNghiem.DataSource = getTracNghiem;
            rpTracNghiem.DataBind();
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
        public string style { get; set; }
    }

    protected void rpTracNghiem_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpThang = e.Item.FindControl("rpThang") as Repeater;
        int username_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "username_id").ToString());
        List<Thang> dapan = new List<Thang>();
        for (int i = 1; i <= currentMonth; i++)
        {
            var getThang = (from tn in db.tbTracNghiem_Questions
                            where tn.username_id == username_id && Convert.ToDateTime(tn.question_createdate).Month == i && Convert.ToDateTime(tn.question_createdate).Year == DateTime.Now.Year
                            select tn).Count();
            dapan.Add(new Thang
            {
                soluong = getThang + "",
                //style = DateTime.Now.Month >= i && getThang < 100 ? "background:yellow" : "",
            });

        }
        //rpThang.DataSource = dapan;
        //rpThang.DataBind();
    }
}