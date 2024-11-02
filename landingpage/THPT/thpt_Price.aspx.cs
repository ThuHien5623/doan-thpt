using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class landingpage_THPT_thpt_Price : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int btn = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        var getData = from bg in db.tbLandingPage_BangGias select bg;
        rpBangGia.DataSource = getData;
        rpBangGia.DataBind();
    }
    protected void rpBangGia_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Repeater rpBangGiaChiTiet = e.Item.FindControl("rpBangGiaChiTiet") as Repeater;
        int id_banggia = int.Parse(DataBinder.Eval(e.Item.DataItem, "banggia_id").ToString());
        var getBangGiaChiTiet = from bgct in db.tbLandingPage_BangGiaChiTiets where bgct.banggia_id == id_banggia select bgct;
        rpBangGiaChiTiet.DataSource = getBangGiaChiTiet;
        rpBangGiaChiTiet.DataBind();
    }

    protected void btnLienHe_ServerClick(object sender, EventArgs e)
    {
        // kiểm tra bảng giá chị tiết thuộc loại bảng giá nào thì trỏ link về bảng giá đó
        var checkLoaiBangGia = (from bg in db.tbLandingPage_BangGiaChiTiets
                                where bg.banggiachitiet_id == Convert.ToInt16(txtBangGiaChiTiet.Value)
                                select bg).FirstOrDefault();
        Session["banggiachitiet"] = checkLoaiBangGia.banggiachitiet_gia;
        if (checkLoaiBangGia.banggia_id == 1)
        {
            Response.Redirect("/mam-non-lien-he");
        }
        if (checkLoaiBangGia.banggia_id == 2)
        {
            Response.Redirect("/tieu-hoc-lien-he");
        }
        if (checkLoaiBangGia.banggia_id == 3)
        {
            Response.Redirect("/thcs-lien-he");
        }
        if (checkLoaiBangGia.banggia_id == 4)
        {
            Response.Redirect("/thpt-lien-he");
        }

    }
}