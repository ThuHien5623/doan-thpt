using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Sach
/// </summary>
public class cls_Sach
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_Sach()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool Them(int lop_id, string sach_title)
    {
        tbSach insert = new tbSach();
        insert.lop_id = lop_id;
        insert.sach_title = sach_title;
        insert.hidden = true;
        db.tbSaches.InsertOnSubmit(insert);
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
    public bool CapNhat(int id, int lop_id, string sach_title)
    {
        tbSach update = db.tbSaches.Where(x => x.sach_id == id).FirstOrDefault();
        update.lop_id = lop_id;
        update.sach_title = sach_title;
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
    public bool Xoa(int id)
    {
        tbSach detele = db.tbSaches.Where(x => x.sach_id == id).FirstOrDefault();
        if (detele != null)
        {
            detele.hidden = false;
        }
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