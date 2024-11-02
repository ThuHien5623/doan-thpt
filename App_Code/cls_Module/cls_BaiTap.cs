using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_BaiTap
/// </summary>
public class cls_BaiTap
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_BaiTap()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool Them(int lop_id, int sach_id, string baitap_title, int baitap_Position)
    {
        //var get
        tbBaiTap insert = new tbBaiTap();
        insert.lop_id = lop_id;
        insert.sach_id = sach_id;
        insert.baitap_title = baitap_title;
        insert.hidden = true;
        insert.baitap_Position = baitap_Position;
        db.tbBaiTaps.InsertOnSubmit(insert);
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
    public bool CapNhat(int id, int lop_id, int sach_id, string baihoc_title, int baitap_Position)
    {
        tbBaiTap update = db.tbBaiTaps.Where(x => x.baitap_id == id).FirstOrDefault();
        update.lop_id = lop_id;
        update.sach_id = sach_id;
        update.baitap_title = baihoc_title;
        update.baitap_Position = baitap_Position;
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
        tbBaiTap detele = db.tbBaiTaps.Where(x => x.baitap_id == id).FirstOrDefault();
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