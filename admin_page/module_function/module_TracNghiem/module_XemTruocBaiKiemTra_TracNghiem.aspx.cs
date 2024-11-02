using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_XemTruocBaiKiemTra_TracNghiem : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int tongSoCau = 0;
    Random rnd = new Random();
    cls_Alert alert = new cls_Alert();
    private int test_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        loadData();
    }
    private void loadData()
    {
        test_id = Convert.ToInt32(RouteData.Values["id"]);
        int seed = rnd.Next();
        //get tên bài, ds bài và tỉ lệ câu hỏi từng bài
        var getTracNghiem = from bkt in db.tbTracNghiem_Tests
                            join ch in db.tbTracNghiem_Questions on bkt.test_id equals ch.baikiemtra_id
                            where bkt.test_id == test_id && ch.question_group == "part1"
                            select new
                            {
                                ch.question_id,
                                noidungcauhoi = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content
                            };
        rpCauHoi.DataSource = getTracNghiem.OrderBy(x => (~(x.question_id & seed)) & (x.question_id | seed));
        rpCauHoi.DataBind();
    }
    
    public class Dapan
    {
        public string answer_content { get; set; }
        public string name_label { get; set; }
    }
    protected void rpCauHoi_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        int seed = rnd.Next();
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from ct in db.tbTracNghiem_Answers
                               where ct.question_id == question_id && ct.answer_content != null
                               select new
                               {
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
    protected void btnXoaCauHoi_ServerClick(object sender, EventArgs e)
    {
        var getCauHoi = (from ch in db.tbTracNghiem_Questions
                         where ch.question_id == Convert.ToInt32(txtCauHoiID.Value)
                         select ch).Single();
        var checkDapAn = (from da in db.tbTracNghiem_Answers
                          join ch in db.tbTracNghiem_Questions on da.question_id equals ch.question_id
                          where ch.question_id == Convert.ToInt32(txtCauHoiID.Value)
                          select da);
        db.tbTracNghiem_Answers.DeleteAllOnSubmit(checkDapAn);
        db.tbTracNghiem_Questions.DeleteOnSubmit(getCauHoi);
        db.SubmitChanges();
        alert.alert_Success(Page, "Xóa thành công", "");
        loadData();
    }
}