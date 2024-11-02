using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_Slide
/// </summary>
public class cls_SLLDT_QuyTrinh
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_SLLDT_QuyTrinh()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data(string cap, string tieude, string image1,  string image2,  string image3)
    {
        tbLandingPage_TungCap_QuyTrinh insert = new tbLandingPage_TungCap_QuyTrinh();
        insert.tungcap_quytrinh_name = cap;
        insert.tungcap_quytrinh_title = tieude;
        insert.tungcap_quytrinh_image_1 = image1;
        insert.tungcap_quytrinh_image_2 = image2;
        insert.tungcap_quytrinh_image_3 = image3;
        db.tbLandingPage_TungCap_QuyTrinhs.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string cap, string tieude, string image1, string image2,  string image3)
    {
        tbLandingPage_TungCap_QuyTrinh update = db.tbLandingPage_TungCap_QuyTrinhs.Where(x => x.tungcap_quytrinh_id == id).FirstOrDefault();
        update.tungcap_quytrinh_name = cap;
        if (tieude != null)
            update.tungcap_quytrinh_title = tieude;
        if (image1 != null)
            update.tungcap_quytrinh_image_1 = image1;
      
        if (image2 != null)
            update.tungcap_quytrinh_image_2 = image2;
     
        if (image3 != null)
            update.tungcap_quytrinh_image_3 = image3;
       
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
        tbLandingPage_TungCap_QuyTrinh delete = db.tbLandingPage_TungCap_QuyTrinhs.Where(x => x.tungcap_quytrinh_id == id).FirstOrDefault();
        db.tbLandingPage_TungCap_QuyTrinhs.DeleteOnSubmit(delete);
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