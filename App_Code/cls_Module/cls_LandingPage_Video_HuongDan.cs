using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_LandingPage_Video_HuongDan
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_LandingPage_Video_HuongDan()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data(string title, string cap, string link, string image)
    {
        tbLandingPage_VideoHuongDan insert = new tbLandingPage_VideoHuongDan();
        insert.videohuongdan_title = title;
        insert.videohuongdan_cap = cap;
        insert.videohuongdan_video_path = link;
        if (image != null)
            insert.videohuongdan_image_path = image;
        db.tbLandingPage_VideoHuongDans.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string title, string cap, string link, string image)
    {

        tbLandingPage_VideoHuongDan update = db.tbLandingPage_VideoHuongDans.Where(x => x.videohuongdan_id == id).FirstOrDefault();
        update.videohuongdan_title = title;
        update.videohuongdan_cap = cap;
        update.videohuongdan_video_path = link;
        if (image != null)
            update.videohuongdan_image_path = image;
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
        tbLandingPage_VideoHuongDan delete = db.tbLandingPage_VideoHuongDans.Where(x => x.videohuongdan_id == id).FirstOrDefault();
        db.tbLandingPage_VideoHuongDans.DeleteOnSubmit(delete);
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