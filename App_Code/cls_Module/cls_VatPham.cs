using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_vatPham
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_vatPham()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data( string ten,string mota,int gia, int sticker, string hinhanh )
    {
        tbVatPham insert = new tbVatPham();
        insert.vatpham_name = ten;
        insert.vatpham_description = mota;
        insert.vatpham_price = gia;
        insert.vatpham_sticker = sticker;
        insert.vatpham_image = hinhanh;

        db.tbVatPhams.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string ten, string mota, int gia, int sticker, string hinhanh)
    {
     
        tbVatPham update = db.tbVatPhams.Where(x => x.vatpham_id == id).FirstOrDefault();
       
        update.vatpham_name = ten;
        update.vatpham_description = mota;
        update.vatpham_price = gia;
        update.vatpham_sticker = sticker;
        update.vatpham_image = hinhanh;
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
        tbVatPham delete = db.tbVatPhams.Where(x => x.vatpham_id == id).FirstOrDefault();
        db.tbVatPhams.DeleteOnSubmit(delete);
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