using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_web_tracnghiem_web_KetQuaLuyenTap : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int STT = 1;
    public int STTs = 1;
    public string date = "dfghj";
    protected void Page_Load(object sender, EventArgs e)
    {

        var getData = from bd in db.tbTracNghiem_ResultTests
                      join hs in db.tbHocSinhs on bd.hocsinh_code equals hs.hocsinh_code
                      join t in db.tbTracNghiem_Tests on bd.test_id equals t.test_id
                      join blt in db.tbTracNghiem_BaiLuyenTaps on t.luyentap_id equals blt.luyentap_id
                      join k in db.tbKhois on t.khoi_id equals k.khoi_id
                      join mh in db.tbTKB_Mons on t.monhoc_id equals mh.mon_id
                      where bd.hocsinh_code == Request.Cookies["HocSinh"].Value
                      && bd.result_type == "bai luyen tap"
                      orderby bd.resulttest_datetime descending
                      select new
                      {
                          bd.hocsinh_code,
                          hs.hocsinh_name,
                          bd.resulttest_result,
                          bd.resulttest_datetime,
                          bd.resulttest_id,
                          blt.luyentap_name,
                          k.khoi_name,
                          mh.mon_name,
                      };
        rpBangDiem.DataSource = getData;
        rpBangDiem.DataBind();
        rpPopupChiTiet.DataSource = getData;
        rpPopupChiTiet.DataBind();

    }


    protected void rpPopupChiTiet_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //STTs = 1;
        Repeater rpBangDiemDetails = e.Item.FindControl("rpBangDiemDetails") as Repeater;
        int resulttest_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "resulttest_id").ToString());

        //get trac nghiem
        var getDetail = (from ctkq in db.tbTracNghiem_ResultChiTiets
                         join ch in db.tbTracNghiem_Questions on ctkq.question_id equals ch.question_id
                         where ctkq.resulttest_id == resulttest_id
                         select new
                         {
                             result_id = ctkq.resulttest_id,
                             noidungcauhoi = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains(".jpg") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains(".png") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains(".mp3") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                             content_dapandung = (from ans in db.tbTracNghiem_Answers
                                                  where ans.answer_id == Convert.ToInt32(ctkq.answer_true_id)
                                                  select ans.answer_content).SingleOrDefault(),
                             content_dapanchon = (from ans in db.tbTracNghiem_Answers
                                                  where Convert.ToString(ans.answer_id) == ctkq.answer_checked_id
                                                  select ans.answer_content).SingleOrDefault(),
                             style = ctkq.answer_true == "True" ? "correct_question" : "",
                         });
        rpBangDiemDetails.DataSource = getDetail;
        rpBangDiemDetails.DataBind();
    }
}