using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_GiaHan
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_GiaHan()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data( string sodienthoai,string hotenhocsinh,string lop, string goi )
    {
        //tbAccount_LichSu_GiaHan insert = new tbAccount_LichSu_GiaHan();
        //insert.account_sodienthoai = sodienthoai;
        //insert.dangky_lop = lop;
        //insert.dangky_goi = goi;

        //db.tbDangKies.InsertOnSubmit(insert);
        //try
        //{
        //    db.SubmitChanges();
        //    return true;
        //}
        //catch
        //{
            return false;
        //}
    }
    public bool Update_Data(int id, string sodienthoai, string hotenhocsinh, string lop, string goi)
    {
        return false;
    }
  
    public bool delete_Data(int id)
    {
        tbAccount_LichSu_GiaHan delete = db.tbAccount_LichSu_GiaHans.Where(x => x.lichsugianhan_id == id).FirstOrDefault();
        db.tbAccount_LichSu_GiaHans.DeleteOnSubmit(delete);
        try
        {
            db.SubmitChanges();
            return true;
        }
        catch
        {
            return false;
        }
    }
}