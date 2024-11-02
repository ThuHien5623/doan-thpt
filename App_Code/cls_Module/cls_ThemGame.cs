using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_ThemGame
/// </summary>
public class cls_ThemGame
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_ThemGame()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool Them(int lop_id, int baitap_id, int loaigame_id, int sach_id, int chitietbaitap_vitribaitap, string tinhtrang)
    {
        tbChiTietBaiTap insert = new tbChiTietBaiTap();
        insert.lop_id = lop_id;
        insert.baitap_id = baitap_id;
        insert.loaigame_id = loaigame_id;
        insert.sach_id = sach_id;
        insert.chitietbaitap_vitribaitap = chitietbaitap_vitribaitap;
        insert.chitietbaitap_tinhtrang = tinhtrang;
        //insert.chitietbaitap_tinhtrang = "sử dụng";
        db.tbChiTietBaiTaps.InsertOnSubmit(insert);
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
    public bool CapNhat(int id, int loaigame_id, int sach_id, string link)
    {
        tbChiTietBaiTap update = db.tbChiTietBaiTaps.Where(x => x.chitietbaitap_id == id).FirstOrDefault();
        update.loaigame_id = loaigame_id;
        update.chitietbaitap_linkbaitap = link;
        update.sach_id = sach_id;
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
        tbChiTietBaiTap detele = db.tbChiTietBaiTaps.Where(x => x.chitietbaitap_id == id).FirstOrDefault();
        db.tbChiTietBaiTaps.DeleteOnSubmit(detele);
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