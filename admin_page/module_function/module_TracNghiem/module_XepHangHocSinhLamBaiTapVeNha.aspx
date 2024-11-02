<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_XepHangHocSinhLamBaiTapVeNha.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_XepHangHocSinhLamBaiTapVeNha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
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

        .chon {
            display: flex;
            justify-content: center;
            align-items: end;
        }

        .button-active {
            background-color: #17a2b8 !important;
            border: #17a2b8 !important;
        }
    </style>

    <div class="card section-content">
        <div class="container mt-1">
            <p class="heading-nhapsach">Xếp hạng học sinh làm bài tập về nhà</p>
        </div>
        <div class="chon">
            <span>Chọn lớp
                <dx:ASPxComboBox ID="ddlLop" runat="server" TextField="lop_name" ValueField="lop_id" ValueType="System.Int32" ClientInstanceName="ddlLop" Width="80%" OnSelectedIndexChanged="ddlLop_SelectedIndexChanged" AutoPostBack="true"></dx:ASPxComboBox>
            </span>
            <span>Chọn môn
                <dx:ASPxComboBox ID="ddlMon" runat="server" TextField="mon_name" ValueField="mon_id" ValueType="System.Int32" ClientInstanceName="ddlMon" Width="80%" OnSelectedIndexChanged="ddlMon_SelectedIndexChanged" AutoPostBack="true"></dx:ASPxComboBox>
            </span>
            <span>Chọn bài luyện tập
                <dx:ASPxComboBox ID="ddlBaiLuyenTap" runat="server" TextField="luyentap_name" ValueField="luyentap_id" ValueType="System.Int32" ClientInstanceName="ddlBaiLuyenTap" Width="80%" OnSelectedIndexChanged="ddlBaiLuyenTap_SelectedIndexChanged" AutoPostBack="true"></dx:ASPxComboBox>
            </span>
        </div>
        <div class="form-row">
            <div class="col-12">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>STT</th>
                        <th>Tên học sinh</th>
                        <th>Tên bài</th>
                        <th>Số câu đúng</th>
                        <th>Số lần làm bài</th>
                        <th>thời gian ngắn nhất</th>
                        <th>Chi tiết</th>
                    </tr>

                    <asp:Repeater runat="server" ID="rpXepHangHocSinh">
                        <ItemTemplate>
                            <tr>
                                <th>
                                    <%#Container.ItemIndex+1 %>
                                </th>
                                <td><%#Eval("hocsinh_name") %></td>
                                <td><%#Eval("luyentap_name") %></td>
                                <td><%#Eval("socaudung") %>/<%#Eval("tongsocau") %></td>
                                <td><%#Eval("solanlambai") %></td>
                                <td><%#Eval("thoigianngannhat") %></td>
                                <td>
                                    <a href="javascript:void(0)" class="btn btn-danger" data-toggle="modal" data-target="#modalChiTiet-<%#Eval(" hocsinh_code")%>">Xem</a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>

        </div>
    </div>
    <!-- Modal -->
    <asp:Repeater runat="server" ID="rpModalChiTiet" OnItemDataBound="rpModalChiTiet_ItemDataBound">
        <ItemTemplate>
            <div class="modal fade" id="modalChiTiet-<%#Eval(" hocsinh_code")%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-info text-light">
                            <h5 class="modal-title" id="exampleModalLabel">Lịch sử làm bài: <%#Eval("hocsinh_name") %></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <%--table chi tiết--%>
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <%--<th>Họ tên</th>--%>
                                        <th>Ngày làm</th>
                                        <th>Thời gian làm</th>
                                        <th>Số câu đúng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater runat="server" ID="rpChiTietLamBai">
                                        <ItemTemplate>
                                            <tr>
                                                <th><%#Container.ItemIndex+1 %></th>
                                                <%-- <td><%#Eval("hocsinh_name") %></td>--%>
                                                <td class="tdNgayLamBai-<%#Eval("hocsinh_code") %>"><%#Eval("resulttest_datetime") %></td>
                                                <td><%#Eval("result_thoigianlambai") %></td>
                                                <td class="tdSoCauDung-<%#Eval("hocsinh_code") %>"><%#Eval("resulttest_result") %></td>
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
    <div style="display: none">
        <input type="text" id="txtDSHSDaLamBai" runat="server" />
    </div>

</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

