<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_TaoCauHoiLuyenTapTuChon.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_TaoCauHoiLuyenTapTuChon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <script>
        function checkNULLBai() {
            var CityName = document.getElementById('<%= txtTenBai.ClientID%>');
            if (CityName.value.trim() == "") {
                swal('Tên bài học không được để trống!', '', 'warning').then(function () { CityName.focus(); });
                return false;
            }
            return true;
        }
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
    </style>
    <div class="card section-content">
        <div class="container mt-1">
            <p class="heading-nhapsach">Tạo bài luyện tập tự chọn</p>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div>
                        <div class="form-row">
                            <label class="col-2 col-form-label">&nbsp;&nbsp;&nbsp;Link video:</label>
                            <div class="col-8">
                                <input type="text" class="form-control" id="txtLink" runat="server" />
                            </div>
                        </div>
                        <div class="form-row my-1">
                            <label class="col-2 col-form-label">&nbsp;&nbsp;&nbsp;Tên bài:</label>
                            <div class="col-8">
                                <input type="text" class="form-control" id="txtTenBai" runat="server" />
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddlKhoi" runat="server" CssClass="btn btn-primary" OnSelectedIndexChanged="ddlKhoi_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddlMon" runat="server" CssClass="btn btn-primary" OnSelectedIndexChanged="ddlMon_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="col-sm-6">
                                <asp:DropDownList ID="ddlChuong" runat="server" CssClass="btn btn-primary" AutoPostBack="true"></asp:DropDownList>
                            </div>
                        </div>
                        <div id="divHien" runat="server">
                            <asp:Button Text="Hiện bộ câu hỏi trắc nghiệm" CssClass="btn btn-primary" runat="server" ID="btnHienTracNghiem" OnClick="btnHienTracNghiem_Click" />
                        </div>
                        <div id="divTracNghiem" runat="server">
                          <%--  <div class="col-12">
                                <label class="col-3 col-form-label">I) Phần trắc nghiệm:</label>
                            </div>--%>
                            <div class="form-group table-responsive">
                                <dx:ASPxGridView ID="grvList" runat="server" ClientInstanceName="grvList" KeyFieldName="question_id" Width="100%">
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" Width="2%"></dx:GridViewCommandColumn>
                                        <dx:GridViewDataColumn Caption="STT" HeaderStyle-HorizontalAlign="Center" Width="2%">
                                            <DataItemTemplate>
                                                <%#Container.ItemIndex+1 %>
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Tên bài" FieldName="lesson_name" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Nội dung câu hỏi" FieldName="question_content" HeaderStyle-HorizontalAlign="Center" Width="50%">
                                            <DataItemTemplate>
                                                <div>
                                                    <%#Eval("question_content") %>
                                                </div>
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Loại câu hỏi" FieldName="question_dangcauhoi" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Mức độ câu hỏi" FieldName="question_level" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Hình thức" FieldName="question_type" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                    </Columns>
                                    <SettingsSearchPanel Visible="true" />
                                    <SettingsBehavior AllowFocusedRow="true" />
                                    <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                                    <SettingsLoadingPanel Text="Đang tải..." />
                                    <SettingsPager PageSize="15" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
                                </dx:ASPxGridView>
                            </div>
                            <%--  <asp:Button Text="Tắt bộ câu hỏi" CssClass="btn btn-primary" runat="server" ID="btnTatTracNghiem" OnClick="btnTatTracNghiem_Click" />
                            <div class="col-12">
                                <label class="col-3 col-form-label">II) Phần tự luận:</label>
                            </div>--%>
                        </div>
                        <div style="display: none">
                            <dx:ASPxHtmlEditor ID="edtnoidung" ClientInstanceName="edtnoidung" runat="server" Width="100%" Height="500px" Border-BorderStyle="Solid" Border-BorderWidth="1px" Border-BorderColor="#dddddd">
                                <SettingsHtmlEditing EnablePasteOptions="true" />
                                <Settings AllowHtmlView="true" AllowContextMenu="Default" />
                                <settingsimageupload uploadfolder="~/editorimages"></settingsimageupload>
                                <Toolbars>
                                    <dx:HtmlEditorToolbar>
                                        <Items>
                                            <dx:ToolbarCustomCssEdit Width="120px">
                                                <Items>
                                                    <dx:ToolbarCustomCssListEditItem TagName="" Text="Clear Style" CssClass="" />
                                                    <dx:ToolbarCustomCssListEditItem TagName="H1" Text="Title" CssClass="CommonTitle">
                                                        <PreviewStyle CssClass="CommonTitlePreview" />
                                                    </dx:ToolbarCustomCssListEditItem>
                                                    <dx:ToolbarCustomCssListEditItem TagName="H3" Text="Header1" CssClass="CommonHeader1">
                                                        <PreviewStyle CssClass="CommonHeader1Preview" />
                                                    </dx:ToolbarCustomCssListEditItem>
                                                    <dx:ToolbarCustomCssListEditItem TagName="H4" Text="Header2" CssClass="CommonHeader2">
                                                        <PreviewStyle CssClass="CommonHeader2Preview" />
                                                    </dx:ToolbarCustomCssListEditItem>
                                                    <dx:ToolbarCustomCssListEditItem TagName="Div" Text="Content" CssClass="CommonContent">
                                                        <PreviewStyle CssClass="CommonContentPreview" />
                                                    </dx:ToolbarCustomCssListEditItem>
                                                    <dx:ToolbarCustomCssListEditItem TagName="Strong" Text="Features" CssClass="CommonFeatures">
                                                        <PreviewStyle CssClass="CommonFeaturesPreview" />
                                                    </dx:ToolbarCustomCssListEditItem>
                                                    <dx:ToolbarCustomCssListEditItem TagName="Div" Text="Footer" CssClass="CommonFooter">
                                                        <PreviewStyle CssClass="CommonFooterPreview" />
                                                    </dx:ToolbarCustomCssListEditItem>
                                                    <dx:ToolbarCustomCssListEditItem TagName="" Text="Link" CssClass="Link">
                                                        <PreviewStyle CssClass="LinkPreview" />
                                                    </dx:ToolbarCustomCssListEditItem>
                                                    <dx:ToolbarCustomCssListEditItem TagName="EM" Text="ImageTitle" CssClass="ImageTitle">
                                                        <PreviewStyle CssClass="ImageTitlePreview" />
                                                    </dx:ToolbarCustomCssListEditItem>
                                                    <dx:ToolbarCustomCssListEditItem TagName="" Text="ImageMargin" CssClass="ImageMargin">
                                                        <PreviewStyle CssClass="ImageMarginPreview" />
                                                    </dx:ToolbarCustomCssListEditItem>
                                                </Items>
                                            </dx:ToolbarCustomCssEdit>
                                            <dx:ToolbarParagraphFormattingEdit>
                                                <Items>
                                                    <dx:ToolbarListEditItem Text="Normal" Value="p" />
                                                    <dx:ToolbarListEditItem Text="Heading  1" Value="h1" />
                                                    <dx:ToolbarListEditItem Text="Heading  2" Value="h2" />
                                                    <dx:ToolbarListEditItem Text="Heading  3" Value="h3" />
                                                    <dx:ToolbarListEditItem Text="Heading  4" Value="h4" />
                                                    <dx:ToolbarListEditItem Text="Heading  5" Value="h5" />
                                                    <dx:ToolbarListEditItem Text="Heading  6" Value="h6" />
                                                    <dx:ToolbarListEditItem Text="Address" Value="address" />
                                                    <dx:ToolbarListEditItem Text="Normal (DIV)" Value="div" />
                                                </Items>
                                            </dx:ToolbarParagraphFormattingEdit>
                                            <dx:ToolbarFontNameEdit>
                                                <Items>
                                                    <dx:ToolbarListEditItem Value="Times New Roman" Text="Times New Roman"></dx:ToolbarListEditItem>
                                                    <dx:ToolbarListEditItem Value="Tahoma" Text="Tahoma"></dx:ToolbarListEditItem>
                                                    <dx:ToolbarListEditItem Value="Verdana" Text="Verdana"></dx:ToolbarListEditItem>
                                                    <dx:ToolbarListEditItem Value="Arial" Text="Arial"></dx:ToolbarListEditItem>
                                                    <dx:ToolbarListEditItem Value="MS Sans Serif" Text="MS Sans Serif"></dx:ToolbarListEditItem>
                                                    <dx:ToolbarListEditItem Value="Courier" Text="Courier"></dx:ToolbarListEditItem>
                                                    <dx:ToolbarListEditItem Value="bodoni MT" Text="bodoni MT"></dx:ToolbarListEditItem>
                                                </Items>
                                            </dx:ToolbarFontNameEdit>
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
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="mt-1">
                <asp:Button Text="Tạo bài luyện tập" CssClass="btn btn-primary" runat="server" ID="btnLuu" OnClick="btnLuu_Click" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>
