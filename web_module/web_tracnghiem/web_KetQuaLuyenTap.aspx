<%@ Page Title="" Language="C#" MasterPageFile="~/MutipleChoiceMasterPage.master" AutoEventWireup="true" CodeFile="web_KetQuaLuyenTap.aspx.cs" Inherits="web_module_web_tracnghiem_web_KetQuaLuyenTap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headlink" Runat="Server">
     <style>
        
        .correct_question, .correct_question > td, .correct_question > th {
            font-family: 'Times New Roman';
            background-color: #28a745;
        }

            .correct_question, .correct_question > td *, .correct_question > th * {
                background-color: transparent !important;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hihead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="himenu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="higlobal" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="hislider" Runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="hibelowtop" Runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="hibodyhead" Runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="hibodywrapper" Runat="Server">
    <div class="main-bangdiem" id="mainBangDiem">
        <div class="container">
            <h4 class="bangdiem__heading">Kết quả luyện tập</h4>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="bangdiem__content">
                        <table class="table table-bordered">
                            <thead>
                                <tr class="table-info table__point-head">
                                    <th scope="col">STT</th>
                                    <th scope="col">Mã học sinh</th>
                                    <th scope="col">Họ tên</th>
                                    <th scope="col">Môn</th>
                                    <th scope="col">Kết quả</th>
                                    <th scope="col">Ngày làm</th>
                                    <th scope="col">#</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater runat="server" ID="rpBangDiem">
                                    <ItemTemplate>
                                        <tr class="table-light table__point table-hover">
                                            <th scope="row"><%#Container.ItemIndex+1%></th>
                                            <td><%#Eval("hocsinh_code") %></td>
                                            <td><%#Eval("hocsinh_name") %></td>
                                            <td><%#Eval("mon_name") %></td>
                                            <td><%#Eval("resulttest_result") %></td>
                                            <td><%#Eval("resulttest_datetime", "{0: dd-MM-yyyy}") %></td>
                                            <td>
                                                <a id="<%#Eval("resulttest_id") %>" class="button check__point serif glass" href="javascript:void(0)" data-toggle="modal" data-target=".bd-example-modal-lg-<%#Eval("resulttest_id") %>">Xem</a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <%--//popup--%>
    <asp:Repeater ID="rpPopupChiTiet" runat="server" OnItemDataBound="rpPopupChiTiet_ItemDataBound">
        <ItemTemplate>
            <div class="modal fade bd-example-modal-lg-<%#Eval("resulttest_id") %>" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-point-content">
                    <div class="modal-header modal__point bg-light">
                        <h4 class="popup__heading-point">Kết quả chi tiết</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span class="span-icon__popup" aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-content">
                        <div class="popup__body popup__body-point">
                            <table class="table table-bordered">
                                <thead>
                                    <tr class="table-info table__point-head">
                                        <th scope="col">STT</th>
                                        <th scope="col">Nội dung câu hỏi</th>
                                        <th scope="col">Đáp án đúng</th>
                                        <th scope="col">Đáp án chọn</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rpBangDiemDetails" runat="server">
                                        <ItemTemplate>
                                            <tr class="table__point <%#Eval("style") %>">
                                                <th scope="row"><%#Container.ItemIndex+1 %></th>
                                                <td><%#Eval("noidungcauhoi") %></td>
                                                <td><%#Eval("content_dapandung") %></td>
                                                <td><%#Eval("content_dapanchon") %></td>
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
</asp:Content>
<asp:Content ID="Content9" ContentPlaceHolderID="hibodybottom" Runat="Server">
</asp:Content>
<asp:Content ID="Content10" ContentPlaceHolderID="hibelowbottom" Runat="Server">
</asp:Content>
<asp:Content ID="Content11" ContentPlaceHolderID="hifooter" Runat="Server">
</asp:Content>
<asp:Content ID="Content12" ContentPlaceHolderID="hifootersite" Runat="Server">
</asp:Content>

