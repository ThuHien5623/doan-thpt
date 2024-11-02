using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_RanDomDe : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    protected void btnTaoDe_ServerClick(object sender, EventArgs e)
    {
        Random rnd = new Random();
        int seed = rnd.Next();
        var getCauHoi= (from qs in db.tbTracNghiem_Questions
                              where qs.lesson_id == 197
                              orderby qs.question_solanlap 
                              select new
                              {
                                  qs.question_id,
                                  qs.question_content,
                              }); //20*2.5
        var getCauHoiRanDom = getCauHoi.OrderBy(x => (~(x.question_id & seed)) & (x.question_id | seed)).Take(20);
        rpCauHoi.DataSource = getCauHoiRanDom;
        rpCauHoi.DataBind();
        foreach (var item in getCauHoiRanDom)
        {
            var count = (from qs in db.tbTracNghiem_Questions
                         where qs.question_id == item.question_id
                         select qs).FirstOrDefault().question_solanlap;
            if (count == null)
            {
                count = 1;
            }
            else
            {
                count++;
            }
            tbTracNghiem_Question up = db.tbTracNghiem_Questions.Where(x => x.question_id == item.question_id).FirstOrDefault();
            up.question_solanlap = count;
            db.SubmitChanges();
        }
    }
}