<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_ThongKeTaoDeLuyenTap.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_ThongKeTaoDeLuyenTap" %>

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
        .chart-info {
            display: flex;
            justify-content: center;
            color: black
        }

            .chart-info .chart-title {
                font-weight: 600
            }
    </style>
    <script>
        $(document).ready(function () {
            $("a#btn_tknx8").addClass("active");
        });
    </script>
       <input type="text" id="subMenu" value="7" hidden />
    <div class="container-fluid">
        <div class="card ">
            <div class="block-style block-style-1">
                <div class="block-menu">
                    <uc1:Uc_MenuThongKeQuanTri runat="server" ID="Uc_MenuThongKeQuanTri" />
                </div>
                <div class="block-content">
                    <div class="buttom-tab">
                        <a href="/admin-thong-ke-giao-vien-nhap-cau-hoi-trac-nghiem" onclick="DisplayLoadingIcon()" class="btn btn-primary btn-sm buttom-edit">Thống kê nhập kho dữ liệu</a>
                        <a href="/admin-thong-ke-duyet-cau-hoi-kho-du-lieu" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm buttom-edit">Thống kê duyệt câu hỏi</a>
                        <a href="/admin-thong-ke-tao-de-luyen-tap" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm buttom-edit" style="border-color: rgb(143, 1, 0); background-color: rgb(143, 1, 0);">Thống kê tạo đề</a>
                        <a href="/admin-thong-ke-ket-qua-luyen-tap-tong" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm buttom-edit">Thống kê kết quả luyện tập</a>
                    </div>
                    <div class="">
                        <table class="table up-1">
                            <thead>
                                <tr class="text-center">
                                    <th>STT</th>
                                    <th>Họ tên</th>
                                    <th>Tên khối: đề đã duyệt / tổng số đề </th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater runat="server" ID="rpTracNghiem" OnItemDataBound="rpTracNghiem_ItemDataBound">
                                    <ItemTemplate>
                                        <tr>
                                            <td style="text-align: center"><%#Container.ItemIndex+1 %></td>
                                            <td class="tiet"><%#Eval("username_fullname") %></td>
                                            <td class="">
                                                <div class="card-chart-small">
                                                    <asp:Repeater ID="rpDanhSachLop" runat="server">
                                                        <ItemTemplate>
                                                            <a href="javascript:void(0)" data-toggle="modal" data-target="#exampleModal-<%#Eval("khoi_id")%>-<%#Eval("username_id")%>">
                                                                <div class="chart-item chart-item-<%#Eval("khoi_id") %>">
                                                                    <div class="chart-info">
                                                                        <div class="chart-title">
                                                                            <%#Eval("khoi_name").ToString().Split(' ')[1] %>
                                                                        </div>
                                                                        <div class="chart-density">
                                                                            <span class="title">:</span>&nbsp;<span class="number"><%#Eval("tongduyet") %>/<%#Eval("tongde") %></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <%--modal--%>
                                                    <asp:Repeater ID="rpModalChiTiet" runat="server" OnItemDataBound="rpModalChiTiet_ItemDataBound">
                                                        <ItemTemplate>
                                                            <div class="modal fade" id="exampleModal-<%#Eval("khoi_id")%>-<%#Eval("username_id")%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                                <div class="modal-dialog modal-lg" role="document">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header bg-info text-light">
                                                                            <h5 class="modal-title" id="exampleModalLabel">Chi tiết tạo đề của giáo viên <%#Eval("username_fullname")%> - <%#Eval("khoi_name")%></h5>
                                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                <span aria-hidden="true">&times;</span>
                                                                            </button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <table class="table ">
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th scope="col">#</th>
                                                                                        <th scope="col">Tên đề</th>
                                                                                        <th scope="col">Môn</th>
                                                                                        <th scope="col">Khối</th>
                                                                                        <th scope="col">Tổng câu hỏi</th>
                                                                                        <th scope="col">Thời gian</th>
                                                                                        <th scope="col">Tình trạng</th>
                                                                                        <th scope="col">Ngày tạo</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <asp:Repeater ID="rpChiTiet" runat="server">
                                                                                        <ItemTemplate>
                                                                                            <tr>
                                                                                                <th scope="row"><%#Container.ItemIndex+1 %></th>
                                                                                                <td><%#Eval("luyentap_name") %></td>
                                                                                                <td><%#Eval("mon_name") %></td>
                                                                                                <td><%#Eval("khoi_name") %></td>
                                                                                                <td><%#Eval("soluongcauhoi") %></td>
                                                                                                <td><%#Eval("thoigianlambai") %></td>
                                                                                                <td><%#Eval("tinhtrang") %></td>
                                                                                                <td><%# Convert.ToDateTime(Eval("test_createdate")).ToString("dd/MM/yyyy") %></td>
                                                                                            </tr>
                                                                                        </ItemTemplate>
                                                                                    </asp:Repeater>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </td>
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

