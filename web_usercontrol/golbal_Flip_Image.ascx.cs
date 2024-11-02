using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_usercontrol_golbal_Flip_Image : System.Web.UI.UserControl
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    public int sach_id;
    public int baitap_id;
    public int chitietbaitap_id;
    public int lop_id;
    public DateTime timeStart;
    public string MyParam { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        string url = HttpContext.Current.Request.Url.AbsolutePath;
        string[] arr = url.Split('-');
        sach_id = Convert.ToInt32(arr[arr.Length - 3]);
        baitap_id = Convert.ToInt32(arr[arr.Length - 2]);
        chitietbaitap_id = Convert.ToInt32(arr[arr.Length - 1]);
        lop_id = Convert.ToInt32(arr[arr.Length - 4]);
        timeStart = DateTime.Now;
        txtOrderGameFlipImage.Value = MyParam;
        txtTimeStartFlipImage.Value = timeStart.ToString();
        var getnoidunglathhinh = (from l in db.tbGameToan_LatHinhs 
                                  where l.baitap_id == baitap_id && l.chitietbaitap_id == chitietbaitap_id && l.lop_id == lop_id && l.sach_id == sach_id
                                  select l);
        rpnoidunglathinh.DataSource = getnoidunglathhinh;
        rpnoidunglathinh.DataBind();
        if (!IsPostBack)
        {
            loadData(6, "col-3");
        }

    }
    public void loadData(int soluonghinh, string col)
    {
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "setnull", "setNull()", true);
        Random random = new Random();
        int seed = random.Next();
        var getList = (from l in db.tbGameToan_LatHinhs 
                       where l.baitap_id == baitap_id && l.sach_id == sach_id && l.lop_id == lop_id && l.chitietbaitap_id == chitietbaitap_id
                       group l by l.lathinh_code into g
                       select new
                       {
                           lathinh_code = g.Key,
                           lathinh_id = g.First().lathinh_id,
                           col = col
                       });
        if (getList.Count() < 3)
            col = "col-6";
        var randomCode = (getList.OrderBy(s => (~(s.lathinh_id & seed)) & (s.lathinh_id | seed))).Take(soluonghinh);
        txtSoCauHoi.Value = randomCode.Count() + "";
        txtID.Value = string.Join("|", randomCode.Select(x => "," + x.lathinh_id + ","));
        var listData = from tx in db.tbGameToan_LatHinhs 
                       join a in randomCode on tx.lathinh_code equals a.lathinh_code
                       select new
                       {
                           tx.lathinh_id,
                           tx.lathinh_code,
                           tx.lathinh_image,
                           tx.lathinh_mp3,
                           col = col,
                       };
        var result2 = (listData.OrderBy(s => (~(s.lathinh_id & seed)) & (s.lathinh_id | seed)));
        var result3 = (result2.OrderBy(s => (~(s.lathinh_id & seed)) & (s.lathinh_id | seed)));
        //var result4 = (result3.OrderBy(s => (~(s.lathinh_id & seed)) & (s.lathinh_id | seed)));
        rpListHinhAnh.DataSource = result3.OrderBy(x => random.Next());
        rpListHinhAnh.DataBind();
    }
    protected void btnChoiLai_ServerClick(object sender, EventArgs e)
    {
        string[] arrId = txtID.Value.Split('|');
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "setnull", "setNull();", true);
        Random random = new Random();
        int seed = random.Next();
        var getList = (from l in db.tbGameToan_LatHinhs 
                       where arrId.Contains("," + l.lathinh_id + ",")
                       select new
                       {
                           l.lathinh_code,
                           l.lathinh_id,
                          
                       });
        string col = "col-3";
        if (getList.Count() < 3)
            col = "col-6";
        var randomCode = (getList.OrderBy(s => (~(s.lathinh_id & seed)) & (s.lathinh_id | seed)));
        var listData = from tx in db.tbGameToan_LatHinhs 
                       join a in randomCode on tx.lathinh_code equals a.lathinh_code
                       select new
                       {
                           tx.lathinh_id,
                           tx.lathinh_code,
                           tx.lathinh_image,
                           tx.lathinh_mp3,
                           col = col,
                       };

        var result2 = (listData.OrderBy(s => (~(s.lathinh_id & seed)) & (s.lathinh_id | seed)));
        var result3 = (result2.OrderBy(s => (~(s.lathinh_id & seed)) & (s.lathinh_id | seed)));
        //var result4 = (result3.OrderBy(s => (~(s.lathinh_id & seed)) & (s.lathinh_id | seed)));
        rpListHinhAnh.DataSource = result3.OrderBy(x => random.Next());
        rpListHinhAnh.DataBind();
    }
}