<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_ThongKeTracNghiem.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_ThongKeTracNghiem" %>

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

        .row-yellow {
            background-color: yellow !important;
        }

        .user-active {
            background: #007bff !important;
            border-color: #007bff !important;
        }

        .table-thongke thead th {
            vertical-align: middle;
        }

        .table-cauhoi thead th {
            background-color: #17a2b8 !important;
            position: sticky;
            top: 0;
            box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.4);
            z-index: 9999;
        }

            .table-cauhoi thead th.header-dapan {
                position: sticky;
                top: 46px;
            }

        .content-cauhoi * {
            font-size: 20px !important;
        }
    </style>
    <div class="loading" id="img-loading-icon" style="display: none">
        <div class="loading">Loading&#8230;</div>
    </div>
    <div class="card">
        <div class="container">
            <div class="form-group-name">
                THỐNG KÊ GIÁO VIÊN NHẬP KHO DỮ LIỆU TRẮC NGHIỆM
            </div>
            <div class="my-3">
                <div class="form-row">
                    <table class="table table-bordered table-hover table-striped table-thongke">
                        <thead>
                            <tr class="text-center">
                                <th>STT</th>
                                <th>Họ tên</th>
                                <th>Tháng 1</th>
                                <th>Tháng 2</th>
                                <th>Tháng 3</th>
                                <th>Tháng 4</th>
                                <th>Tháng 5</th>
                                <th>Tháng 6</th>
                                <th>Tháng 7</th>
                                <th>Tháng 8</th>
                                <th>Tháng 9</th>
                                <th>Tháng 10</th>
                                <th>Tháng 11</th>
                                <th>Tháng 12</th>
                                <th>Tổng</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater runat="server" ID="rpTracNghiem" OnItemDataBound="rpTracNghiem_ItemDataBound">
                                <ItemTemplate>
                                    <tr class='<%#Eval("myclass") %>'>
                                        <th class="text-center"><%#Container.ItemIndex+1 %></th>
                                        <td class="tiet"><%#Eval("username_fullname") %></td>
                                        <asp:Repeater ID="rpThang" runat="server">
                                            <ItemTemplate>
                                                <td class="text-center"><%#Eval("soluong") %></td>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <td class="text-center"><%#Eval("count") %></td>
                                        <td class="text-center"><a href="javascript:void(0)" class="btn btn-danger btn-user" id="btnUser-<%#Eval("username_id") %>" onclick="xemDetail(<%#Eval("username_id") %>)">Xem</a></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <table class="table table-bordered table-hover table-striped table-thongke table-cauhoi" id="div_ketqua">
                    <thead class="text-center bg-info text-light">
                        <tr>
                            <th rowspan="2">STT</th>
                            <th rowspan="2">Khối</th>
                            <th rowspan="2">Môn</th>
                            <th rowspan="2">Bài</th>
                            <th rowspan="2">Câu hỏi</th>
                            <th colspan="4">Đáp án</th>
                            <th rowspan="2" colspan="2">#</th>
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
                                    <td><%#Eval("khoi_name") %></td>
                                    <td><%#Eval("mon_name") %></td>
                                    <td><%#Eval("lesson_name") %></td>
                                    <td class="content-cauhoi"><%#Eval("noidungcauhoi") %></td>
                                    <asp:Repeater ID="rpDapAn" runat="server">
                                        <ItemTemplate>
                                            <td>
                                                <div class="content_image">
                                                    <%#Eval("answer_content") %>
                                                </div>
                                            </td>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <td><a href="#" class="btn btn-success">Duyệt</a></td>
                                    <td><a href="javascript:void(0)" class="btn btn-success">Phản hồi</a></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
                <div style="display: none">
                    <input type="text" id="txtUserID" runat="server" />
                    <a href="#" id="btnChiTiet" runat="server" onserverclick="btnChiTiet_ServerClick">content</a>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <script>
        function DisplayLoadingIcon() {
            $("#img-loading-icon").show();
        }
        function HiddenLoadingIcon() {
            $("#img-loading-icon").hide();
        }
        function xemDetail(id) {

            document.getElementById('<%=txtUserID.ClientID%>').value = id;
            document.getElementById('<%=btnChiTiet.ClientID%>').click();
            DisplayLoadingIcon()
            //$("#img-loading-icon").show();
        }
        function setActive(id) {
            document.querySelectorAll(".btn-user").forEach((elm) => { elm.classList.remove("user-active") })
            HiddenLoadingIcon();
            document.getElementById("btnUser-" + id).classList.add("user-active");
            const element = document.getElementById("div_ketqua");
            //element.offsetTop
            window.scroll(0, element.offsetTop)
            //element.scrollIntoView();
        }
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

