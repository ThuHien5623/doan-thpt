using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Services;
using System.Web.Services;

public partial class web_module_web_tracnghiem_vietnhatliencap_LamBaiLuyenTap_Ver2 : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int khoi_id;
    public int tongSoCau = 0, stt = 1;
    Random rnd = new Random();
    cls_Alert alert = new cls_Alert();
    List<Question> selectQuestion = new List<Question>();
    private int hocsinh_id, test_id;
    cls_Md5Js md5 = new cls_Md5Js();
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
        var checkHocSinh = (from hs in db.tbAccounts where hs.account_sodienthoai == Request.Cookies["taikhoan"].Value select hs);
        //if (Request.Cookies["taikhoan"] != null)
        //{
        //    string[] arrListStr = Request.Cookies["PhuHuynhVietNhat"].Value.Split(',');

        //    if (arrListStr[0] == "hocsinh")// nếu là học sinh đăng nhập
        //    {
        //        var checkHS = (from hs in db.tbHocSinhs
        //                       where hs.hocsinh_taikhoan == arrListStr[1]
        //                       select hs).Single();
        //        hocsinh_id = checkHS.hocsinh_id;
        //    }
        test_id = Convert.ToInt32(RouteData.Values["id_test"]);
        if (!IsPostBack)
        {
            var getData = from lt in db.tbTracNghiem_BaiLuyenTaps
                          join t in db.tbTracNghiem_Tests on lt.luyentap_id equals t.luyentap_id
                          where t.test_id == test_id
                          select new
                          {
                              lt.luyentap_danhsachbai,
                              lt.luyentap_tilecauhoi,
                              t.test_thoigianlambai,
                              t.test_soluongcauhoi,
                          };
            txtThoiGian.Value = getData.FirstOrDefault().test_thoigianlambai; // thời gian làm bài 
            string[] arrIdAnswer = getData.FirstOrDefault().luyentap_danhsachbai.Split(',');
            string[] arrRatio = getData.FirstOrDefault().luyentap_tilecauhoi.Split(';'); //40/40/30
            tongSoCau = Convert.ToInt32(getData.FirstOrDefault().test_soluongcauhoi);
            txtTongCauHoi.Value = tongSoCau + "";
            for (var i = 0; i < arrRatio.Length; i++)
            {
                arrRatio[i] = Convert.ToString(Convert.ToInt32(arrRatio[i]) * tongSoCau / 100); //tổng số câu của từng bài => 10 câu hỏi của 1 bài
            }
            for (var j = 0; j < arrIdAnswer.Length; j++)//35:37
            {
                List<int> arrIdQuestion = new List<int>();
                var getIdQuestion = (from qs in db.tbTracNghiem_Questions
                                     where qs.lesson_id == Convert.ToInt32(arrIdAnswer[j]) //35:37 : 50
                                     & qs.hidden == false
                                     select new
                                     {
                                         qs.question_id,
                                     });//.Take(arrIdAnswer.Length == 1 ? 30 : 20);

                foreach (var item in getIdQuestion)
                {
                    arrIdQuestion.Add(item.question_id);
                }

                List<int> distinctNumbers = GetRandomDistinctNumbers(arrIdQuestion, Convert.ToInt32(arrRatio[j]));

                for (int i = 0; i < distinctNumbers.Count(); i++)
                {
                    var question_content = (from qs in db.tbTracNghiem_Questions
                                            where qs.question_id == distinctNumbers[i]
                                            select qs).FirstOrDefault().question_content;
                    selectQuestion.Add(new Question
                    {
                        question_id = distinctNumbers[i],
                        question_content = question_content.Contains("style=") ? "<div class='content_image'>" + question_content + "</div>" : question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + question_content + "'>" : question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + question_content + "'> </audio>" : question_content,
                        answer_true = md5.Md5((from qs in db.tbTracNghiem_Questions
                                               join aw in db.tbTracNghiem_Answers on qs.question_id equals aw.question_id
                                               where qs.question_id == distinctNumbers[i]
                                               && aw.answer_true == true
                                               select aw).FirstOrDefault().answer_id + ""),
                    });
                }
            }
            int r = rnd.Next();
            var result = selectQuestion.OrderBy(x => (~(x.question_id & r)) & (x.question_id | r));
            rpCauHoi.DataSource = result;
            rpCauHoi.DataBind();
        }
    }
    protected void rpCauHoiDetals_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Random rnd = new Random();
        int seed = rnd.Next();
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from t in db.tbTracNghiem_Answers
                               where t.question_id == question_id && t.answer_content != ""
                               select new
                               {
                                   t.answer_id,
                                   t.answer_content,
                                   t.answer_true,
                                   t.question_id
                               };
        int[] arrAnswer = getDataCauTraLoi.Select(x => x.answer_id).ToArray();
        StringArrayShuffler shuffler = new StringArrayShuffler();
        int[] shuffledArray = shuffler.ShuffleArray(arrAnswer);
        List<Dapan> dapan = new List<Dapan>();
        for (int i = 0; i < shuffledArray.Length; i++)
        {
            var getDapAn = (from da in db.tbTracNghiem_Answers
                            where da.answer_id == shuffledArray[i]
                            select new
                            {
                                da.answer_id,
                                da.answer_content,
                                da.answer_true,
                            }).First();
            dapan.Add(new Dapan()
            {
                answer_id = getDapAn.answer_id,
                answer_content = getDapAn.answer_content,
                answer_true = md5.Md5(Convert.ToString(getDataCauTraLoi.Where(x => x.answer_true == true).Select(x => x.answer_id).FirstOrDefault())),
                question_id = question_id,
                vitri = stt,
            });
        }
        stt++;
        rpCauTraLoi.DataSource = dapan;
        rpCauTraLoi.DataBind();
    }
    public class Dapan
    {
        public int answer_id { get; set; }
        public string answer_content { get; set; }
        public string answer_true { get; set; }
        public int question_id { get; set; }
        public int vitri { get; set; }
    }
    protected void btnLuuKetQua_ServerClick(object sender, EventArgs e)
    {
        tbTracNghiem_ResultTest insert = new tbTracNghiem_ResultTest();
        insert.resulttest_result = txtSoCauDung.Value;
        //insert.hocsinh_code = "1";
        insert.resulttest_datetime = DateTime.Now;
        insert.test_id = Convert.ToInt32(RouteData.Values["id_test"]);
        insert.result_thoigianlambai = txtFinish.Value;
        insert.lop_id = 1;
        if (Request.Cookies["taikhoan"] != null)
        {
            var checkTaiKhoan = (from tk in db.tbDangKies
                                 where tk.dangky_taikhoan == Request.Cookies["taikhoan"].Value
                                 select tk).FirstOrDefault();
            insert.hstl_id = checkTaiKhoan.dangky_id;
        }
        insert.result_type = "bai luyen tap";
        //insert.namhoc_id = 1;
        db.tbTracNghiem_ResultTests.InsertOnSubmit(insert);
        db.SubmitChanges();

        //khai báo biến chứa ds ID câu tl được checked
        string[] arrAnswerChecked = txtDSCauTraLoi.Value.Split(',');
        //khai báo biến chứa ds ID câu hỏi
        string[] arrQuestionID = txtDSCauHoi.Value.Split(',');
        string[] arrResult = txtResultChecked.Value.Split(',');
    }

    public List<int> GetRandomDistinctNumbers(List<int> inputList, int count)
    {
        Random random = new Random();
        List<int> distinctList = inputList.Distinct().ToList();
        List<int> result = new List<int>();
        if (inputList.Count() > count)
        {
            while (result.Count < count)
            {
                int randomIndex = random.Next(0, distinctList.Count);
                int number = distinctList[randomIndex];
                result.Add(number);
                distinctList.RemoveAt(randomIndex);
            }
        }
        else
        {
            result = distinctList;
        }
        return result;
    }
    class StringArrayShuffler
    {
        private Random random;

        public StringArrayShuffler()
        {
            random = new Random();
        }

        public int[] ShuffleArray(int[] inputArray)
        {
            int n = inputArray.Length;
            int[] shuffledArray = new int[n];

            // Sao chép các phần tử từ mảng gốc vào mảng đã random đảo
            Array.Copy(inputArray, shuffledArray, n);

            // Sử dụng thuật toán Fisher-Yates để random đảo các phần tử
            for (int i = n - 1; i > 0; i--)
            {
                int j = random.Next(0, i + 1);
                int temp = shuffledArray[i];
                shuffledArray[i] = shuffledArray[j];
                shuffledArray[j] = temp;
            }

            return shuffledArray;
        }
    }
    public class Question
    {
        public int question_id { get; set; }
        public string question_content { get; set; }
        public string question_answer_a { get; set; }
        public string question_answer_b { get; set; }
        public string question_answer_c { get; set; }
        public string question_answer_d { get; set; }
        public int answer_id_a { get; set; }
        public int answer_id_b { get; set; }
        public int answer_id_c { get; set; }
        public int answer_id_d { get; set; }
        public string answer_true { get; set; }
    }
    protected void btnExit_ServerClick(object sender, EventArgs e)
    {
        khoi_id = Convert.ToInt32(RouteData.Values["id_khoi"]);
        if (khoi_id > 5 && khoi_id < 10)
            Response.Redirect("/app-danh-muc-khoi-thcs-" + khoi_id);
        else if (khoi_id >= 10)
            Response.Redirect("/app-danh-muc-khoi-thpt-" + khoi_id);
    }
}
