<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_TaoDeKiemTra_TracNghiem.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_TaoDeKiemTra_TracNghiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="../../../css/admin-style-lan.css" rel="stylesheet" />
    <script>
        function checkNULLBai() {
            var txtTenBai = document.getElementById('<%= txtTenBai.ClientID%>');
            var txtThoiGian = document.getElementById('<%= txtThoiGian.ClientID%>');
            if (txtTenBai.value.trim() == "") {
                swal('Vui lòng nhập tên bài kiểm tra!', '', 'warning').then(function () { txtTenBai.focus(); });
                return false;
            }
            if (txtThoiGian.value.trim() == "") {
                swal('Vui lòng nhập thời gian làm bài!', '', 'warning').then(function () { txtThoiGian.focus(); });
                return false;
            }
            DisplayLoadingIcon();
            return true;
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode
            if (charCode == 46 || (charCode > 47 && charCode < 58))
                return true; return false;
        }
        //function chooseForm(id) {
        //    $(".btn-button").removeClass("active");
        //    $(".form-nhap-de").css("display", "none");
        //    $("#" + id).addClass("active");
        //    $("#dv_" + id).css("display", "block");
        //}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
    <style>
        .heading-nhapsach {
            font-size: 40px;
            font-weight: bold;
            text-align: center;
            color: darkblue;
        }

        .table-matran tr th, .table-matran tr td {
            border: 1px solid #9d9595;
            padding: 5px;
            text-align: center
        }

        .table-matran input {
            width: 50px;
            display: inline-block;
        }

        .active {
            background-color: red;
            border-color: red;
        }

        p.title_h2_c {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 0;
        }

        p.title-form {
            text-align: center;
            font-size: 24px;
            color: red;
            font-weight: bold;
            text-transform: uppercase;
        }

        .btn-disable {
            background-color: #7e8489 !important;
            border-color: #7e8489 !important;
            cursor: not-allowed !important;
            pointer-events: none !important;
        }
    </style>
    <input type="text" id="subMenu" value="5" hidden />
    <div class="container-fluid">
        <div class="card">
            <div class="content-headertl-out">
                <span>nhập đề trắc nghiệm</span>
                 <a href="/admin-danh-sach-bai-kiem-tra-version2" class="btn btn-primary btn-sm" style="float: right">Quay lại</a>
            </div>
            <asp:UpdatePanel runat="server" hidden="hidden">
                <ContentTemplate>
                    <div class="form-group row">
                        <label class="col-2 col-form-label">Tên bài kiểm tra <span class="text-danger">(*)</span> :</label>
                        <div class="col-8">
                            <input type="text" class="form-control" id="txtTenBai" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-2 col-form-label">Thời gian làm bài <span class="text-danger">(*)</span>:</label>
                        <div class="col-8">
                            <input type="text" class="form-control" id="txtThoiGian" runat="server" />
                        </div>
                        <div class="input-group-prepend">
                            <span class="input-group-text" id="inputGroupPrepend2">&nbsp;phút</span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-6">
                            Chọn khối:
                                <asp:DropDownList ID="ddlKhoi" runat="server" CssClass="form-control" OnChange="DisplayLoadingIcon()" OnSelectedIndexChanged="ddlKhoi_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                        </div>
                        <div class="col-sm-6">
                            Chọn môn:
                                <asp:DropDownList ID="ddlMon" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <%-- <a href="javascript:void(0)" id="tracnghiem" onclick="chooseForm(this.id)" class="btn btn-primary btn-button">Nhập trắc nghiệm 4 đáp án</a>
            <a href="javascript:void(0)" id="dungsai" onclick="chooseForm(this.id)" class="btn btn-primary btn-button">Nhập trắc nghiệm đúng sai</a>
            <a href="javascript:void(0)" id="traloingan" onclick="chooseForm(this.id)" class="btn btn-primary btn-button">Nhập trắc nghiệm trả lời ngắn</a>--%>
            <input type="text" id="txtMaxTracNghiem" runat="server" style="display: none" />
            <input type="text" id="txtMaxDungSai" runat="server" style="display: none" />
            <input type="text" id="txtMaxTuLuan" runat="server" style="display: none" />
            <%-- form nhập trắc nghiệm--%>
            <em class="up-1 but-1"><strong style="color: #ff0505; font-size: 1rem">
                <asp:Label ID="txtTongCauDaNhap" runat="server" /></strong></em>
            <div id="dv_tracnghiem">
                <input type="text" id="txtTongTracNghiemDaNhap" runat="server" style="display: none" />
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-6">
                                <dx:ASPxHtmlEditor ID="edtContent" ClientInstanceName="edtContent" runat="server" Width="100%" Height="600px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd" OnHtmlCorrecting="edtContent_HtmlCorrecting">
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
                                <div class="up-1">
                                    <div class="content-headertl">
                                        <span>Giải thích đáp án
                                        </span>
                                    </div>
                                    <dx:ASPxHtmlEditor ID="edtGiaiThich" ClientInstanceName="edtGiaiThich" runat="server" Width="100%" Height="275px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd" OnHtmlCorrecting="edtGiaiThich_HtmlCorrecting">
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
                            <div class="col-6">
                                <div class="">
                                    <div class="content-headertl">
                                        <span>Câu A
                                        <input type="checkbox" id="DaA" runat="server" />
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
                                    <div class="content-headertl">
                                        <span>Câu B
                                        <input type="checkbox" id="DaB" runat="server" />
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
                                    <div class="content-headertl">
                                        <span>Câu C
                                        <input type="checkbox" id="DaC" runat="server" />
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
                                    <div class="content-headertl">
                                        <span>Câu A
                                        <input type="checkbox" id="DaD" runat="server" />
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
                            </div>
                        </div>

                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Button ID="btnLuu" type="btnLuu" runat="server" Text="Lưu và tiếp tục" CssClass="btn btn-primary btn-sm up-1 " OnClientClick="return checkNULLBai(); DisplayLoadingIcon();" OnClick="btnLuu_Click" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

