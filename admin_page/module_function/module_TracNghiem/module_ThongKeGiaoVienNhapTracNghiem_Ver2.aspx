﻿<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_ThongKeGiaoVienNhapTracNghiem_Ver2.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_ThongKeGiaoVienNhapTracNghiem" %>

<%@ Register Src="~/web_usercontrol/Uc_MenuThongKeQuanTri.ascx" TagPrefix="uc1" TagName="Uc_MenuThongKeQuanTri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
     <script>
        $(document).ready(function () {
            $("a#btn_tknx8").addClass("active");
        });
     </script>
    <div class="container-fluid">
        <div class="loading" id="img-loading-icon" style="display: none">
            <div class="loading">Loading&#8230;</div>
        </div>
        <div class="block-card ">
            <div class="block-style block-style-1">
                <div class="block-menu">
                    <uc1:Uc_MenuThongKeQuanTri runat="server" ID="Uc_MenuThongKeQuanTri" />
                </div>
                <div class="block-content">
                    <div class="text-center">
                        <a href="/admin-thong-ke-giao-vien-nhap-cau-hoi-trac-nghiem" onclick="DisplayLoadingIcon()" class="btn btn-primary btn-sm my-1" style="border: rgb(143, 1, 0); background-color: rgb(143, 1, 0);">Thống kê nhập kho dữ liệu</a>
                        <a href="/admin-thong-ke-duyet-cau-hoi-kho-du-lieu" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm mx-1 my-1">Thống kê duyệt câu hỏi</a>
                        <a href="/admin-thong-ke-tao-de-luyen-tap" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm mx-1 my-1">Thống kê tạo đề</a>
                        <a href="/admin-thong-ke-ket-qua-luyen-tap-tong" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm mx-1 my-1">Thống kê kết quả luyện tập</a>
                    </div>
                    <%-- <div class="block-content__header">
                        <div class="title">THỐNG KÊ GIÁO VIÊN NHẬP KHO DỮ LIỆU</div>
                    </div>--%>
                    <div class="">
                        <table class="table table-bordered table-hover table-striped table-thongke">
                            <thead>
                                <tr class="text-center">
                                    <th>STT</th>
                                    <th>Họ tên</th>
                                   <%-- <asp:Repeater runat="server" ID="rpThang">
                                        <ItemTemplate>
                                            <th>Tháng <%#Container.ItemIndex+1 %></th>
                                        </ItemTemplate>
                                    </asp:Repeater>--%>
                                    <%--<th>Tháng 1</th>
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
                                    <th>Tháng 12</th>--%>
                                    <th>Tổng đã nhập</th>
                                    <%--<th>Tổng đã được duyệt</th>--%>
                                    <th>Tình trạng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater runat="server" ID="rpTracNghiem" OnItemDataBound="rpTracNghiem_ItemDataBound">
                                    <ItemTemplate>
                                        <tr class=''>
                                            <th class="text-center"><%#Container.ItemIndex+1 %></th>
                                            <td class="tiet"><%#Eval("username_fullname") %></td>
                                           <%-- <asp:Repeater ID="rpThang" runat="server">
                                                <ItemTemplate>
                                                    <td class="text-center" style=""><%#Eval("soluong") %></td>
                                                </ItemTemplate>
                                            </asp:Repeater>--%>
                                            <td class="text-center"><%#Eval("count") %>/500</td>
                                            <td class="text-center font-weight-bold"><%#Eval("tinhtrang") %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>
