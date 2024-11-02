using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_LandingPage_Video
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_LandingPage_Video()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data(string title, string cap, string link)
    {
        tbLandingPage_TungCap_video insert = new tbLandingPage_TungCap_video();
        insert.tungcap_video_title = title;
        insert.tungcap_video_name = cap;
        insert.tungcap_video_link = link;
        db.tbLandingPage_TungCap_videos.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string title,string cap, string link)
    {

        tbLandingPage_TungCap_video update = db.tbLandingPage_TungCap_videos.Where(x => x.tungcap_video_id == id).FirstOrDefault();
        update.tungcap_video_title = title;
        update.tungcap_video_name = cap;
        update.tungcap_video_link = link;
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
        tbLandingPage_TungCap_video delete = db.tbLandingPage_TungCap_videos.Where(x => x.tungcap_video_id == id).FirstOrDefault();
        db.tbLandingPage_TungCap_videos.DeleteOnSubmit(delete);
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