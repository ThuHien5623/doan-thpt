<%@ Page Language="C#" MasterPageFile="~/Admin_MasterPage.master" AutoEventWireup="true" CodeFile="module_Account.aspx.cs" Inherits="admin_page_module_function_module_WebSite_module_Account" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v17.1" %>
<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxSpellChecker" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headlink" runat="Server">
    <script src="../../../admin_js/sweetalert.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hihead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="himenu" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="hibodyhead" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="hibodywrapper" runat="Server">
    <script type="text/javascript">
        function func() {
            --
                grvList.Refresh();
            popupControl.Hide();
        }
        function btnChiTiet() {
            --
                document.getElementById('<%=btnChiTiet.ClientID%>').click();
        }
        function popupHide() {
            --
                document.getElementById('btnClosePopup').click();
        }
        function confirmDel() {
            --
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
            var name = document.getElementById('<%= txtSoDienThoai.ClientID%>');

            if (name.value.trim() == "") {
                swal('Tên cấp không được để trống!', '', 'warning').then(function () { name.focus(); });
                return false;
            }
            return true;
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
    </script>
    <div class="card card-block">
        <div class="form-group row">
            <div class="col-sm-10">
                <asp:UpdatePanel ID="udButton" runat="server">
                    <ContentTemplate>
                        <div style="display: none">
                            <asp:Button ID="btnThem" runat="server" Text="Thêm" CssClass="btn btn-primary" OnClick="btnThem_Click" />
                            <input type="submit" class="btn btn-primary" value="Xóa" onclick="confirmDel()" />
                            <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" />
                        </div>
                        <asp:Button ID="btnChiTiet" runat="server" Text="Xem" CssClass="btn btn-primary" OnClick="btnChiTiet_Click" />
                        <asp:Button ID="btnKhoa" runat="server" Text="Khóa" CssClass="btn btn-primary" OnClick="btnKhoa_Click" />
                        <asp:Button ID="btnMoKhoa" runat="server" Text="Mở khóa" CssClass="btn btn-primary" OnClick="btnMoKhoa_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="form-group table-responsive">
            <dx:ASPxGridView ID="grvList" runat="server" ClientInstanceName="grvList" KeyFieldName="account_id" Width="100%">
                <Columns>
                    <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="5%">
                    </dx:GridViewCommandColumn>
                     <dx:GridViewDataColumn Caption="active" FieldName="account_active" HeaderStyle-HorizontalAlign="Center" Width="20%"></dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Số điện thoại" FieldName="account_sodienthoai" HeaderStyle-HorizontalAlign="Center" Width="20%"></dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Ngày kích hoạt" FieldName="account_ngaykichhoat" HeaderStyle-HorizontalAlign="Center" Width="10%" Settings-AllowEllipsisInText="True"></dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Gói" FieldName="account_goi" HeaderStyle-HorizontalAlign="Center" Width="10%" Settings-AllowEllipsisInText="True"></dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Ngày gia hạn" FieldName="account_ngaygiahan" HeaderStyle-HorizontalAlign="Center" Width="10%" Settings-AllowEllipsisInText="True"></dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Số lần gia hạn" FieldName="account_solan_giahan" HeaderStyle-HorizontalAlign="Center" Width="10%" Settings-AllowEllipsisInText="True"></dx:GridViewDataColumn>
                    <dx:GridViewDataColumn Caption="Ngày kết thúc" FieldName="account_ngayketthuc" HeaderStyle-HorizontalAlign="Center" Width="10%" Settings-AllowEllipsisInText="True"></dx:GridViewDataColumn>
                </Columns>
                <ClientSideEvents RowDblClick="btnChiTiet" />
                <SettingsSearchPanel Visible="true" />
                <SettingsBehavior AllowFocusedRow="true" />
                <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                <SettingsLoadingPanel Text="Đang tải..." />
                <SettingsPager PageSize="50" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
            </dx:ASPxGridView>
        </div>
    </div>
    <dx:ASPxPopupControl ID="popupControl" runat="server" Width="800px" Height="400px" CloseAction="CloseButton" ShowCollapseButton="True" ShowMaximizeButton="True" ScrollBars="Auto" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popupControl" ShowFooter="true"
        HeaderText="Đăng ký của khách hàng" AllowDragging="True" PopupAnimationType="Fade" EnableViewState="False" AutoUpdatePosition="true" ClientSideEvents-CloseUp="function(s,e){grvList.Refresh();}">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <asp:UpdatePanel ID="udPopup" runat="server">
                    <ContentTemplate>
                        <div class="popup-main">
                            <div class="div_content col-12">
                                <div class="col-12">
                                    <div class="col-12">
                                        <div class="col-8">
                                            <div class="col-12 form-group">
                                                <label class="col-2 form-control-label">Số điện thoại:</label>
                                                <div class="col-10">
                                                    <asp:TextBox ID="txtSoDienThoai" runat="server" ClientIDMode="Static" CssClass="form-control boxed" Width="90%"> </asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-12 form-group">
                                                <label class="col-2 form-control-label">Họ tên học sinh:</label>
                                                <div class="col-10">
                                                    <asp:TextBox ID="txtHoTenHocSinh" runat="server" ClientIDMode="Static" CssClass="form-control boxed" Width="90%"> </asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="col-12 form-group">
                                                <label class="col-2 form-control-label">Lớp:</label>
                                                <div class="col-10">
                                                    <asp:TextBox ID="txtLop" runat="server" ClientIDMode="Static" CssClass="form-control boxed" Width="90%"> </asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-12 form-group">
                                                <label class="col-2 form-control-label">Gói:</label>
                                                <div class="col-10">
                                                    <asp:TextBox ID="txtGoi" runat="server" ClientIDMode="Static" CssClass="form-control boxed" Width="90%"> </asp:TextBox>
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
                <asp:Button ID="btnLuu" runat="server" ClientIDMode="Static" Text="Duyệt" CssClass="btn btn-primary" OnClientClick="return checkNULL()" OnClick="btnLuu_Click" />
            </div>
        </FooterContentTemplate>
        <ContentStyle>
            <Paddings PaddingBottom="0px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="hibodybottom" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="hifooter" runat="Server">
    <script type="text/javascript">
        function clickavatar1() {
            $("#up1 input[type=file]").click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="hifootersite" runat="Server">
</asp:Content>

