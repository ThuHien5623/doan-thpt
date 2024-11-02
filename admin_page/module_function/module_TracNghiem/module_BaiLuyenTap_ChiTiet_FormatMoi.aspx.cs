using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_BaiLuyenTap_ChiTiet : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int test_id;
    Random rnd = new Random();
    List<Question> selectQuestion = new List<Question>();
    private static int maxCauTracNghiem = 0, maxDungSai = 4, maxTuLuan = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        test_id = Convert.ToInt32(RouteData.Values["test_id"]);

        var getBaiLuyenTap = (from test in db.tbTracNghiem_Tests
                              join blt in db.tbTracNghiem_BaiLuyenTaps on test.luyentap_id equals blt.luyentap_id
                              where test.test_id == test_id
                              select new
                              {
                                  blt.luyentap_danhsachbai,
                                  blt.luyentap_tilecauhoi,
                                  test.monhoc_id,
                              }).First();
        maxSoLuongCau(Convert.ToInt32(getBaiLuyenTap.monhoc_id));
        string[] arrDanhSachBai = getBaiLuyenTap.luyentap_danhsachbai.Split(',');
        string[] arrTiLeCauHoi = getBaiLuyenTap.luyentap_tilecauhoi.Split(';');
        string[] arrTiLeTracNghhiem = new string[arrTiLeCauHoi.Length];
        string[] arrTiLeDungSai = new string[arrTiLeCauHoi.Length];
        string[] arrTiLeTuLuan = new string[arrTiLeCauHoi.Length];
        for (var i = 0; i < arrTiLeCauHoi.Length; i++)
        {
            arrTiLeTracNghhiem[i] = Convert.ToString(Convert.ToInt32(arrTiLeCauHoi[i]) * maxCauTracNghiem / 100); 
            arrTiLeDungSai[i] = Convert.ToString(Convert.ToInt32(arrTiLeCauHoi[i]) * maxDungSai / 100); 
            arrTiLeTuLuan[i] = Convert.ToString(Convert.ToInt32(arrTiLeCauHoi[i]) * maxTuLuan / 100); 
        }

        for (var j = 0; j < arrDanhSachBai.Length; j++)//35:37
        {
            List<int> arrIdTracNghiem = new List<int>();
            List<int> arrIdDungSai = new List<int>();
            List<int> arrIdTuLuan = new List<int>();
            var getIdQuestion = from qs in db.tbTracNghiem_Questions
                                where qs.lesson_id == Convert.ToInt32(arrDanhSachBai[j]) //35:37 : 50
                                  && qs.hidden == false && qs.question_type == "Trắc nghiệm"
                                select qs.question_id;
            var getIdDungSai = from qs in db.tbTracNghiem_Question_Part23s
                               where qs.lesson_id == Convert.ToInt32(arrDanhSachBai[j]) //35:37 : 50
                                 && qs.hidden == false && qs.question_part == 2
                               select qs.question_id;
            var getIdTuLuan = from qs in db.tbTracNghiem_Question_Part23s
                              where qs.lesson_id == Convert.ToInt32(arrDanhSachBai[j]) //35:37 : 50
                                && qs.hidden == false && qs.question_part == 3
                              select qs.question_id;
            arrIdTracNghiem = getIdQuestion.ToList();
            arrIdDungSai = getIdDungSai.ToList();
            arrIdTuLuan = getIdTuLuan.ToList();
            List<int> distinctNumbers = GetRandomDistinctNumbers(arrIdTracNghiem, Convert.ToInt32(arrTiLeTracNghhiem[j]));
            List<int> distinctDungSai = GetRandomDistinctNumbers(arrIdDungSai, Convert.ToInt32(arrTiLeDungSai[j]));
            List<int> distinctTuLuan = GetRandomDistinctNumbers(arrIdTuLuan, Convert.ToInt32(arrTiLeTuLuan[j]));
            //part1
            for (int i = 0; i < distinctNumbers.Count(); i++)
            {
                var question_content = (from qs in db.tbTracNghiem_Questions
                                        where qs.question_id == distinctNumbers[i]
                                        select qs).FirstOrDefault().question_content;
                selectQuestion.Add(new Question
                {
                    question_id = distinctNumbers[i],
                    question_content = question_content.Contains("style=") ? "<div class='content_image'>" + question_content + "</div>" : question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + question_content + "'>" : question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + question_content + "'> </audio>" : question_content,
                    part = "1",
                    lesson_id = arrDanhSachBai[j],
                });
            }
            //part2
            for (int i = 0; i < distinctDungSai.Count(); i++)
            {
                var question_content = (from qs in db.tbTracNghiem_Question_Part23s
                                        where qs.question_id == distinctDungSai[i]
                                        select qs).FirstOrDefault().question_content;
                selectQuestion.Add(new Question
                {
                    question_id = distinctDungSai[i],
                    question_content = question_content.Contains("style=") ? "<div class='content_image'>" + question_content + "</div>" : question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + question_content + "'>" : question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + question_content + "'> </audio>" : question_content,
                    part = "2",
                    lesson_id = arrDanhSachBai[j],
                });
            }
            //part3
            for (int i = 0; i < distinctTuLuan.Count(); i++)
            {
                var question_content = (from qs in db.tbTracNghiem_Question_Part23s
                                        where qs.question_id == distinctTuLuan[i]
                                        select qs).FirstOrDefault().question_content;
                selectQuestion.Add(new Question
                {
                    question_id = distinctTuLuan[i],
                    question_content = question_content.Contains("style=") ? "<div class='content_image'>" + question_content + "</div>" : question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + question_content + "'>" : question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + question_content + "'> </audio>" : question_content,
                    part = "3",
                    lesson_id = arrDanhSachBai[j],
                });
            }

            //var getQuestion = from c in distinctNumbers
            //                  join qs in db.tbTracNghiem_Questions on c equals qs.question_id
            //                  select new
            //                  {
            //                      qs.question_id,
            //                      question_content = qs.question_content.Contains("style=") ? "<div class='content_image'>" + qs.question_content + "</div>" : qs.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + qs.question_content + "'>" : qs.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + qs.question_content + "'> </audio>" : qs.question_content,
            //                  };
            //foreach (var item in getQuestion)
            //{
            //    selectQuestion.Add(new Question
            //    {
            //        question_id = item.question_id,
            //        question_content = item.question_content,
            //        part = "1",
            //        lesson_id = arrDanhSachBai[j],
            //    });
            //}
            //var getCauHoiDungSai = from c in distinctDungSai
            //                       join ch in db.tbTracNghiem_Question_Part23s on c equals ch.question_id
            //                       where ch.question_part == 2
            //                       select new
            //                       {
            //                           ch.question_id,
            //                           question_content = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
            //                       };
            //foreach (var item in getCauHoiDungSai)
            //{
            //    selectQuestion.Add(new Question
            //    {
            //        question_id = item.question_id,
            //        question_content = item.question_content,
            //        part = "2",
            //        lesson_id = arrDanhSachBai[j],
            //    });
            //}
            //var getCauHoiTuLuan = from c in distinctTuLuan
            //                      join ch in db.tbTracNghiem_Question_Part23s on c equals ch.question_id
            //                      where ch.question_part == 3
            //                      select new
            //                      {
            //                          ch.question_id,
            //                          question_content = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
            //                      };
            //foreach (var item in getCauHoiTuLuan)
            //{
            //    selectQuestion.Add(new Question
            //    {
            //        question_id = item.question_id,
            //        question_content = item.question_content,
            //        part = "3",
            //        lesson_id = arrDanhSachBai[j],
            //    });
            //}

        }
        int r = rnd.Next();
        rpCauHoi.DataSource = selectQuestion.Where(x => x.part == "1");
        rpCauHoi.DataBind();
        //câu hỏi đúng sai
        rpCauHoiDungSai.DataSource = selectQuestion.Where(x => x.part == "2");
        rpCauHoiDungSai.DataBind();
        //get câu hỏi tự luận
        rpCauHoiTuLuan.DataSource = selectQuestion.Where(x => x.part == "3");
        rpCauHoiTuLuan.DataBind();
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
        if (mon_id == 3 || mon_id == 4 || mon_id == 8 || mon_id == 52) //môn lý hóa sinh địa
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
        public string part { get; set; }
        public string lesson_id { get; set; }
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
    protected void rpCauHoiDungSai_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpCauHoiDungSaiChiTiet = e.Item.FindControl("rpCauHoiDungSaiChiTiet") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getCauHoiChiTiet = from ct in db.tbTracNghiem_Answer_Part23s
                               where ct.question_id == question_id
                               select new
                               {
                                   answer_content = ct.answer_content.Contains("style=") ? "<div class='content_image'>" + ct.answer_content + "</div>" : ct.answer_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + ct.answer_content + "'>" : ct.answer_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + ct.answer_content + "'> </audio>" : ct.answer_content,
                               };
        List<Dapan> dapan = new List<Dapan>();
        int index = 1;
        foreach (var item in getCauHoiChiTiet)
        {
            dapan.Add(new Dapan()
            {
                answer_content = item.answer_content,
                name_label = index == 1 ? "A" : index == 2 ? "B" : index == 3 ? "C" : "D",
            });
            index++;
        };
        rpCauHoiDungSaiChiTiet.DataSource = dapan;
        rpCauHoiDungSaiChiTiet.DataBind();
    }
}