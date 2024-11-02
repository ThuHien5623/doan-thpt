<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_DuyetCauHoiTracNghiem.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_DuyetCauHoiTracNghiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="../../../admin_css/css_index/Loading.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
    <style>
        .form-group-name {
            font-size: 28px;
            font-weight: bold;
            text-align: center;
            color: #1550da;
            display: flex;
            justify-content: center;
            padding: 2% 0;
        }


        .table-thongke thead th {
            vertical-align: middle;
        }

        .table-cauhoi {
            width: 100%;
        }

            .table-cauhoi th {
                padding: 0.75rem;
            }

            .table-cauhoi thead th {
                background-color: #17a2b8 !important;
                position: sticky;
                top: 0;
                box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.4);
                /*z-index: 9999;*/
            }

                .table-cauhoi thead th.header-dapan {
                    position: sticky;
                    top: 46px;
                    max-width: 100%;
                }

        .content-cauhoi * {
            font-family: 'Times New Roman' !important;
            font-size: 20px !important;
        }

        .content_image * {
            font-family: 'Times New Roman' !important;
            background: transparent !important;
        }

        .chon {
            display: flex;
            justify-content: center;
            align-items: end;
            margin-bottom: 15px;
        }
    </style>
    <div class="loading" id="img-loading-icon" style="display: none">
        <div class="loading">Loading&#8230;</div>
    </div>
    <div class="card">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="container">
                    <div class="form-group-name">
                        DUYỆT CÂU HỎI KHO DỮ LIỆU TRẮC NGHIỆM
                    </div>
                    <div class="text-center">
                        Tổng câu hỏi đã duyệt:
                        <asp:Label Text="0" ID="txtTongDuyet" runat="server" />
                    </div>
                    <div class="chon">
                        <span>Chọn giáo viên
                <dx:ASPxComboBox ID="ddlGiaoVien" runat="server"
                    TextField="username_fullname" ValueField="username_id" ValueType="System.Int32" ClientInstanceName="ddlGiaoVien" Width="80%" OnSelectedIndexChanged="ddlGiaoVien_SelectedIndexChanged" AutoPostBack="true">
                </dx:ASPxComboBox>
                        </span>
                        <span>Chọn môn
            <dx:ASPxComboBox ID="ddlMon" runat="server"
                TextField="mon_name" ValueField="mon_id" ValueType="System.Int32" ClientInstanceName="ddlMon" Width="80%">
            </dx:ASPxComboBox>
                        </span>
                        <span class="mr-1">Chọn khối
                 <asp:DropDownList ID="ddlKhoi" runat="server" CssClass="form-control">
                     <asp:ListItem Text="" Value="" />
                     <asp:ListItem Text="Khối 6" Value="6" />
                     <asp:ListItem Text="Khối 7" Value="7" />
                     <asp:ListItem Text="Khối 8" Value="8" />
                     <asp:ListItem Text="Khối 9" Value="9" />
                     <asp:ListItem Text="Khối 10" Value="10" />
                     <asp:ListItem Text="Khối 11" Value="11" />
                     <asp:ListItem Text="Khối 12" Value="12" />
                 </asp:DropDownList>
                        </span>
                        <a href="javascript:void(0)" class="btn btn-primary" id="btnXemCauHoi" runat="server" onclick="DisplayLoadingIcon()" onserverclick="btnXemCauHoi_ServerClick">Xem</a>
                    </div>
                </div>
                <div class="container-fluid">
                    <table class="table-bordered table-hover table-striped table-thongke table-cauhoi" id="div_ketqua">
                        <thead class="text-center bg-info text-light">
                            <tr>
                                <th rowspan="2">STT</th>
                                <%--<th rowspan="2">Khối</th>--%>
                                <th rowspan="2">Môn</th>
                                <th rowspan="2">Bài</th>
                                <th rowspan="2">Câu hỏi</th>
                                <th colspan="4">Đáp án</th>
                                <th rowspan="2">#</th>
                            </tr>
                            <tr>
                                <th class="header-dapan">Đáp án A</th>
                                <th class="header-dapan">Đáp án B</th>
                                <th class="header-dapan">Đáp án C</th>
                                <th class="header-dapan">Đáp án D</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater runat="server" ID="rpDanhSachCauHoi" OnItemDataBound="rpDanhSachCauHoi_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <th class="text-center"><%#Container.ItemIndex+1 %></th>
                                        <%-- <td><%#Eval("khoi_name") %></td>--%>
                                        <td><%#Eval("mon_name") %></td>
                                        <td><%#Eval("lesson_name") %></td>
                                        <td class="content-cauhoi"><%#Eval("noidungcauhoi") %></td>
                                        <asp:Repeater ID="rpDapAn" runat="server">
                                            <ItemTemplate>
                                                <td style="max-width: 250px;">
                                                    <div class="content_image" <%#Eval("mystyle") %>>
                                                        <%#Eval("answer_content") %>
                                                    </div>
                                                </td>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <td>
                                            <a href="javascript:void(0)" onclick="duyetCauHoi(<%#Eval("question_id") %>)" class="btn btn-sm btn-success m-1">Duyệt</a>
                                            <a href="javascript:void(0)" onclick="getPhanHoi(<%#Eval("question_id") %>)" class="btn  btn-sm btn-success">Phản hồi</a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div style="display: none">
                    <input type="text" id="txtQuestionID" runat="server" />
                    <a href="#" id="btnDuyet" runat="server" onserverclick="btnDuyet_ServerClick">content</a>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <a href="#" id="btnShowModalPhanHoi" class="btn btn-link" data-toggle="modal" data-target="#exampleModal" style="display: none">show form phản hồi</a>
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Nội dung phản hồi</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <textarea class="form-control" rows="3" id="txtPhanHoi" runat="server"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <asp:Button ID="btnLuuPhanHoi" runat="server" ClientIDMode="Static" Text="Lưu" CssClass="btn btn-primary" OnClientClick="return checkNullPhanHoi()" OnClick="btnLuuPhanHoi_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function DisplayLoadingIcon() {
            $("#img-loading-icon").show();
        }
        function HiddenLoadingIcon() {
            $("#img-loading-icon").hide();
        }
        function duyetCauHoi(id) {
            document.getElementById('<%=txtQuestionID.ClientID%>').value = id;
            document.getElementById('<%=btnDuyet.ClientID%>').click();
            DisplayLoadingIcon();
        }
        function getPhanHoi(id) {
            document.getElementById("<%=txtQuestionID.ClientID%>").value = id;
            document.getElementById("btnShowModalPhanHoi").click();
        }
        function setActive(id) {
            document.querySelectorAll(".btn-user").forEach((elm) => { elm.classList.remove("user-active") })
            HiddenLoadingIcon();
            document.getElementById("btnUser-" + id).classList.add("user-active");
            const element = document.getElementById("div_ketqua");
            window.scroll(0, element.offsetTop)
        }
        function checkNullPhanHoi() {
            var tenCongViec = document.getElementById('<%= txtPhanHoi.ClientID%>');
            if (tenCongViec.value.trim() == "") {
                swal('Nội dung phản hồi không được để trống!', '', 'warning').then(function () { tenCongViec.focus(); });
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

