<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_TaoDeKiemTra_TuChon.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_TaoDeKiemTraNgauNhien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="../../../css/admin-style-lan.css" rel="stylesheet" />
    <link href="../../../css/pageTest.css" rel="stylesheet" />
    <script>
        function CloseGridLookup() {
            lkChuong.ConfirmCurrentSelection();
            lkChuong.HideDropDown();
            //lkChuong.Focus();
            arr = [];
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode
            if (charCode == 46 || (charCode > 47 && charCode < 58))
                return true; return false;
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
            if (arr.length > 0)
                $(".button_xemcauhoi").css("display", "block");
            else
                $(".button_xemcauhoi").css("display", "none");
        }
        function setChecked() {
            if (document.getElementById("<%=txtLessonID.ClientID%>").value != "") {
                var valuesToCheck = document.getElementById("<%=txtLessonID.ClientID%>").value.split(',');
                var checkboxes = document.querySelectorAll('input[type=checkbox][name=ckLesson]');
                checkboxes.forEach(function (checkbox) {
                    if (valuesToCheck.includes(checkbox.value)) {
                        checkbox.checked = true;
                    }
                });
            }
        }
        function checkNULLBai() {
            var txtTenBai = document.getElementById('<%= txtTenBai.ClientID%>');
            var txtThoiGian = document.getElementById('<%= txtThoiGian.ClientID%>');
            var lkChuong = document.getElementById('<%= lkChuong.ClientID%>').text;
            var lkBai = document.getElementById('<%= txtLessonID.ClientID%>').value;

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
            DisplayLoadingIcon();
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
            <div class="content-headertl-out">
                <span>TẠO ĐỀ KIỂM TRA TỰ CHỌN</span>
                <a href="/admin-danh-sach-bai-kiem-tra-version2" class="btn btn-primary btn-sm" style="float: right">Quay lại</a>
            </div>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div hidden="hidden">
                        <div class="form-group row">
                            <label class="col-2 col-form-label">Tên bài kiểm tra <span class="text-danger">(*)</span> :</label>
                            <div class="col-8">
                                <input type="text" class="form-control" id="txtTenBai" runat="server" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-2 col-form-label">Thời gian làm bài <span class="text-danger">(*)</span>:</label>
                            <div class="col-8">
                                <input type="text" class="form-control" id="txtThoiGian" runat="server" onkeypress="return isNumberKey(event)" />
                            </div>
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="inputGroupPrepend2">&nbsp;phút</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-5">
                                Chọn khối:
                                <asp:DropDownList ID="ddlKhoi" runat="server" CssClass="form-control" OnChange="DisplayLoadingIcon()" OnSelectedIndexChanged="ddlKhoi_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="col-sm-5">
                                Chọn môn:
                                <asp:DropDownList ID="ddlMon" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlMon_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4" style="margin-top: 3rem">
                            <div class="name-block">Nhập thông tin</div>
                            <div class="popup-main__insert">
                                <dx:ASPxGridLookup ID="lkChuong" Width="100%" runat="server" SelectionMode="Multiple" ClientInstanceName="lkChuong"
                                    KeyFieldName="chapter_id" TextFormatString="{0}" MultiTextSeparator=", " Caption="Chương">
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" />
                                        <dx:GridViewDataColumn FieldName="chapter_name" Caption="Chương" />
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
                                        <SettingsPager PageSize="10" EnableAdaptivity="true" />
                                    </GridViewProperties>
                                </dx:ASPxGridLookup>
                                <asp:Repeater runat="server" ID="rpLesson">
                                    <ItemTemplate>
                                        <label>
                                            <input type="checkbox" id="ck_<%#Eval("lesson_id") %>" name="ckLesson" onclick="checkValue(this.value)" value="<%#Eval("lesson_id") %>">
                                            <%#Eval("lesson_name") %>
                                        </label>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <input type="text" id="txtLessonID" runat="server" style="display: block" hidden="hidden"/>
                            <div class="form-row">
                                <a href="javascript:void(0)" id="btnXemCauHoi" runat="server" onserverclick="btnXemCauHoi_ServerClick" class="btn btn-sm btn-primary up-1 button_xemcauhoi" style="display: none">Xem câu hỏi</a>
                            </div>
                            </div>
                            
                        </div>
                        <div class="col-8 up-1">
                            <div class="content-headertl-out">
                                <span>danh sách câu hỏi</span>
                            <asp:Button Text="Tạo đề" CssClass="btn btn-primary btn-sm" OnClientClick="return checkNULLBai()" ID="btnLuu" runat="server" OnClick="btnLuu_Click" />

                            </div>
                            <div class="form-group table-responsive">
                                <dx:ASPxGridView ID="grvList" runat="server" Width="100%" ClientInstanceName="grvList" KeyFieldName="question_id">
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="5%"></dx:GridViewCommandColumn>
                                        <dx:GridViewDataColumn Caption="Nội dung câu hỏi" HeaderStyle-HorizontalAlign="Center" Width="70%">
                                            <DataItemTemplate>
                                                <%#Eval("noidungcauhoi") %>
                                            </DataItemTemplate>
                                        </dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Dạng câu hỏi" FieldName="question_dangcauhoi" HeaderStyle-HorizontalAlign="Center" Width="5%"></dx:GridViewDataColumn>
                                        <dx:GridViewDataColumn Caption="Mức độ" FieldName="question_level" HeaderStyle-HorizontalAlign="Center" Width="5%"></dx:GridViewDataColumn>
                                    </Columns>
                                    <%--<SettingsSearchPanel Visible="true" />--%>
                                    <Styles>
                                        <Header CssClass="header-table" ForeColor="White" Font-Bold="true"></Header>
                                    </Styles>
                                    <Settings ShowFilterRow="true" />
                                    <SettingsBehavior AllowFocusedRow="true" />
                                    <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                                    <SettingsLoadingPanel Text="Đang tải..." />
                                    <SettingsPager PageSize="1000" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
                                </dx:ASPxGridView>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

