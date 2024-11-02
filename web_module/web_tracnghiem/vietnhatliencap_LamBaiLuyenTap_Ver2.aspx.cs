using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_web_tracnghiem_vietnhatliencap_LamBaiLuyenTap_Ver2 : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int tongSoCau = 0;
    Random rnd = new Random();
    cls_Alert alert = new cls_Alert();
    private int hocsinh_id, test_id;
    protected override void Render(HtmlTextWriter writer)
    {
        //html minifier & JS at bottom
        // not tested
        if (this.Request.Headers["X-MicrosoftAjax"] != "Delta=true")
        {
            System.Text.RegularExpressions.Regex reg = new System.Text.RegularExpressions.Regex(@"<script[^>]*>[\w|\t|\r|\W]*?</script>");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            System.IO.StringWriter sw = new System.IO.StringWriter(sb);
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            base.Render(hw);
            string html = sb.ToString();
            System.Text.RegularExpressions.MatchCollection mymatch = reg.Matches(html);
            html = reg.Replace(html, string.Empty);
            reg = new System.Text.RegularExpressions.Regex(@"(?<=[^])\t{2,}|(?<=[>])\s{2,}(?=[<])|(?<=[>])\s{2,11}(?=[<])|(?=[\n])\s{2,}|(?=[\r])\s{2,}");
            html = reg.Replace(html, string.Empty);
            reg = new System.Text.RegularExpressions.Regex(@"</body>");
            string str = string.Empty;
            foreach (System.Text.RegularExpressions.Match match in mymatch)
            {
                str += match.ToString();
            }
            html = reg.Replace(html, str + "</body>");
            writer.Write(html);
        }
        else
            base.Render(writer);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["PhuHuynhVietNhat"] != null)
        {
            string[] arrListStr = Request.Cookies["PhuHuynhVietNhat"].Value.Split(',');

            if (arrListStr[0] == "hocsinh")// nếu là học sinh đăng nhập
            {
                var checkHS = (from hs in db.tbHocSinhs
                               where hs.hocsinh_taikhoan == arrListStr[1]
                               select hs).Single();
                hocsinh_id = checkHS.hocsinh_id;
            }
            test_id = Convert.ToInt32(RouteData.Values["id_test"]);
            if (!IsPostBack)
            {
                var getBaiLuyenTap = (from test in db.tbTracNghiem_Tests
                                      join blt in db.tbTracNghiem_BaiLuyenTaps on test.luyentap_id equals blt.luyentap_id
                                      where test.test_id == test_id
                                      select new
                                      {
                                          test.test_thoigianlambai,
                                          blt.luyentap_name,
                                          blt.luyentap_danhsachbai,
                                          blt.luyentap_tilecauhoi,
                                          test.test_soluongcauhoi,

                                      }).First();
                txtThoiGian.Value = getBaiLuyenTap.test_thoigianlambai + "";
                txtName.InnerHtml = getBaiLuyenTap.luyentap_name;

                string[] arrDanhSachBai = getBaiLuyenTap.luyentap_danhsachbai.Split(',');
                string[] arrTiLeCauHoi = getBaiLuyenTap.luyentap_tilecauhoi.Split(';');
                string chuoiCauHoi = "";
                int index = 0, tongCauDaLay = 0;
                int tongCau = Convert.ToInt32(getBaiLuyenTap.test_soluongcauhoi);
                List<Question> selectedQuestions = new List<Question>();
                foreach (string item in arrDanhSachBai)
                {
                    var getDuLieuFR = (from gdtCH in db.tbTracNghiem_Questions
                                       join c in db.tbTracNghiem_Lessons on gdtCH.lesson_id equals c.lesson_id
                                       join ch in db.tbTracNghiem_Chapters on gdtCH.chapter_id equals ch.chapter_id
                                       where c.lesson_id == Convert.ToInt32(item)
                                       && gdtCH.hidden == false && gdtCH.question_type == "Trắc nghiệm"
                                       select new
                                       {
                                           gdtCH.question_id,
                                           gdtCH.question_dangcauhoi,
                                           gdtCH.question_giaithich,
                                           gdtCH.question_content,
                                           gdtCH.lesson_id,
                                       }).ToList();
                    int seed = rnd.Next();
                    if (tongCau > 0)
                    {
                        int socaudalay = 0;
                        if (index == arrTiLeCauHoi.Length - 1)
                        {
                            int soCauTheoTiLe = tongCau - tongCauDaLay;
                            while (socaudalay < soCauTheoTiLe)
                            {
                                if (getDuLieuFR.Count() > 0)
                                {
                                    Random random = new Random();
                                    int _rnd = random.Next();
                                    var checkDuLieuNhanBiet = getDuLieuFR.OrderBy(x => (~(x.question_id & _rnd)) & (x.question_id | _rnd)).FirstOrDefault();
                                    selectedQuestions.Add(new Question()
                                    {
                                        question_id = checkDuLieuNhanBiet.question_id,
                                        question_dangcauhoi = checkDuLieuNhanBiet.question_dangcauhoi + "",
                                        question_content = XoaHTMLVaStyle(checkDuLieuNhanBiet.question_content),
                                        question_giaithich = checkDuLieuNhanBiet.question_giaithich,
                                        lesson_id = checkDuLieuNhanBiet.lesson_id + "",
                                    });
                                    getDuLieuFR.Remove(checkDuLieuNhanBiet);
                                    socaudalay++;
                                    Thread.Sleep(500);
                                }
                                else
                                {
                                    break;
                                }
                            }
                        }
                        else
                        {
                            double tile = (double)(Convert.ToDouble(arrTiLeCauHoi[index]) / 100);
                            int soCauTheoTiLe = (int)(tongCau * tile);

                            while (socaudalay < soCauTheoTiLe)
                            {
                                if (getDuLieuFR.Count() > 0)
                                {
                                    Random random = new Random();
                                    int _rnd = random.Next();
                                    var checkDuLieuNhanBiet = getDuLieuFR.OrderBy(x => (~(x.question_id & _rnd)) & (x.question_id | _rnd)).First();
                                    selectedQuestions.Add(new Question()
                                    {
                                        question_id = checkDuLieuNhanBiet.question_id,
                                        question_dangcauhoi = checkDuLieuNhanBiet.question_dangcauhoi + "",
                                        question_content = XoaHTMLVaStyle(checkDuLieuNhanBiet.question_content),
                                        question_giaithich = checkDuLieuNhanBiet.question_giaithich,
                                        lesson_id = checkDuLieuNhanBiet.lesson_id + "",
                                    });
                                    getDuLieuFR.Remove(checkDuLieuNhanBiet);
                                    socaudalay++;
                                    Thread.Sleep(500);
                                }
                                else
                                {
                                    break;
                                }
                            }
                            tongCauDaLay += soCauTheoTiLe;
                        }
                    }
                    index++;
                }
                //nếu lấy theo tỉ lệ nhập mà vẫn chưa đủ số lượng câu hỏi thì lấy ngẫu nhiên các câu hỏi khác sao cho đủ
                while (selectedQuestions.Count < tongCau)
                {
                    //lấy ds các câu hỏi còn lại của các bài được chọn
                    //List<Question> listTongCauHoi = (from gdtCH in db.tbTracNghiem_Questions
                    //                                 join c in db.tbTracNghiem_Lessons on gdtCH.lesson_id equals c.lesson_id
                    //                                 join ch in db.tbTracNghiem_Chapters on gdtCH.chapter_id equals ch.chapter_id
                    //                                 where arrDanhSachBai.Contains(c.lesson_id + "")
                    //                                      && gdtCH.hidden == false && gdtCH.question_type == "Trắc nghiệm"
                    //                                 select new Question
                    //                                 {
                    //                                     question_id = gdtCH.question_id,
                    //                                     question_dangcauhoi = gdtCH.question_dangcauhoi,
                    //                                     question_content = gdtCH.question_content,
                    //                                     question_giaithich = gdtCH.question_giaithich,
                    //                                     lesson_id = gdtCH.lesson_id + "",
                    //                                 }).ToList();
                    var listConLai = (from gdtCH in db.tbTracNghiem_Questions
                                      join c in db.tbTracNghiem_Lessons on gdtCH.lesson_id equals c.lesson_id
                                      join ch in db.tbTracNghiem_Chapters on gdtCH.chapter_id equals ch.chapter_id
                                      where arrDanhSachBai.Contains(c.lesson_id + "") && !selectedQuestions.Select(i => i.question_id).ToList().Contains(gdtCH.question_id)
                                           && gdtCH.hidden == false && gdtCH.question_type == "Trắc nghiệm"
                                      select new
                                      {
                                          gdtCH.question_id,
                                          gdtCH.question_dangcauhoi,
                                          gdtCH.question_giaithich,
                                          gdtCH.question_content,
                                          gdtCH.lesson_id,
                                      }).ToList();

                    //var danhSachCauHoiConLai = listTongCauHoi.Except(selectedQuestions, new QuestionComparer()).ToList();
                    //trường hợp vẫn còn câu hỏi thì lấy, không thì để mặc
                    if (listConLai.Count() > 0)
                    {
                        Random random = new Random();
                        int _rnd = random.Next();
                        var checkDuLieuNhanBiet = listConLai.OrderBy(x => (~(Convert.ToInt32(x.question_id) & _rnd)) & (Convert.ToInt32(x.question_id) | _rnd)).First();
                        selectedQuestions.Add(new Question()
                        {
                            question_id = checkDuLieuNhanBiet.question_id,
                            question_dangcauhoi = checkDuLieuNhanBiet.question_dangcauhoi + "",
                            question_content = XoaHTMLVaStyle(checkDuLieuNhanBiet.question_content),
                            question_giaithich = checkDuLieuNhanBiet.question_giaithich,
                            lesson_id = checkDuLieuNhanBiet.lesson_id + "",
                        });
                        listConLai.Remove(checkDuLieuNhanBiet);
                        Thread.Sleep(500);
                    }
                    else
                    {
                        break;
                    }
                }


                chuoiCauHoi = string.Join(",", selectedQuestions.Select(x => x.question_id));
                int r = rnd.Next();
                //get ds câu hỏi trắc nghiệm
                var getDataDetails = from ch in selectedQuestions
                                     join q in db.tbTracNghiem_Questions on ch.question_id equals q.question_id
                                     select new
                                     {
                                         ch.question_id,
                                         //noidungcauhoi = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                                         noidungcauhoi = q.question_content.Contains("style=") ? "<div class='content_image'>" + q.question_content + "</div>" : q.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content,
                                         question_giaithich = ch.question_giaithich.Contains("style=") ? "<div class='content_image'>" + ch.question_giaithich + "</div>" : ch.question_giaithich.Contains("/uploadimages/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_giaithich + "'>" : ch.question_giaithich,
                                         style = ch.question_giaithich == "" ? "hidden-item" : "",
                                     };

                var result = getDataDetails.ToList().OrderBy(x => (~(x.question_id & r)) & (x.question_id | r));
                tongSoCau = getDataDetails.Count();
                rpCauHoi.DataSource = result;
                rpCauHoi.DataBind();
            }
            var getKhoi = (from test in db.tbTracNghiem_Tests
                           join blt in db.tbTracNghiem_BaiLuyenTaps on test.luyentap_id equals blt.luyentap_id
                           where test.test_id == test_id
                           select test).Single();
            btnExit.HRef = "danh-sach-bai-luyen-tap-" + getKhoi.khoi_id + "/" + getKhoi.monhoc_id;
        }
        else
        {
            string test_link = HttpContext.Current.Request.Url.PathAndQuery.Remove(0, 1);
            Session["linktest"] = test_link;
            Response.Redirect("/login-account");
        }
    }
    public class Question
    {
        public int question_id { get; set; }
        public string question_dangcauhoi { get; set; }
        public string question_content { get; set; }
        public string question_giaithich { get; set; }
        public string lesson_id { get; set; }
    }
    // Hàm để xóa các thẻ HTML và định dạng style từ một chuỗi HTML
    public string XoaHTMLVaStyle(string html)
    {
        // Tạo một đối tượng HtmlDocument
        HtmlDocument doc = new HtmlDocument();
        doc.LoadHtml(html);

        // Sử dụng XPath để lấy nội dung text của các thẻ
        var textNodes = doc.DocumentNode.SelectNodes("//text()");

        // Tạo một StringBuilder để xây dựng nội dung text mới
        StringBuilder newText = new StringBuilder();

        foreach (var node in textNodes)
        {
            newText.Append(node.InnerText);
        }

        // Trả về nội dung text đã xóa các thẻ HTML và định dạng style
        return newText.ToString();
    }
    protected void rpCauHoi_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        int seed = rnd.Next();
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from t in db.tbTracNghiem_Answers
                               where t.question_id == question_id && t.answer_content != null
                               select new
                               {
                                   t.answer_id,
                                   t.answer_content,
                                   t.answer_true,
                                   t.question_id
                               };
        rpCauTraLoi.DataSource = getDataCauTraLoi.OrderBy(x => (~(x.answer_id & seed)) & (x.answer_id | seed));
        rpCauTraLoi.DataBind();
    }

    protected void btnLuuKetQua_ServerClick(object sender, EventArgs e)
    {
        //gán thời gian làm bài từ client về db
        //string time;
        //TimeSpan s = TimeSpan.FromSeconds(Convert.ToDouble(txtFinish.Value));
        //time = s.ToString();

        //int _idKhoi = Convert.ToInt32(RouteData.Values["id_khoi"]);
        var checkNamHoc = (from nh in db.tbHoctap_NamHocs orderby nh.namhoc_id descending select nh).First();
        var checkHocSinh = (from hs in db.tbHocSinhs
                            join hstl in db.tbHocSinhTrongLops on hs.hocsinh_id equals hstl.hocsinh_id
                            join l in db.tbLops on hstl.lop_id equals l.lop_id
                            where hs.hocsinh_id == hocsinh_id && hstl.namhoc_id == checkNamHoc.namhoc_id
                            orderby hstl.hstl_id descending
                            select new
                            {
                                hs.hocsinh_mahocphi,
                                hs.hocsinh_id,
                                l.lop_id,
                                hstl.hstl_id,
                            }).FirstOrDefault();

        tbTracNghiem_ResultTest insert = new tbTracNghiem_ResultTest();
        insert.resulttest_result = txtSoCauDung.Value;
        insert.hocsinh_code = checkHocSinh.hocsinh_mahocphi;
        insert.resulttest_datetime = DateTime.Now;
        insert.test_id = Convert.ToInt32(RouteData.Values["id_test"]);
        insert.result_thoigianlambai = txtFinish.Value;
        insert.lop_id = checkHocSinh.lop_id;
        insert.hstl_id = checkHocSinh.hstl_id;
        insert.result_type = "bai luyen tap";
        insert.namhoc_id = checkNamHoc.namhoc_id;
        db.tbTracNghiem_ResultTests.InsertOnSubmit(insert);
        db.SubmitChanges();

        //khai báo biến chứa ds ID câu tl được checked
        //string[] arrAnswerChecked = txtDSCauTraLoi.Value.Split(',');
        ////khai báo biến chứa ds ID câu hỏi
        //string[] arrQuestionID = txtDSCauHoi.Value.Split(',');
        //string[] arrResult = txtResultChecked.Value.Split(',');
        //for (int index = 0; index < arrQuestionID.Length; index++)
        //{
        //    tbTracNghiem_ResultChiTiet insertDetail = new tbTracNghiem_ResultChiTiet();
        //    insertDetail.resulttest_id = insert.resulttest_id;
        //    insertDetail.question_id = Convert.ToInt32(arrQuestionID[index]);
        //    insertDetail.answer_true_id = (from t in db.tbTracNghiem_Answers
        //                                   where t.question_id == Convert.ToInt32(arrQuestionID[index]) && t.answer_true == true
        //                                   select t.answer_id).FirstOrDefault() + "";
        //    if (arrAnswerChecked[index] == "")
        //        insertDetail.answer_checked_id = "0";
        //    else
        //        insertDetail.answer_checked_id = arrAnswerChecked[index];
        //    if (arrResult[index] == "")
        //        insertDetail.answer_true = "False";
        //    else
        //        insertDetail.answer_true = arrResult[index];
        //    db.tbTracNghiem_ResultChiTiets.InsertOnSubmit(insertDetail);
        //    db.SubmitChanges();
        //}
    }


    public class QuestionComparer : IEqualityComparer<Question>
    {
        public bool Equals(Question x, Question y)
        {
            if (x == null && y == null)
                return true;
            if (x == null || y == null)
                return false;
            return x.question_id == y.question_id;
        }

        public int GetHashCode(Question obj)
        {
            return obj.question_id.GetHashCode();
        }
    }
}
