using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_MaTranDeThi_Detail_Version2 : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int STT = 1;
    public int STT1 = 1;
    //public int STTTraLoi;
    public int count = 0;
    public int sum_count_NB_TN = 0;
    public int sum_count_NB_TL = 0;
    public int sum_count_TH_TN = 0;
    public int sum_count_TH_TL = 0;
    public int sum_count_VD_TN = 0;
    public int sum_count_VD_TL = 0;
    public int sum_count_VDC_TN = 0;
    public int sum_count_VDC_TL = 0;
    public double tileNhanBiet = 0;
    public double tileThongHieu = 0;
    public double tileVanDung = 0;
    public double tileVanDungCao = 0;
    //public double TiLeChung1 = 0;
    //public double TiLeChung2 = 0;
    int question_id;
    public double seconds = 0.0;
    private static int _idUser;
    // Roudata 281
    int id_test = 0;
    cls_Alert alert = new cls_Alert();
    public double percent = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        id_test = Convert.ToInt32(RouteData.Values["id_test"]);
        //kiểm tra xem user nào đang truy cập
        var getDataDetails = from td in db.tbTracNghiem_TestDetails
                             join q in db.tbTracNghiem_Questions on td.question_id equals q.question_id
                             where td.test_id == id_test
                             select new
                             {
                                 td.question_id,
                                 noidungcauhoi = q.question_content.Contains("style=") ? "<div class='content_image'>" + q.question_content + "</div>" : q.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("mp3") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content,
                             };
        rpCauHoi.DataSource = getDataDetails;
        rpCauHoi.DataBind();

        var getMaTran = from mt in db.tbTracNghiem_MaTraDeThis
                        join lt in db.tbTracNghiem_BaiLuyenTaps on mt.matrade_id equals lt.matrande_id
                        join t in db.tbTracNghiem_Tests on lt.luyentap_id equals t.luyentap_id
                        where t.test_id == id_test
                        select mt;
        //int sum_count_NB_TN = 0;
        // nội dung kiến thức sẽ có nhiều bài được chọn
        var listDanhSachBai = from ls in db.tbTracNghiem_Lessons
                              where ls.lesson_name == ""
                              select ls;

        string[] arrListLesson = getMaTran.FirstOrDefault().tracnghiem_noidung_kienthuc.Split(',');
        // duyệt từng bài để lấy ra câu hỏi
        foreach (string item in arrListLesson)
        {
            var getTungBai = from ls in db.tbTracNghiem_Lessons
                             where ls.lesson_id == Convert.ToInt16(item)
                             select ls;
            // add các bài vào trong 1 list
            listDanhSachBai = listDanhSachBai.Union(getTungBai);
            //listDanhSachBai.Except(getTungBai);
        }
        var list = from le in listDanhSachBai
                   join ch in db.tbTracNghiem_Chapters on le.chapter_id equals ch.chapter_id
                   select new
                   {

                       le.lesson_id,
                       le.lesson_name,
                       ch.chapter_name,
                       tongphamtram = (from ct in db.tbTracNghiem_MaTranChiTiets
                                                        where ct.lession_id == le.lesson_id && ct.test_id == id_test
                                                        select ct).Sum(x => Convert.ToDouble(x.matranchitiet_phantram.Replace(',','.')))
                   };
        //}
        rpMaTranDeThi.DataSource = list;
        rpMaTranDeThi.DataBind();

        tileNhanBiet = (double)(((getMaTran.FirstOrDefault().tracnghiem_nhanbiet ?? 0) + (getMaTran.FirstOrDefault().tuluan_nhanbiet ?? 0)) * 10);
        tileThongHieu = (double)(((getMaTran.FirstOrDefault().tracnghiem_thonghieu ?? 0) + (getMaTran.FirstOrDefault().tuluan_thonghieu ?? 0)) * 10);
        tileVanDung = (double)(((getMaTran.FirstOrDefault().tracnghiem_vandung ?? 0) + (getMaTran.FirstOrDefault().tuluan_vandung ?? 0)) * 10);
        tileVanDungCao = (double)(((getMaTran.FirstOrDefault().tracnghiem_vandungcao ?? 0) + (getMaTran.FirstOrDefault().tuluan_vandungcao ?? 0)) * 10);
        // Đặc tả ma trận
        // Kiểm tra số câu hỏi có trong bài để get ra nội dung đăc tả bài đó
        // Sau đó add vào list
        //id_test = Convert.ToInt32(RouteData.Values["id_test"]);
        //var listDacTaTracNgiem = from testdt in db.tbTracNghiem_TestDetails
        //                         join q in db.tbTracNghiem_Questions on testdt.question_id equals q.question_id
        //                         join dt in db.tbTracNghiem_DacTas on Convert.ToInt32(q.question_dacta) equals dt.dacta_id
        //                         where testdt.test_id == id_test && q.question_type == "Trắc nghiệm"
        //                         group q by q.chapter_id into g
        //                         select new
        //                         {
        //                             //dacta_id = g.Key.question_dacta,
        //                             chapter_id = g.Key,
        //                             //lesson_id = (from c in db.tbTracNghiem_Lessons
        //                             //             join dt in db.tbTracNghiem_DacTas on c.lesson_id equals dt.lession_id
        //                             //             where dt.dacta_id == Convert.ToInt32(g.Key.question_dacta)
        //                             //             select c.lesson_id).FirstOrDefault(),
        //                             chapter_name = (from c in db.tbTracNghiem_Chapters
        //                                                 //join dt in db.tbTracNghiem_DacTas on c.chapter_id equals dt.chapter_id
        //                                             where c.chapter_id == g.Key
        //                                             select c.chapter_name).FirstOrDefault(),
        //                             //lesson_name = (from c in db.tbTracNghiem_Lessons
        //                             //               join dt in db.tbTracNghiem_DacTas on c.lesson_id equals dt.lession_id
        //                             //               where dt.dacta_id == Convert.ToInt32(g.Key.question_dacta)
        //                             //               select c.lesson_name).FirstOrDefault(),
        //                             //dacta_content = (from dt in db.tbTracNghiem_DacTas where dt.dacta_id == Convert.ToInt32(g.Key.question_dacta) select dt.dacta_content).SingleOrDefault(),

        //                         };
        //var listDacTaTuLuan = from testdt in db.tbTracNghiem_TestDetails
        //                      join q in db.tbTracNghiem_Questions on testdt.question_id equals q.question_id
        //                      //join dt in db.tbTracNghiem_DacTas on Convert.ToInt32(q.question_dacta) equals dt.dacta_id
        //                      where testdt.test_id == id_test && q.question_type == "Tự luận"
        //                      group q by q.chapter_id into g
        //                      select new
        //                      {
        //                          //dacta_id = g.Key.question_dacta,
        //                          chapter_id = g.Key,
        //                          //lesson_id = (from c in db.tbTracNghiem_Lessons
        //                          //             join dt in db.tbTracNghiem_DacTas on c.lesson_id equals dt.lession_id
        //                          //             where dt.dacta_id == Convert.ToInt32(g.Key.question_dacta)
        //                          //             select c.lesson_id).FirstOrDefault(),
        //                          chapter_name = (from c in db.tbTracNghiem_Chapters
        //                                              //join dt in db.tbTracNghiem_DacTas on c.chapter_id equals dt.chapter_id
        //                                          where c.chapter_id == g.Key
        //                                          select c.chapter_name).FirstOrDefault(),
        //                          //lesson_name = (from c in db.tbTracNghiem_Lessons
        //                          //               join dt in db.tbTracNghiem_DacTas on c.lesson_id equals dt.lession_id
        //                          //               where dt.dacta_id == Convert.ToInt32(g.Key.question_dacta)
        //                          //               select c.lesson_name).FirstOrDefault(),
        //                          //dacta_content = (from dt in db.tbTracNghiem_DacTas where dt.dacta_id == Convert.ToInt32(g.Key.question_dacta) select dt.dacta_content).SingleOrDefault(),

        //                      };
        //rpDacTa.DataSource = listDacTa;
        //rpDacTa.DataBind();
        //var listDacTa = listDacTaTracNgiem.Union(listDacTaTuLuan);
        //rpGroupChuong.DataSource = listDacTa;
        //rpGroupChuong.DataBind();
        //rpGroupChuong2.DataSource = listDacTa;
        //rpGroupChuong2.DataBind();
        //var listChuongDacTaTracNgiem = from testdt in db.tbTracNghiem_TestDetails
        //                               join q in db.tbTracNghiem_Questions on testdt.question_id equals q.question_id
        //                               join dt in db.tbTracNghiem_DacTas on Convert.ToInt32(q.question_dacta) equals dt.dacta_id
        //                               where testdt.test_id == id_test && q.question_type == "Trắc nghiệm"
        //                               group q by q.chapter_id into g
        //                               select new
        //                               {
        //                                   chapter_id = g.Key,
        //                                   chapter_name = (from c in db.tbTracNghiem_Chapters
        //                                                   where c.chapter_id == g.Key
        //                                                   select c.chapter_name).FirstOrDefault(),
        //                               };
        //rpChung.DataSource = listChuongDacTaTracNgiem;
        //rpChung.DataBind();

        var getDacTaTracNghiem = from qsdt in db.tbTracNghiem_TestDetails
                                 join qs in db.tbTracNghiem_Questions on qsdt.question_id equals qs.question_id
                                 where qsdt.test_id == id_test && qs.question_type == "Trắc nghiệm" && qs.question_dacta != ""
                                 orderby qs.lesson_id descending
                                 group qs by qs.question_dacta into g
                                 select new
                                 {
                                     //dacta_id = g.Key,
                                     lesson_id = (from c in db.tbTracNghiem_Lessons
                                                  join dt in db.tbTracNghiem_DacTas on c.lesson_id equals dt.lession_id
                                                  where dt.dacta_id == Convert.ToInt32(g.Key)
                                                  select c.lesson_id).FirstOrDefault(),
                                     chapter_name = (from c in db.tbTracNghiem_Chapters
                                                     join dt in db.tbTracNghiem_DacTas on c.chapter_id equals dt.chapter_id
                                                     where dt.dacta_id == Convert.ToInt32(g.Key)
                                                     select c.chapter_name).FirstOrDefault(),
                                     lesson_name = (from c in db.tbTracNghiem_Lessons
                                                    join dt in db.tbTracNghiem_DacTas on c.lesson_id equals dt.lession_id
                                                    where dt.dacta_id == Convert.ToInt32(g.Key)
                                                    select c.lesson_name).FirstOrDefault(),
                                     chapter_id = (from c in db.tbTracNghiem_Chapters
                                                   join dt in db.tbTracNghiem_DacTas on c.chapter_id equals dt.chapter_id
                                                   where dt.dacta_id == Convert.ToInt32(g.Key)
                                                   select c.chapter_id).FirstOrDefault(),
                                     dacta_content = (from dt in db.tbTracNghiem_DacTas where dt.dacta_id == Convert.ToInt32(g.Key) select dt.dacta_content).SingleOrDefault(),
                                 };
        var getDacTaTuLuan = from qsdt in db.tbTracNghiem_TestDetails
                             join qs in db.tbTracNghiem_Questions on qsdt.question_id equals qs.question_id
                             where qsdt.test_id == id_test && qs.question_type == "Tự luận" //&& qs.question_dacta != ""
                             orderby qs.lesson_id descending
                             group qs by qs.question_dacta into g
                             select new
                             {
                                 //dacta_id = g.Key,
                                 lesson_id = Convert.ToInt32(g.First().lesson_id),
                                 chapter_name = (from c in db.tbTracNghiem_Chapters
                                                     //join dt in db.tbTracNghiem_DacTas on c.chapter_id equals dt.chapter_id
                                                 where c.chapter_id == g.First().chapter_id
                                                 select c.chapter_name).FirstOrDefault(),
                                 lesson_name = (from c in db.tbTracNghiem_Lessons
                                                    //join dt in db.tbTracNghiem_DacTas on c.lesson_id equals dt.lession_id
                                                where c.lesson_id == g.First().lesson_id
                                                select c.lesson_name).FirstOrDefault(),
                                 chapter_id = Convert.ToInt32(g.First().chapter_id),
                                 dacta_content = g.Key,
                             };
        var result = getDacTaTracNghiem.Union(getDacTaTuLuan);
        var detailChuong = from c in result
                           group c by c.lesson_id into g
                           select new
                           {
                               lesson_id = g.Key,
                               //chapter_name = g.First().chapter_name,
                               //lesson_name = g.First().lesson_name,
                               //rowspanbai = g.Count(),
                               //dacta_content = g.First().dacta_content,
                           };
        rpChung.DataSource = detailChuong;
        rpChung.DataBind();
        //foreach (var ct in detailChuong)
        //{
        //    rpListChuong.DataSource = detailChuong.Where(x => x.lesson_id == ct.lesson_id);
        //    rpListChuong.DataBind();
        //    var detailBai = from c in getDacTaTracNghiem
        //                    where c.lesson_id == Convert.ToInt32(ct.lesson_id)
        //                    select new
        //                    {
        //                        lesson_id = ct.lesson_id,
        //                        dacta_content = c.dacta_content,
        //                    };
        //    rpListDacTa.DataSource = detailBai.Skip(1).Take(detailBai.Count() - 1);
        //    rpListDacTa.DataBind();
        //}

        //foreach (var item in detailChuong)
        //{
        //    var detailBai = from c in getDacTaTracNghiem
        //                    where c.lesson_id == Convert.ToInt32(item.lesson_id)
        //                    select new
        //                    {
        //                        lesson_id = item.lesson_id,
        //                        dacta_content = c.dacta_content,
        //                    };
        //    rpListDacTa.DataSource = detailBai.Skip(1).Take(detailBai.Count() - 1);
        //    rpListDacTa.DataBind();
        //}
        //var detailBai = from c in getDacTaTracNghiem
        //                group c by c.lesson_id into g
        //                select new
        //                {
        //                    lesson_id = g.Key,
        //                    lesson_name = g.First().lesson_name,
        //                    rowspanbai = g.Count(),
        //                };
        //rpListBai.DataSource = detailBai;
        //rpListBai.DataBind();
        //rpListDacTa.DataSource = getDacTaTracNghiem;
        //rpListDacTa.DataBind();


    }

    protected void rpCauHoiDetals_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        int question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from t in db.tbTracNghiem_Answers
                               where t.question_id == question_id && t.answer_content != null
                               select new
                               {
                                   t.answer_id,
                                   t.answer_content,
                                   t.answer_true,
                                   t.question_id,
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
    public class Dapan
    {
        public string answer_content { get; set; }
        public string name_label { get; set; }
    }
    protected void rpMaTranDeThi_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        id_test = Convert.ToInt32(RouteData.Values["id_test"]);
        Repeater rpMaTranChiTiet = e.Item.FindControl("rpMaTranChiTiet") as Repeater;
        int lesson_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "lesson_id").ToString());
        var maTranChiTiet = from ct in db.tbTracNghiem_MaTranChiTiets
                            where ct.lession_id == lesson_id && ct.test_id == id_test
                            select new
                            {
                                ct.lession_id,
                                ct.matranchitiet_id,
                                ct.matranchitiet_socau,
                                ct.matranchitiet_phantram,
                                ct.matranchitiet_diem,
                            };
        rpMaTranChiTiet.DataSource = maTranChiTiet;
        rpMaTranChiTiet.DataBind();

    }

    protected void rpChung_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpListChuong = e.Item.FindControl("rpListChuong") as Repeater;
        Repeater rpListDacTa = e.Item.FindControl("rpListDacTa") as Repeater;
        int lesson_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "lesson_id").ToString());
        var getDacTaTracNghiem = from qsdt in db.tbTracNghiem_TestDetails
                                 join qs in db.tbTracNghiem_Questions on qsdt.question_id equals qs.question_id
                                 where qsdt.test_id == id_test && qs.question_type == "Trắc nghiệm" && qs.question_dacta != ""
                                 orderby qs.lesson_id descending
                                 group qs by qs.question_dacta into g
                                 select new
                                 {
                                     dacta_id = g.Key,
                                     lesson_id = (from c in db.tbTracNghiem_Lessons
                                                  join dt in db.tbTracNghiem_DacTas on c.lesson_id equals dt.lession_id
                                                  where dt.dacta_id == Convert.ToInt32(g.Key)
                                                  select c.lesson_id).FirstOrDefault(),
                                     chapter_name = (from c in db.tbTracNghiem_Chapters
                                                     join dt in db.tbTracNghiem_DacTas on c.chapter_id equals dt.chapter_id
                                                     where dt.dacta_id == Convert.ToInt32(g.Key)
                                                     select c.chapter_name).FirstOrDefault(),
                                     lesson_name = (from c in db.tbTracNghiem_Lessons
                                                    join dt in db.tbTracNghiem_DacTas on c.lesson_id equals dt.lession_id
                                                    where dt.dacta_id == Convert.ToInt32(g.Key)
                                                    select c.lesson_name).FirstOrDefault(),
                                     chapter_id = (from c in db.tbTracNghiem_Chapters
                                                   join dt in db.tbTracNghiem_DacTas on c.chapter_id equals dt.chapter_id
                                                   where dt.dacta_id == Convert.ToInt32(g.Key)
                                                   select c.chapter_id).FirstOrDefault(),
                                     dacta_content = (from dt in db.tbTracNghiem_DacTas where dt.dacta_id == Convert.ToInt32(g.Key) select dt.dacta_content).SingleOrDefault(),
                                 };


        var getFirstDacTaTracNghiem = from c in getDacTaTracNghiem
                                      where c.lesson_id == lesson_id
                                      select new
                                      {
                                          c.lesson_id,
                                          c.dacta_id,
                                          c.chapter_name,
                                          c.lesson_name,
                                          c.dacta_content,
                                          rowspanbai = (from r in getDacTaTracNghiem
                                                        where r.lesson_id == lesson_id
                                                        select r).Count(),
                                          socau_nhanbiet = (from t in db.tbTracNghiem_TestDetails
                                                            join nb in db.tbTracNghiem_Questions on t.question_id equals nb.question_id
                                                            where nb.lesson_id == lesson_id && nb.question_dacta == c.dacta_id
                                                            && nb.question_dangcauhoi == "Nhận biết" && t.test_id == id_test
                                                            select nb).Count(),
                                          socau_thonghieu = (from t in db.tbTracNghiem_TestDetails
                                                             join nb in db.tbTracNghiem_Questions on t.question_id equals nb.question_id
                                                             where nb.lesson_id == lesson_id && nb.question_dacta == c.dacta_id
                                                             && nb.question_dangcauhoi == "Thông hiểu" && t.test_id == id_test
                                                             select nb).Count(),
                                          socau_vandung = (from t in db.tbTracNghiem_TestDetails
                                                           join nb in db.tbTracNghiem_Questions on t.question_id equals nb.question_id
                                                           where nb.lesson_id == lesson_id && nb.question_dacta == c.dacta_id
                                                           && nb.question_dangcauhoi == "Vận dụng" && t.test_id == id_test
                                                           select nb).Count(),
                                          socau_vandungcao = (from t in db.tbTracNghiem_TestDetails
                                                              join nb in db.tbTracNghiem_Questions on t.question_id equals nb.question_id
                                                              where nb.lesson_id == lesson_id && nb.question_dacta == c.dacta_id
                                                              && nb.question_dangcauhoi == "Vận dụng cao" && t.test_id == id_test
                                                              select nb).Count(),
                                      };
        var getDacTaTuLuan = from qsdt in db.tbTracNghiem_TestDetails
                             join qs in db.tbTracNghiem_Questions on qsdt.question_id equals qs.question_id
                             where qsdt.test_id == id_test && qs.question_type == "Tự luận" //&& qs.question_dacta != ""
                             orderby qs.lesson_id descending
                             group qs by qs.question_dacta into g
                             select new
                             {
                                 dacta_id = g.Key,
                                 lesson_id = Convert.ToInt32(g.First().lesson_id),
                                 chapter_name = (from c in db.tbTracNghiem_Chapters
                                                 where c.chapter_id == g.First().chapter_id
                                                 select c.chapter_name).FirstOrDefault(),
                                 lesson_name = (from c in db.tbTracNghiem_Lessons
                                                where c.lesson_id == g.First().lesson_id
                                                select c.lesson_name).FirstOrDefault(),
                                 chapter_id = Convert.ToInt32(g.First().chapter_id),
                                 dacta_content = g.Key,
                             };



        var getFirstDacTaTuLuan = from c in getDacTaTuLuan
                                  where c.lesson_id == lesson_id
                                  select new
                                  {
                                      c.lesson_id,
                                      c.dacta_id,
                                      c.chapter_name,
                                      c.lesson_name,
                                      c.dacta_content,
                                      rowspanbai = (from r in getDacTaTracNghiem
                                                    where r.lesson_id == lesson_id
                                                    select r).Count(),
                                      socau_nhanbiet = (from t in db.tbTracNghiem_TestDetails
                                                        join nb in db.tbTracNghiem_Questions on t.question_id equals nb.question_id
                                                        where nb.lesson_id == lesson_id && nb.question_dacta == c.dacta_id
                                                        && nb.question_dangcauhoi == "Nhận biết" && t.test_id == id_test
                                                        select nb).Count(),
                                      socau_thonghieu = (from t in db.tbTracNghiem_TestDetails
                                                         join nb in db.tbTracNghiem_Questions on t.question_id equals nb.question_id
                                                         where nb.lesson_id == lesson_id && nb.question_dacta == c.dacta_id
                                                         && nb.question_dangcauhoi == "Thông hiểu" && t.test_id == id_test
                                                         select nb).Count(),
                                      socau_vandung = (from t in db.tbTracNghiem_TestDetails
                                                       join nb in db.tbTracNghiem_Questions on t.question_id equals nb.question_id
                                                       where nb.lesson_id == lesson_id && nb.question_dacta == c.dacta_id
                                                       && nb.question_dangcauhoi == "Vận dụng" && t.test_id == id_test
                                                       select nb).Count(),
                                      socau_vandungcao = (from t in db.tbTracNghiem_TestDetails
                                                          join nb in db.tbTracNghiem_Questions on t.question_id equals nb.question_id
                                                          where nb.lesson_id == lesson_id && nb.question_dacta == c.dacta_id
                                                          && nb.question_dangcauhoi == "Vận dụng cao" && t.test_id == id_test
                                                          select nb).Count(),
                                  };
        if (getFirstDacTaTuLuan.Count() > 0)
        {
            List<DacTa> dacta = new List<DacTa>();
            foreach (var item in getFirstDacTaTracNghiem)
            {
                dacta.Add(new DacTa()
                {
                    lesson_id = item.lesson_id,
                    dacta_id = item.dacta_id,
                    chapter_name = item.chapter_name,
                    lesson_name = item.lesson_name,
                    dacta_content = item.dacta_content,
                    rowspanbai = item.rowspanbai + getFirstDacTaTuLuan.Count(),
                    socau_nhanbiet = item.socau_nhanbiet,
                    socau_thonghieu = item.socau_thonghieu,
                    socau_vandung = item.socau_vandung,
                    socau_vandungcao = item.socau_vandungcao,
                });
            };
            foreach (var item in getFirstDacTaTuLuan)
            {
                dacta.Add(new DacTa()
                {
                    lesson_id = item.lesson_id,
                    dacta_id = item.dacta_id,
                    chapter_name = item.chapter_name,
                    lesson_name = item.lesson_name,
                    dacta_content = item.dacta_content,
                    rowspanbai = item.rowspanbai + getFirstDacTaTuLuan.Count(),
                    socau_nhanbiet = item.socau_nhanbiet,
                    socau_thonghieu = item.socau_thonghieu,
                    socau_vandung = item.socau_vandung,
                    socau_vandungcao = item.socau_vandungcao,
                });
            };
            rpListChuong.DataSource = dacta.Take(1);
            rpListChuong.DataBind();
            rpListDacTa.DataSource = dacta.Skip(1).Take(dacta.Count() - 1);
            rpListDacTa.DataBind();
        }
        else
        {
            rpListChuong.DataSource = getFirstDacTaTracNghiem.Take(1);
            rpListChuong.DataBind();
            rpListDacTa.DataSource = getFirstDacTaTracNghiem.Skip(1).Take(getFirstDacTaTracNghiem.Count() - 1);
            rpListDacTa.DataBind();
        }
    }
    public class DacTa
    {
        public int lesson_id { get; set; }
        public string dacta_id { get; set; }
        public string chapter_name { get; set; }
        public string lesson_name { get; set; }
        public string dacta_content { get; set; }
        public int rowspanbai { get; set; }
        public int socau_nhanbiet { get; set; }
        public int socau_thonghieu { get; set; }
        public int socau_vandung { get; set; }
        public int socau_vandungcao { get; set; }
    }

}