using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_ThongBaoBaiKiemTra
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_ThongBaoBaiKiemTra()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data( string title,string summary,string content, string image, int lop )
    {
        //tbThongBaoBaiKiemTra insert = new tbThongBaoBaiKiemTra();
        //insert.thongbaobaikiemtra_title = title;
        //insert.thongbaobaikiemtra_summary = summary;
        //insert.thongbaobaikiemtra_content = content;
        //insert.thongbaobaikiemtra_image = image;
        //insert.lop_id = lop;
        //db.tbThongBaoBaiKiemTras.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string title, string summary, string content, string image, int lop)
    {

        //tbThongBaoBaiKiemTra update = db.tbThongBaoBaiKiemTras.Where(x => x.thongbaobaikiemtra_id == id).FirstOrDefault();

        //update.thongbaobaikiemtra_title = title;
        //update.thongbaobaikiemtra_summary = summary;
        //update.thongbaobaikiemtra_content = content;
        //update.thongbaobaikiemtra_image = image;
        //update.lop_id = lop;
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
        //tbThongBaoBaiKiemTra delete = db.tbThongBaoBaiKiemTras.Where(x => x.thongbaobaikiemtra_id == id).FirstOrDefault();
        //db.tbThongBaoBaiKiemTras.DeleteOnSubmit(delete);
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