using DevExpress.Web.ASPxHtmlEditor;
using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_page_module_function_module_TracNghiem_module_TaoDeKiemTra_CauTrucMoi : System.Web.UI.Page
{
    dbcsdlDataContext db = new dbcsdlDataContext();
    cls_Alert alert = new cls_Alert();
    public int user_id;
    private static int idTest, TongCauTracNghiemDaNhap = 0, TongCauDungSaiDaNhap = 0, TongCauTuLuanDaNhap = 0, maxCauTracNghiem = 0, maxDungSai = 0, maxTuLuan = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["UserName"] != null)
        {
            var checkTaiKhoan = (from u in db.admin_Users
                                 where u.username_username == Request.Cookies["UserName"].Value
                                 select u).FirstOrDefault();
            user_id = checkTaiKhoan.username_id;
            idTest = Convert.ToInt32(RouteData.Values["id"]);
            if (!IsPostBack)
            {
                edtContent.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDapAnA.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDapAnB.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDapAnC.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDapAnD.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtGiaiThich.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDungSaiNoiDung.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDungSaiCau1.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDungSaiCau2.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDungSaiCau3.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDungSaiCau4.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtDungSaiGiaiThich.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtTraLoiNganCauHoi.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());
                edtTraLoiNganGiaiThich.Toolbars.Add(HtmlEditorToolbar.CreateStandardToolbar1());

                var getkhoi = from ldt in db.tbKhois
                              join gvdk in db.tbGiaoVienDayKhois on ldt.khoi_id equals gvdk.khoi_id
                              where gvdk.username_id == checkTaiKhoan.username_id
                              select ldt;
                ddlKhoi.DataValueField = "khoi_id";
                ddlKhoi.DataTextField = "khoi_name";
                ddlKhoi.DataSource = getkhoi;
                ddlKhoi.DataBind();

                if (idTest != 0)
                {
                    //tính tổng số câu hỏi đã được nhập trước đó
                    var checkCauHoi = from ch in db.tbTracNghiem_Questions
                                      join bkt in db.tbTracNghiem_Tests on ch.baikiemtra_id equals bkt.test_id
                                      where bkt.test_id == idTest
                                      select ch;
                    TongCauTracNghiemDaNhap = checkCauHoi.Where(x => x.question_group == "part1").Count();
                    TongCauDungSaiDaNhap = checkCauHoi.Where(x => x.question_group == "part2").Count();
                    TongCauTuLuanDaNhap = checkCauHoi.Where(x => x.question_group == "part3").Count();
                    var getBKT = (from bkt in db.tbTracNghiem_Tests
                                  join blt in db.tbTracNghiem_BaiLuyenTaps on bkt.luyentap_id equals blt.luyentap_id
                                  where bkt.test_id == idTest
                                  select new
                                  {
                                      blt.luyentap_name,
                                      bkt.test_thoigianlambai,
                                      bkt.khoi_id,
                                      bkt.monhoc_id,
                                  }).SingleOrDefault();
                    txtTenBai.Value = getBKT.luyentap_name;
                    txtThoiGian.Value = Convert.ToInt32(getBKT.test_thoigianlambai) / 60 + "";
                    ddlKhoi.Items.FindByValue(getBKT.khoi_id + "").Selected = true;
                    if (ddlKhoi.SelectedValue != "")
                    {
                        var listMon = from gvdm in db.tbTKB_GiaoVienDayMon_Tests
                                      join m in db.tbTKB_Mons on gvdm.mon_id equals m.mon_id
                                      join l in db.tbLops on gvdm.lop_id equals l.lop_id
                                      where gvdm.username_id == user_id && gvdm.lop_id != null && l.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue)
                                      group gvdm by gvdm.mon_id into k
                                      select new
                                      {
                                          mon_id = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_id).FirstOrDefault(),
                                          mon_name = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_name).FirstOrDefault(),
                                      };
                        ddlMon.DataSource = listMon;
                        ddlMon.DataTextField = "mon_name";
                        ddlMon.DataValueField = "mon_id";
                        ddlMon.DataBind();

                    }
                    ddlMon.Items.FindByValue(getBKT.monhoc_id + "").Selected = true;
                    maxSoLuongCau();
                    txtMaxTracNghiem.Value = maxCauTracNghiem + "";
                    txtMaxDungSai.Value = maxDungSai + "";
                    txtMaxTuLuan.Value = maxTuLuan + "";
                }
                else
                {
                    TongCauTracNghiemDaNhap = 0; TongCauDungSaiDaNhap = 0; TongCauTuLuanDaNhap = 0;
                    if (ddlKhoi.SelectedValue != "")
                    {
                        var listMon = from gvdm in db.tbTKB_GiaoVienDayMon_Tests
                                      join m in db.tbTKB_Mons on gvdm.mon_id equals m.mon_id
                                      join l in db.tbLops on gvdm.lop_id equals l.lop_id
                                      where gvdm.username_id == user_id && gvdm.lop_id != null && l.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue)
                                      group gvdm by gvdm.mon_id into k
                                      select new
                                      {
                                          mon_id = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_id).FirstOrDefault(),
                                          mon_name = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_name).FirstOrDefault(),
                                      };
                        ddlMon.DataSource = listMon;
                        ddlMon.DataTextField = "mon_name";
                        ddlMon.DataValueField = "mon_id";
                        ddlMon.DataBind();
                        //maxSoLuongCau();
                        //txtMaxTracNghiem.Value = maxCauTracNghiem + "";
                        //txtMaxDungSai.Value = maxDungSai + "";
                        //txtMaxTuLuan.Value = maxTuLuan + "";
                    }
                }
                txtTongTracNghiemDaNhap.Value = TongCauTracNghiemDaNhap + "";
                txtTongDungSaiDaNhap.Value = TongCauDungSaiDaNhap + "";
                txtTongTuLuanDaNhap.Value = TongCauTuLuanDaNhap + "";

            }
        }
        else
        {
            Response.Redirect("/admin-login");
        }
        //getChuong();
    }
    protected void ddlKhoi_SelectedIndexChanged(object sender, EventArgs e)
    {
        var listMon = from gvdm in db.tbTKB_GiaoVienDayMon_Tests
                      join m in db.tbTKB_Mons on gvdm.mon_id equals m.mon_id
                      join l in db.tbLops on gvdm.lop_id equals l.lop_id
                      where gvdm.username_id == user_id && gvdm.lop_id != null && l.khoi_id == Convert.ToInt32(ddlKhoi.SelectedValue)
                      group gvdm by gvdm.mon_id into k
                      select new
                      {
                          mon_id = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_id).FirstOrDefault(),
                          mon_name = (from mh in db.tbTKB_Mons where mh.mon_id == k.Key select mh.mon_name).FirstOrDefault(),
                      };
        ddlMon.DataSource = listMon;
        ddlMon.DataTextField = "mon_name";
        ddlMon.DataValueField = "mon_id";
        ddlMon.DataBind();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "HiddenLoadingIcon()", true);
    }

    //tính max câu 
    private void maxSoLuongCau()
    {
        if (ddlMon.SelectedValue == "1") //môn toán
        {
            maxCauTracNghiem = 12;
            maxDungSai = 4;
            maxTuLuan = 6;
        }
        if (ddlMon.SelectedValue == "3" || ddlMon.SelectedValue == "4" || ddlMon.SelectedValue == "8" || ddlMon.SelectedValue == "52") //môn lý hóa sinh địa
        {
            maxCauTracNghiem = 18;
            maxDungSai = 4;
            maxTuLuan = 6;
        }
        if (ddlMon.SelectedValue == "7" || ddlMon.SelectedValue == "10") //môn sử gdcd
        {
            maxCauTracNghiem = 24;
            maxDungSai = 4;
            maxTuLuan = 0;
        }

    }

    protected void btnLuu_Click(object sender, EventArgs e)
    {
        int dem_DapAnChecked = 0;
        if (DaA.Checked == true)
            dem_DapAnChecked = 1;
        if (DaB.Checked == true)
            dem_DapAnChecked = dem_DapAnChecked + 1;
        if (DaC.Checked == true)
            dem_DapAnChecked = dem_DapAnChecked + 1;
        if (DaD.Checked == true)
            dem_DapAnChecked = dem_DapAnChecked + 1;
        if (edtContent.Html == "")
            alert.alert_Error(Page, "Bạn chưa nhập nội dung câu hỏi", "");
        else if (DaA.Checked == false && DaB.Checked == false && DaC.Checked == false && DaD.Checked == false)
            alert.alert_Error(Page, "Bạn cần chọn câu trả lời đúng", "");
        else if (edtDapAnA.Html == "" || edtDapAnB.Html == "")
            alert.alert_Error(Page, "Bạn cần nhập tối thiếu 2 nội dung đáp án theo thứ tự A,B,...", "");
        else if (dem_DapAnChecked > 1)
            alert.alert_Error(Page, "Bạn chỉ được chọn 1 đáp đúng", "");
        else
        {
            maxSoLuongCau();
            if (idTest == 0)
            {
                insertDataTracNghiem();
            }
            else
            {
                updateDataTracNghiem();
            }
        }
    }
    private void insertDataTracNghiem()
    {
        TongCauTracNghiemDaNhap = Convert.ToInt32(txtTongTracNghiemDaNhap.Value) + 1;
        txtTongTracNghiemDaNhap.Value = TongCauTracNghiemDaNhap + "";
        if (TongCauTracNghiemDaNhap > maxCauTracNghiem)
        {
            alert.alert_Error(Page, "Bạn đã nhập đủ câu hỏi cho phần này", "");
        }
        else if (TongCauTracNghiemDaNhap == 1)
        {
            //lưu 3 bảng: bài KT, question, answer // bài luyện tập, test, question, answer
            //tbTracNghiem_BaiKiemTra bkt = new tbTracNghiem_BaiKiemTra();
            //bkt.baikiemtra_name = txtTenBai.Value;
            //bkt.baikiemtra_thoigianlambai = txtThoiGian.Value;
            //bkt.baikiemtra_ngaytao = DateTime.Now;
            //bkt.username_id = user_id;
            //bkt.khoi_id = Convert.ToInt32(ddlKhoi.SelectedValue);
            //bkt.monhoc_id = Convert.ToInt32(ddlMon.SelectedValue);
            //bkt.hidden = false;
            //bkt.baikiemtra_tinhtrang = "Chưa hiển thị";
            //db.tbTracNghiem_BaiKiemTras.InsertOnSubmit(bkt);
            //db.SubmitChanges();

            //tbTracNghiem_BaiKiemTra_Question themcauhoi = new tbTracNghiem_BaiKiemTra_Question();
            //themcauhoi.question_content = edtContent.Html;
            //themcauhoi.question_createdate = DateTime.Now;
            //themcauhoi.question_giaithich = edtGiaiThich.Html;
            //themcauhoi.question_group = "part1";
            //themcauhoi.baikiemtra_id = bkt.baikiemtra_id;
            //themcauhoi.username_id = user_id;
            //themcauhoi.hidden = false;
            //db.tbTracNghiem_BaiKiemTra_Questions.InsertOnSubmit(themcauhoi);
            //db.SubmitChanges();
            ////lưu đáp án A
            //tbTracNghiem_BaiKiemTra_Answer dapanA = new tbTracNghiem_BaiKiemTra_Answer();
            //dapanA.answer_content = edtDapAnA.Html;
            //dapanA.question_id = themcauhoi.question_id;
            //if (DaA.Checked == true)
            //    dapanA.answer_true = true;
            //else
            //    dapanA.answer_true = false;
            //db.tbTracNghiem_BaiKiemTra_Answers.InsertOnSubmit(dapanA);
            //tbTracNghiem_BaiKiemTra_Answer dapanB = new tbTracNghiem_BaiKiemTra_Answer();
            //dapanB.answer_content = edtDapAnB.Html;
            //dapanB.question_id = themcauhoi.question_id;
            //if (DaB.Checked == true)
            //    dapanB.answer_true = true;
            //else
            //    dapanB.answer_true = false;
            //db.tbTracNghiem_BaiKiemTra_Answers.InsertOnSubmit(dapanB);
            //tbTracNghiem_BaiKiemTra_Answer dapanC = new tbTracNghiem_BaiKiemTra_Answer();
            //dapanC.answer_content = edtDapAnC.Html;
            //dapanC.question_id = themcauhoi.question_id;
            //if (DaC.Checked == true)
            //    dapanC.answer_true = true;
            //else
            //    dapanC.answer_true = false;
            //db.tbTracNghiem_BaiKiemTra_Answers.InsertOnSubmit(dapanC);
            //tbTracNghiem_BaiKiemTra_Answer dapanD = new tbTracNghiem_BaiKiemTra_Answer();
            //dapanD.answer_content = edtDapAnD.Html;
            //dapanD.question_id = themcauhoi.question_id;
            //if (DaD.Checked == true)
            //    dapanD.answer_true = true;
            //else
            //    dapanD.answer_true = false;
            //db.tbTracNghiem_BaiKiemTra_Answers.InsertOnSubmit(dapanD);
            //db.SubmitChanges();

            tbTracNghiem_BaiLuyenTap insert = new tbTracNghiem_BaiLuyenTap();
            insert.luyentap_name = txtTenBai.Value;
            insert.luyentap_status = 1; // tạo bài luyện tập luyentap_status =2, tạo bài thi luyentap_status = 1
            insert.username_id = user_id;
            insert.luyentap_baitaptuluan = "kiem tra kieu moi";
            db.tbTracNghiem_BaiLuyenTaps.InsertOnSubmit(insert);
            db.SubmitChanges();
            tbTracNghiem_Test test = new tbTracNghiem_Test();
            test.test_createdate = DateTime.Now;
            test.username_id = user_id;
            test.khoi_id = Convert.ToInt32(ddlKhoi.SelectedValue);
            test.monhoc_id = Convert.ToInt32(ddlMon.SelectedValue);
            test.luyentap_id = insert.luyentap_id;
            test.hidden = false;
            test.test_thoigianlambai = Convert.ToInt32(txtThoiGian.Value) * 60 + "";

            db.tbTracNghiem_Tests.InsertOnSubmit(test);
            db.SubmitChanges();
            test.test_link = "slldt-bai-kiem-tra-kieu-moi-chi-tiet-" + test.test_id;
            db.SubmitChanges();
            tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
            themcauhoi.question_content = edtContent.Html;
            themcauhoi.question_createdate = DateTime.Now;
            themcauhoi.question_giaithich = edtGiaiThich.Html;
            themcauhoi.question_group = "part1";
            themcauhoi.baikiemtra_id = test.test_id;
            themcauhoi.username_id = user_id;
            themcauhoi.hidden = false;
            themcauhoi.question_baikiemtra = "kiem tra";
            db.tbTracNghiem_Questions.InsertOnSubmit(themcauhoi);
            db.SubmitChanges();
            //lưu đáp án A
            tbTracNghiem_Answer dapanA = new tbTracNghiem_Answer();
            dapanA.answer_content = edtDapAnA.Html;
            dapanA.question_id = themcauhoi.question_id;
            if (DaA.Checked == true)
                dapanA.answer_true = true;
            else
                dapanA.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanA);
            tbTracNghiem_Answer dapanB = new tbTracNghiem_Answer();
            dapanB.answer_content = edtDapAnB.Html;
            dapanB.question_id = themcauhoi.question_id;
            if (DaB.Checked == true)
                dapanB.answer_true = true;
            else
                dapanB.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanB);
            tbTracNghiem_Answer dapanC = new tbTracNghiem_Answer();
            dapanC.answer_content = edtDapAnC.Html;
            dapanC.question_id = themcauhoi.question_id;
            if (DaC.Checked == true)
                dapanC.answer_true = true;
            else
                dapanC.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanC);
            tbTracNghiem_Answer dapanD = new tbTracNghiem_Answer();
            dapanD.answer_content = edtDapAnD.Html;
            dapanD.question_id = themcauhoi.question_id;
            if (DaD.Checked == true)
                dapanD.answer_true = true;
            else
                dapanD.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanD);
            db.SubmitChanges();
        }
        else
        {
            //nếu tổng câu đã nhập lớp hơn 1 thì chỉ cần lưu bảng câu hỏi và đáp án với id cuối cùng
            var checkBaiKiemTra = (from bkt in db.tbTracNghiem_Tests
                                   where bkt.username_id == user_id && bkt.hidden == false
                                   orderby bkt.test_id descending
                                   select bkt).First();
            tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
            themcauhoi.question_content = edtContent.Html;
            themcauhoi.question_createdate = DateTime.Now;
            themcauhoi.question_giaithich = edtGiaiThich.Html;
            themcauhoi.question_group = "part1";
            themcauhoi.baikiemtra_id = checkBaiKiemTra.test_id;
            themcauhoi.username_id = user_id;
            themcauhoi.hidden = false;
            themcauhoi.question_baikiemtra = "kiem tra";
            db.tbTracNghiem_Questions.InsertOnSubmit(themcauhoi);
            db.SubmitChanges();
            //lưu đáp án A
            tbTracNghiem_Answer dapanA = new tbTracNghiem_Answer();
            dapanA.answer_content = edtDapAnA.Html;
            dapanA.question_id = themcauhoi.question_id;
            if (DaA.Checked == true)
                dapanA.answer_true = true;
            else
                dapanA.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanA);
            tbTracNghiem_Answer dapanB = new tbTracNghiem_Answer();
            dapanB.answer_content = edtDapAnB.Html;
            dapanB.question_id = themcauhoi.question_id;
            if (DaB.Checked == true)
                dapanB.answer_true = true;
            else
                dapanB.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanB);
            tbTracNghiem_Answer dapanC = new tbTracNghiem_Answer();
            dapanC.answer_content = edtDapAnC.Html;
            dapanC.question_id = themcauhoi.question_id;
            if (DaC.Checked == true)
                dapanC.answer_true = true;
            else
                dapanC.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanC);
            tbTracNghiem_Answer dapanD = new tbTracNghiem_Answer();
            dapanD.answer_content = edtDapAnD.Html;
            dapanD.question_id = themcauhoi.question_id;
            if (DaD.Checked == true)
                dapanD.answer_true = true;
            else
                dapanD.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanD);
            db.SubmitChanges();
        }
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "chooseForm('tracnghiem');HiddenLoadingIcon();", true);
        setFormNull();
    }
    private void updateDataTracNghiem()
    {
        TongCauTracNghiemDaNhap = Convert.ToInt32(txtTongTracNghiemDaNhap.Value) + 1;
        txtTongTracNghiemDaNhap.Value = TongCauTracNghiemDaNhap + "";
        if (TongCauTracNghiemDaNhap > maxCauTracNghiem)
        {
            alert.alert_Error(Page, "Bạn đã nhập đủ câu hỏi cho phần này", "");
        }
        else
        {
            //nếu tổng câu đã nhập lớp hơn 1 thì chỉ cần lưu bảng câu hỏi và đáp án với id cuối cùng
            var checkBaiKiemTra = (from bkt in db.tbTracNghiem_Tests
                                   where bkt.test_id == idTest
                                   orderby bkt.test_id descending
                                   select bkt).First();
            tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
            themcauhoi.question_content = edtContent.Html;
            themcauhoi.question_createdate = DateTime.Now;
            themcauhoi.question_giaithich = edtGiaiThich.Html;
            themcauhoi.question_group = "part1";
            themcauhoi.baikiemtra_id = checkBaiKiemTra.test_id;
            themcauhoi.username_id = user_id;
            themcauhoi.hidden = false;
            themcauhoi.question_baikiemtra = "kiem tra";
            db.tbTracNghiem_Questions.InsertOnSubmit(themcauhoi);
            db.SubmitChanges();
            //lưu đáp án A
            tbTracNghiem_Answer dapanA = new tbTracNghiem_Answer();
            dapanA.answer_content = edtDapAnA.Html;
            dapanA.question_id = themcauhoi.question_id;
            if (DaA.Checked == true)
                dapanA.answer_true = true;
            else
                dapanA.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanA);
            tbTracNghiem_Answer dapanB = new tbTracNghiem_Answer();
            dapanB.answer_content = edtDapAnB.Html;
            dapanB.question_id = themcauhoi.question_id;
            if (DaB.Checked == true)
                dapanB.answer_true = true;
            else
                dapanB.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanB);
            tbTracNghiem_Answer dapanC = new tbTracNghiem_Answer();
            dapanC.answer_content = edtDapAnC.Html;
            dapanC.question_id = themcauhoi.question_id;
            if (DaC.Checked == true)
                dapanC.answer_true = true;
            else
                dapanC.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanC);
            tbTracNghiem_Answer dapanD = new tbTracNghiem_Answer();
            dapanD.answer_content = edtDapAnD.Html;
            dapanD.question_id = themcauhoi.question_id;
            if (DaD.Checked == true)
                dapanD.answer_true = true;
            else
                dapanD.answer_true = false;
            db.tbTracNghiem_Answers.InsertOnSubmit(dapanD);
            db.SubmitChanges();
        }
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "chooseForm('tracnghiem');HiddenLoadingIcon();", true);
        setFormNull();
    }
    protected void btnLuuDungSai_Click(object sender, EventArgs e)
    {
        if (edtDungSaiNoiDung.Html == "")
        {
            alert.alert_Error(Page, "Bạn chưa nhập nội dung câu hỏi", "");
        }
        else if (edtDungSaiCau1.Html == "" || edtDungSaiCau2.Html == "" || edtDungSaiCau3.Html == "" || edtDungSaiCau4.Html == "")
        {
            alert.alert_Error(Page, "Vui lòng nhập đủ 4 câu hỏi", "");
        }
        else
        {
            maxSoLuongCau();
            if (idTest == 0)
            {
                insertDataDungSai();
            }
            else
            {
                updateDataDungSai();
            }
        }
    }
    private void insertDataDungSai()
    {
        TongCauDungSaiDaNhap = Convert.ToInt32(txtTongDungSaiDaNhap.Value) + 1;
        txtTongDungSaiDaNhap.Value = TongCauDungSaiDaNhap + "";
        if (TongCauDungSaiDaNhap > maxDungSai)
        {
            alert.alert_Error(Page, "Bạn đã nhập đủ câu hỏi cho phần này", "");
        }
        else
        {
            //nếu tổng câu đã nhập lớp hơn 1 thì chỉ cần lưu bảng câu hỏi và đáp án với id cuối cùng
            var checkBaiKiemTra = (from bkt in db.tbTracNghiem_Tests
                                   join blt in db.tbTracNghiem_BaiLuyenTaps on bkt.luyentap_id equals blt.luyentap_id
                                   where  blt.luyentap_status == 1
                                   orderby bkt.test_id descending
                                   select bkt);
            if (checkBaiKiemTra.Count() <=0)
            {
                alert.alert_Warning(Page, "Vui lòng nhập phần trắc nghiệm 4 đáp án trước!", "");
            }
            else
            {
                tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
                themcauhoi.question_content = edtDungSaiNoiDung.Html;
                themcauhoi.question_createdate = DateTime.Now;
                themcauhoi.question_giaithich = edtDungSaiGiaiThich.Html;
                themcauhoi.question_group = "part2";
                themcauhoi.baikiemtra_id = checkBaiKiemTra.First().test_id;
                themcauhoi.username_id = user_id;
                themcauhoi.hidden = false;
                themcauhoi.question_baikiemtra = "kiem tra";
                db.tbTracNghiem_Questions.InsertOnSubmit(themcauhoi);
                db.SubmitChanges();
                //lưu đáp án A
                tbTracNghiem_Answer dapanA = new tbTracNghiem_Answer();
                dapanA.answer_content = edtDungSaiCau1.Html;
                dapanA.question_id = themcauhoi.question_id;
                if (rdDung1.Checked == true)
                    dapanA.answer_true = true;
                else
                    dapanA.answer_true = false;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanA);
                tbTracNghiem_Answer dapanB = new tbTracNghiem_Answer();
                dapanB.answer_content = edtDungSaiCau2.Html;
                dapanB.question_id = themcauhoi.question_id;
                if (rdDung2.Checked == true)
                    dapanB.answer_true = true;
                else
                    dapanB.answer_true = false;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanB);
                tbTracNghiem_Answer dapanC = new tbTracNghiem_Answer();
                dapanC.answer_content = edtDungSaiCau3.Html;
                dapanC.question_id = themcauhoi.question_id;
                if (rdDung3.Checked == true)
                    dapanC.answer_true = true;
                else
                    dapanC.answer_true = false;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanC);
                tbTracNghiem_Answer dapanD = new tbTracNghiem_Answer();
                dapanD.answer_content = edtDungSaiCau4.Html;
                dapanD.question_id = themcauhoi.question_id;
                if (rdDung4.Checked == true)
                    dapanD.answer_true = true;
                else
                    dapanD.answer_true = false;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanD);
                db.SubmitChanges();

                //alert.alert_Success(Page, "Lưu thành công", "");
            }
        }
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "chooseForm('dungsai');HiddenLoadingIcon();", true);
        setFormNull();
    }
    private void updateDataDungSai()
    {
        TongCauDungSaiDaNhap = Convert.ToInt32(txtTongDungSaiDaNhap.Value) + 1;
        txtTongDungSaiDaNhap.Value = TongCauDungSaiDaNhap + "";
        if (TongCauDungSaiDaNhap > maxDungSai)
        {
            alert.alert_Error(Page, "Bạn đã nhập đủ câu hỏi cho phần này", "");
        }
        else
        {
            //nếu tổng câu đã nhập lớp hơn 1 thì chỉ cần lưu bảng câu hỏi và đáp án với id cuối cùng
            var checkBaiKiemTra = (from bkt in db.tbTracNghiem_Tests
                                   join blt in db.tbTracNghiem_BaiLuyenTaps on bkt.luyentap_id equals blt.luyentap_id
                                   where bkt.test_id == idTest && blt.luyentap_status == 1
                                   orderby bkt.test_id descending
                                   select bkt);
            if (checkBaiKiemTra.Count()<=0)
            {
                alert.alert_Warning(Page, "Vui lòng nhập phần trắc nghiệm 4 đáp án trước!", "");
            }
            else
            {
                tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
                themcauhoi.question_content = edtDungSaiNoiDung.Html;
                themcauhoi.question_createdate = DateTime.Now;
                themcauhoi.question_giaithich = edtDungSaiGiaiThich.Html;
                themcauhoi.question_group = "part2";
                themcauhoi.baikiemtra_id = checkBaiKiemTra.First().test_id;
                themcauhoi.username_id = user_id;
                themcauhoi.hidden = false;
                themcauhoi.question_baikiemtra = "kiem tra";
                db.tbTracNghiem_Questions.InsertOnSubmit(themcauhoi);
                db.SubmitChanges();
                //lưu đáp án A
                tbTracNghiem_Answer dapanA = new tbTracNghiem_Answer();
                dapanA.answer_content = edtDungSaiCau1.Html;
                dapanA.question_id = themcauhoi.question_id;
                if (rdDung1.Checked == true)
                    dapanA.answer_true = true;
                else
                    dapanA.answer_true = false;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanA);
                tbTracNghiem_Answer dapanB = new tbTracNghiem_Answer();
                dapanB.answer_content = edtDungSaiCau2.Html;
                dapanB.question_id = themcauhoi.question_id;
                if (rdDung2.Checked == true)
                    dapanB.answer_true = true;
                else
                    dapanB.answer_true = false;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanB);
                tbTracNghiem_Answer dapanC = new tbTracNghiem_Answer();
                dapanC.answer_content = edtDungSaiCau3.Html;
                dapanC.question_id = themcauhoi.question_id;
                if (rdDung3.Checked == true)
                    dapanC.answer_true = true;
                else
                    dapanC.answer_true = false;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanC);
                tbTracNghiem_Answer dapanD = new tbTracNghiem_Answer();
                dapanD.answer_content = edtDungSaiCau4.Html;
                dapanD.question_id = themcauhoi.question_id;
                if (rdDung4.Checked == true)
                    dapanD.answer_true = true;
                else
                    dapanD.answer_true = false;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanD);
                db.SubmitChanges();

                //alert.alert_Success(Page, "Lưu thành công", "");
            }
        }
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "chooseForm('dungsai');HiddenLoadingIcon();", true);
        setFormNull();
    }
    protected void btnLuuTraLoiNgan_Click(object sender, EventArgs e)
    {
        if (edtTraLoiNganCauHoi.Html == "")
        {
            alert.alert_Error(Page, "Bạn chưa nhập nội dung câu hỏi", "");
        }

        else if (txtDapAn.Value == "")
        {
            alert.alert_Error(Page, "Bạn chưa nhập đáp án", "");
        }
        else
        {
            maxSoLuongCau();
            if (idTest == 0)
            {
                insertDataTuLuan();
            }
            else
            {
                updateDataTuLuan();
            }
        }
    }
    private void insertDataTuLuan()
    {
        TongCauTuLuanDaNhap = Convert.ToInt32(txtTongTuLuanDaNhap.Value) + 1;
        txtTongTuLuanDaNhap.Value = TongCauTuLuanDaNhap + "";
        if (TongCauTuLuanDaNhap > maxTuLuan)
        {
            alert.alert_Error(Page, "Bạn đã nhập đủ câu hỏi cho phần này", "");
        }
        else
        {
            //nếu tổng câu đã nhập lớp hơn 1 thì chỉ cần lưu bảng câu hỏi và đáp án với id cuối cùng
            var checkBaiKiemTra = (from bkt in db.tbTracNghiem_Tests
                                   join blt in db.tbTracNghiem_BaiLuyenTaps on bkt.luyentap_id equals blt.luyentap_id
                                   where blt.luyentap_status == 1
                                   orderby bkt.test_id descending
                                   select bkt);
            if (checkBaiKiemTra.Count()<=0)
            {
                alert.alert_Warning(Page, "Vui lòng nhập phần trắc nghiệm 4 đáp án trước!", "");
            }
            else
            {
                tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
                themcauhoi.question_content = edtTraLoiNganCauHoi.Html;
                themcauhoi.question_createdate = DateTime.Now;
                themcauhoi.question_giaithich = edtTraLoiNganGiaiThich.Html;
                themcauhoi.question_group = "part3";
                themcauhoi.baikiemtra_id = checkBaiKiemTra.First().test_id;
                themcauhoi.username_id = user_id;
                themcauhoi.hidden = false;
                themcauhoi.question_baikiemtra = "kiem tra";
                db.tbTracNghiem_Questions.InsertOnSubmit(themcauhoi);
                db.SubmitChanges();
                //lưu đáp án A
                tbTracNghiem_Answer dapanA = new tbTracNghiem_Answer();
                dapanA.answer_content = txtDapAn.Value.Replace(" ", string.Empty);
                dapanA.question_id = themcauhoi.question_id;
                dapanA.answer_true = true;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanA);
                db.SubmitChanges();
                //alert.alert_Success(Page, "Lưu thành công", "");
            }
        }
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "chooseForm('traloingan');HiddenLoadingIcon();", true);
        setFormNull();
    }
    private void updateDataTuLuan()
    {
        TongCauTuLuanDaNhap = Convert.ToInt32(txtTongTuLuanDaNhap.Value) + 1;
        txtTongTuLuanDaNhap.Value = TongCauTuLuanDaNhap + "";
        if (TongCauTuLuanDaNhap > maxTuLuan)
        {
            alert.alert_Error(Page, "Bạn đã nhập đủ câu hỏi cho phần này", "");
        }
        else
        {
            //nếu tổng câu đã nhập lớp hơn 1 thì chỉ cần lưu bảng câu hỏi và đáp án với id cuối cùng
            var checkBaiKiemTra = (from bkt in db.tbTracNghiem_Tests
                                   join blt in db.tbTracNghiem_BaiLuyenTaps on bkt.luyentap_id equals blt.luyentap_id
                                   where bkt.test_id == idTest && blt.luyentap_status == 1
                                   orderby bkt.test_id descending
                                   select bkt);
            if (checkBaiKiemTra.Count() <= 0)
            {
                alert.alert_Warning(Page, "Vui lòng nhập phần trắc nghiệm 4 đáp án trước!", "");
            }
            else
            {
                tbTracNghiem_Question themcauhoi = new tbTracNghiem_Question();
                themcauhoi.question_content = edtTraLoiNganCauHoi.Html;
                themcauhoi.question_createdate = DateTime.Now;
                themcauhoi.question_giaithich = edtTraLoiNganGiaiThich.Html;
                themcauhoi.question_group = "part3";
                themcauhoi.baikiemtra_id = checkBaiKiemTra.First().test_id;
                themcauhoi.username_id = user_id;
                themcauhoi.hidden = false;
                themcauhoi.question_baikiemtra = "kiem tra";
                db.tbTracNghiem_Questions.InsertOnSubmit(themcauhoi);
                db.SubmitChanges();
                //lưu đáp án A
                tbTracNghiem_Answer dapanA = new tbTracNghiem_Answer();
                dapanA.answer_content = txtDapAn.Value.Replace(" ", string.Empty);
                dapanA.question_id = themcauhoi.question_id;
                dapanA.answer_true = true;
                db.tbTracNghiem_Answers.InsertOnSubmit(dapanA);
                db.SubmitChanges();
                //alert.alert_Success(Page, "Lưu thành công", "");
            }
        }
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "chooseForm('traloingan');HiddenLoadingIcon();", true);
        setFormNull();
    }
    private void setFormNull()
    {
        edtContent.Html = "";
        edtDapAnA.Html = "";
        edtDapAnB.Html = "";
        edtDapAnC.Html = "";
        edtDapAnD.Html = "";
        DaA.Checked = false;
        DaB.Checked = false;
        DaC.Checked = false;
        DaD.Checked = false;
        edtGiaiThich.Html = "";
        edtDungSaiNoiDung.Html = "";
        edtDungSaiCau1.Html = "";
        edtDungSaiCau2.Html = "";
        edtDungSaiCau3.Html = "";
        edtDungSaiCau4.Html = "";
        edtDungSaiGiaiThich.Html = "";
        edtTraLoiNganCauHoi.Html = "";
        edtTraLoiNganGiaiThich.Html = "";
        txtDapAn.Value = "";
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

    protected void edtDungSaiNoiDung_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtDungSaiCau1_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtDungSaiCau2_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtDungSaiCau3_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtDungSaiCau4_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtDungSaiGiaiThich_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtTraLoiNganCauHoi_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
    {
        Regex regex = new Regex("<img[^/]+src=[\"'](?<data>data:image/[^'\"]*)[\"'][^/]*/>");
        e.Html = regex.Replace(e.Html, new MatchEvaluator(m =>
        {
            string base64Value = m.Groups["data"].Value;
            string tagStr = m.Value;
            return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value));
        }));
    }

    protected void edtTraLoiNganGiaiThich_HtmlCorrecting(object sender, HtmlCorrectingEventArgs e)
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