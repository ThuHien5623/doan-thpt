using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_SLLDT_ThongBao
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_SLLDT_ThongBao()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data(string title, string link, string content, string image, int lop)
    {
        tb_SLLDT_ThongBao insert = new tb_SLLDT_ThongBao();
        insert.thongbao_title = title;
        insert.thongbao_link = link;
        insert.thongbao_content = content;
        insert.thongbao_image = image;
        insert.thongbao_lop = lop;
        db.tb_SLLDT_ThongBaos.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string title, string link, string content, string image, int lop)
    {

        tb_SLLDT_ThongBao update = db.tb_SLLDT_ThongBaos.Where(x => x.thongbao_id == id).FirstOrDefault();
        update.thongbao_title = title;
        update.thongbao_link = link;
        update.thongbao_content = content;
        update.thongbao_image = image;
        update.thongbao_lop = lop;
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
        tb_SLLDT_ThongBao delete = db.tb_SLLDT_ThongBaos.Where(x => x.thongbao_id == id).FirstOrDefault();
        db.tb_SLLDT_ThongBaos.DeleteOnSubmit(delete);
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