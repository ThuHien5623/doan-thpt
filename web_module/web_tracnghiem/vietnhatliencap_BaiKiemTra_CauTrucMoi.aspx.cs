using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_web_tracnghiem_vietnhatliencap_BaiKiemTra_CauTrucMoi : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int tongSoCau = 0;
    Random rnd = new Random();
    cls_Alert alert = new cls_Alert();
    private string hocsinh_code;
    private int hocsinh_id;
    public int stt = 1;
    private int test_id, tongThoiGianLamBai;
    private int result_id = 0;
    private static int maxCauTracNghiem = 0, maxDungSai = 0, maxTuLuan = 0;
    List<Question> selectQuestion = new List<Question>();
    cls_Md5Js md5 = new cls_Md5Js();
    protected override void Render(HtmlTextWriter writer)
    {
        //html minifier & JS at bottom
        // not testeds
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
        if (Request.Cookies["taikhoan"] != null)
        {
            var checkHocSinh = (from hs in db.tbAccounts where hs.account_sodienthoai == Request.Cookies["taikhoan"].Value select hs);
            if (checkHocSinh.Count() > 0)
            {
                // Kiểm tra học sinh hiện tại đã học lớp mấy
                var checkHocSinhTrongLop = from hstl in db.tbAccount_Childrens
                                           where hstl.account_id == checkHocSinh.First().account_id && hstl.children_active == true
                                           select hstl;
                hocsinh_id = checkHocSinhTrongLop.First().children_id;
                //hocsinh_code = checkHS.hocsinh_taikhoan;
                test_id = Convert.ToInt32(RouteData.Values["id"]);
                //get tên bài, ds bài và tỉ lệ câu hỏi từng bài
                var getBaiLuyenTap = (from blt in db.tbTracNghiem_BaiLuyenTaps
                                      join bkt in db.tbTracNghiem_Tests on blt.luyentap_id equals bkt.luyentap_id
                                      where bkt.test_id == test_id
                                      select new
                                      {
                                          blt.luyentap_name,
                                          bkt.monhoc_id,
                                          bkt.test_thoigianlambai,
                                          blt.luyentap_baitaptuluan,
                                      }).First();
                //txtThoiGian.Value = "120";
                txtThoiGian.Value = getBaiLuyenTap.test_thoigianlambai + "";
                txtName.InnerHtml = getBaiLuyenTap.luyentap_name;
                //tongSoCau = Convert.ToInt32(getBaiLuyenTap.test_socauhoi);
                tongThoiGianLamBai = Convert.ToInt32(getBaiLuyenTap.test_thoigianlambai);
                txtMon.Value = getBaiLuyenTap.monhoc_id + "";
                maxSoLuongCau(Convert.ToInt32(getBaiLuyenTap.monhoc_id));
                //txtTongCauHoi.Value = tongSoCau + "";
                //kiểm tra xem tình trạng làm bài của hs đã đạt hay chưa
                var chekLamBai = from rs in db.tbTracNghiem_ResultTests
                                 where rs.test_id == test_id && rs.hocsinh_code == hocsinh_code
                                 orderby rs.resulttest_id descending
                                 select rs;
                if (chekLamBai.Count() > 0)
                {
                    //txtTinhTrangLamBai.Value = chekLamBai.First().result_danhgia + "";
                }
                if (!IsPostBack)
                {
                    List<int> idQuestionDungSai = new List<int> { };
                    List<int> idQuestionTuLuan = new List<int> { };
                    List<int> arrIdQuestion = new List<int>();
                    List<int> arrIdQuestionDungSai = new List<int>();
                    List<int> arrIdQuestionTuLuan = new List<int>();
                    var getIdQuestion = (from qs in db.tbTracNghiem_Questions
                                         where qs.baikiemtra_id == test_id && qs.question_group == "part1"
                                         select new
                                         {
                                             qs.question_id,
                                         });
                    foreach (var item in getIdQuestion)
                    {
                        arrIdQuestion.Add(item.question_id);
                    }
                    //lấy câu hỏi đúng sai
                    var getIdQuestionDungSai = (from qs in db.tbTracNghiem_Questions
                                                where qs.baikiemtra_id == test_id && qs.question_group == "part2"
                                                select new
                                                {
                                                    qs.question_id,
                                                });
                    foreach (var item in getIdQuestionDungSai)
                    {
                        arrIdQuestionDungSai.Add(item.question_id);
                    }
                    //lấy câu hỏi tự luận
                    var getIdQuestionTuLuan = (from qs in db.tbTracNghiem_Questions
                                               where qs.baikiemtra_id == test_id && qs.question_group == "part3"
                                               select new
                                               {
                                                   qs.question_id,
                                               });
                    foreach (var item in getIdQuestionTuLuan)
                    {
                        arrIdQuestionTuLuan.Add(item.question_id);
                    }

                    List<int> distinctNumbers = GetRandomDistinctNumbers(arrIdQuestion, maxCauTracNghiem);
                    List<int> distinctDungSai = GetRandomDistinctNumbers(arrIdQuestionDungSai, maxDungSai);
                    List<int> distinctTuLuan = GetRandomDistinctNumbers(arrIdQuestionTuLuan, maxTuLuan);
                    idQuestionDungSai.AddRange(distinctDungSai);
                    idQuestionTuLuan.AddRange(distinctTuLuan);
                    for (int i = 0; i < distinctNumbers.Count(); i++)
                    {

                        var question_content = (from qs in db.tbTracNghiem_Questions
                                                where qs.question_id == distinctNumbers[i] && qs.question_group == "part1"
                                                select new
                                                {
                                                    qs.question_content,
                                                    qs.question_giaithich,
                                                }).FirstOrDefault();
                        selectQuestion.Add(new Question
                        {
                            question_id = distinctNumbers[i],
                            question_content = question_content.question_content.Contains("style=") ? "<div class='content_image'>" + question_content.question_content + "</div>" : question_content.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + question_content.question_content + "'>" : question_content.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + question_content.question_content + "'> </audio>" : question_content.question_content,
                            answer_true = md5.Md5((from qs in db.tbTracNghiem_Questions
                                                   join aw in db.tbTracNghiem_Answers on qs.question_id equals aw.question_id
                                                   where qs.question_id == distinctNumbers[i] && aw.answer_true == true
                                                   select aw).FirstOrDefault().answer_id + ""),
                            answer_id_a = (from qs in db.tbTracNghiem_Questions
                                           join aw in db.tbTracNghiem_Answers on qs.question_id equals aw.question_id
                                           where qs.question_id == distinctNumbers[i] && aw.answer_true == true
                                           select aw).FirstOrDefault().answer_id,
                            style = question_content.question_giaithich == "" ? "hidden-item" : "",
                            question_giaithich = question_content.question_giaithich.Contains("style=") ? "<div class='content_image'>" + question_content.question_giaithich + "</div>" : question_content.question_giaithich.Contains("/uploadimages/") ? "<img class='tracnghiem-answer__image' src='" + question_content.question_giaithich + "'>" : question_content.question_giaithich,
                        });
                    }
                    int r = rnd.Next();
                    var result = selectQuestion.OrderBy(x => (~(x.question_id & r)) & (x.question_id | r));
                    rpCauHoi.DataSource = result;
                    rpCauHoi.DataBind();

                    //câu hỏi đúng sai
                    var getCauHoiDungSai = from ch in db.tbTracNghiem_Questions
                                           where idQuestionDungSai.Contains(ch.question_id) && ch.question_group == "part2"
                                           select new
                                           {
                                               ch.question_id,
                                               question_content = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                                               style = ch.question_giaithich == "" ? "hidden-item" : "",
                                           };
                    rpCauHoiDungSai.DataSource = getCauHoiDungSai;
                    rpCauHoiDungSai.DataBind();
                    //get câu hỏi tự luận
                    var getCauHoiTuLuan = from ch in db.tbTracNghiem_Questions
                                          join da in db.tbTracNghiem_Answers on ch.question_id equals da.question_id
                                          where idQuestionTuLuan.Contains(ch.question_id) && ch.question_group == "part3"
                                          select new
                                          {
                                              ch.question_id,
                                              da.answer_id,
                                              da.answer_content,
                                              result = md5.Md5(Convert.ToString(da.answer_content)),
                                              question_content = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                                              style = ch.question_giaithich == "" ? "hidden-item" : "",
                                          };
                    rpCauHoiTuLuan.DataSource = getCauHoiTuLuan;
                    rpCauHoiTuLuan.DataBind();
                    rpModal.DataSource = from qs in db.tbTracNghiem_Questions
                                         where qs.baikiemtra_id == test_id
                                         select new
                                         {
                                             question_id = qs.question_id,
                                             question_giaithich = qs.question_giaithich.Contains("style=") ? "<div class='content_image'>" + qs.question_giaithich + "</div>" : qs.question_giaithich.Contains("/uploadimages/") ? "<img class='tracnghiem-answer__image' src='" + qs.question_giaithich + "'>" : qs.question_giaithich,
                                         };
                    rpModal.DataBind();
                }
            }
            else
            {

            }
        }
        else
        {
            Response.Redirect("/thpt-trang-chu");
        }
    }
    //tính max câu
    private void maxSoLuongCau(int mon_id)
    {
        if (mon_id == 1) //môn toán
        {
            maxCauTracNghiem = 12;
            maxDungSai = 4;
            maxTuLuan = 6;
        }
        if (mon_id == 2 || mon_id == 3 || mon_id == 8 || mon_id == 52) //môn lý hóa sinh địa
        {
            maxCauTracNghiem = 18;
            maxDungSai = 4;
            maxTuLuan = 6;
        }
        if (mon_id == 7 || mon_id == 10) //môn sử gdcd
        {
            maxCauTracNghiem = 24;
            maxDungSai = 4;
            maxTuLuan = 0;
        }

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
        public string style { get; set; }
        public string question_giaithich { get; set; }
    }
    protected void btnLuuKetQua_ServerClick(object sender, EventArgs e)
    {

        var checkHocSinhTrongLop = (from hstl in db.tbAccount_Childrens
                                    where hstl.children_id ==  hocsinh_id && hstl.children_active == true
                                    select hstl).FirstOrDefault();
        int thoigianconlai = Convert.ToInt32(txtThoiGianConLai.Value);
        //kiểm tra xem đã làm đạt yêu cầu chưa
        //var chekLamBai = from rs in db.tbTracNghiem_ResultTests
        //                 where rs.test_id == test_id && rs.hocsinh_code == hocsinh_code
        //                 && rs.result_danhgia == "đã đạt" && rs.result_type == "bai kiem tra moi"
        //                 select rs;

        // Thêm dữ liệu
        //Bước 1 tạo đội tượng
        //tbTracNghiem_ResultTest insert = new tbTracNghiem_ResultTest();
        //// Bước 2: gắn giá trị vào trong các trường của đội tượng
        //insert.resulttest_result = txtSoCauDung.Value;
        //insert.hocsinh_code = hocsinh_code;
        //insert.resulttest_datetime = DateTime.Now;
        //insert.test_id = test_id;
        //insert.result_thoigianlambai = txtFinish.Value;
        ////insert.lop_id = Convert.ToInt32(RouteData.Values["id_khoi"]);
        //insert.lop_id = checkHocSinh.lop_id;
        //insert.hstl_id = checkHocSinh.hstl_id;
        //insert.result_type = "bai kiem tra moi";
        //insert.namhoc_id = checkNamHoc.namhoc_id;
        //double result = Convert.ToDouble(txtSoCauDung.Value, CultureInfo.InvariantCulture);
        //if (chekLamBai.Count() <= 0)
        //{
        //    if ((thoigianconlai * 2 < tongThoiGianLamBai && result >= 5.0) || result >= 7.0)
        //    {
        //        insert.result_danhgia = "đã đạt";
        //    }
        //}
        //else
        //{
        //    insert.result_danhgia = "đã đạt";
        //}
        //// Bước 3: Thực hiện câu lệnh insert
        //db.tbTracNghiem_ResultTests.InsertOnSubmit(insert);
        //// Bước 4: Lưu dữ liệu xuống database
        //db.SubmitChanges();
        //string url = HttpContext.Current.Request.Url.AbsolutePath;
        //if (insert.result_danhgia != "đã đạt")
        //{
        //    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "AlertBox", "swal('Bài làm của bạn chưa đạt yêu cầu, cần làm lại!', '','warning').then(function(){window.onbeforeunload = null;window.location = '" + url + "';})", true);
        //}
    }
    protected void rpCauHoiDungSai_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpCauHoiDungSaiChiTiet = e.Item.FindControl("rpCauHoiDungSaiChiTiet") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getCauHoiChiTiet = from ct in db.tbTracNghiem_Answers
                               where ct.question_id == question_id
                               select new
                               {
                                   question_id = question_id,
                                   ct.answer_id,
                                   ct.answer_true,
                                   result = md5.Md5(Convert.ToString(ct.answer_true)),
                                   answer_content = ct.answer_content.Contains("style=") ? "<div class='content_image'>" + ct.answer_content + "</div>" : ct.answer_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ct.answer_content + "'>" : ct.answer_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ct.answer_content + "'> </audio>" : "<div class='content_image'>" + ct.answer_content + "</div>",
                               };
        rpCauHoiDungSaiChiTiet.DataSource = getCauHoiChiTiet;
        rpCauHoiDungSaiChiTiet.DataBind();
    }
    public class Dapan
    {
        public int answer_id { get; set; }
        public string answer_content { get; set; }
        public string answer_true { get; set; }
        public int question_id { get; set; }
        public int vitri { get; set; }
    }
    protected void rpCauHoi_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Random rnd = new Random();
        int seed = rnd.Next();
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from ct in db.tbTracNghiem_Answers
                               where ct.question_id == question_id && ct.answer_content != ""
                               select new
                               {
                                   ct.answer_id,
                                   //t.answer_content,
                                   answer_content = ct.answer_content.Contains("style=") ? "<div class='content_image'>" + ct.answer_content + "</div>" : ct.answer_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ct.answer_content + "'>" : ct.answer_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ct.answer_content + "'> </audio>" : ct.answer_content,
                                   ct.answer_true,
                                   ct.question_id
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
}