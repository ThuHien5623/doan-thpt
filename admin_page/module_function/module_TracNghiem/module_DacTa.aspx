<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_DacTa.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_DacTa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="../../../css/admin-style-lan.css" rel="stylesheet" />
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
        function checkNULL() {
            var CityName = document.getElementById('<%= txtNoiDung.ClientID%>');

            if (CityName.value.trim() == "") {
                swal('Tên form không được để trống!', '', 'warning').then(function () { CityName.focus(); });
                return false;
            }
            return true;
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
        function disableUpdate() {
            document.getElementById("buttonUpdate").style.display = "none";
        }
    </script>
    <div class="container-fluid">
        <div class="card">
            <div class="content-headertl-out">
                <span>thêm đặc tả</span>
                <a href="/admin-quan-ly-module-trac-nghiem-version2" class="btn btn-primary btn-sm" style="float: right">Quay lại</a>
            </div>
            <div class="col-12 up-1 but-1">
                <div class="row">
                    <asp:UpdatePanel ID="udButton" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="btnThem" runat="server" Text="Thêm" CssClass="btn btn-primary btn-sm" OnClick="btnThem_Click" />
                            <asp:Button ID="btnChiTiet" runat="server" Text="Chi tiết" CssClass="btn btn-primary btn-sm" OnClick="btnChiTiet_Click" />
                            <input type="submit" class="btn btn-primary btn-sm" value="Xóa" onclick="confirmDel()" />
                            <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="">
                <dx:ASPxGridView ID="grvList" runat="server" ClientInstanceName="grvList" KeyFieldName="dacta_id" Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="5%">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataColumn Caption="Loại" FieldName="dacta_loai" HeaderStyle-HorizontalAlign="Center" Width="8%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Khối" FieldName="khoi_name" HeaderStyle-HorizontalAlign="Center" Width="5%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Môn" FieldName="mon_name" HeaderStyle-HorizontalAlign="Center" Width="5%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Chương/Chủ đề" FieldName="chapter_name" HeaderStyle-HorizontalAlign="Center" Width="15%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Bài" FieldName="lesson_name" HeaderStyle-HorizontalAlign="Center" Width="30%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Nội dung" FieldName="dacta_content" HeaderStyle-HorizontalAlign="Center" Width="30%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Người nhập" FieldName="username_fullname" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                    </Columns>
                    <ClientSideEvents RowDblClick="btnChiTiet" />
                    <%--<SettingsSearchPanel Visible="true" />--%>
                    <Styles>
                        <Header CssClass="header-table" ForeColor="White" Font-Bold="true"></Header>
                    </Styles>
                    <Settings ShowFilterRow="true" />
                    <SettingsBehavior AllowFocusedRow="true" />
                    <SettingsText EmptyDataRow="Trống" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                    <SettingsLoadingPanel Text="Đang tải..." />
                    <SettingsPager PageSize="10" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
                </dx:ASPxGridView>
            </div>
        </div>
        <dx:ASPxPopupControl ID="popupControl" runat="server" Width="1000" CloseAction="CloseButton" ShowCollapseButton="True" ShowMaximizeButton="True" ScrollBars="Auto" CloseOnEscape="true" Modal="True"
            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popupControl" ShowFooter="true"
            HeaderText="Nội dung đặc tả" AllowDragging="True" PopupAnimationType="Fade" EnableViewState="False" AutoUpdatePosition="true" ClientSideEvents-CloseUp="function(s,e){grvList.Refresh();}">
            <HeaderStyle CssClass="header-popup" />
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">
                    <asp:UpdatePanel ID="udPopup" runat="server">
                        <ContentTemplate>
                            <div class="popup-main">
                                <div class="row">
                                    <div class="col-4">
                                        <div class="">
                                            <label>Khối:</label>
                                            <dx:ASPxComboBox ID="ddlKhoi" runat="server" OnSelectedIndexChanged="ddlKhoi_SelectedIndexChanged" AutoPostBack="true" ValueType="System.Int32" ClientInstanceName="ddlMon" CssClass="" Width="100%">
                                                <Items>
                                                    <%--<dx:ListEditItem Text="" Value="" Selected="True" />--%>
                                                    <dx:ListEditItem Text="Khối 6" Value="6" />
                                                    <dx:ListEditItem Text="Khối 7" Value="7" />
                                                    <dx:ListEditItem Text="Khối 8" Value="8" />
                                                    <dx:ListEditItem Text="Khối 9" Value="9" />
                                                    <dx:ListEditItem Text="Khối 10" Value="10" />
                                                    <dx:ListEditItem Text="Khối 11" Value="11" />
                                                    <dx:ListEditItem Text="Khối 12" Value="12" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </div>
                                        <div class="">
                                            <label>Môn:</label>
                                            <dx:ASPxComboBox ID="ddlMon" runat="server" ValueType="System.Int32" OnSelectedIndexChanged="ddlMon_SelectedIndexChanged" AutoPostBack="true" TextField="mon_name" ValueField="mon_id" ClientInstanceName="ddlMon" CssClass="" Width="100%"></dx:ASPxComboBox>
                                        </div>
                                        <div class="">
                                            <label>Chương/chủ đề:</label>
                                            <dx:ASPxComboBox ID="ddlChuong" runat="server" ValueType="System.Int32" OnSelectedIndexChanged="ddlChuong_SelectedIndexChanged" AutoPostBack="true" TextField="chapter_name" ValueField="chapter_id" ClientInstanceName="ddlChuong" CssClass="" Width="100%"></dx:ASPxComboBox>
                                            <label>Bài:</label>
                                            <dx:ASPxComboBox ID="ddlLesson" runat="server" ValueType="System.Int32" TextField="lesson_name" ValueField="lesson_id" ClientInstanceName="ddlLesson" CssClass="" Width="100%"></dx:ASPxComboBox>
                                        </div>
                                        <div class="">
                                            <label>Loại:</label>
                                            <asp:DropDownList ID="ddlLoai" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="Nhận biết" Text="Nhận biết"></asp:ListItem>
                                                <asp:ListItem Value="Thông hiểu" Text="Thông hiểu"></asp:ListItem>
                                                <asp:ListItem Value="Vận dụng" Text="Vận dụng"></asp:ListItem>
                                                <asp:ListItem Value="Vận dụng cao" Text="Vận dụng cao"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-8">
                                        <label>Nội dung:</label>
                                        <div>
                                            <textarea id="txtNoiDung" class="form-control boxed" runat="server" style="height:30vh; resize: vertical;"></textarea>
                                            <%--<asp:TextBox ID="txtNoiDung" runat="server" ClientIDMode="Static" CssClass="form-control boxed" Width="100%"> </asp:TextBox>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </dx:PopupControlContentControl>
            </ContentCollection>
            <FooterContentTemplate>
                <div class="mar_but button" id="buttonUpdate">
                    <asp:UpdatePanel ID="udSave" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="btnLuu" runat="server" ClientIDMode="Static" Text="Lưu" CssClass="btn btn-primary btn-sm" OnClientClick="return checkNULL()" OnClick="btnLuu_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </FooterContentTemplate>
            <ContentStyle>
                <Paddings PaddingBottom="0px" />
            </ContentStyle>
        </dx:ASPxPopupControl>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>
