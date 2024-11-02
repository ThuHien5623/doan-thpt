using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_BaiLuyenTap_ChiTiet_Ver2 : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    private int id_test;
    public int tongSoCau = 0;
    Random rnd = new Random();
    List<Question> selectQuestion = new List<Question>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            id_test = Convert.ToInt32(RouteData.Values["test_id"]);
            var getBaiLuyenTap = (from test in db.tbTracNghiem_Tests
                                  join blt in db.tbTracNghiem_BaiLuyenTaps on test.luyentap_id equals blt.luyentap_id
                                  where test.test_id == id_test
                                  select new
                                  {
                                      test.test_thoigianlambai,
                                      blt.luyentap_name,
                                      blt.luyentap_danhsachbai,
                                      blt.luyentap_tilecauhoi,
                                      test.test_soluongcauhoi,

                                  }).First();
            tongSoCau = Convert.ToInt32(getBaiLuyenTap.test_soluongcauhoi);
            string[] arrDanhSachBai = getBaiLuyenTap.luyentap_danhsachbai.Split(',');
            string[] arrTiLeCauHoi = getBaiLuyenTap.luyentap_tilecauhoi.Split(';');

            for (var i = 0; i < arrTiLeCauHoi.Length; i++)
            {
                arrTiLeCauHoi[i] = Convert.ToString(Convert.ToInt32(arrTiLeCauHoi[i]) * tongSoCau / 100); //tổng số câu của từng bài => 10 câu hỏi của 1 bài
            }


            for (var j = 0; j < arrDanhSachBai.Length; j++)//35:37
            {
                List<int> arrIdQuestion = new List<int>();
                if (arrDanhSachBai.Length == 1)
                {

                }
                var getIdQuestion = (from qs in db.tbTracNghiem_Questions
                                     where qs.lesson_id == Convert.ToInt32(arrDanhSachBai[j]) //35:37 : 50
                                       && qs.hidden == false && qs.question_type == "Trắc nghiệm" //& qs.question_active == true
                                     select new
                                     {
                                         qs.question_id,
                                     });//.Take(arrIdAnswer.Length == 1 ? 30 : 20);

                foreach (var item in getIdQuestion)
                {
                    arrIdQuestion.Add(item.question_id);
                }

                List<int> distinctNumbers = GetRandomDistinctNumbers(arrIdQuestion, Convert.ToInt32(arrTiLeCauHoi[j]));

                for (int i = 0; i < distinctNumbers.Count(); i++)
                {
                    var question_content = (from qs in db.tbTracNghiem_Questions
                                            where qs.question_id == distinctNumbers[i]
                                            select qs).FirstOrDefault().question_content;
                    selectQuestion.Add(new Question
                    {
                        question_id = distinctNumbers[i],
                        question_content = question_content.Contains("style=") ? "<div class='content_image'>" + question_content + "</div>" : question_content.Contains("/uploadimages/anh_cauhoitracnghiem/") ? "<img class='tracnghiem-answer__image' src='" + question_content + "'>" : question_content.Contains("/uploadimages/video_cauhoitracnghiem/") ? " <audio controls> <source src = '" + question_content + "'> </audio>" : question_content,
                    });
                }
            }
            int r = rnd.Next();
            var result = selectQuestion.OrderBy(x => (~(x.question_id & r)) & (x.question_id | r));
            rpCauHoi.DataSource = result;
            rpCauHoi.DataBind();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "AlertBox", "swal('Đề tạo bị lỗi!', 'Vui lòng xóa và tạo lại!','error').then(function(){window.location = '/admin-danh-sach-bai-luyen-tap';})", true);
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
    }
    public class Dapan
    {
        public string answer_content { get; set; }
        public string name_label { get; set; }
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