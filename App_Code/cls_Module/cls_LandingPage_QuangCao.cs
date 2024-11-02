using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_LandingPage_QuangCao
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_LandingPage_QuangCao()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data(string gia, string link, string image)
    {
        tbLandingPage_QuangCao insert = new tbLandingPage_QuangCao();
        insert.quangcao_price = gia;
        insert.quangcao_link = link;
        insert.quangcao_image = image;
        db.tbLandingPage_QuangCaos.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string gia, string link, string image)
    {
        tbLandingPage_QuangCao update = db.tbLandingPage_QuangCaos.Where(x => x.quangcao_id == id).FirstOrDefault();
        update.quangcao_price = gia;
        update.quangcao_link = link;
        if (image != null)
            update.quangcao_image = image;
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
        tbLandingPage_QuangCao delete = db.tbLandingPage_QuangCaos.Where(x => x.quangcao_id == id).FirstOrDefault();
        db.tbLandingPage_QuangCaos.DeleteOnSubmit(delete);
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