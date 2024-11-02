<%@ Page Language="C#" AutoEventWireup="true" CodeFile="module_QuanLyCauHoiTracNghiem_Part2.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_QuanLyCauHoiTracNghiem" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v17.1" %>
<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxSpellChecker" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản trị Việt Nhật</title>
    <link rel="icon" type="image/x-icon" href="/images/logo_mamnon.png" />
    <link href="../../../css/admin-style-lan.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" />
    <!-- jQuery library -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/admin_js/sweetalert.min.js"></script>
</head>
<body>
    <style>
        .header-form {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            text-transform: uppercase;
            color: #215ae2;
        }

        .radio_text_type {
            margin-right: 3px;
            margin-left: 20px;
        }

        .question_radio {
            margin-top: 10px;
            font-size: 16px;
            display: -webkit-inline-box;
        }

        .title_h2 {
            font-size: 18px;
            margin-bottom: 0;
        }

        .title_h2_c {
            margin-top: 10px;
            font-size: 18px;
            margin-bottom: 0;
        }

        .title_them_question {
            text-align: center;
        }

        .tracnghiem-answer__image {
            max-width: 100%;
            height: 217px;
            width: auto;
            display: block;
            margin: 0 auto;
            margin-bottom: 21px;
            border-radius: 10px;
            border: 1px solid #ccc;
            box-shadow: 0 7px 10px rgba(0,0,0,0.3);
        }

        .note {
            font-size: 1.2rem;
            color: red;
        }

        .title_h2_c-active {
            color: red;
            font-size: 18px;
            font-weight: 500;
        }

        input type[checkbox] {
            height: 25px;
            width: 25px;
        }
    </style>
    <form id="form1" runat="server">
        <div class="loading" id="img-loading-icon" style="display: none">
            <div class="loading">Loading&#8230;</div>
        </div>
        <asp:ScriptManager ID="smScriptManager" runat="server"></asp:ScriptManager>
        <script>
            function btnChiTiet() {
                document.getElementById('<%=btnChiTiet.ClientID%>').click();
            }
            function setForm() {
                var a = document.querySelector('input[name="kieucauhoi"]:checked').value;
                document.getElementById("<%=txtKieuCauHoi.ClientID%>").value = a;
                if (a == 2) {
                    document.getElementById("dvnoidungcauhoi").style.display = "none";
                }
                else {
                    document.getElementById("dvnoidungcauhoi").style.display = "block";
                }
                console.log(a);
            }
            $(document).ready(function () {
                setForm();
                getquestion();
            });
            function getquestion() {
                var a = document.querySelector('input[name="loaicauhoi"]:checked').value;
                document.getElementById("<%=txtLoaiCauHoi.ClientID%>").value = a;
                console.log("getquestion:" + a);
            }
            function setCheckedDCH() {
                var value = document.getElementById("<%=txtKieuCauHoi.ClientID%>").value;
                $("input[name=kieucauhoi][value=" + value + "]").attr('checked', 'checked');
                console.log("kieucauhoi:" + value)
            }
            function setChecked() {
                var value = document.getElementById("<%=txtLoaiCauHoi.ClientID%>").value;
                $("input[name=loaicauhoi][value=" + value + "]").attr('checked', 'checked');
                console.log("Mức độ:" + value)
            }
            function confirmDel() {
                swal("Bạn có thực sự muốn xóa?",
                    "Nếu xóa, dữ liệu sẽ không thể khôi phục.",
                    "warning",
                    {
                        buttons: true,
                        dangerMode: true
                    }).then(function (value) {
                        if (value == true) {
                            var xoa = document.getElementById('<%=btnXoa.ClientID%>');
                            xoa.click();
                        }
                    });
            }
            function clickavatar1() {
                $("#up1 input[type=file]").click();
            }
            function showPreview1(input) {
                if (input.files && input.files[0]) {

                    var filerdr = new FileReader();
                    filerdr.onload = function (e) {

                        $('#imgPreview1').attr('src', e.target.result);
                    }
                    filerdr.readAsDataURL(input.files[0]);
                }
            }
            function showImg1_1(img) {
                $('#imgPreview1').attr('src', img);
                $('#imgPreview2').attr('src', img);
                $("input[type=checkbox]").css("display", "block");
            }
            function lockImg() {
                $('#imgPreview1').css("display", "none");
                $('#audio').css("display", "block");
            }
            function lockAudio() {
                $('#audio').css("display", "none");
                $('#imgPreview1').css("display", "block");
            }
            function lockDCH() {
                $('#DangCauHoi_').css("position", "absolute");
                $('#DangCauHoi_').css("top", "45%");
                $('#DangCauHoi_').css("left", "0");
            }
            function showIconLoading() {
                $('#img-loading-icon').show()
            }
            function hiddenIconLoading() {
                $('#img-loading-icon').hide()
            }
        </script>
        <div class="container-fluid">
            <div class="card">
                <div style="display: none">
                    <input type="text" id="txtKieuCauHoi" placeholder="txtKieuCauHoi" runat="server" />
                </div>
                <div class="content-headertl-out">
                    <span>TẠO CÂU HỎI TRẮC NGHIỆM</span>
                    <a href="/admin-quan-ly-module-trac-nghiem-version2" class="btn btn-primary  btn-sm">Quay lại</a>
                </div>
                <div class="row up-1 but-1">
                    <div class="col-6">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div class="col-sm-4 question_radio" id="DangCauHoi_" hidden="hidden">
                                    <label>Kiểu câu hỏi:</label>
                                    <input class="radio_text_type" type="radio" id="type1" name="kieucauhoi" value="1" onclick="setForm()" checked="checked" />Text + Image 
                                        <input class="radio_text_type" type="radio" id="type2" name="kieucauhoi" value="2" onclick="setForm()" />Video 
                                </div>
                                <div class="col-sm-4 question_radio" hidden="hidden">
                                    <%--                                        <h2 class="title_h2">Mức độ:</h2>
                                        <input class="radio_text_type" type="radio" id="21" name="loaicauhoi" value="Dễ" onclick="getquestion()" checked="checked" />Dễ
                                        <input class="radio_text_type" type="radio" id="22" name="loaicauhoi" value="Vừa" onclick="getquestion()" />Vừa 
                                        <input class="radio_text_type" type="radio" id="34" name="loaicauhoi" value="Khó" onclick="getquestion()" />Khó --%>
                                </div>
                                <div class="but-1">
                                    <label>Dạng câu hỏi:</label>
                                    <asp:DropDownList runat="server" CssClass="drlist col-2" ID="ddlLoaiCauHoi">
                                        <%--<asp:ListItem Text="Chọn dạng" Value="" Selected="True" Enabled="true" />--%>
                                        <asp:ListItem Text="Nhận biết" Value="Nhận biết" />
                                        <asp:ListItem Text="Thông hiểu" Value="Thông hiểu" />
                                        <asp:ListItem Text="Vận dụng" Value="Vận dụng" />
                                        <asp:ListItem Text="Vận dụng cao" Value="Vận dụng cao" />
                                    </asp:DropDownList>
                                </div>
                                <input hidden="hidden" type="text" value="" runat="server" id="txtLoaiCauHoi" placeholder="loại câu hỏi" />
                                <div class="row" hidden="hidden">
                                    <div class="col-sm-3">
                                        <div>
                                            <div class="colum-5 form-group">
                                                <div id="up1" class="">
                                                    <asp:FileUpload ID="FileUpload1" runat="server" onchange="showPreview1(this)" accept=".png,.jpg,.mp3" Style="display: none" />
                                                    <button type="button" class="btn-chang" onclick="clickavatar1()">
                                                        <img id="imgPreview1" src="/admin_images/up-img.png" style="max-width: 100%; height: 200px" />
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="dvnoidungcauhoi">
                                    <div class="content-headertl-out">
                                        <span>Nội dung câu hỏi</span>
                                    </div>
                                    <dx:ASPxHtmlEditor ID="edtContent" ClientInstanceName="edtContent" runat="server" Width="100%" Height="910px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd" OnHtmlCorrecting="edtContent_HtmlCorrecting">
                                        <SettingsHtmlEditing EnablePasteOptions="true" />
                                        <Settings AllowHtmlView="true" AllowContextMenu="Default" />
                                        <settingsimageupload uploadfolder="~/editorimages"></settingsimageupload>
                                        <Toolbars>
                                            <dx:HtmlEditorToolbar>
                                                <Items>
                                                    <dx:ToolbarFontSizeEdit>
                                                        <Items>
                                                            <dx:ToolbarListEditItem Value="1" Text="1 (8pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="2" Text="2 (10pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="3" Text="3 (12pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="4" Text="4 (14pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="5" Text="5 (18pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="6" Text="6 (24pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="7" Text="7 (36pt)"></dx:ToolbarListEditItem>
                                                        </Items>
                                                    </dx:ToolbarFontSizeEdit>
                                                    <dx:ToolbarBoldButton BeginGroup="True" />
                                                    <dx:ToolbarItalicButton />
                                                    <dx:ToolbarUnderlineButton />
                                                    <dx:ToolbarStrikethroughButton />
                                                    <dx:ToolbarJustifyLeftButton BeginGroup="True" />
                                                    <dx:ToolbarJustifyCenterButton />
                                                    <dx:ToolbarJustifyRightButton />
                                                    <dx:ToolbarJustifyFullButton />
                                                    <dx:ToolbarBackColorButton BeginGroup="True" />
                                                    <dx:ToolbarFontColorButton />
                                                </Items>
                                            </dx:HtmlEditorToolbar>
                                        </Toolbars>
                                    </dx:ASPxHtmlEditor>
                                    <%--<textarea runat="server" id="txtcontent" name="w3review" rows="2" class="form-control"></textarea>--%>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="col-6">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div class="col-sm-12 question_radio">
                                    <%-- <h2 class="title_h2 mr-2">Đặc tả:</h2>
                                <asp:DropDownList runat="server" ID="ddlDacTa">
                                </asp:DropDownList>--%>
                                </div>
                                <div class="">
                                    <div class="content-headertl-out">
                                        <span>Câu 1
                                            <asp:RadioButton Text="Đúng" runat="server" ID="rdDung1" GroupName="cau1" Checked="true" />
                                            <asp:RadioButton Text="Sai" runat="server" ID="rdSai1" GroupName="cau1" />
                                        </span>
                                    </div>
                                    <dx:ASPxHtmlEditor ID="edtDapAnA" ClientInstanceName="edtDapAnA" runat="server" Width="100%" Height="200px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd" OnHtmlCorrecting="edtDapAnA_HtmlCorrecting">
                                        <SettingsHtmlEditing EnablePasteOptions="true" />
                                        <Settings AllowHtmlView="true" AllowContextMenu="Default" />
                                        <settingsimageupload uploadfolder="~/editorimages"></settingsimageupload>
                                        <Toolbars>
                                            <dx:HtmlEditorToolbar>
                                                <Items>
                                                    <dx:ToolbarFontSizeEdit>
                                                        <Items>
                                                            <dx:ToolbarListEditItem Value="1" Text="1 (8pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="2" Text="2 (10pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="3" Text="3 (12pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="4" Text="4 (14pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="5" Text="5 (18pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="6" Text="6 (24pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="7" Text="7 (36pt)"></dx:ToolbarListEditItem>
                                                        </Items>
                                                    </dx:ToolbarFontSizeEdit>
                                                    <dx:ToolbarBoldButton BeginGroup="True" />
                                                    <dx:ToolbarItalicButton />
                                                    <dx:ToolbarUnderlineButton />
                                                    <dx:ToolbarStrikethroughButton />
                                                    <dx:ToolbarJustifyLeftButton BeginGroup="True" />
                                                    <dx:ToolbarJustifyCenterButton />
                                                    <dx:ToolbarJustifyRightButton />
                                                    <dx:ToolbarJustifyFullButton />
                                                    <dx:ToolbarBackColorButton BeginGroup="True" />
                                                    <dx:ToolbarFontColorButton />
                                                </Items>
                                            </dx:HtmlEditorToolbar>

                                        </Toolbars>
                                    </dx:ASPxHtmlEditor>
                                </div>
                                <div class="">
                                    <div class="content-headertl-out">
                                        <span>Câu 2
                                            <asp:RadioButton Text="Đúng" runat="server" ID="rdDung2" GroupName="cau1" Checked="true" />
                                            <asp:RadioButton Text="Sai" runat="server" ID="rdSai2" GroupName="cau1" />
                                        </span>
                                    </div>
                                    <dx:ASPxHtmlEditor ID="edtDapAnB" ClientInstanceName="edtDapAnB" runat="server" Width="100%" Height="200px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd" OnHtmlCorrecting="edtDapAnB_HtmlCorrecting">
                                        <SettingsHtmlEditing EnablePasteOptions="true" />
                                        <Settings AllowHtmlView="true" AllowContextMenu="Default" />
                                        <settingsimageupload uploadfolder="~/editorimages"></settingsimageupload>
                                        <Toolbars>
                                            <dx:HtmlEditorToolbar>
                                                <Items>
                                                    <dx:ToolbarFontSizeEdit>
                                                        <Items>
                                                            <dx:ToolbarListEditItem Value="1" Text="1 (8pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="2" Text="2 (10pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="3" Text="3 (12pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="4" Text="4 (14pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="5" Text="5 (18pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="6" Text="6 (24pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="7" Text="7 (36pt)"></dx:ToolbarListEditItem>
                                                        </Items>
                                                    </dx:ToolbarFontSizeEdit>
                                                    <dx:ToolbarBoldButton BeginGroup="True" />
                                                    <dx:ToolbarItalicButton />
                                                    <dx:ToolbarUnderlineButton />
                                                    <dx:ToolbarStrikethroughButton />
                                                    <dx:ToolbarJustifyLeftButton BeginGroup="True" />
                                                    <dx:ToolbarJustifyCenterButton />
                                                    <dx:ToolbarJustifyRightButton />
                                                    <dx:ToolbarJustifyFullButton />
                                                    <dx:ToolbarBackColorButton BeginGroup="True" />
                                                    <dx:ToolbarFontColorButton />
                                                </Items>
                                            </dx:HtmlEditorToolbar>
                                        </Toolbars>
                                    </dx:ASPxHtmlEditor>
                                </div>
                                <div class="">
                                    <div class="content-headertl-out">
                                        <span>Câu 3
                                            <asp:RadioButton Text="Đúng" runat="server" ID="rdDung3" GroupName="cau1" Checked="true" />
                                            <asp:RadioButton Text="Sai" runat="server" ID="rdSai3" GroupName="cau1" />
                                        </span>
                                    </div>
                                    <dx:ASPxHtmlEditor ID="edtDapAnC" ClientInstanceName="edtDapAnC" runat="server" Width="100%" Height="200px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd" OnHtmlCorrecting="edtDapAnC_HtmlCorrecting">
                                        <SettingsHtmlEditing EnablePasteOptions="true" />
                                        <Settings AllowHtmlView="true" AllowContextMenu="Default" />
                                        <settingsimageupload uploadfolder="~/editorimages"></settingsimageupload>
                                        <Toolbars>
                                            <dx:HtmlEditorToolbar>
                                                <Items>
                                                    <dx:ToolbarFontSizeEdit>
                                                        <Items>
                                                            <dx:ToolbarListEditItem Value="1" Text="1 (8pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="2" Text="2 (10pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="3" Text="3 (12pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="4" Text="4 (14pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="5" Text="5 (18pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="6" Text="6 (24pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="7" Text="7 (36pt)"></dx:ToolbarListEditItem>
                                                        </Items>
                                                    </dx:ToolbarFontSizeEdit>
                                                    <dx:ToolbarBoldButton BeginGroup="True" />
                                                    <dx:ToolbarItalicButton />
                                                    <dx:ToolbarUnderlineButton />
                                                    <dx:ToolbarStrikethroughButton />
                                                    <dx:ToolbarJustifyLeftButton BeginGroup="True" />
                                                    <dx:ToolbarJustifyCenterButton />
                                                    <dx:ToolbarJustifyRightButton />
                                                    <dx:ToolbarJustifyFullButton />
                                                    <dx:ToolbarBackColorButton BeginGroup="True" />
                                                    <dx:ToolbarFontColorButton />
                                                </Items>
                                            </dx:HtmlEditorToolbar>
                                        </Toolbars>
                                    </dx:ASPxHtmlEditor>
                                </div>
                                <div class="">
                                    <div class="content-headertl-out">
                                        <span>Câu 4
                                            <asp:RadioButton Text="Đúng" runat="server" ID="rdDung4" GroupName="cau1" Checked="true" />
                                            <asp:RadioButton Text="Sai" runat="server" ID="rdSai4" GroupName="cau1" />
                                        </span>
                                    </div>
                                    <dx:ASPxHtmlEditor ID="edtDapAnD" ClientInstanceName="edtDapAnD" runat="server" Width="100%" Height="200px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd" OnHtmlCorrecting="edtDapAnD_HtmlCorrecting">
                                        <SettingsHtmlEditing EnablePasteOptions="true" />
                                        <Settings AllowHtmlView="true" AllowContextMenu="Default" />
                                        <settingsimageupload uploadfolder="~/editorimages"></settingsimageupload>
                                        <Toolbars>
                                            <dx:HtmlEditorToolbar>
                                                <Items>
                                                    <dx:ToolbarFontSizeEdit>
                                                        <Items>
                                                            <dx:ToolbarListEditItem Value="1" Text="1 (8pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="2" Text="2 (10pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="3" Text="3 (12pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="4" Text="4 (14pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="5" Text="5 (18pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="6" Text="6 (24pt)"></dx:ToolbarListEditItem>
                                                            <dx:ToolbarListEditItem Value="7" Text="7 (36pt)"></dx:ToolbarListEditItem>
                                                        </Items>
                                                    </dx:ToolbarFontSizeEdit>
                                                    <dx:ToolbarBoldButton BeginGroup="True" />
                                                    <dx:ToolbarItalicButton />
                                                    <dx:ToolbarUnderlineButton />
                                                    <dx:ToolbarStrikethroughButton />
                                                    <dx:ToolbarJustifyLeftButton BeginGroup="True" />
                                                    <dx:ToolbarJustifyCenterButton />
                                                    <dx:ToolbarJustifyRightButton />
                                                    <dx:ToolbarJustifyFullButton />
                                                    <dx:ToolbarBackColorButton BeginGroup="True" />
                                                    <dx:ToolbarFontColorButton />
                                                </Items>
                                            </dx:HtmlEditorToolbar>
                                        </Toolbars>
                                    </dx:ASPxHtmlEditor>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="">
                    <div class="content-headertl">
                        <span>Giải thích đáp án</span>
                    </div>
                    <dx:ASPxHtmlEditor ID="edtGiaiThich" ClientInstanceName="edtGiaiThich" runat="server" Width="100%" Height="200px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd" OnHtmlCorrecting="edtGiaiThich_HtmlCorrecting">
                        <SettingsHtmlEditing EnablePasteOptions="true" />
                        <Settings AllowHtmlView="true" AllowContextMenu="Default" />
                        <settingsimageupload uploadfolder="~/editorimages"></settingsimageupload>
                        <Toolbars>
                            <dx:HtmlEditorToolbar>
                                <Items>
                                    <dx:ToolbarBoldButton BeginGroup="True" />
                                    <dx:ToolbarItalicButton />
                                    <dx:ToolbarUnderlineButton />
                                    <dx:ToolbarStrikethroughButton />
                                    <dx:ToolbarJustifyLeftButton BeginGroup="True" />
                                    <dx:ToolbarJustifyCenterButton />
                                    <dx:ToolbarJustifyRightButton />
                                    <dx:ToolbarJustifyFullButton />
                                    <dx:ToolbarBackColorButton BeginGroup="True" />
                                    <dx:ToolbarFontColorButton />
                                </Items>
                            </dx:HtmlEditorToolbar>
                        </Toolbars>
                    </dx:ASPxHtmlEditor>
                </div>
                <div class="col-12 up-1 but-1">
                    <div class="row">
                        <asp:Button ID="btnLuu" type="btnLuu" runat="server" Text="Lưu" CssClass="btn btn-primary btn-sm mr-1 " OnClick="btnLuu_Click" />
                        <asp:Button ID="btnLuuvaThemmoi" runat="server" Text="Lưu và thêm mới" CssClass="btn btn-primary btn-sm" OnClick="btnLuuvaThemmoi_Click1" />
                    </div>
                </div>
                <div class="col-12 but-1">
                    <div class="row">
                        <a href="#" id="btnChiTiet" runat="server" class="btn btn-primary btn-sm mr-1" onserverclick="btnChiTiet_Click">Chi tiết</a>
                        <asp:UpdatePanel runat="server" ID="uppanelXoa">
                            <ContentTemplate>
                                <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" hidden="hidden" />
                                <a href="javascript:void(0)" class="btn btn-primary btn-sm mr-1" onclick="confirmDel()">Xóa</a>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:Button ID="btnTaiLaiTrang" Text="Tải lại trang" CssClass="btn btn-primary btn-sm mr-1" runat="server" OnClick="btnTaiLaiTrang_Click" />
                        <%--  <asp:Button ID="btnNhapExcel" Text="Nhập file Excel" CssClass="btn btn-primary" runat="server" OnClick="btnNhapExcel_Click" />
                        <asp:FileUpload ID="FileUpload2" runat="server" />--%>
                        <a href="javascript:void(0)" style="display: none" class="btn btn-primary btn-sm mr-1" data-toggle="modal" data-target="#exampleModal">Nhập file excel </a>
                        <%--<a href="/admin-dac-ta" class="btn btn-primary  mx-1">Thêm đặc tả</a>--%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <div class="form-group table-responsive">
                                    <dx:ASPxGridView ID="grvList" runat="server" ClientInstanceName="grvList" KeyFieldName="question_id">
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="7%">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataColumn Caption="STT" HeaderStyle-HorizontalAlign="Center" Width="5%">
                                                <DataItemTemplate>
                                                    <%#Container.ItemIndex+1 %>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Bài học" FieldName="lesson_name" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Nội dung câu hỏi" FieldName="question_content" HeaderStyle-HorizontalAlign="Center" Width="30%" Settings-AllowEllipsisInText="true">
                                                <DataItemTemplate>
                                                    <div>
                                                        <%#Eval("question_content") %>
                                                    </div>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Loại CH" FieldName="question_level" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Người nhập" FieldName="username_fullname" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                        </Columns>
                                        <%--<SettingsSearchPanel Visible="true" />--%>
                                        <Styles>
                                            <Header CssClass="header-table" ForeColor="White" Font-Bold="true"></Header>
                                        </Styles>
                                        <Settings ShowFilterRow="true" />
                                        <SettingsBehavior AllowFocusedRow="true" />
                                        <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                                        <SettingsLoadingPanel Text="Đang tải..." />
                                        <SettingsPager PageSize="10" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
                                    </dx:ASPxGridView>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
        <%--modal nhập file excel--%>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-info text-light">
                        <h5 class="modal-title" id="exampleModalLabel">Nhập câu hỏi trắc nghiệm</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:FileUpload ID="FileUpload2" runat="server" />
                        <div>
                            <span>Nếu chưa có mẫu file vui lòng download <a href="/Excel_Files/mau_file_nhap_cau_hoi_trac_nghiem.xlsx" download style="color: #0275d8">tại đây</a></span>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <asp:Button ID="btnNhapExcel" Text="Nhập file Excel" CssClass="btn btn-primary" runat="server" OnClick="btnNhapExcel_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
