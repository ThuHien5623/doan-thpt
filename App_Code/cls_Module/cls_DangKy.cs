using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_DangKy
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_DangKy()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data( string sodienthoai,string hotenhocsinh,string lop, string goi )
    {
        tbDangKy insert = new tbDangKy();
        insert.dangky_sodienthoai = sodienthoai;
        insert.dangky_hotenhocsinh = hotenhocsinh;
        insert.dangky_lop = lop;
        //insert.dangky_goi = goi;

        db.tbDangKies.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string sodienthoai, string hotenhocsinh, string lop, string goi)
    {
     
        tbDangKy update = db.tbDangKies.Where(x => x.dangky_id == id).FirstOrDefault();

        update.dangky_sodienthoai = sodienthoai;
        update.dangky_hotenhocsinh = hotenhocsinh;
        update.dangky_lop = lop;
        //update.dangky_goi = goi;
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
  
    public bool delete_Data(int id)
    {
        tbDangKy delete = db.tbDangKies.Where(x => x.dangky_id == id).FirstOrDefault();
        db.tbDangKies.DeleteOnSubmit(delete);
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