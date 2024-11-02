using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_BangGia
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_BangGia()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data( string cap,string loai,string noidung )
    {
        tbLandingPage_BangGia insert = new tbLandingPage_BangGia();
        insert.banggia_cap = cap;
        insert.banggia_title = loai;
        insert.banggia_content = noidung;
        db.tbLandingPage_BangGias.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string cap, string loai, string noidung)
    {

        tbLandingPage_BangGia update = db.tbLandingPage_BangGias.Where(x => x.banggia_id == id).FirstOrDefault();
        update.banggia_cap = cap;
        update.banggia_title = loai;
        update.banggia_content = noidung;
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
        tbLandingPage_BangGia delete = db.tbLandingPage_BangGias.Where(x => x.banggia_id == id).FirstOrDefault();
        db.tbLandingPage_BangGias.DeleteOnSubmit(delete);
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