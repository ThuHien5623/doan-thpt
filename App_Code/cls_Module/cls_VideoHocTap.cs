using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cls_VideoHocTap
/// </summary>
public class cls_VideoHocTap
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public cls_VideoHocTap()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool insert_Data(string tenbai, string link, int mon_id, string image, string lop, string monhoc_name, int position)
    {
        tbTracNghiem_VideoLuyenTap insert = new tbTracNghiem_VideoLuyenTap();
        insert.videoluyentap_tenbai = tenbai;
        insert.videoluyentap_video_path = link;
        insert.monhoc_id = mon_id;
        insert.videoluyentap_monhoc = monhoc_name;
        insert.videoluyentap_lop = lop;
        insert.videoluyentap_image_path = image;
        insert.videoluyentap_position = position;
        db.tbTracNghiem_VideoLuyenTaps.InsertOnSubmit(insert);
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
    public bool Update_Data(int id, string tenbai, string link, int mon_id, string image, string lop, string monhoc_name, int position)
    {

        tbTracNghiem_VideoLuyenTap update = db.tbTracNghiem_VideoLuyenTaps.Where(x => x.videoluyentap_id == id).FirstOrDefault();
        update.videoluyentap_tenbai = tenbai;
        update.videoluyentap_video_path = link;
        update.monhoc_id = mon_id;
        update.videoluyentap_monhoc = monhoc_name;
        update.videoluyentap_lop = lop;
        update.videoluyentap_image_path = image;
        update.videoluyentap_position = position;
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
        tbTracNghiem_VideoLuyenTap delete = db.tbTracNghiem_VideoLuyenTaps.Where(x => x.videoluyentap_id == id).FirstOrDefault();
        db.tbTracNghiem_VideoLuyenTaps.DeleteOnSubmit(delete);
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