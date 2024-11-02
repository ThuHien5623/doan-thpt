using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_usercontrol_global_header_avatar : System.Web.UI.UserControl
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public string fullname, link_image;
    public int conlai_songay;
    protected void Page_Load(object sender, EventArgs e)
    {
        //fullname = (from tkcr in db.tbAccount_Childrens
        //            join tk in db.tbAccounts on tkcr.account_id equals tk.account_id
        //            where tk.account_sodienthoai == Request.Cookies["taikhoan"].Value
        //            select tkcr).FirstOrDefault().children_fullname;
        //tbAccount account = (from tk in db.tbAccounts
        //                     where tk.account_sodienthoai == Request.Cookies["taikhoan"].Value
        //                     select tk).FirstOrDefault();
        fullname = (from tk in db.tbDangKies
                    where tk.dangky_taikhoan == Request.Cookies["taikhoan"].Value
                    select tk).FirstOrDefault().dangky_hotenhocsinh;
        tbDangKy account = (from tk in db.tbDangKies
                             where tk.dangky_taikhoan == Request.Cookies["taikhoan"].Value
                             select tk).FirstOrDefault();
        //TimeSpan hieu = Convert.ToDateTime(account.account_ngayketthuc) - DateTime.Now;
        //conlai_songay = hieu.Days;
        //link_image = (from tk in db.tbDangKies
        //              where tk.dangky_taikhoan == Request.Cookies["taikhoan"].Value
        //              select tk).FirstOrDefault().children_image;
    }

    protected void btnLogout_ServerClick(object sender, EventArgs e)
    {
        HttpCookie ck = new HttpCookie("taikhoan");
        string s = ck.Value;
        ck.Value = "";  //set a blank value to the cookie 
        ck.Expires = DateTime.Now.AddDays(-1);
        Response.Cookies.Add(ck);
        Response.Redirect("thcs-trang-chu");
    }
}
