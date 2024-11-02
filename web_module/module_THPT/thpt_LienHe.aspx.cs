using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_module_module_THPT_thpt_LienHe : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public string fullname;
    protected void Page_Load(object sender, EventArgs e)
    {
        var getCoSo = from cs in db.tbThongTinCoSos select cs;
        rpCoSo.DataSource = getCoSo;
        rpCoSo.DataBind();

        fullname = (from tk in db.tbDangKies where tk.dangky_taikhoan == Request.Cookies["taikhoan"].Value select tk).FirstOrDefault().dangky_hotenhocsinh;
    }
}