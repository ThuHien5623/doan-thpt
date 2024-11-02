using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_BaiLuyenTap_ChiTiet : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    public int STT = 1;
    public int STT1 = 1;
    int question_id;
    public int user_id;
    cls_Alert alert = new cls_Alert();
    int id_test;
    protected void Page_Load(object sender, EventArgs e)
    {
        var checkTaiKhoan = (from u in db.admin_Users
                             where u.username_username == Request.Cookies["UserName"].Value
                             select u).FirstOrDefault();
        user_id = checkTaiKhoan.username_id;
        id_test = Convert.ToInt32(RouteData.Values["id_test"]);
        //kiểm tra xem user nào đang truy cập
        if (!IsPostBack)
        {
            divThayThe.Visible = false;
        }
        var getDataDetails = from td in db.tbTracNghiem_TestDetails
                             join q in db.tbTracNghiem_Questions on td.question_id equals q.question_id
                             where td.test_id == id_test
                             select new
                             {
                                 td.question_id,
                                 q.question_dangcauhoi,
                                 q.question_type,
                                 noidungcauhoi = q.question_content.Contains("style=") ?
                                 "<div class='content_image'>" + q.question_content + "</div>"
                                 : q.question_content.Contains("jpg") ?
                                 "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" :
                                 q.question_content.Contains("png") ?
                                 "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" :
                                 q.question_content.Contains("mp3") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content,
                             };
        rpCauHoi.DataSource = getDataDetails;
        rpCauHoi.DataBind();

    }

    protected void rpCauHoiDetals_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Random rnd = new Random();
        int seed = rnd.Next();
        Repeater rpCauTraLoi = e.Item.FindControl("rpCauTraLoi") as Repeater;
        question_id = int.Parse(DataBinder.Eval(e.Item.DataItem, "question_id").ToString());
        var getDataCauTraLoi = from t in db.tbTracNghiem_Answers
                               where t.question_id == question_id
                               select new
                               {
                                   t.answer_id,
                                   t.answer_content,
                                   t.answer_true,
                                   t.question_id
                               };
        List<Dapan> dapan = new List<Dapan>();
        int index = 1;
        foreach (var item in getDataCauTraLoi)
        {
            dapan.Add(new Dapan()
            {
                answer_content = item.answer_content,
                name_label = index == 1 ? "A" : index == 2 ? "B" : index == 3 ? "C" : "D",
            });
            index++;
        };
        rpCauTraLoi.DataSource = dapan;
        rpCauTraLoi.DataBind();
    }
    public class Dapan
    {
        public string answer_content { get; set; }
        public string name_label { get; set; }
    }
    protected void ddlChuong_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlChuong.SelectedValue != "Chọn chương")
        {
            var getTest = (from t in db.tbTracNghiem_Tests
                           where t.test_id == id_test
                           select t).FirstOrDefault();
            var listQues = from q in db.tbTracNghiem_Questions
                           join l in db.tbTracNghiem_Lessons on q.lesson_id equals l.lesson_id
                           where l.khoi_id == getTest.khoi_id
                           && l.monhoc_id == getTest.monhoc_id
                           && l.chapter_id == Convert.ToInt32(ddlChuong.SelectedValue)
                              && q.question_type == txtType.Value
                           && q.question_dangcauhoi == txtDang.Value
                           && !db.tbTracNghiem_TestDetails.Any(x => (x.test_id == id_test))

                           select new
                           {
                               q.lesson_id,
                               q.question_id,
                               noidungcauhoi = q.question_content.Contains("style=") ? "<div class='content_image'>" + q.question_content + "</div>" : q.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("mp3") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content,
                           };
            rpThayThe.DataSource = listQues;
            rpThayThe.DataBind();
            var listLes = from l in db.tbTracNghiem_Lessons
                          where l.chapter_id == Convert.ToInt32(ddlChuong.SelectedValue)
                          select l;
            ddlBai.Items.Clear();
            ddlBai.AppendDataBoundItems = true;
            ddlBai.Items.Insert(0, "Chọn bài");
            ddlBai.DataValueField = "lesson_id";
            ddlBai.DataTextField = "lesson_name";
            ddlBai.DataSource = listLes;
            ddlBai.DataBind();
            divThayThe.Visible = true;
            if (txtCauHoiThayDoi.Value != "")
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setActiveCauHoi('" + txtCauHoiThayDoi.Value + "')", true);
        }
        else
        {
            ddlBai.Items.Clear();
            divThayThe.Visible = false;
        }
    }

    protected void ddlBai_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlBai.SelectedValue != "Chọn bài")
        {
            var getTest = (from t in db.tbTracNghiem_Tests
                           where t.test_id == id_test
                           select t).FirstOrDefault();
            var listQues = from q in db.tbTracNghiem_Questions
                           join l in db.tbTracNghiem_Lessons on q.lesson_id equals l.lesson_id
                           where l.khoi_id == getTest.khoi_id
                           && l.monhoc_id == getTest.monhoc_id
                           && l.chapter_id == Convert.ToInt32(ddlChuong.SelectedValue)
                           && l.lesson_id == Convert.ToInt32(ddlBai.SelectedValue)
                            && q.question_type == txtType.Value
                               && q.question_dangcauhoi == txtDang.Value
                           select new
                           {
                               q.lesson_id,
                               q.question_id,
                               noidungcauhoi = q.question_content.Contains("style=") ? "<div class='content_image'>" + q.question_content + "</div>" : q.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("mp3") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content,
                           };
            rpThayThe.DataSource = listQues;
            rpThayThe.DataBind();
            divThayThe.Visible = true;
            if (txtCauHoiThayDoi.Value != "")
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setActiveCauHoi('" + txtCauHoiThayDoi.Value + "')", true);
        }
        else
        {
            divThayThe.Visible = false;
        }
    }

    protected void btnThayDoi_ServerClick(object sender, EventArgs e)
    {
        var user_test = (from u in db.tbTracNghiem_Tests
                         where u.test_id == Convert.ToInt32(id_test)
                         select u).FirstOrDefault();
        if (user_test.username_id != user_id)
        {
            alert.alert_Warning(Page, "Không thể chỉnh sửa bài luyện tập của giáo viên khác ", "");
        }
        else
        {
            var getTest = (from t in db.tbTracNghiem_Tests
                           where t.test_id == id_test
                           select t).FirstOrDefault();

            var listChuong = from ch in db.tbTracNghiem_Chapters
                             where ch.monhoc_id == getTest.monhoc_id
                             && ch.khoi_id == getTest.khoi_id
                             select ch;
            ddlChuong.Items.Clear();
            ddlBai.Items.Clear();
            ddlChuong.AppendDataBoundItems = true;
            ddlChuong.Items.Insert(0, "Chọn chương");
            ddlChuong.DataValueField = "chapter_id";
            ddlChuong.DataTextField = "chapter_name";
            ddlChuong.DataSource = listChuong;
            ddlChuong.DataBind();

            var listQues = from q in db.tbTracNghiem_Questions
                           join l in db.tbTracNghiem_Lessons on q.lesson_id equals l.lesson_id
                           where l.khoi_id == getTest.khoi_id
                           && l.monhoc_id == getTest.monhoc_id
                           //  && l.chapter_id == Convert.ToInt32(ddlChuong.SelectedValue)
                           // && l.lesson_id == Convert.ToInt32(ddlBai.SelectedValue)
                           && q.question_type == txtType.Value
                           && q.question_dangcauhoi == txtDang.Value
                           select new
                           {
                               q.lesson_id,
                               q.question_id,
                               noidungcauhoi = q.question_content.Contains("style=") ? "<div class='content_image'>" + q.question_content + "</div>" : q.question_content.Contains("jpg") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("png") ? "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" : q.question_content.Contains("mp3") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content,
                           };
            rpThayThe.DataSource = listQues;
            rpThayThe.DataBind();
            divThayThe.Visible = true;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "setActiveCauHoi('" + txtCauHoiThayDoi.Value + "')", true);
        }
    }

    protected void btnLuaChon_ServerClick(object sender, EventArgs e)
    {
        //try
        //{
        tbTracNghiem_TestDetail updateDE = (from t in db.tbTracNghiem_TestDetails
                                            where t.test_id == id_test
                                            && t.question_id == Convert.ToInt32(txtID.Value)
                                            select t).First();
        updateDE.question_id = Convert.ToInt32(txtIDnew.Value);
        db.SubmitChanges();
       
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Alert", "swal('Cập nhật thành công!','','success')", true);
        var getDataDetails = from td in db.tbTracNghiem_TestDetails
                             join q in db.tbTracNghiem_Questions on td.question_id equals q.question_id
                             where td.test_id == id_test
                             select new
                             {
                                 td.question_id,
                                 q.question_dangcauhoi,
                                 q.question_type,
                                 noidungcauhoi = q.question_content.Contains("style=") ?
                                 "<div class='content_image'>" + q.question_content + "</div>"
                                 : q.question_content.Contains("jpg") ?
                                 "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" :
                                 q.question_content.Contains("png") ?
                                 "<img class='tracnghiem-answer__image' src='" + q.question_content + "'>" :
                                 q.question_content.Contains("mp3") ? " <audio controls> <source src = '" + q.question_content + "'> </audio>" : q.question_content,
                             };
        rpCauHoi.DataSource = getDataDetails;
        rpCauHoi.DataBind();
        //}
        //catch
        //{
        //    alert.alert_Error(Page, "Lỗi", "");
        //}
    }

    protected void btnCapNhat_ServerClick(object sender, EventArgs e)
    {
        var getMatran = (from mt in db.tbTracNghiem_MaTranChiTiets
                         where mt.test_id == id_test
                         select mt);
        var diem_TLNB = getMatran.Where(x => x.matranchitiet_name == "TLNB").FirstOrDefault().matranchitiet_diemchitiet;
        var diem_TLTH = getMatran.Where(x => x.matranchitiet_name == "TLTH").FirstOrDefault().matranchitiet_diemchitiet;
        var diem_TLVD = getMatran.Where(x => x.matranchitiet_name == "TLVD").FirstOrDefault().matranchitiet_diemchitiet;
        var diem_TLVDC = getMatran.Where(x => x.matranchitiet_name == "TLVDC").FirstOrDefault().matranchitiet_diemchitiet;
        var diem_TN = getMatran.Where(x => x.matranchitiet_name == "TNNB").FirstOrDefault().matranchitiet_diemchitiet;

        //lấy chuỗi câu hỏi mới
        var listNewQues = from de in db.tbTracNghiem_TestDetails
                          join qu in db.tbTracNghiem_Questions on de.question_id equals qu.question_id
                          where de.test_id == id_test
                          select de;
        string chuoiCH = string.Join(",", listNewQues.Select(x => x.question_id)).ToString();
        //lấy chuỗi bài mới
        var listNewLes = from de in db.tbTracNghiem_TestDetails
                         join qu in db.tbTracNghiem_Questions on de.question_id equals qu.question_id
                         where de.test_id == id_test
                         group qu by qu.lesson_id into g
                         select new
                         {
                             lesson_id = g.Key,
                         };
        string chuoiLes = string.Join(",", listNewLes.Select(x => x.lesson_id)).ToString();
        //cập nhật chuỗi câu hỏi mới vào bảng tbTracNghiem_Test
        tbTracNghiem_Test updateTE = (from t in db.tbTracNghiem_Tests
                                      where t.test_id == id_test
                                      select t).First();
        updateTE.question_id = chuoiCH;
        db.SubmitChanges();
        //Xóa dự liệu cũ của bảng tbTracNghiem_MaTranChiTiets có test_id = id cũ
        var delete = (from mt in db.tbTracNghiem_MaTranChiTiets
                      where mt.test_id == id_test
                      select mt);
        db.tbTracNghiem_MaTranChiTiets.DeleteAllOnSubmit(delete);
        db.SubmitChanges();

        //insert lại vào bảng tbTracNghiem_MaTranChiTiets
        var getCauHoi = from qe in db.tbTracNghiem_Questions
                        select qe;
        int countTN_NB = 0;
        int countTN_TH = 0;
        int countTN_VD = 0;
        int countTN_VDC = 0;
        int countTL_NB = 0;
        int countTL_TH = 0;
        int countTL_VD = 0;
        int countTL_VDC = 0;

        string[] arrCauHoi = chuoiCH.Split(',');
        string[] arrBai = chuoiLes.Split(',');
        foreach (string bai in arrBai)
        {
            foreach (var item in arrCauHoi)
            {
                int _TNNB = getCauHoi.Where(x => x.lesson_id == Convert.ToInt32(bai)
                && x.question_id == Convert.ToInt32(item)
                && x.question_dangcauhoi == "Nhận biết"
                && x.question_type == "Trắc nghiệm").Count();
                if (_TNNB == 1)
                {
                    countTN_NB = countTN_NB + 1;
                    arrCauHoi = arrCauHoi.Where(val => val != item).ToArray();
                }
                else
                {
                    int _TNTH = getCauHoi.Where(x => x.lesson_id == Convert.ToInt32(bai)
               && x.question_id == Convert.ToInt32(item)
               && x.question_dangcauhoi == "Thông hiểu"
               && x.question_type == "Trắc nghiệm").Count();
                    if (_TNTH == 1)
                    {
                        arrCauHoi = arrCauHoi.Where(val => val != item).ToArray();
                        countTN_TH = countTN_TH + 1;
                    }
                    else
                    {
                        int _TNVD = getCauHoi.Where(x => x.lesson_id == Convert.ToInt32(bai)
                    && x.question_id == Convert.ToInt32(item)
                    && x.question_dangcauhoi == "Vận dụng"
                    && x.question_type == "Trắc nghiệm").Count();
                        if (_TNVD == 1)
                        {
                            arrCauHoi = arrCauHoi.Where(val => val != item).ToArray();
                            countTN_VD = countTN_VD + 1;
                        }
                        else
                        {
                            int _TNVDC = getCauHoi.Where(x => x.lesson_id == Convert.ToInt32(bai)
                        && x.question_id == Convert.ToInt32(item)
                        && x.question_dangcauhoi == "Vận dụng cao"
                        && x.question_type == "Trắc nghiệm").Count();
                            if (_TNVDC == 1)
                            {
                                arrCauHoi = arrCauHoi.Where(val => val != item).ToArray();
                                countTN_VDC = countTN_VDC + 1;
                            }
                            else
                            {
                                int _TLNB = getCauHoi.Where(x => x.lesson_id == Convert.ToInt32(bai)
                            && x.question_id == Convert.ToInt32(item)
                            && x.question_dangcauhoi == "Nhận biết"
                            && x.question_type == "Tự luận").Count();
                                if (_TLNB == 1)
                                {
                                    arrCauHoi = arrCauHoi.Where(val => val != item).ToArray();
                                    countTL_NB = countTL_NB + 1;
                                }
                                else
                                {
                                    int _TLTH = getCauHoi.Where(x => x.lesson_id == Convert.ToInt32(bai)
                                && x.question_id == Convert.ToInt32(item)
                                && x.question_dangcauhoi == "Thông hiểu"
                                && x.question_type == "Tự luận").Count();
                                    if (_TLTH == 1)
                                    {
                                        arrCauHoi = arrCauHoi.Where(val => val != item).ToArray();
                                        countTL_TH = countTL_TH + 1;
                                    }
                                    else
                                    {
                                        int _TLVD = getCauHoi.Where(x => x.lesson_id == Convert.ToInt32(bai)
                                    && x.question_id == Convert.ToInt32(item)
                                    && x.question_dangcauhoi == "Vận dụng"
                                    && x.question_type == "Tự luận").Count();
                                        if (_TLVD == 1)
                                        {
                                            arrCauHoi = arrCauHoi.Where(val => val != item).ToArray();
                                            countTL_VD = countTL_VD + 1;
                                        }
                                        else
                                        {
                                            int _TLVDC = getCauHoi.Where(x => x.lesson_id == Convert.ToInt32(bai)
                                        && x.question_id == Convert.ToInt32(item)
                                        && x.question_dangcauhoi == "Vận dụng cao"
                                        && x.question_type == "Tự luận").Count();
                                            if (_TLVDC == 1)
                                            {
                                                arrCauHoi = arrCauHoi.Where(val => val != item).ToArray();
                                                countTL_VDC = countTL_VDC + 1;
                                            }
                                            else
                                            {
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            }
            // dòng 1
            tbTracNghiem_MaTranChiTiet add_TNNB = new tbTracNghiem_MaTranChiTiet();
            add_TNNB.matranchitiet_name = "TNNB";
            add_TNNB.matranchitiet_socau = countTN_NB + "";
            add_TNNB.matranchitiet_diemchitiet = diem_TN;
            add_TNNB.matranchitiet_diem = (Convert.ToDouble(diem_TN, CultureInfo.InvariantCulture) * countTN_NB) + "";
            add_TNNB.matranchitiet_phantram = (Convert.ToDouble(diem_TN, CultureInfo.InvariantCulture) * countTN_NB) * 10 + "";
            add_TNNB.lession_id = Convert.ToInt32(bai);
            add_TNNB.test_id = id_test;
            db.tbTracNghiem_MaTranChiTiets.InsertOnSubmit(add_TNNB);

            // dòng 2
            tbTracNghiem_MaTranChiTiet add_TLNB = new tbTracNghiem_MaTranChiTiet();
            add_TLNB.matranchitiet_name = "TLNB";
            add_TLNB.matranchitiet_socau = countTL_NB + "";
            add_TLNB.matranchitiet_diemchitiet = diem_TLNB;
            add_TLNB.matranchitiet_diem = (Convert.ToDouble(diem_TLNB, CultureInfo.InvariantCulture) * countTL_NB) + "";
            add_TLNB.matranchitiet_phantram = (Convert.ToDouble(diem_TLNB, CultureInfo.InvariantCulture) * countTL_NB) * 10 + "";
            add_TLNB.lession_id = Convert.ToInt32(bai);
            add_TLNB.test_id = id_test;
            db.tbTracNghiem_MaTranChiTiets.InsertOnSubmit(add_TLNB);

            // dòng 3
            tbTracNghiem_MaTranChiTiet add_TNTH = new tbTracNghiem_MaTranChiTiet();
            add_TNTH.matranchitiet_name = "TNTH";
            add_TNTH.matranchitiet_socau = countTN_TH + "";
            add_TNTH.matranchitiet_diemchitiet = diem_TN;
            add_TNTH.matranchitiet_diem = (Convert.ToDouble(diem_TN, CultureInfo.InvariantCulture) * countTN_TH) + "";
            add_TNTH.matranchitiet_phantram = (Convert.ToDouble(diem_TN, CultureInfo.InvariantCulture) * countTN_TH) * 10 + "";
            add_TNTH.lession_id = Convert.ToInt32(bai);
            add_TNTH.test_id = id_test;
            db.tbTracNghiem_MaTranChiTiets.InsertOnSubmit(add_TNTH);

            // dòng 4
            tbTracNghiem_MaTranChiTiet add_TLTH = new tbTracNghiem_MaTranChiTiet();
            add_TLTH.matranchitiet_name = "TLTH";
            add_TLTH.matranchitiet_socau = countTL_TH + "";
            add_TLTH.matranchitiet_diemchitiet = diem_TLTH;
            add_TLTH.matranchitiet_diem = (Convert.ToDouble(diem_TLTH, CultureInfo.InvariantCulture) * countTL_TH) + "";
            add_TLTH.matranchitiet_phantram = (Convert.ToDouble(diem_TLTH, CultureInfo.InvariantCulture) * countTL_TH) * 10 + "";
            add_TLTH.lession_id = Convert.ToInt32(bai);
            add_TLTH.test_id = id_test;
            db.tbTracNghiem_MaTranChiTiets.InsertOnSubmit(add_TLTH);

            //dòng 5
            tbTracNghiem_MaTranChiTiet add_TNVD = new tbTracNghiem_MaTranChiTiet();
            add_TNVD.matranchitiet_name = "TNVD";
            add_TNVD.matranchitiet_socau = countTN_VD + "";
            add_TNVD.matranchitiet_diemchitiet = diem_TN;
            add_TNVD.matranchitiet_diem = (Convert.ToDouble(diem_TN, CultureInfo.InvariantCulture) * countTN_VD) + "";
            add_TNVD.matranchitiet_phantram = (Convert.ToDouble(diem_TN, CultureInfo.InvariantCulture) * countTN_VD) * 10 + "";
            add_TNVD.lession_id = Convert.ToInt32(bai);
            add_TNVD.test_id = id_test;
            db.tbTracNghiem_MaTranChiTiets.InsertOnSubmit(add_TNVD);

            // dòng 6
            tbTracNghiem_MaTranChiTiet add_TLVD = new tbTracNghiem_MaTranChiTiet();
            add_TLVD.matranchitiet_name = "TLVD";
            add_TLVD.matranchitiet_socau = countTL_VD + "";
            add_TLVD.matranchitiet_diemchitiet = diem_TLVD;
            add_TLVD.matranchitiet_diem = (Convert.ToDouble(diem_TLVD, CultureInfo.InvariantCulture) * countTL_VD) + "";
            add_TLVD.matranchitiet_phantram = (Convert.ToDouble(diem_TLVD, CultureInfo.InvariantCulture) * countTL_VD) * 10 + "";
            add_TLVD.lession_id = Convert.ToInt32(bai);
            add_TLVD.test_id = id_test;
            db.tbTracNghiem_MaTranChiTiets.InsertOnSubmit(add_TLVD);
            // dòng 7
            tbTracNghiem_MaTranChiTiet add_TNVDC = new tbTracNghiem_MaTranChiTiet();
            add_TNVDC.matranchitiet_name = "TNVDC";
            add_TNVDC.matranchitiet_socau = countTN_VDC + "";
            add_TNVDC.matranchitiet_diemchitiet = diem_TN;
            add_TNVDC.matranchitiet_diem = (Convert.ToDouble(diem_TN, CultureInfo.InvariantCulture) * countTN_VDC) + "";
            add_TNVDC.matranchitiet_phantram = (Convert.ToDouble(diem_TN, CultureInfo.InvariantCulture) * countTN_VDC) * 10 + "";
            add_TNVDC.lession_id = Convert.ToInt32(bai);
            add_TNVDC.test_id = id_test;
            db.tbTracNghiem_MaTranChiTiets.InsertOnSubmit(add_TNVDC);

            //dòng 8
            tbTracNghiem_MaTranChiTiet add_TLVDC = new tbTracNghiem_MaTranChiTiet();
            add_TLVDC.matranchitiet_name = "TLVDC";
            add_TLVDC.matranchitiet_socau = countTL_VDC + "";
            add_TLVDC.matranchitiet_diemchitiet = diem_TLVDC;
            add_TLVDC.matranchitiet_diem = (Convert.ToDouble(diem_TLVDC, CultureInfo.InvariantCulture) * countTL_VDC) + "";
            add_TLVDC.matranchitiet_phantram = (Convert.ToDouble(diem_TLVDC, CultureInfo.InvariantCulture) * countTL_VDC) * 10 + "";
            add_TLVDC.lession_id = Convert.ToInt32(bai);
            add_TLVDC.test_id = id_test;
            db.tbTracNghiem_MaTranChiTiets.InsertOnSubmit(add_TLVDC);

            countTN_NB = 0;
            countTN_TH = 0;
            countTN_VD = 0;
            countTN_VDC = 0;
            countTL_NB = 0;
            countTL_TH = 0;
            countTL_VD = 0;
            countTL_VDC = 0;

        }
        db.SubmitChanges();
        alert.alert_Success(Page, "Cập nhật đề thành công!", "");

    }
}