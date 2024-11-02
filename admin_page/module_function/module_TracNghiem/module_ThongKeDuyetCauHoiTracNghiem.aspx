<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_ThongKeDuyetCauHoiTracNghiem.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_ThongKeDuyetCauHoiTracNghiem" %>

<%@ Register Src="~/web_usercontrol/Uc_MenuThongKeQuanTri.ascx" TagPrefix="uc1" TagName="Uc_MenuThongKeQuanTri" %>

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

        .giaovien-item--active * {
            background-color: #dc3545 !important;
            color: #fff !important;
        }

        .user-active {
            background: #007bff !important;
            border-color: #007bff !important;
        }

        .content-cauhoi * {
            font-size: 20px !important;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("a#btn_tknx8").addClass("active");
        });
    </script>
    <div class="loading" id="img-loading-icon" style="display: none">
        <div class="loading">Loading&#8230;</div>
    </div>
     <input type="text" id="subMenu" value="7" hidden />
    <div class="container-fluid">
        <div class="block-card ">
            <div class="block-style block-style-1">
                <div class="block-menu">
                    <uc1:Uc_MenuThongKeQuanTri runat="server" ID="Uc_MenuThongKeQuanTri" />
                </div>
                <div class="block-content">
                    <div class="buttom-tab">
                        <a href="/admin-thong-ke-giao-vien-nhap-cau-hoi-trac-nghiem" onclick="DisplayLoadingIcon()" class="btn btn-primary btn-sm buttom-edit" >Thống kê nhập kho dữ liệu</a>
                        <a href="/admin-thong-ke-duyet-cau-hoi-kho-du-lieu" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm buttom-edit" style="border-color: rgb(143, 1, 0); background-color: rgb(143, 1, 0);">Thống kê duyệt câu hỏi</a>
                        <a href="/admin-thong-ke-tao-de-luyen-tap" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm buttom-edit">Thống kê tạo đề</a>
                        <a href="/admin-thong-ke-ket-qua-luyen-tap-tong" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm buttom-edit">Thống kê kết quả luyện tập</a>
                    </div>
                    <div class="my-3">
                        <div class="form-row">
                            <table class="table table-bordered table-hover table-striped table-thongke">
                                <tr class="text-center">
                                    <th>STT</th>
                                    <th>Giáo viên</th>
                                    <th>SL câu hỏi đã nhập</th>
                                    <th>SL câu hỏi đã được duyệt</th>
                                    <th>SL câu hỏi y/c phản hồi</th>
                                </tr>
                                <asp:Repeater runat="server" ID="rpDanhSach">
                                    <ItemTemplate>
                                        <tr>
                                            <th class="text-center"><%#Container.ItemIndex+1 %></th>
                                            <td class="tiet"><%#Eval("username_fullname") %></td>
                                            <td class="text-center"><%#Eval("countdanhap") %></td>
                                            <td class="text-center"><%#Eval("countdaduyet") %></td>
                                            <td class="text-center"><%#Eval("countphanhoi") %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </div>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <p class="font-weight-bold">2. Thống kê duyệt câu hỏi</p>
                                <div class="form-row">
                                    <div class="col-4">
                                        <table class="table table-bordered table-hover table-striped table-thongke">
                                            <tr class="text-center">
                                                <th>STT</th>
                                                <th>Người duyệt</th>
                                                <th>SL câu hỏi đã duyệt</th>
                                                <th>SL câu hỏi đã phản hồi</th>
                                                <th></th>
                                            </tr>
                                            <asp:Repeater runat="server" ID="rpDanhSachDuyet">
                                                <ItemTemplate>
                                                    <tr id="giaovien-<%#Eval("username_id") %>" class="giaovien-item">
                                                        <th class="text-center"><%#Container.ItemIndex+1 %></th>
                                                        <td class="tiet"><%#Eval("username_fullname") %></td>
                                                        <td class="text-center"><%#Eval("countdaduyet") %></td>
                                                        <td class="text-center"><%#Eval("countphanhoi") %></td>
                                                        <td class="text-center">
                                                            <a href="javascript:void(0)" onclick="xemChiTiet(<%#Eval("username_id") %>)">Chi tiết</a>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                    <div class="col-8">
                                        <table class="table table-bordered table-hover table-striped table-thongke table-cauhoi" id="div_ketqua">
                                            <tr>
                                                <th>STT</th>
                                                <th>Khối</th>
                                                <th>Môn</th>
                                                <th>Chủ đề</th>
                                                <th>Câu hỏi</th>
                                                <th>Người nhập</th>
                                            </tr>
                                            <asp:Repeater runat="server" ID="rpDanhSachCauHoiDaDuyet">
                                                <ItemTemplate>
                                                    <tr>
                                                        <th class="text-center"><%#Container.ItemIndex+1 %></th>
                                                        <td><%#Eval("khoi_name") %></td>
                                                        <td><%#Eval("mon_name") %></td>
                                                        <td><%#Eval("lesson_name") %></td>
                                                        <td class="content-cauhoi"><%#Eval("noidungcauhoi") %></td>
                                                        <td><%#Eval("nguoinhap") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </table>
                                    </div>
                                </div>
                                <div style="display: none">
                                    <input type="text" id="txtUserID" runat="server" />
                                    <a href="#" id="btnChiTiet" runat="server" onserverclick="btnChiTiet_ServerClick">chi tiết</a>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function xemChiTiet(id) {
            document.getElementById('<%=txtUserID.ClientID%>').value = id;
            document.getElementById('<%=btnChiTiet.ClientID%>').click();
        }
        function setActive(id) {
            document.querySelectorAll(".giaovien-item").forEach((elm) => { elm.classList.remove("giaovien-item--active") })
            HiddenLoadingIcon();
            document.getElementById("giaovien-" + id).classList.add("giaovien-item--active");
        }
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

