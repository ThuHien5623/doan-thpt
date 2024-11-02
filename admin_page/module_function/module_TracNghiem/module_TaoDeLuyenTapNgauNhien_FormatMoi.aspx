<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_TaoDeLuyenTapNgauNhien_FormatMoi.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_TaoDeLuyenTapNgauNhien_FormatMoi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="../../../css/admin-style-lan.css" rel="stylesheet" />
    <link href="../../../css/pageTest.css" rel="stylesheet" />
    <script>
        function CloseGridLookup() {
            lkChuong.ConfirmCurrentSelection();
            lkChuong.HideDropDown();
            //lkChuong.Focus();
        }

        function checkNULLBai() {
            var txtTenBai = document.getElementById('<%= txtTenBai.ClientID%>');
            var txtThoiGian = document.getElementById('<%= txtThoiGian.ClientID%>');
            var txtHinhThuc = document.getElementById('<%= txtHinhThucThi.ClientID%>').value;
            var lkChuong = document.getElementById('<%= lkChuong.ClientID%>').text;
            var lkBai = document.getElementById('<%= txtLessonID.ClientID%>').value;
            var tiLeTungBai = document.getElementById('<%= txtTiLeTungBai.ClientID%>').value;
            if (txtTenBai.value.trim() == "") {
                swal('Vui lòng nhập tên bài kiểm tra!', '', 'warning').then(function () { txtTenBai.focus(); });
                return false;
            }
            if (txtThoiGian.value.trim() == "") {
                swal('Vui lòng nhập thời gian làm bài!', '', 'warning').then(function () { txtThoiGian.focus(); });
                return false;
            }
            if (lkChuong == "") {
                swal('Bạn chưa chọn chương!', '', 'warning');
                return false;
            }
            if (lkBai == "") {
                swal('Bạn chưa chọn bài!', '', 'warning');
                return false;
            }
            if (tiLeTungBai == "") {
                swal('Vui lòng nhập tỉ lệ câu hỏi theo từng bài!', '', 'warning');
                return false;
            }
            if (lkBai.split(',').length != tiLeTungBai.split(';').length) {
                swal('Tỉ lệ câu hỏi theo từng bài không khớp với số lượng bài đã chọn!', '', 'warning');
                return false;
            }
            //debugger;
            let arrTile = tiLeTungBai.split(';');
            //tổng tỉ lệ phải bằng 100%
            const tong = arrTile.reduce((acc, currentValue) => acc + Number(currentValue), 0);
            if (tong != 100) {
                swal('Tổng tỉ lệ câu hỏi theo từng bài phải bằng 100%!', '', 'warning');
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
        function confirmDel() {
            swal("Bạn có thực sự muốn xóa đề này?",
                "Nếu có, dữ liệu sẽ không thể khôi phục.",
                "warning",
                {
                    buttons: true,
                    successMode: true
                }).then(function (value) {
                    if (value == true) {
                        var xoa = document.getElementById('<%=btnXoa.ClientID%>');
                        xoa.click();
                    }
                });

        }
        var arr = [];
        function checkValue(id) {
            if (arr.includes(id)) {
                arr = arr.filter(item => item !== id)
            }
            else {
                arr.push(id);
            }
            document.getElementById("<%=txtLessonID.ClientID%>").value = arr.toString();
            if (document.getElementById("<%=txtLessonID.ClientID%>").value != "") {
                document.getElementById("div_tile").style.display = "block"
            }
            else {
                document.getElementById("div_tile").style.display = "none"
            }
        }
        $(document).ready(function () {
            $("a#btn_tknx2").addClass("active");
        });
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
            font-size: 32px;
            font-weight: bold;
            text-align: center;
            color: darkblue;
        }
    </style>
     <input type="text" id="subMenu" value="5" hidden />
    <div class="container-fluid">
        <div class="card">
            <div class="block-style block-style-1">
                <div class="block-content">
                    <%--<div class="buttom-tab">
                        <a class="btn btn-primary btn-sm  buttom-edit" href="/admin-danh-sach-bai-luyen-tap-version2">kho luyện tập</a>
                        <a class="btn btn-primary btn-sm  buttom-edit" href="/admin-tao-bai-luyen-tap-ngau-nhien" id="btnNgauNhien">Tạo bài trắc nghiệm ngẫu nhiên</a>
                        <a class="btn btn-primary btn-sm  buttom-edit" href="/admin-tao-bai-luyen-tap-format-moi" runat="server" style="border-color: rgb(143, 1, 0); background-color: rgb(143, 1, 0);">Tạo bài trắc nghiệm format mới</a>
                        <a class="btn btn-primary btn-sm  buttom-edit" href="/admin-tao-bai-luyen-tap-tu-luan">Tạo bài luyện tập tự luận</a>
                    </div>--%>
                    <div class="row">
                        <div class="col-4" style="margin-top: 3.3rem">
                            <div class="name-block">Nhập thông tin</div>
                            <div class="popup-main__insert">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <label>Tên bài luyện tập <span class="text-danger">(*)</span> :</label>
                                        <input type="text" class="form-control" id="txtTenBai" runat="server" />
                                        <label>Thời gian làm bài <span class="text-danger">(*)</span>:</label>
                                        <input type="text" class="form-control" id="txtThoiGian" runat="server" onkeypress="return isNumberKey(event)" />
                                        <span class="input-group-text" id="inputGroupPrepend2">phút</span>
                                        Chọn khối:<asp:DropDownList ID="ddlKhoi" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlKhoi_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                        Chọn môn:<asp:DropDownList ID="ddlMon" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlMon_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                        Chọn chương:
                                <dx:ASPxGridLookup ID="lkChuong" runat="server" SelectionMode="Multiple" ClientInstanceName="lkChuong"
                                    KeyFieldName="chapter_id" Width="300px" TextFormatString="{0}" MultiTextSeparator="; ">
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" />
                                        <dx:GridViewDataColumn FieldName="chapter_name" Caption="Chương" Width="250px" />
                                        <dx:GridViewDataColumn FieldName="chapter_id" Settings-AllowAutoFilter="false" Visible="false" />
                                    </Columns>
                                    <GridViewProperties>
                                        <Templates>
                                            <StatusBar>
                                                <table class="OptionsTable" style="float: right">
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxButton ID="Close" runat="server" AutoPostBack="true" Text="Chọn" ClientSideEvents-Click="CloseGridLookup" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                        <Settings ShowFilterRow="True" ShowStatusBar="Visible" />
                                        <SettingsPager PageSize="5" EnableAdaptivity="true" />
                                    </GridViewProperties>
                                </dx:ASPxGridLookup>
                                        <div class="form-row">
                                            <asp:Repeater runat="server" ID="rpLesson">
                                                <ItemTemplate>
                                                    <div class="col-sm-4 col-lg-4">
                                                        <label>
                                                            <input type="checkbox" id="ck_<%#Eval("lesson_id") %>" name="ckLesson" onclick="checkValue(this.value)" value="<%#Eval("lesson_id") %>">
                                                            <%#Eval("lesson_name") %>
                                                        </label>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <input type="text" id="txtLessonID" runat="server" style="display: none" />
                                        </div>
                                        <div class="form-row">
                                            <div id="div_tile" style="display: none">
                                                Tỉ lệ câu hỏi theo từng bài:
                                                <input type="text" id="txtTiLeTungBai" runat="server" />
                                                <br />
                                                <span class="text-danger font-weight-bold">Ví dụ: mong muốn số câu hỏi ở bài 1 là 40%, số câu hỏi ở bài 2 là 30%, số câu hỏi ở bài 3 là 30% thì nhập 40;30;30</span>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <input style="display: none" id="txtHinhThucThi" type="text" runat="server" />
                                <input style="display: none" id="txtLockInsert" value="0" type="text" runat="server" />
                                <asp:Button Text="Tạo bài luyện tập" CssClass="btn btn-primary btn-sm up-1" OnClientClick="return checkNULLBai()" ID="btnLuu" runat="server" OnClick="btnLuu_Click" />
                            </div>
                        </div>
                        <div class="col-8 up-1">
                            <div class="content-headertl" style="display: flex; justify-content: space-between; padding-bottom: unset">
                                <span>danh sách đề đã tạo</span>
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <input type="submit" class="btn btn-primary btn-sm" value="Xóa" onclick="confirmDel()" />
                                        <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" hidden="hidden" />
                                        <asp:Button ID="btnMoKhoa" runat="server" CssClass="btn btn-primary btn-sm" Text="Hiển thị lên cho học sinh" OnClick="btnMoKhoa_Click" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <div class="form-group table-responsive">
                                        <dx:ASPxGridView ID="grvDeLuyenTap" runat="server" Width="100%" ClientInstanceName="grvDeLuyenTap" KeyFieldName="test_id">
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="5%"></dx:GridViewCommandColumn>
                                                <dx:GridViewDataColumn Caption="STT" HeaderStyle-HorizontalAlign="Center" Width="5%">
                                                    <DataItemTemplate>
                                                        <%#Container.ItemIndex+1 %>
                                                    </DataItemTemplate>
                                                </dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Đề" FieldName="luyentap_name" HeaderStyle-HorizontalAlign="Center" Width="15%"></dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Ngày tạo" FieldName="test_createdate" HeaderStyle-HorizontalAlign="Center" Width="8%"></dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Môn" FieldName="mon_name" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Khối" FieldName="khoi_name" HeaderStyle-HorizontalAlign="Center" Width="8%"></dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Người tạo" FieldName="username_fullname" HeaderStyle-HorizontalAlign="Center" Width="15%"></dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn Caption="Tình trạng" FieldName="tinhtrang" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                                <dx:GridViewDataColumn HeaderStyle-HorizontalAlign="Center" Width="5%">
                                                    <DataItemTemplate>
                                                        <a href="/admin-de-luyen-tap-chi-tiet-<%#Eval("test_id") %>" style="color: white" class="btn btn-primary btn-sm">Xem</a>
                                                    </DataItemTemplate>
                                                </dx:GridViewDataColumn>
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
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>
