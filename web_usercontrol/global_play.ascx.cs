using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_usercontrol_global_play : System.Web.UI.UserControl
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    string soDienThoai;
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Request.Cookies["taikhoan"] != null)
        //{
        //    soDienThoai = Request.Cookies["taikhoan"].Value;
        //}
    }

  
}