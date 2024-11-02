using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_GameChonMot
/// </summary>
public class cls_GameChonMot
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_GameChonMot()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool Them(int lop_id, int sach_id, int baitap_id, int chitietbaitap_id, string cauhoi, string amthanh, string chonmot_image, string chonmot_value)
    {
        tbGameToan_ChonMot insert = new tbGameToan_ChonMot();
        insert.lop_id = lop_id;
        insert.sach_id = sach_id;
        insert.baitap_id = baitap_id;
        insert.chitietbaitap_id = chitietbaitap_id;
        insert.chonmot_cauhoi = cauhoi;
        insert.chonmot_mp3 = amthanh;
        insert.chonmot_image = chonmot_image;
        insert.chonmot_value = chonmot_value;
        //insert.hidden = true;
        db.tbGameToan_ChonMots.InsertOnSubmit(insert);
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
    public bool CapNhat(int id, string cauhoi, string amthanh, string chonmot_image, string chonmot_value)
    {
        tbGameToan_ChonMot update = db.tbGameToan_ChonMots.Where(x => x.chonmot_id == id).FirstOrDefault();
        update.chonmot_cauhoi = cauhoi;
        update.chonmot_mp3 = amthanh;
        update.chonmot_image = chonmot_image;
        update.chonmot_value = chonmot_value;
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
        tbHinhAnh_LoaiGame detele = db.tbHinhAnh_LoaiGames.Where(x => x.hinhanhloaigame_id == id).FirstOrDefault();
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