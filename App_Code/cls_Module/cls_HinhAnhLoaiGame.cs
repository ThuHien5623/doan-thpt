using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_HinhAnhLoaiGame
/// </summary>
public class cls_HinhAnhLoaiGame
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_HinhAnhLoaiGame()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool Them(int loaigame_id, string hinhanhloaigame_image, string hinhanhloaigame_giatri)
    {
        tbHinhAnh_LoaiGame insert = new tbHinhAnh_LoaiGame();
        insert.loaigame_id = loaigame_id;
        insert.hinhanhloaigame_image = hinhanhloaigame_image;
        insert.hinhanhloaigame_giatri = hinhanhloaigame_giatri;
        insert.hidden = true;
        db.tbHinhAnh_LoaiGames.InsertOnSubmit(insert);
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
    public bool CapNhat(int id, int loaigame_id, string hinhanhloaigame_image, string hinhanhloaigame_giatri)
    {
        tbHinhAnh_LoaiGame update = db.tbHinhAnh_LoaiGames.Where(x => x.hinhanhloaigame_id == id).FirstOrDefault();
        update.loaigame_id = loaigame_id;
        update.hinhanhloaigame_image = hinhanhloaigame_image;
        update.hinhanhloaigame_giatri = hinhanhloaigame_giatri;
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