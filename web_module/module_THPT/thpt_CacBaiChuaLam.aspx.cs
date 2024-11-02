using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_CacBaiChuaLam : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public static int khoi_id, mon_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
        //    var getMon = from cm in db.tbTKB_Mons select cm;
        //    ddlChonMon.Items.Clear();
        //    ddlChonMon.AppendDataBoundItems = true;
        //    ddlChonMon.Items.Insert(0, "-- Chọn môn --");
        //    ddlChonMon.DataSource = getMon;
        //    ddlChonMon.DataTextField = "mon_name";
        //    ddlChonMon.DataValueField = "mon_id";
        //    ddlChonMon.DataBind();
        //}
        getList();
    }
    protected void getList()
    {
        //khoi_id = Convert.ToInt32(ddlChonKhoi.SelectedValue);
        khoi_id = Convert.ToInt32(RouteData.Values["khoi"]);
        //mon_id = Convert.ToInt32(ddlChonMon.SelectedValue);
        mon_id = Convert.ToInt32(RouteData.Values["mon"]);
        var checktaikhoan = (from tb in db.tbAccounts
                             join hstl in db.tbAccount_Childrens on tb.account_id equals hstl.account_id
                             where tb.account_sodienthoai == Request.Cookies["taikhoan"].Value
                             // "0705962757"
                             select new
                             {
                                 tb.account_id,
                                 hstl.children_id
                             }).FirstOrDefault();
        var getBaiTap = from bt in db.tbTracNghiem_BaiLuyenTaps
                        join t in db.tbTracNghiem_Tests on bt.luyentap_id equals t.luyentap_id
                        where bt.luyentap_status == 2 && t.khoi_id == khoi_id && t.monhoc_id == mon_id
                        select new
                        {
                            bt.luyentap_id,
                            t.test_id,
                            imgBaiTap = bt.luyentap_path,
                            bt.luyentap_name,
                            t.test_link,
                            khoi_id = khoi_id,
                            mon_id = mon_id,
                            t.test_thoigianlambai, 
                            count_view = (from rt in db.tbTracNghiem_ResultTests
                                          join t1 in db.tbTracNghiem_Tests on rt.test_id equals t1.test_id
                                          where t1.luyentap_id == bt.luyentap_id && rt.hstl_id == checktaikhoan.children_id
                                          select rt).Count(),
                            luyentap_heart_class = (from lth in db.tbTracNghiem_LuyenTap_Hearts
                                                    where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.account_id
                                                    select lth).Count() > 0 ?
                                                    (from lth in db.tbTracNghiem_LuyenTap_Hearts
                                                     where lth.luyentap_id == bt.luyentap_id && lth.account_id == checktaikhoan.account_id
                                                     select lth).FirstOrDefault().luyentap_heart_class == "fa fa-heart" ? "fa fa-heart" : "fa fa-heart-o"
                                                     : "fa fa-heart-o",
                            luyentap_star_class = (from s in db.tbTracNghiem_LuyenTap_Stars
                                                   where s.luyentap_id == bt.luyentap_id
                                                   select s).Count() > 0 ? "fa fa-star" : "fa fa-star-o"
                        };

        var getBT = from bt in getBaiTap where bt.count_view == 0 select bt;

        //rpList_BaiLuyenTap.DataSource = getBaiTap;
        rpList_BaiLuyenTap.DataSource = getBT;
        rpList_BaiLuyenTap.DataBind();
    }

    protected void btnMyHeart_ServerClick(object sender, EventArgs e)
    {
        var checktaikhoan = (from tb in db.tbAccounts where tb.account_sodienthoai == Request.Cookies["taikhoan"].Value select tb).FirstOrDefault();
        tbTracNghiem_LuyenTap_Heart checkHeart = (from h in db.tbTracNghiem_LuyenTap_Hearts where h.luyentap_id == Convert.ToInt32(txtLuyenTap_id.Value) && h.account_id == checktaikhoan.account_id select h).FirstOrDefault();
        if (checkHeart == null)
        {
            tbTracNghiem_LuyenTap_Heart insert = new tbTracNghiem_LuyenTap_Heart();
            insert.account_id = checktaikhoan.account_id;
            insert.luyentap_id = Convert.ToInt32(txtLuyenTap_id.Value);
            insert.luyentap_heart_class = "fa fa-heart";
            db.tbTracNghiem_LuyenTap_Hearts.InsertOnSubmit(insert);
            db.SubmitChanges();
        }
        else
        {
            if (checkHeart.luyentap_heart_class == "fa fa-heart-o")
            {
                checkHeart.luyentap_heart_class = "fa fa-heart";
                db.SubmitChanges();
            }
            else
            {
                checkHeart.luyentap_heart_class = "fa fa-heart-o";
                db.SubmitChanges();
            }
        }
        getList();
    }

    //protected void ddlChonMon_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    getList();
    //}

}