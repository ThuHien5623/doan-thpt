<%@ Page Language="C#" AutoEventWireup="true" CodeFile="module_QuanLyCauHoiTuLuan.aspx.cs" Inherits="admin_page_module_function_module_QuanLyCauHoiTuLuan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hệ thống giáo dục Việt Nhật | Trắc nghiệm</title>
    <link href="../../../css/admin-style-lan.css" rel="stylesheet" />
    <%--<link rel="stylesheet" href="/admin_css/vendor.css" />--%>
    <%--<link rel="stylesheet" href="/admin_css/app-blue.css" />--%>
    <link href="/admin_css/admin_style.css" rel="stylesheet" />
    <link href="/admin_css/datepicker.min.css" rel="stylesheet" />
    <script src="/admin_js/sweetalert.min.js"></script>
    <script src="/admin_js/js_base/jquery-1.9.1.js"></script>
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
        .radio_text_type {
            margin-right: 3px;
            margin-left: 20px;
        }

        .question_radio {
            margin-top: 10px;
            font-size: 16px;
            display: -webkit-inline-box;
        }

        .file {
            margin-top: 40px;
        }

        .title_h2 {
            font-size: 19px;
            margin-bottom: 0;
        }

        .title_h2_c {
            margin-top: 10px;
            font-size: 19px;
            margin-bottom: 0;
        }

        .title_them_question {
            text-align: center;
        }

        .button_quaylai them_chuong {
            float: right;
        }

        .button_quaylai {
            float: right;
        }

        .title_h2_c {
            margin: 12px 0;
        }

        .marginFooter {
            margin: 8px 15px;
        }

        .title_h2_c-active {
            color: red;
            font-size: 1.6rem;
            font-weight: 500;
        }

        .popup-main__insert {
            height: calc(68vh - 100px);
        }
    </style>
    <form id="form1" runat="server">
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
                console.log(a);
            }
            function setCheckedDCH() {
                var value = document.getElementById("<%=txtKieuCauHoi.ClientID%>").value;
                $("input[name=kieucauhoi][value=" + value + "]").attr('checked', 'checked');
                console.log(value)
            }
            function setChecked() {
                debugger;
                var value = document.getElementById("<%=txtLoaiCauHoi.ClientID%>").value;
                $("input[name=loaicauhoi][value=" + value + "]").attr('checked', 'checked');
                console.log(value)
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
            function DisplayQuestion() {
                $('.question').css({ 'display': 'block' });
            }
            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode
                if (charCode == 46 || (charCode > 47 && charCode < 58))
                    return true; return false;
            }
        </script>
        <div class="container-fluid">
            <div class="card">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div style="display: none">
                            <input type="text" id="txtKieuCauHoi" runat="server" />
                            <input type="text" value="" runat="server" id="txtLoaiCauHoi" placeholder="loại câu hỏi" />
                        </div>
                        <div class="content-headertl-out">
                            <span>Tạo câu hỏi tự luận</span>
                            <div>
                                <asp:Button ID="btnTaiLaiTrang" Text="Tải lại trang" CssClass="btn btn-primary btnFunction" runat="server" OnClick="btnTaiLaiTrang_Click" />
                                <a href="/admin-quan-ly-module-trac-nghiem" class="btn btn-primary ">Quay lại</a>
                            </div>
                        </div>
                        <div class="row up-1">
                            <div class="col-3">
                                <div class="name-block">Nhập thông tin</div>
                                <div class="popup-main__insert">
                                    <div class="" id="DangCauHoi_">
                                        <label>Kiểu câu hỏi:</label>
                                        <input class="radio_text_type" type="radio" id="type1" name="kieucauhoi" value="1" onclick="setForm()" />Text + Image 
                                    <input class="radio_text_type" type="radio" id="type2" name="kieucauhoi" value="2" onclick="setForm()" />Video 
                                    </div>
                                    <br />
                                    <label>Mức độ câu hỏi:</label>
                                    <input class="radio_text_type" type="radio" id="21" name="loaicauhoi" value="Dễ" onclick="getquestion()" />Dễ
                                    <input class="radio_text_type" type="radio" id="22" name="loaicauhoi" value="Vừa" onclick="getquestion()" />Vừa 
                                    <input class="radio_text_type" type="radio" id="34" name="loaicauhoi" value="Khó" onclick="getquestion()" />Khó 
                                    <label>Dạng câu hỏi:</label>
                                    <asp:DropDownList runat="server" CssClass="drlist" ID="ddlLoaiCauHoi">
                                        <asp:ListItem Text="Nhận biết" Value="Nhận biết" Selected="True" Enabled="true" />
                                        <asp:ListItem Text="Thông hiểu" Value="Thông hiểu" />
                                        <asp:ListItem Text="Vận dụng" Value="Vận dụng" />
                                        <asp:ListItem Text="Vận dụng cao" Value="Vận dụng cao" />
                                    </asp:DropDownList>
                                    <label class="form-control-label">Hình ảnh :</label>
                                    <div id="up1" class="">
                                        <asp:FileUpload CssClass="hidden-xs-up" ID="FileUpload1" runat="server" onchange="showPreview1(this)" accept=".png,.jpg,.mp3" />
                                        <%--<button type="button" class="btn-chang" onclick="clickavatar1()">
                                            <img id="imgPreview1" src="/admin_images/up-img.png" style="max-width: 100%; height: 200px" />
                                        </button>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-9">
                                <div class="row">
                                    <div class="col-6">
                                        <div id="dvnoidungcauhoi">
                                            <div class="content-headertl-out">
                                                <span>Nội dung câu hỏi</span>
                                                <div>
                                                    <label>Điểm</label>
                                                    <input type="text" id="txtDiem" runat="server" autocomplete="off" onkeypress="return isNumberKey(event)" />
                                                </div>
                                            </div>
                                            <dx:ASPxHtmlEditor ID="edtContent" ClientInstanceName="edtContent" runat="server" Width="100%" Height="420px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd">
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
                                    </div>
                                    <div class="col-6">
                                        <div class="">
                                            <div class="content-headertl">
                                                <span>Giải thích cho câu trả lời đúng</span>
                                            </div>
                                            <dx:ASPxHtmlEditor ID="edtGiaiThich" ClientInstanceName="edtGiaiThich" runat="server" Width="100%" Height="200px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd">
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
                                        <div class="">
                                            <div class="content-headertl">
                                                <span>Đặc tả câu hỏi</span>
                                            </div>
                                            <dx:ASPxHtmlEditor ID="edtDacta" ClientInstanceName="edtDacta" runat="server" Width="100%" Height="200px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd">
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
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="">
                    <div class="widthContent">
                        <div class="col-12">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="row up-1 but-1">
                                        <asp:Button ID="btnLuu" type="btnLuu" runat="server" Text="Lưu" CssClass="btn btn-primary btn-sm mr-1" OnClientClick="return checkNull()" OnClick="btnLuu_Click" />
                                        <asp:Button ID="btnLuuvaThemmoi" runat="server" Text="Lưu và thêm mới" CssClass="btn btn-primary btn-sm" OnClientClick="return checkNull()" OnClick="btnLuuvaThemmoi_Click1" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="udButton2" runat="server">
                                <ContentTemplate>
                                    <div class="row but-1">
                                        <asp:Button ID="btnChiTiet" runat="server" Text="Chi tiết" CssClass="btn btn-primary btnFunction btn-sm mr-1" OnClick="btnChiTiet_Click" />
                                        <input type="submit" class="btn btn-primary btn-sm btnFunction" value="Xóa" onclick="confirmDel()" />
                                        <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
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
                                            <dx:GridViewDataColumn Caption="Dạng CH" FieldName="question_dangcauhoi" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
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
    </form>
    <script>
        function checkNull() {
            var txtDiem = document.getElementById('<%= txtDiem.ClientID%>');
            if (txtDiem.value.trim() == "") {
                swal('Vui lòng nhập điểm cho câu hỏi!', '', 'warning').then(function () { txtDiem.focus(); });
                return false;
            }
            return true;
        }
    </script>
</body>

</html>
