<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_TaoDeLuyenTapTuLuan.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_TaoDeLuyenTapTuLuan" %>

<%@ Register Src="~/web_usercontrol/Uc_MenuHocTap.ascx" TagPrefix="uc1" TagName="Uc_MenuHocTap" %>


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
            var lkChuong = document.getElementById('<%= lkChuong.ClientID%>').text;
            var lkBai = document.getElementById('<%= txtLessonID.ClientID%>').value;
           <%-- var rdLink = document.getElementById('<%= rdLink.ClientID%>');
            var rdzalo= document.getElementById('<%= rdZalo.ClientID%>');--%>
            var txtlink = document.getElementById('<%= txtLinkNopBai.ClientID%>');

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
            //if (!rdLink.checked && !rdzalo.checked) {
            //    swal('Vui lòng chọn hình thức nộp bài!', '', 'warning');
            //    return false;
            //}
            if (txtlink.value == "") {
                swal('Vui lòng link nộp bài!', '', 'warning').then(function () { txtlink.focus(); });
                return false;
            }
            //DisplayLoadingIcon();
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
            <%--if (document.getElementById("<%=txtLessonID.ClientID%>").value != "") {
                document.getElementById("div_tile").style.display = "block"
            }
            else {
                document.getElementById("div_tile").style.display = "none"
            }--%>
        }
        function checkHinhThucNopBai(id) {
            if (id == 2)
                document.getElementById("div_linknopbai").style.display = "flex"
            else document.getElementById("div_linknopbai").style.display = "none"
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

        .table-matran tr th, .table-matran tr td {
            border: 1px solid #9d9595;
            padding: 5px;
            text-align: center
        }

        .table-matran input {
            width: 50px;
            display: inline-block;
        }
    </style>
     <input type="text" id="subMenu" value="5" hidden />
    <div class="container-fluid">
        <div class="card">
            <div class="block-style block-style-1">
                <div class="block-menu">
                    <uc1:Uc_MenuHocTap runat="server" ID="Uc_MenuHocTap" />
                </div>
                <div class="block-content">
                    <div class="buttom-tab">
                        <a class="btn btn-primary btn-sm  buttom-edit" href="/admin-danh-sach-bai-luyen-tap-version2">kho luyện tập</a>
                        <a class="btn btn-primary btn-sm  buttom-edit" href="/admin-tao-bai-luyen-tap-ngau-nhien" id="btnNgauNhien">Tạo bài trắc nghiệm ngẫu nhiên</a>
                        <a class="btn btn-primary btn-sm  buttom-edit" href="/admin-tao-bai-luyen-tap-format-moi">Tạo bài trắc nghiệm format mới</a>
                        <a class="btn btn-primary btn-sm  buttom-edit" href="/admin-tao-bai-luyen-tap-tu-luan" style="border-color: rgb(143, 1, 0); background-color: rgb(143, 1, 0);">Tạo bài luyện tập tự luận</a>
                    </div>
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
                                        <span id="inputGroupPrepend2">phút</span>
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
                                        </div>
                                        <input type="text" id="txtLessonID" runat="server" style="display: none" />
                                        <br />
                                        <div id="div_linknopbai">
                                            <label>Link nộp bài <span class="text-danger">(*)</span> :</label>
                                            <input type="text" class="form-control" id="txtLinkNopBai" runat="server" />
                                        </div>
                                        <a href="javascript:void(0)" id="btnXemCauHoi" runat="server" onserverclick="btnXemCauHoi_ServerClick" class="btn btn-primary btn-sm my-1">Xem câu hỏi</a>
                                        <br />
                                        <asp:Button Text="Tạo bài luyện tập" CssClass="btn btn-primary btn-sm" OnClientClick="return checkNULLBai()" ID="btnLuu" runat="server" OnClick="btnLuu_Click" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </div>
                        </div>
                        <div class="col-8 up-1">
                            <div class="content-headertl" style="display: flex; justify-content: space-between; padding-bottom: unset">
                                <span>DANH SÁCH ĐỀ ĐÃ TẠO</span>
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
                                                        <a href="/admin-de-luyen-tap-tu-luan-chi-tiet-<%#Eval("test_id") %>" style="color: white" class="btn btn-primary">Xem</a>
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
                    <div class="up-1">
                        <dx:ASPxGridView ID="grvDanhSachCauHoi" runat="server" Width="100%" ClientInstanceName="grvDanhSachCauHoi" KeyFieldName="question_id">
                            <Columns>
                                <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="5%"></dx:GridViewCommandColumn>
                                <dx:GridViewDataColumn Caption="STT" HeaderStyle-HorizontalAlign="Center" Width="5%">
                                    <DataItemTemplate>
                                        <%#Container.ItemIndex+1 %>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn Caption="Nội dung câu hỏi" FieldName="question_content" HeaderStyle-HorizontalAlign="Center" Width="50%" Settings-AllowEllipsisInText="true">
                                    <DataItemTemplate>
                                        <div>
                                            <%#Eval("question_content") %>
                                        </div>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>
                                <dx:GridViewDataColumn Caption="Loại CH" FieldName="question_level" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                            </Columns>
                            <%--<SettingsSearchPanel Visible="false" />--%>
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
                    <%--<div class="form-row">
                        <label class="col-2 col-form-label">Hình thức nộp bài <span class="text-danger">(*)</span> :</label>
                        <div>
                            <asp:RadioButton Text="zalo" runat="server" ID="rdZalo" OnClick="checkHinhThucNopBai(1)" GroupName="hinhthucnopbai" />
                            <asp:RadioButton Text="link drive" runat="server" ID="rdLink" OnClick="checkHinhThucNopBai(2)" GroupName="hinhthucnopbai" />
                        </div>
                    </div>--%>

                    <%--  </ContentTemplate>
                                </asp:UpdatePanel>--%>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>
