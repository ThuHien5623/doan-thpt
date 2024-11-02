using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_LandingPage_Slide
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_LandingPage_Slide()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data(string title, string image)
    {
        tbLandingPage_TungCap_Slide insert = new tbLandingPage_TungCap_Slide();
        insert.tungcap_slide_name = title;
        insert.tungcap_slide_image = image;
        db.tbLandingPage_TungCap_Slides.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string title, string image)
    {
        tbLandingPage_TungCap_Slide update = db.tbLandingPage_TungCap_Slides.Where(x => x.tungcap_slide_id == id).FirstOrDefault();
        update.tungcap_slide_name = title;
        if (image != null)
            update.tungcap_slide_image = image;
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
        tbLandingPage_TungCap_Slide delete = db.tbLandingPage_TungCap_Slides.Where(x => x.tungcap_slide_id == id).FirstOrDefault();
        db.tbLandingPage_TungCap_Slides.DeleteOnSubmit(delete);
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