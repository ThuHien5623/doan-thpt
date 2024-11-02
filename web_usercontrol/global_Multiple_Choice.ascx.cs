using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_usercontrol_global_Multiple_Choice : System.Web.UI.UserControl
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    public DataTable tableMultiple;
    public int SoCauDaLam, Tong;
    public int sach_id, baihoc_id;
    public DateTime timeStart;
    public string MyParam { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = HttpContext.Current.Request.Url.AbsolutePath;
        //string url = "/sach-tieng-viet-1-1";
        string[] arr = url.Split('-');
        //sach_id = Convert.ToInt32(arr[arr.Length - 2]);
        //baihoc_id = Convert.ToInt32(arr[arr.Length - 1]);
        timeStart = DateTime.Now;
        if (!IsPostBack)
        {
            //txtOrderGameMultipleChoice.Value = MyParam;
            //txtTimeStartMultipleChoice.Value = timeStart.ToString();
            //var listID = (from ch in db.tbGameToan_CauHois
            //              where ch.sach_id == sach_id && ch.baihoc_id == baihoc_id && ch.cauhoi_group == "TracNghiem" && ch.cauhoi_image1 == null
            //              select new
            //              {
            //                  ch.cauhoi_id,
            //                  ch.cauhoi_mp3,
            //                  ch.cauhoi_image,
            //                  ch.cauhoi_content,
            //                  ch.cauhoi_titlecauhoi,
            //                  ch.cauhoi_amthanhtrung,
            //              });//10
            //rpnoidung.DataSource = listID;
            //rpnoidung.DataBind();
            //int[] arr_ID = { } ;
            List<int> termsList = new List<int>();
            Random rn = new Random();
            for (int i = 0; i < 5; i++)
            {
                //int see = rn.Next();
                //int index = rn.Next(0, listID.Count());
                //int _id = listID.OrderByDescending(x => (~(x.cauhoi_id & see)) & (x.cauhoi_id | see)).Select(x => x.cauhoi_id).Skip(index).Take(1).First();
                //listID = listID.Where(x => x.cauhoi_id != _id);
                //termsList.Add(_id);
            }
            //var listResult = (from ch in db.tbGameToan_CauHois
            //                  where termsList.Contains(ch.cauhoi_id)
            //                  select new
            //                  {
            //                      ch.cauhoi_id,
            //                      ch.cauhoi_mp3,
            //                      ch.cauhoi_image,
            //                      ch.cauhoi_content,
            //                      ch.cauhoi_titlecauhoi,
            //                      ch.cauhoi_amthanhtrung,
            //                  });

            //    if (listResult.Count() > 0)
            //    {
            //        Random rnd = new Random();
            //        int seed = rnd.Next();
            //        //if (listID.Count() < 10)
            //        //{
            //        listResult = listResult.OrderBy(x => (~(x.cauhoi_id & seed)) & (x.cauhoi_id | seed));
            //        tableMultiple = new DataTable();
            //        tableMultiple.Columns.Add("cauhoi_id", typeof(int));
            //        tableMultiple.Columns.Add("cauhoi_mp3", typeof(string));
            //        tableMultiple.Columns.Add("cauhoi_image", typeof(string));
            //        tableMultiple.Columns.Add("cauhoi_titlecauhoi", typeof(string));
            //        tableMultiple.Columns.Add("cauhoi_amthanhtrung", typeof(string));
            //        //table.Columns.Add("tracnghiem_vocabulary_mp3", typeof(string));
            //        foreach (var p in listResult)
            //        {
            //            tableMultiple.Rows.Add(p.cauhoi_id, p.cauhoi_mp3, p.cauhoi_image, p.cauhoi_titlecauhoi, p.cauhoi_amthanhtrung);
            //        }
            //        txtIDCauHoiDuocChon.Value = listResult.First().cauhoi_id.ToString();
            //        rpTitle.DataSource = listResult.Take(1);
            //        rpTitle.DataBind();
            //        rpCauHoi.DataSource = listResult.Take(1);
            //        rpCauHoi.DataBind();
            //        SoCauDaLam = 1;
            //        txtSoCau.Value = SoCauDaLam + "";
            //        txtTongSoCau.Value = tableMultiple.Rows.Count + "";
            //        Tong = Convert.ToInt32(txtTongSoCau.Value);
            //        Session["socauMultiple"] = 1;
            //        Session["tableMultiple"] = tableMultiple;
            //        var get_id_CauTraLoisai = (from l in db.tbGameToan_CauTraLois
            //                                   where l.cauhoi_id == Convert.ToInt16(txtIDCauHoiDuocChon.Value) && l.cautraloi_dapandung == false
            //                                   select l);
            //        var cautraloidung = (from l in db.tbGameToan_CauTraLois
            //                             where l.cauhoi_id == Convert.ToInt16(txtIDCauHoiDuocChon.Value) && l.cautraloi_dapandung != false
            //                             select l);
            //        Random random = new Random();
            //        int seed1 = random.Next();
            //        var result1 = (get_id_CauTraLoisai.OrderBy(s => (~(s.cauhoi_id & seed1)) & (s.cauhoi_id | seed1))).Take(2);
            //        var result = result1.Union(cautraloidung); /*//Union : cộng 2 bảng lại với nhau.*/
            //        int[] _arr = new int[100];
            //        string a = "";
            //        List<DapAn> Dapan = new List<DapAn>();
            //        for (int i = 0; i < _arr.Length; i++)
            //        {
            //            int vitri = rnd.Next(1, 4);
            //            if (!a.Contains(vitri + ""))
            //            {
            //                var rs = (from r in result
            //                          select new
            //                          {
            //                              r.cautraloi_id,
            //                              r.cautraloi_image,
            //                              //cautraloi_image = r.cautraloi_image.Contains(".png") ? "<img class='answer-item__gather--img' src='" + r.cautraloi_image + "'/>" : r.cautraloi_image,
            //                              style = (r.cautraloi_mp3 != null) ? "display: block" : "display: none",
            //                              cautraloi_mp3 = r.cautraloi_mp3,
            //                              r.cautraloi_dapandung,

            //                              //r.tracnghiem_traloi_name,
            //                              position = vitri,
            //                          }).First();
            //                Dapan.Add(new DapAn()
            //                {
            //                    cautraloi_id = rs.cautraloi_id,
            //                    cautraloi_image = rs.cautraloi_image,
            //                    cautraloi_mp3 = rs.cautraloi_mp3,
            //                    style = rs.style,
            //                    cautraloi_dapandung = rs.cautraloi_dapandung + "",
            //                    //cautraloi_dapandung = rs.cautraloi_dapandung,
            //                    //tracnghiem_traloi_name = rs.tracnghiem_traloi_name,
            //                    position = rs.position,
            //                });
            //                //result2.Union(rs);
            //                result = result.Where(x => x.cautraloi_id != rs.cautraloi_id);
            //                a += vitri + ",";
            //            }
            //        }
            //        rpCauTraLoi.DataSource = Dapan.ToList().OrderBy(x => x.position);
            //        rpCauTraLoi.DataBind();
            //        txtDapAnTruoc.Value = a.Split(',')[0];
            //        if (MyParam == "1")
            //            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "audiobai1();", true);
            //    }
        }
        //SoCauDaLam = Convert.ToInt16(Session["socauMultiple"].ToString());
        //Tong = Convert.ToInt32(txtTongSoCau.Value);
    }
    public class DapAn
    {
        public int cautraloi_id { get; set; }
        public string cautraloi_image { get; set; }
        public string cautraloi_mp3 { get; set; }
        public string style { get; set; }
        public string cautraloi_dapandung { get; set; }
        public int position { get; set; }
        public string tracnghiem_traloi_name { get; set; }
    }

    protected void btnNextCauHoiMultiple_ServerClick(object sender, EventArgs e)
    {
        txtOrderGameMultipleChoice.Value = MyParam;
        txtTimeStartMultipleChoice.Value = timeStart.ToString();
        Session["socauMultiple"] = Convert.ToInt16(txtSoCau.Value) + 1;
        //SoCauDaLam = Convert.ToInt16(Session["socauMultiple"].ToString());
        //txtSoCau.Value = SoCauDaLam + "";
        //tableMultiple = (DataTable)Session["tableMultiple"];
        //txtTongSoCau.Value = tableMultiple.Rows.Count + "";
        //Tong = Convert.ToInt32(txtTongSoCau.Value);
        DataTable firstFiveRows = tableMultiple.AsEnumerable().Skip(Convert.ToInt16(Session["socauMultiple"].ToString()) - 1).Take(1).CopyToDataTable();
        if (firstFiveRows.Rows.Count > 0)
        {
            //rpTitle.DataSource = firstFiveRows;
            //rpTitle.DataBind();
            //rpCauHoi.DataSource = firstFiveRows;
            //rpCauHoi.DataBind();
            foreach (DataRow r in firstFiveRows.Rows)
            {
                txtIDCauHoiDuocChon.Value = r["cauhoi_id"].ToString();
            }
        }

        //var get_id_CauTraLoisai = (from l in db.tbGameToan_CauTraLois
        //                           where l.cauhoi_id == Convert.ToInt16(txtIDCauHoiDuocChon.Value) && l.cautraloi_dapandung == false
        //                           select l);
        //var cautraloidung = (from l in db.tbGameToan_CauTraLois
        //                     where l.cauhoi_id == Convert.ToInt16(txtIDCauHoiDuocChon.Value) && l.cautraloi_dapandung != false
        //                     select l);
        Random random = new Random();
        //int seed = random.Next();
        //var result1 = (get_id_CauTraLoisai.OrderBy(s => (~(s.cautraloi_id & seed)) & (s.cautraloi_id | seed))).Take(2);
        //var result = result1.Union(cautraloidung); /*//Union : cộng 2 bảng lại với nhau.*/
        //int[] arr = new int[1000];
        //string a = "";
        List<DapAn> Dapan = new List<DapAn>();
        int dapantruoc = Convert.ToInt32(txtDapAnTruoc.Value);
        int SoLuongDapAn_A = Convert.ToInt32(txtDapAnA.Value);
        int SoLuongDapAn_B = Convert.ToInt32(txtDapAnB.Value);
        int SoLuongDapAn_C = Convert.ToInt32(txtDapAnC.Value);
        //for (int i = 0; i < arr.Length; i++)
        //{
        //    if (a.Length == 6)
        //    {
        //        break;
        //    }
        //    else
        //    {
        //        //int vitri = random.Next(1, 4);
        //        //if (dapantruoc != vitri)
        //        //{
        //        //    if (!a.Contains(vitri + ""))
        //        //    {
        //        //        var rs = (from r in result
        //        //                  select new
        //        //                  {
        //        //                      r.cautraloi_id,
        //        //                      r.cautraloi_image,
        //        //                      //cautraloi_image = r.cautraloi_image.Contains(".png") ? "<img class='answer-item__image--bg' src='" + r.cautraloi_image + "'/>" : r.cautraloi_image,
        //        //                      //r.cautraloi_mp3,
        //        //                      style = (r.cautraloi_mp3 != null) ? "display: block" : "display: none",
        //        //                      cautraloi_mp3 = r.cautraloi_mp3,
        //        //                      r.cautraloi_dapandung,
        //        //                      //r.tracnghiem_traloi_name,
        //        //                      position = vitri,
        //        //                  }).First();
        //        //        Dapan.Add(new DapAn()
        //        //        {
        //        //            cautraloi_id = rs.cautraloi_id,
        //        //            cautraloi_image = rs.cautraloi_image,
        //        //            cautraloi_mp3 = rs.cautraloi_mp3,
        //        //            style = rs.style,
        //        //            cautraloi_dapandung = rs.cautraloi_dapandung + "",
        //        //            //cautraloi_dapandung = rs.cautraloi_dapandung,
        //        //            //tracnghiem_traloi_name = rs.tracnghiem_traloi_name,
        //        //            position = rs.position,
        //        //        });
        //        //        result = result.Where(x => x.cautraloi_id != rs.cautraloi_id);
        //        //        a += vitri + ",";
        //        //        dapantruoc = 0;
        //        //    }
        //        //}
        //    }
        //}
        //if ((firstFiveRows.Rows[0]["cauhoi_amthanhtrung"]).ToString() != "trung")
        //{
        //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "audiobai1();", true);
        //}
        //rpCauTraLoi.DataSource = Dapan.ToList().OrderBy(x => x.position);
        //rpCauTraLoi.DataBind();
        //txtDapAnTruoc.Value = a.Split(',')[0];
    }

    protected void btnReLoadglobalMultipleChoice_ServerClick(object sender, EventArgs e)
    {
        txtOrderGameMultipleChoice.Value = MyParam;
        txtTimeStartMultipleChoice.Value = timeStart.ToString();
        txtDiemSo.Value = "0";
        txtTongSoCau.Value = "0";
        //var listID = from ch in db.tbGameToan_CauHois
        //             where ch.sach_id == sach_id && ch.baihoc_id == baihoc_id && ch.cauhoi_group == "TracNghiem" && ch.cauhoi_image1 == null
        //             select new
        //             {
        //                 ch.cauhoi_id,
        //                 ch.cauhoi_mp3,
        //                 ch.cauhoi_image,
        //                 ch.cauhoi_content,
        //                 ch.cauhoi_titlecauhoi,
        //                 ch.cauhoi_amthanhtrung,
        //             };
        //rpnoidung.DataSource = listID;
        //rpnoidung.DataBind();
        List<int> termsList = new List<int>();
        Random rn = new Random();
        for (int i = 0; i < 5; i++)
        {
            //int see = rn.Next();
            //int index = rn.Next(0, listID.Count());
            //int _id = listID.OrderByDescending(x => (~(x.cauhoi_id & see)) & (x.cauhoi_id | see)).Select(x => x.cauhoi_id).Skip(index).Take(1).First();
            //listID = listID.Where(x => x.cauhoi_id != _id);
            //termsList.Add(_id);
        }
        //var listResult = (from ch in db.tbGameToan_CauHois
        //                  where termsList.Contains(ch.cauhoi_id)
        //                  select new
        //                  {
        //                      ch.cauhoi_id,
        //                      ch.cauhoi_mp3,
        //                      ch.cauhoi_image,
        //                      ch.cauhoi_content,
        //                      ch.cauhoi_titlecauhoi,
        //                      ch.cauhoi_amthanhtrung,
        //                  });

        //if (listResult.Count() > 0)
        //{
        //    Random rnd = new Random();
        //    int seed = rnd.Next();
        //    //if (listID.Count() < 10)
        //    //{
        //    listResult = listResult.OrderBy(x => (~(x.cauhoi_id & seed)) & (x.cauhoi_id | seed)).Take(5);
        //    tableMultiple = new DataTable();
        //    tableMultiple.Columns.Add("cauhoi_id", typeof(int));
        //    tableMultiple.Columns.Add("cauhoi_mp3", typeof(string));
        //    tableMultiple.Columns.Add("cauhoi_image", typeof(string));
        //    tableMultiple.Columns.Add("cauhoi_titlecauhoi", typeof(string));
        //    tableMultiple.Columns.Add("cauhoi_amthanhtrung", typeof(string));
        //    //table.Columns.Add("tracnghiem_vocabulary_mp3", typeof(string));
        //    foreach (var p in listResult)
        //    {
        //        tableMultiple.Rows.Add(p.cauhoi_id, p.cauhoi_mp3, p.cauhoi_image, p.cauhoi_titlecauhoi);
        //    }
        //    txtIDCauHoiDuocChon.Value = listResult.First().cauhoi_id.ToString();
        //    rpTitle.DataSource = listResult.Take(1);
        //    rpTitle.DataBind();
        //    rpCauHoi.DataSource = listResult.Take(1);
        //    rpCauHoi.DataBind();
        //    SoCauDaLam = 1;
        //    txtSoCau.Value = SoCauDaLam + "";
        //    txtTongSoCau.Value = tableMultiple.Rows.Count + "";
        //    Tong = Convert.ToInt32(txtTongSoCau.Value);
        //    Session["socauMultiple"] = 1;
        //    Session["tableMultiple"] = tableMultiple;
        //    var get_id_CauTraLoisai = (from l in db.tbGameToan_CauTraLois
        //                               where l.cauhoi_id == Convert.ToInt16(txtIDCauHoiDuocChon.Value) && l.cautraloi_dapandung == false
        //                               select l);
        //    var cautraloidung = (from l in db.tbGameToan_CauTraLois
        //                         where l.cauhoi_id == Convert.ToInt16(txtIDCauHoiDuocChon.Value) && l.cautraloi_dapandung != false
        //                         select l);
        //    Random random = new Random();
        //    int seed1 = random.Next();
        //    var result1 = (get_id_CauTraLoisai.OrderBy(s => (~(s.cauhoi_id & seed1)) & (s.cauhoi_id | seed1))).Take(2);
        //    var result = result1.Union(cautraloidung); /*//Union : cộng 2 bảng lại với nhau.*/
        //    int[] _arr = new int[100];
        //    string a = "";
        //    List<DapAn> Dapan = new List<DapAn>();
        //    for (int i = 0; i < _arr.Length; i++)
        //    {
        //        int vitri = rnd.Next(1, 4);
        //        if (!a.Contains(vitri + ""))
        //        {
        //            var rs = (from r in result
        //                      select new
        //                      {
        //                          r.cautraloi_id,
        //                          r.cautraloi_image,
        //                          //cautraloi_image = r.cautraloi_image.Contains(".png") ? "<img class='answer-item__image--bg' src='" + r.cautraloi_image + "'/>" : r.cautraloi_image,
        //                          style = (r.cautraloi_mp3 != null) ? "display: block" : "display: none",
        //                          cautraloi_mp3 = r.cautraloi_mp3,
        //                          r.cautraloi_dapandung,

        //                          //r.tracnghiem_traloi_name,
        //                          position = vitri,
        //                      }).First();
        //            Dapan.Add(new DapAn()
        //            {
        //                cautraloi_id = rs.cautraloi_id,
        //                cautraloi_image = rs.cautraloi_image,
        //                cautraloi_mp3 = rs.cautraloi_mp3,
        //                style = rs.style,
        //                cautraloi_dapandung = rs.cautraloi_dapandung + "",
        //                //cautraloi_dapandung = rs.cautraloi_dapandung,
        //                //tracnghiem_traloi_name = rs.tracnghiem_traloi_name,
        //                position = rs.position,
        //            });
        //            //result2.Union(rs);
        //            result = result.Where(x => x.cautraloi_id != rs.cautraloi_id);
        //            a += vitri + ",";
        //        }
        //    }
        //    rpCauTraLoi.DataSource = Dapan.ToList().OrderBy(x => x.position);
        //    rpCauTraLoi.DataBind();
        //    txtDapAnTruoc.Value = a.Split(',')[0];
        //    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "audiobai1();", true);
        //}

        //SoCauDaLam = Convert.ToInt16(Session["socauMultiple"].ToString());
        //Tong = Convert.ToInt32(txtTongSoCau.Value);
    }
}