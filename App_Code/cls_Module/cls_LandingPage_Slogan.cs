using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_LandingPage_Slogan
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_LandingPage_Slogan()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data(string title, string image)
    {
        tbLandingPage_TungCap_Slogan insert = new tbLandingPage_TungCap_Slogan();
        insert.slogan_name = title;
        insert.slogan_image = image;
        db.tbLandingPage_TungCap_Slogans.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string title,string image)
    {

        tbLandingPage_TungCap_Slogan update = db.tbLandingPage_TungCap_Slogans.Where(x => x.slogan_id == id).FirstOrDefault();
        update.slogan_name = title;
        if(image!=null)
        update.slogan_image = image;
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
        tbLandingPage_TungCap_Slogan delete = db.tbLandingPage_TungCap_Slogans.Where(x => x.slogan_id == id).FirstOrDefault();
        db.tbLandingPage_TungCap_Slogans.DeleteOnSubmit(delete);
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