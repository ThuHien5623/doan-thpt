using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_usercontrol_global_menu : System.Web.UI.UserControl
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public String avata;
    public int totalStart;
    public int soluong;
    public string conlai_songay;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["taikhoan"] != null)
        {
            var dataHocSinh = (from hs in db.tbAccounts
                               join cr in db.tbAccount_Childrens on hs.account_id equals cr.account_id
                               where hs.account_sodienthoai == (Request.Cookies["taikhoan"].Value) && cr.children_active == true
                               select cr).FirstOrDefault();
            tbAccount account = (from tk in db.tbAccounts
                                 where tk.account_sodienthoai == Request.Cookies["taikhoan"].Value
                                 select tk).FirstOrDefault();
            if (account.account_goi.Contains("trọn đời"))
            {
                conlai_songay = "trọn đời";
            }
            else
            {
                TimeSpan hieu = Convert.ToDateTime(account.account_ngayketthuc) - DateTime.Now;
                conlai_songay = hieu.Days+" ngày";
            }
            avata = dataHocSinh.children_image.ToString();
            // số sao làm được
            var chitietBaitap = (from ct in db.tbLichSuLamBaiHocSinhs
                                 join cd in db.tbAccount_Childrens on ct.children_id equals cd.children_id
                                 where ct.children_id == dataHocSinh.children_id
                                 select ct.lichsulambai_sao).Sum() ?? 0;
            // số sao đã đổi vật phẩm
            var getSaoOrder = (from od in db.tbOrders
                               join cd in db.tbAccount_Childrens on od.children_id equals cd.children_id
                               where od.children_id == dataHocSinh.children_id && od.order_status == "Đã thanh toán"
                               select od.order_tongxu).Sum() ?? 0;
            lblSao.Text = chitietBaitap - getSaoOrder + "";
            var getDataSoLuong = (from od in db.tbOrderDetails
                                  join o in db.tbOrders on od.order_code equals o.order_code
                                  where o.children_id == dataHocSinh.children_id && o.order_status == "đang order" && o.order_code == od.order_code
                                  select od.order_code).Count();
            soluong = Convert.ToInt32(getDataSoLuong);
            ScriptManager.RegisterStartupScript(this, GetType(), "runFunction", "showLogin();", true);
        }
    }
}