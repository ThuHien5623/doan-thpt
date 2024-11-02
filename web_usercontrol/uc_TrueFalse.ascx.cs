using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_usercontrol_uc_TrueFalse : System.Web.UI.UserControl
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public Random rad = new Random();
    public int countMadeTrueFalse, totalAnswerTrueFalse;
    public int baitap_id, sach_id, lop_id, chitietbaitap_id;
    public DateTime timeStart;
    public String numberRightTrueFalse, numberLeftTrueFalse;
    public String audioTrueFalse;
    public String questionTrueFalse;
    public String answerTrueFalse;
    public int totalFill;
    string trangthai = "";
    String chuoiID;
    List<tbGameToan_TrueFalse> listData = new List<tbGameToan_TrueFalse>();

    protected void Page_Load(object sender, EventArgs e)
    {
        timeStart = DateTime.Now;
        string url = HttpContext.Current.Request.Url.AbsolutePath;
        string[] arr = url.Split('-');
        baitap_id = Convert.ToInt32(arr[arr.Length - 2]);
        chitietbaitap_id = Convert.ToInt32(arr[arr.Length - 1]);
        sach_id = Convert.ToInt32(arr[arr.Length - 3]);
        lop_id = Convert.ToInt32(arr[arr.Length - 4]);

        if (!IsPostBack)
        {
            txtTimeStartTrueFalse.Value = timeStart.ToString();
            txtSoLuongCauTrueFalse.Text = "1";
            int maxCount = 5;
            txtMaxQuestionTrueFalse.Text = maxCount.ToString();

            var listTitle = db.tbGameToan_TrueFalses
                .Where(cs => cs.chitietbaitap_id == chitietbaitap_id && cs.baitap_id == baitap_id)
                .Select(cs => new { Title = cs.truefalse_title });

            rpTitleTrueFalse.DataSource = listTitle;
            rpTitleTrueFalse.DataBind();

            var data = db.tbGameToan_TrueFalses
                .Where(cs => cs.chitietbaitap_id == chitietbaitap_id && cs.baitap_id == baitap_id && cs.sach_id == sach_id && cs.lop_id == lop_id);

            totalFill = data.Count();
            listData.AddRange(data);

            var ids = new StringBuilder();
            ids.Append(string.Join(",", data.Select(item => item.truefalse_id)));

            txtid.Value = ids.ToString();

            loadData();
        }
    }

    protected void loadData()
    {
        string[] mangPhanTu = txtid.Value.Split(',');
        int indexImg = rad.Next(0, mangPhanTu.Length);
        int id = Convert.ToInt32(mangPhanTu[indexImg]);
        var data = from cs in db.tbGameToan_TrueFalses
                   where cs.chitietbaitap_id == chitietbaitap_id && cs.baitap_id == baitap_id && cs.truefalse_id == id
                   select cs;
        rpSrcCauHoi.DataSource = data;
        rpSrcCauHoi.DataBind();

        List<Tuple<string, string, string>> imageTrueFalse = new List<Tuple<string, string, string>>();
        numberLeftTrueFalse = data.FirstOrDefault().truefalse_content.Split('|')[0];
        imageTrueFalse.Add(Tuple.Create(numberLeftTrueFalse, "../../imagesGame/GameTrueFalse/So/so" + numberLeftTrueFalse + ".png", "dapAnLeftTrueFalse"));

        numberRightTrueFalse = data.FirstOrDefault().truefalse_content.Split('|')[1];
        imageTrueFalse.Add(Tuple.Create(numberRightTrueFalse, "../../imagesGame/GameTrueFalse/So/so" + numberRightTrueFalse + ".png", "dapAnRightTrueFalse"));

        rpCauHoiTrueFalse.DataSource = imageTrueFalse;
        rpCauHoiTrueFalse.DataBind();
        txtCauHoiTrueFasle.Text = data.FirstOrDefault().truefalse_cauhoi;
        txtaudioAnswerTrueFalse.Value = data.FirstOrDefault().truefalse_mp3;
        answerTrueFalse = data.FirstOrDefault().truefalse_content.Split('|')[2];
        if (data.FirstOrDefault().truefalse_content.Split('|')[2] == "left")
        {
            txtDapAnTrueFalse.Value = numberLeftTrueFalse.ToString();
        }
        else
        {
            txtDapAnTrueFalse.Value = numberRightTrueFalse.ToString();
        }

        List<string> danhSach = mangPhanTu.ToList();
        danhSach.RemoveAt(indexImg);
        chuoiID = "";
        txtid.Value = string.Join(",", danhSach);
        if (trangthai != "lan2")
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "playSoundTrueFalse();", true);
    }

    protected void btnReloadTrueFalse_ServerClick(object sender, EventArgs e)
    {
        int soCau = Convert.ToInt32(txtSoLuongCauTrueFalse.Text);
        soCau = 0;
        soCau++;
        txtSoLuongCauTrueFalse.Text = soCau.ToString();
        loadData();
    }

    protected void btnNextCauTrueFalse_ServerClick(object sender, EventArgs e)
    {
        int soCau = Convert.ToInt32(txtSoLuongCauTrueFalse.Text);
        soCau++;
        txtSoLuongCauTrueFalse.Text = soCau.ToString();
        loadData();
    }
}