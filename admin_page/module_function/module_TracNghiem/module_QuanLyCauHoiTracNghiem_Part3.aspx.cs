using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxHtmlEditor;
using OfficeOpenXml;

public partial class admin_page_module_function_module_TracNghiem_module_QuanLyCauHoiTracNghiem : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    int _id;
    int id_user;
    public string title_BaiHoc, image;

    protected void Page_Load(object sender, EventArgs e)
    {
        var checkTaiKhoan = (from u in db.admin_Users
                             where u.username_username == Request.Cookies["UserName"].Value
                             select u).FirstOrDefault();
        id_user = checkTaiKhoan.username_id;
        if (!IsPostBack)
        {
            edtContent.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            //edtDapAnA.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            //edtDapAnB.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            //edtDapAnC.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            //edtDapAnD.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            edtGiaiThich.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
            Session["_id"] = 0;
        }
        loadData();
    }
    private void loadData()
    {
        var getCH_TN = from ch in db.tbTracNghiem_Question_Part23s
                       join u in db.admin_Users on ch.username_id equals u.username_id
                       //  join k in db.tbGiaoVienDayKhois on u.username_id equals k.username_id
                       // join m in db.tbGiaoVienDayMons on u.username_id equals m.username_id
                       join c in db.tbTracNghiem_Chapters on ch.chapter_id equals c.chapter_id
                       join b in db.tbTracNghiem_Lessons on ch.lesson_id equals b.lesson_id
                       where
                       //    && ch.khoi_id == Convert.ToInt32(RouteData.Values["khoi_id"])
                       //   && m.monhoc_id == Convert.ToInt32(RouteData.Values["mon_id"])
                       //&& 
                       ch.chapter_id == Convert.ToInt32(RouteData.Values["chuong_id"])
                       && ch.lesson_id == Convert.ToInt32(RouteData.Values["baihoc_id"])
                       && ch.hidden == false && ch.question_part == 3
                       orderby ch.question_id descending
                       select new
                       {
                           c.chapter_id,
                           question_content = ch.question_content.Contains("style=") ? "<div class='content_image'>" + ch.question_content + "</div>" : ch.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + ch.question_content + "'>" : ch.question_content.Contains("mp3") ? " <audio controls> <source src = '" + ch.question_content + "'> </audio>" : ch.question_content,
                           ch.question_createdate,
                           question_level = ch.question_level,
                           b.lesson_name,
                           ch.question_id,
                           //ch.question_dangcauhoi,
                           u.username_fullname
                       };
        grvList.DataSource = getCH_TN;
        grvList.DataBind();
    }
    protected void btnLuu_Click(object sender, EventArgs e)
    {
        //luu file image
        SavefileImage();
        // đếm số đáp án chọn.
        if (edtContent.Html == "" && ddlLoaiCauHoi.SelectedValue == "Nhận biết")
        {
            alert.alert_Error(Page, "Bạn chưa nhập nội dung câu hỏi", "");
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked()", true);
        }

        else if (txtDapAn.Value == "")
        {
            alert.alert_Error(Page, "Bạn cần nhập đáp án", "");
        }
        //else if (ddlDacTa.SelectedValue == "Chọn đặc tả" || ddlDacTa.SelectedValue == "Không có dữ liệu")
        //{
        //    alert.alert_Warning(Page, "Vui lòng chọn đặc tả", "");
        //}
        else
        {
            if (Session["_id"].ToString() == "0")
            {
                //tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
                themdata();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + image + "')", true);
                btnLuu.Text = "Cập nhật";
                btnLuuvaThemmoi.Text = "Cập nhật và thêm mới";
                //if (ddlLoaiCauHoi.SelectedValue != "Nhận biết")
                //{
                //    themcauhoi.question_content = image;
                //}
                //else
                //{
                //    themcauhoi.question_content = edtContent.Html;
                //}
            }
            else
            {
                //update
                updatedata();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + image + "')", true);

            }
        }
    }
    protected void btnLuuvaThemmoi_Click1(object sender, EventArgs e)
    {
        SavefileImage();

        if (edtContent.Html == "" && image == null)
        {
            alert.alert_Error(Page, "Bạn chưa nhập nội dung câu hỏi", "");
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked()", true);
        }

        else if (txtDapAn.Value == "")
        {
            alert.alert_Error(Page, "Bạn cần nhập đáp án", "");
        }
        //else if (ddlDacTa.SelectedValue == "Chọn đặc tả" || ddlDacTa.SelectedValue == "Không có dữ liệu")
        //{
        //    alert.alert_Warning(Page, "Vui lòng chọn đặc tả", "");
        //}
        else
        {
            if (Session["_id"].ToString() == "0")
            {
                tbTracNghiem_Question_Part23 themcauhoi = new tbTracNghiem_Question_Part23();
                themdata();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();", true);
                Session["_id"] = "0";
                btnLuu.Text = "Lưu";
                btnLuuvaThemmoi.Text = "Lưu và thêm mới";
            }
            else
            {
                updatedata();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();", true);
                Session["_id"] = "0";
                btnLuu.Text = "Lưu";
                btnLuuvaThemmoi.Text = "Lưu và thêm mới";
            }
            datarong();
        }
    }
    protected void btnXoa_Click(object sender, EventArgs e)
    {
        List<object> selectedKey = grvList.GetSelectedFieldValues(new string[] { "question_id" });
        if (selectedKey.Count > 0)
        {
            foreach (var item in selectedKey)
            {
                tbTracNghiem_Question_Part23 del = db.tbTracNghiem_Question_Part23s.Where(x => x.question_id == Convert.ToInt32(item)).FirstOrDefault();
                //if (del.username_id == id_user)
                //{
                del.hidden = true;
                db.SubmitChanges();
                alert.alert_Success(Page, "Xoá thành công!", "");
                //}
                //else
                //{
                //    alert.alert_Error(Page, "Không thể xóa dữ liệu!", "");
                //}
            }
            loadData();
            datarong();
            ddlLoaiCauHoi.Text = "Nhận biết";
        }
        else
        {
            alert.alert_Warning(Page, "Bạn chưa chọn dữ liệu", "");
        }
    }

    protected void btnChiTiet_Click(object sender, EventArgs e)
    {
        _id = Convert.ToInt32(grvList.GetRowValues(grvList.FocusedRowIndex, new string[] { "question_id" }));
        Session["_id"] = _id;
        var chitiet = (from ct in db.tbTracNghiem_Question_Part23s
                           //join dt in db.tbTracNghiem_DacTas on Convert.ToInt32(ct.question_dacta) equals dt.dacta_id
                       where ct.question_id == _id
                       select new
                       {
                           ct.username_id,
                           ct.question_content,
                           //ct.question_type,
                           //ct.question_dangcauhoi,
                           ct.question_level,
                           ct.question_giaithich,
                           //dt.dacta_content,
                           //ct.question_dacta,
                       }).Single();
        //if (chitiet.username_id == id_user)
        //{
        //txtLoaiCauHoi.Value = chitiet.question_level + "";
        ddlLoaiCauHoi.Text = chitiet.question_level + "";
        edtGiaiThich.Html = chitiet.question_giaithich;
        //ddlDacTa.SelectedValue = chitiet.question_dacta;
        if (!chitiet.question_content.Contains("uploadimages"))
        {
            txtKieuCauHoi.Value = "0";
            edtContent.Html = chitiet.question_content;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();", true);
        }
        else
        {
            if (!chitiet.question_content.Contains("mp3"))
            {
                image = chitiet.question_content;
                txtKieuCauHoi.Value = "1";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + image + "'),lockAudio()", true);
            }
            else
            {
                txtKieuCauHoi.Value = "1";
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setCheckedDCH();setChecked();setForm();showImg1_1('" + image + "'),lockImg()", true);
            }
        }
        var chitietquestion = (from ctCH in db.tbTracNghiem_Answer_Part23s
                               where ctCH.question_id == _id
                               select ctCH);
        txtDapAn.Value = chitietquestion.First().answer_content;
        btnLuu.Text = "Cập nhật";
        btnLuuvaThemmoi.Text = "Cập nhật và thêm mới";
        //}
        //else
        //{
        //    alert.alert_Error(Page, "Bạn không thể xem chi tiết câu hỏi này", "");
        //}
    }


    protected void btnTaiLaiTrang_Click(object sender, EventArgs e)
    {
        loadData();
        datarong();
        Session["_id"] = "0";
        ddlLoaiCauHoi.Text = "Nhận biết";
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "grvList.UnselectRows();setForm()", true);
    }

    private void datarong()
    {
        //edtDapAnA.Html = "";
        //edtDapAnB.Html = "";
        //edtDapAnC.Html = "";
        //edtDapAnD.Html = "";
        txtDapAn.Value = "";
        edtGiaiThich.Html = "";
        //ddlDacTa.Text = "";
        edtContent.Html = "";
        btnLuu.Text = "Lưu";
        btnLuuvaThemmoi.Text = "Lưu và thêm mới";
    }
    private void themdata()
    {
        var getUser = (from u in db.admin_Users
                       where u.username_username == Request.Cookies["UserName"].Value
                       select u).SingleOrDefault();
        tbTracNghiem_Question_Part23 themcauhoi = new tbTracNghiem_Question_Part23();
        if (edtContent.Html == "" && txtKieuCauHoi.Value != "0")
            themcauhoi.question_content = image;
        else
            themcauhoi.question_content = edtContent.Html;
        themcauhoi.question_createdate = DateTime.Now;
        themcauhoi.question_part = 3;
        //themcauhoi.question_level = txtLoaiCauHoi.Value;
        themcauhoi.username_id = getUser.username_id;
        themcauhoi.chapter_id = Convert.ToInt32(RouteData.Values["chuong_id"]);
        //themcauhoi.question_type = "Trắc nghiệm";
        themcauhoi.hidden = false;
        themcauhoi.question_level = ddlLoaiCauHoi.SelectedValue;
        themcauhoi.question_giaithich = edtGiaiThich.Html;
        //themcauhoi.question_dacta = ddlDacTa.SelectedValue;
        themcauhoi.lesson_id = Convert.ToInt32(RouteData.Values["baihoc_id"]);
        //themcauhoi.diemtichluy = 1;
        db.tbTracNghiem_Question_Part23s.InsertOnSubmit(themcauhoi);
        db.SubmitChanges();
        Session["_id"] = themcauhoi.question_id;
        //lưu đáp án A
        tbTracNghiem_Answer_Part23 dapanA = new tbTracNghiem_Answer_Part23();
        dapanA.answer_content = txtDapAn.Value.Replace(" ", string.Empty);
        dapanA.question_id = themcauhoi.question_id;
        db.tbTracNghiem_Answer_Part23s.InsertOnSubmit(dapanA);
        db.SubmitChanges();
        alert.alert_Success(Page, "Lưu thành công", "");
        loadData();
    }
    private void updatedata()
    {
        var chitiet = (from ct in db.tbTracNghiem_Question_Part23s
                       where ct.question_id == Convert.ToInt32(Session["_id"].ToString())
                       select ct).Single();
        if (txtKieuCauHoi.Value != "0")
        {
            if (edtContent.Html != "")
            {
                chitiet.question_content = edtContent.Html;
            }
            if (image != null)
            {
                chitiet.question_content = image;
            }
        }
        else
        {
            chitiet.question_content = edtContent.Html;
        }
        //chitiet.question_level = txtLoaiCauHoi.Value;
        chitiet.question_level = ddlLoaiCauHoi.SelectedValue;
        chitiet.question_giaithich = edtGiaiThich.Html;
        //chitiet.question_dacta = ddlDacTa.SelectedValue;
        db.SubmitChanges();
        var chitietquestion = (from ctCH in db.tbTracNghiem_Answer_Part23s
                               where ctCH.question_id == Convert.ToInt32(Session["_id"].ToString())
                               select ctCH);
        chitietquestion.First().answer_content = txtDapAn.Value.Replace(" ", string.Empty);
        db.SubmitChanges();
        alert.alert_Success(Page, "Cập nhật thành công", "");
        btnLuu.Text = "Cập nhật";
        btnLuuvaThemmoi.Text = "Cập nhật và thêm mới";
        loadData();
    }
    private void SavefileImage()
    {
        if (Page.IsValid && FileUpload1.HasFile)
        {
            String folderUser;
            string url;
            string filename;
            string fileName_save;
            if (txtKieuCauHoi.Value == "1")
            {
                //lưu hình ảnh
                folderUser = Server.MapPath("~/uploadimages/anh_cauhoitracnghiem/");
                if (!Directory.Exists(folderUser))
                {
                    Directory.CreateDirectory(folderUser);
                }
                url = "/uploadimages/anh_cauhoitracnghiem/";
                HttpFileCollection hfc = Request.Files;
                filename = DateTime.Now.ToString("yyyyMMdd_") + FileUpload1.FileName;
                fileName_save = Path.Combine(Server.MapPath("~/uploadimages/anh_cauhoitracnghiem"), filename);
                FileUpload1.SaveAs(fileName_save);
                VaryQualityLevel(System.Drawing.Image.FromStream(hfc[0].InputStream), fileName_save);
                image = url + filename;
            }
            else if (txtKieuCauHoi.Value == "2")
            {
                //lưu video
                folderUser = Server.MapPath("~/uploadimages/video_cauhoitracnghiem/");
                if (!Directory.Exists(folderUser))
                {
                    Directory.CreateDirectory(folderUser);
                }
                url = "/uploadimages/video_cauhoitracnghiem/";
                HttpFileCollection hfc = Request.Files;
                filename = DateTime.Now.ToString("yyyyMMdd_") + FileUpload1.FileName;
                fileName_save = Path.Combine(Server.MapPath("~/uploadimages/video_cauhoitracnghiem"), filename);
                FileUpload1.SaveAs(fileName_save);
                image = url + filename;
            }
        }
    }

    protected void btnNhapExcel_Click(object sender, EventArgs e)
    {
        if (FileUpload2.HasFile)
        {
            string fileName = FileUpload2.FileName;
            string ext = Path.GetExtension(fileName);
            if (ext.ToLower().Equals(".xlsx") || ext.ToLower().Equals(".xls"))
            {
                String folderUser = Server.MapPath("~/Excel_Files/De_luyen_tap/");
                if (!Directory.Exists(folderUser))
                {
                    Directory.CreateDirectory(folderUser);
                }
                //string filename;
                HttpFileCollection hfc = Request.Files;
                string filename = Path.GetFileNameWithoutExtension(FileUpload2.FileName);
                string path = string.Concat(Server.MapPath("~/Excel_Files/De_luyen_tap/" + filename + "_" + DateTime.Now.ToString("yyyy_MM_dd_HH_mm_ss") + ext));
                FileUpload2.SaveAs(path);
                //load the uploaded file into the memorystream
                //đặt debug đoạn này
                using (MemoryStream stream = new MemoryStream(FileUpload2.FileBytes))
                using (ExcelPackage excelPackage = new ExcelPackage(stream))
                {
                    //loop all worksheets
                    //foreach (ExcelWorksheet worksheet in excelPackage.Workbook.Worksheets)
                    ExcelWorksheet worksheet = excelPackage.Workbook.Worksheets[0];
                    //lặp các cột dòng thứ 2 để lấy các khoản thu, các thông tin câu hỏi bắt đầu từ cột 2 
                    //loop all rows
                    //int cell = 6;
                    for (int i = 3; i <= worksheet.Dimension.End.Row; i++)
                    {
                        if (worksheet.Cells[i, 2].Value + "" != "")
                        {
                            //Nếu đọc cột part mà dữ liệu trống thì được hiểu là đã đọc cuối danh sách, kết thúc việc đọc
                            tbTracNghiem_Question p = new tbTracNghiem_Question();
                            p.question_content = worksheet.Cells[i, 2].Value + "";
                            p.question_createdate = DateTime.Today;
                            p.question_type = "Trắc nghiệm";
                            p.username_id = id_user;
                            p.chapter_id = Convert.ToInt32(RouteData.Values["chuong_id"]);
                            p.hidden = false;
                            p.question_dangcauhoi = worksheet.Cells[i, 3].Value + "";
                            p.question_level = worksheet.Cells[i, 4].Value + "";
                            p.question_giaithich = worksheet.Cells[i, 5].Value + "";
                            p.lesson_id = Convert.ToInt32(RouteData.Values["baihoc_id"]);
                            p.question_dacta = "0";
                            p.diemtichluy = 1;
                            db.tbTracNghiem_Questions.InsertOnSubmit(p);
                            db.SubmitChanges();
                            tbTracNghiem_Answer a = new tbTracNghiem_Answer();
                            a.answer_content = worksheet.Cells[i, 6].Value + "";
                            a.question_id = p.question_id;
                            if (worksheet.Cells[i, 10].Value.ToString().Trim().ToUpper() == "A")
                                a.answer_true = true;
                            else
                                a.answer_true = false;
                            db.tbTracNghiem_Answers.InsertOnSubmit(a);
                            db.SubmitChanges();
                            tbTracNghiem_Answer b = new tbTracNghiem_Answer();
                            b.answer_content = worksheet.Cells[i, 7].Value + "";
                            b.question_id = p.question_id;
                            if (worksheet.Cells[i, 10].Value.ToString().Trim().ToUpper() == "B")
                                b.answer_true = true;
                            else
                                b.answer_true = false;
                            db.tbTracNghiem_Answers.InsertOnSubmit(b);
                            db.SubmitChanges();
                            tbTracNghiem_Answer c = new tbTracNghiem_Answer();
                            c.answer_content = worksheet.Cells[i, 8].Value + "";
                            c.question_id = p.question_id;
                            if (worksheet.Cells[i, 10].Value.ToString().Trim().ToUpper() == "C")
                                c.answer_true = true;
                            else
                                c.answer_true = false;
                            db.tbTracNghiem_Answers.InsertOnSubmit(c);
                            db.SubmitChanges();
                            tbTracNghiem_Answer d = new tbTracNghiem_Answer();
                            d.answer_content = worksheet.Cells[i, 9].Value + "";
                            d.question_id = p.question_id;
                            if (worksheet.Cells[i, 10].Value.ToString().Trim().ToUpper() == "D")
                                d.answer_true = true;
                            else
                                d.answer_true = false;
                            db.tbTracNghiem_Answers.InsertOnSubmit(d);
                            db.SubmitChanges();
                        }
                    }
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Nhập thành công!','','success').then(function(){grvList.Refresh();})", true);
                }
            }
            else
                alert.alert_Warning(Page, "File chọn không đúng định dạng!", "");
        }
        else
        {
            alert.alert_Error(Page, "Vui lòng chọn file", "");
        }
    }
    private void VaryQualityLevel(System.Drawing.Image img, string path)
    {
        using (Bitmap bmp1 = new Bitmap(img))
        {
            ImageCodecInfo jpgEncoder = GetEncoder(ImageFormat.Png);
            System.Drawing.Imaging.Encoder myEncoder = System.Drawing.Imaging.Encoder.Quality;
            EncoderParameters myEncoderParameters = new EncoderParameters(1);

            EncoderParameter myEncoderParameter = new EncoderParameter(myEncoder, 25L);
            myEncoderParameters.Param[0] = myEncoderParameter;
            bmp1.Save(path, jpgEncoder, myEncoderParameters);
        }
    }

    private ImageCodecInfo GetEncoder(ImageFormat format)
    {
        ImageCodecInfo[] codecs = ImageCodecInfo.GetImageDecoders();
        foreach (ImageCodecInfo codec in codecs)
        {
            if (codec.FormatID == format.Guid)
            {
                return codec;
            }
        }
        return null;
    }

    protected void edtContent_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
       {
           string base64Value = m.Groups["data"].Value;
           string tagStr = m.Value;
           return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
       }));
    }
    string CreateImageFromBase64(string base64String)
    {
        base64String = base64String.Split(new string[] { "base64," }, StringSplitOptions.RemoveEmptyEntries)[1];
        byte[] imageBytes = Convert.FromBase64String(base64String);
        using (MemoryStream ms = new MemoryStream(imageBytes, 0, imageBytes.Length))
        {
            ms.Write(imageBytes, 0, imageBytes.Length);
            using (System.Drawing.Image image = System.Drawing.Image.FromStream(ms, true))
            {
                string imagesFolderName = "editorimages";
                string imagesFolderServerPath = Server.MapPath(imagesFolderName);
                if (!Directory.Exists(imagesFolderServerPath))
                    Directory.CreateDirectory(imagesFolderServerPath);
                string imageServerPath = string.Format("~/{0}/{1}{2}", imagesFolderName, Guid.NewGuid(), GetFileExtension(image));
                image.Save(Server.MapPath(imageServerPath));
                return ResolveUrl(imageServerPath);
            }
        }
    }
    string GetFileExtension(System.Drawing.Image image)
    {
        ImageFormat format = image.RawFormat;
        string fileExtension = ".jpeg";
        if (ImageFormat.Bmp.Equals(format))
            fileExtension = ".bmp";
        else if (ImageFormat.Gif.Equals(format))
            fileExtension = ".gif";
        else if (ImageFormat.Png.Equals(format))
            fileExtension = ".png";
        return fileExtension;
    }

    protected void edtDapAnA_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtDapAnB_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtDapAnC_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtDapAnD_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtGiaiThich_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }
}