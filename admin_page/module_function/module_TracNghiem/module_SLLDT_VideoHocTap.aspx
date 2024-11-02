<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_SLLDT_VideoHocTap.aspx.cs" Inherits="admin_page_module_function_module_App_SLLDT_module_SLLDT_VideoHocTap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
    <script type="text/javascript">
        function func() {
            grvList.Refresh();
            popupControl.Hide();
        }
        function btnChiTiet() {
            document.getElementById('<%=btnChiTiet.ClientID%>').click();
        }
        function popupHide() {
            document.getElementById('btnClosePopup').click();
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
        function checkNULL() {
            var CityName = document.getElementById('<%= txtTenBai.ClientID%>');
            if (CityName.value.trim() == "") {
                swal('Tên bài không được để trống!', '', 'warning').then(function () { CityName.focus(); });
                return false;
            }
            return true;
        }
        function showPreview(input) {
            if (input.files && input.files[0]) {
                var filerdr = new FileReader();
                filerdr.onload = function (e) {
                    $('#hibodywrapper_popupControl_imgPreview').attr('src', e.target.result);
                }
                filerdr.readAsDataURL(input.files[0]);
            }
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
        function showImg1(img) {
            $('#hibodywrapper_imgPreview1').attr('src', img);
        }
        function showImg1_1(img) {
            $('#imgPreview1').attr('src', img);
        }
    </script>
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
            <p class="heading-nhapsach">Danh sách video học tập</p>
            <input type="text" name="name" value="" hidden="hidden" runat="server" id="id_key" placeholder="id_click" />
            <div class="col-sm-12">
                <asp:UpdatePanel ID="udButton" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnThem" runat="server" Text="Thêm" CssClass="btn btn-primary" OnClick="btnThem_Click" />
                        <asp:Button ID="btnChiTiet" runat="server" Text="Chi tiết" CssClass="btn btn-primary" OnClick="btnChiTiet_Click" />
                        <input type="submit" class="btn btn-primary" value="Xóa" onclick="confirmDel()" />
                        <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <%-- Danh sách --%>
                <div class="form-group table-responsive">
                    <dx:ASPxGridView ID="grvList" runat="server" ClientInstanceName="grvList" KeyFieldName="videoluyentap_id" Width="100%">
                        <Columns>
                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="0%">
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataColumn Caption="Khối" FieldName="videoluyentap_lop" HeaderStyle-HorizontalAlign="Center" Width="5%"></dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="Môn học" FieldName="videoluyentap_monhoc" HeaderStyle-HorizontalAlign="Center" Width="5%"></dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="Link" FieldName="videoluyentap_video_path" HeaderStyle-HorizontalAlign="Center" Width="35%"></dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="Tên bài" FieldName="videoluyentap_tenbai" HeaderStyle-HorizontalAlign="Center" Width="35%"></dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="Hình ảnh" HeaderStyle-HorizontalAlign="Center" Width="20%">
                                <DataItemTemplate>
                                    <img src="<%#Eval("videoluyentap_image_path") %>" height="100" />
                                </DataItemTemplate>
                            </dx:GridViewDataColumn>
                        </Columns>
                        <ClientSideEvents RowDblClick="btnChiTiet" />
                        <SettingsSearchPanel Visible="true" />
                        <SettingsBehavior AllowFocusedRow="true" />
                        <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                        <SettingsLoadingPanel Text="Đang tải..." />
                        <SettingsPager PageSize="10" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
                    </dx:ASPxGridView>
                </div>
            </div>
        </div>
        <%-- Nhập --%>
        <dx:ASPxPopupControl ID="popupControl" runat="server" Width="700px" Height="600px" CloseAction="CloseButton" ShowCollapseButton="True" ShowMaximizeButton="True" ScrollBars="Auto" CloseOnEscape="true" Modal="True"
            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popupControl" ShowFooter="true"
            HeaderText="Video luyện tập" AllowDragging="True" PopupAnimationType="Fade" EnableViewState="False" AutoUpdatePosition="true" ClientSideEvents-CloseUp="function(s,e){grvList.Refresh();}">
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">
                    <asp:UpdatePanel ID="udPopup" runat="server">
                        <ContentTemplate>
                            <div class="popup-main">
                                <div class="div_content col-12">
                                    <div class="col-12">
                                        <div class="col-12">
                                            <div class="col-12 form-group">
                                                <label class="col-2 form-control-label">Khối:</label>
                                                <div class="col-10">
                                                    <dx:ASPxComboBox ID="ddlKhoi" runat="server" ValueType="System.Int32" TextField="lop_id" ValueField="lop_id" ClientInstanceName="ddlLop" CssClass="" Width="50%"></dx:ASPxComboBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="col-12 form-group">
                                                <label class="col-2 form-control-label">Môn học:</label>
                                                <div class="col-10">
                                                    <dx:ASPxComboBox ID="ddlMon" runat="server" ValueType="System.Int32" TextField="mon_name" ValueField="mon_id" ClientInstanceName="ddlLop" CssClass="" Width="50%"></dx:ASPxComboBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="col-12 form-group">
                                                <label class="col-2 form-control-label">Link:</label>
                                                <div class="col-10">
                                                    <asp:TextBox ID="txtLink" runat="server" ClientIDMode="Static" CssClass="form-control boxed" Width="90%"> </asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="col-12 form-group">
                                                <label class="col-2 form-control-label">Tên bài:</label>
                                                <div class="col-10">
                                                    <asp:TextBox ID="txtTenBai" runat="server" ClientIDMode="Static" CssClass="form-control boxed" Width="90%"> </asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="col-12 form-group">
                                                <label class="col-2 form-control-label">Hình ảnh:</label>
                                                <div class="col-10">
                                                    <div id="up1" class="">
                                                        <asp:FileUpload CssClass="hidden-xs-up" ID="FileUpload1" runat="server" onchange="showPreview1(this)" />
                                                        <button type="button" class="btn-chang" onclick="clickavatar1()">
                                                            <img id="imgPreview1" src="/admin_images/up-img.png" style="max-width: 100%; height: 150px" />
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </dx:PopupControlContentControl>
            </ContentCollection>
            <FooterContentTemplate>
                <div class="mar_but button">
                    <asp:Button ID="btnLuu" runat="server" ClientIDMode="Static" Text="Lưu" CssClass="btn btn-primary" OnClientClick="return checkNULL()" OnClick="btnLuu_Click" />
                </div>
            </FooterContentTemplate>
            <ContentStyle>
                <Paddings PaddingBottom="0px" />
            </ContentStyle>
        </dx:ASPxPopupControl>
    </div>

    <script type="text/javascript">
        function clickavatar1() {
            $("#up1 input[type=file]").click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>
