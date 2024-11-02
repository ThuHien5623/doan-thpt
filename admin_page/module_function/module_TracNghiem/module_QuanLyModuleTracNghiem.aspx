<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_QuanLyModuleTracNghiem.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_QuanLyModuleTracNghiem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="../../../css/pageTest.css" rel="stylesheet" />
    <script>
        function func() {
            popupThemBai.Hide();
            popupControl.Hide();
        }
        function checkNull() {
            var chude = document.getElementById("<%=txtTenChuDe.ClientID%>");
            if (chude.value.trim() == "") {
                swal('Vui lòng nhập chủ đề!', '', 'warning').then(function () { chude.focus(); });
                return false;
            }
            return true;
        }
        function checkThemBai() {
            var bai = document.getElementById("<%=txtTenBai.ClientID%>");
            if (bai.value.trim() == "") {
                swal('Vui lòng nhập tên bài!', '', 'warning').then(function () { bai.focus(); });
                return false;
            }
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
    </style>
    <div class="card section-content">
        <div class="container-fluid mt-1">
            <p class="heading-nhapsach">KHO DỮ LIỆU</p>
            <div class="form-group">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div style="display: flex;">
                            <div>
                                <b>Chọn khối</b>
                                <%--<asp:DropDownList ID="ddlKhoi" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlKhoi_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>--%>
                                <asp:DropDownList ID="ddlKhoi" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlKhoi_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Text="" Value="" />
                                    <asp:ListItem Text="Khối 6" Value="6" />
                                    <asp:ListItem Text="Khối 7" Value="7" />
                                    <asp:ListItem Text="Khối 8" Value="8" />
                                    <asp:ListItem Text="Khối 9" Value="9" />
                                    <asp:ListItem Text="Khối 10" Value="10" />
                                    <asp:ListItem Text="Khối 11" Value="11" />
                                    <asp:ListItem Text="Khối 12" Value="12" />
                                </asp:DropDownList>
                            </div>
                            <div class="mx-1" style="width: 150px">
                                <b>Chọn môn</b>
                                <asp:DropDownList ID="ddlMon" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlMon_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div style="min-width: 150px">
                                <b>Chủ đề</b>
                                <asp:DropDownList ID="ddlChuDe" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlChuDe_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="mx-1" style="min-width: 150px">
                                <b>Chọn Bài</b>
                                <asp:DropDownList ID="ddlBai" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br />
                <div class="col-12">
                    <span style="color: red; font-weight:500"> Yêu cầu số lượng câu hỏi: Thầy/Cô nhập tối thiểu 30 câu hỏi trắc nghiệm cho 1 bài học </span>
                    <br />
                    Note: Nội dung đặc tả các thầy/cô có thể nhập bổ sung sau!
                </div>
                <div class="mt-1">
                    <asp:UpdatePanel ID="UpdatePanel" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="btnThemChuDe" runat="server" Text="Thêm chủ đề" OnClick="btnThemChuDe_ServerClick" CssClass="btn btn-primary mb-1" />
                            <asp:Button ID="btnCapNhatChuDe" runat="server" Text="Đổi tên chủ đề" OnClick="btnCapNhatChuDe_Click" CssClass="btn btn-primary mb-1" />
                            <asp:Button ID="btnThemBai" runat="server" Text="Thêm bài" OnClick="btnThemBai_Click" CssClass="btn btn-primary mb-1" />
                            <asp:Button ID="btnCapNhatBai" runat="server" Text="Đổi tên bài" OnClick="btnCapNhatBai_Click" CssClass="btn btn-primary mb-1" />
                            <a href="/admin-dac-ta" class="btn btn-primary">Thêm đặc tả</a>
                            <a href="#" id="btnThemCauHoiTracNghiem" runat="server" class="btn btn-primary mb-1" onserverclick="btnThemCauHoiTracNghiem_ServerClick">Nhập kho trắc nghiệm</a>
                            <asp:Button ID="btnThemCauHoiTracNghiem2" runat="server" ClientIDMode="Static" Text="Nhập kho trắc nghiệm phần 2" CssClass="btn btn-primary mb-1" OnClick="btnThemCauHoiTracNghiem2_Click" />
                            <asp:Button ID="btnThemCauHoiTracNghiem3" runat="server" ClientIDMode="Static" Text="Nhập kho trắc nghiệm phần 3" CssClass="btn btn-primary mb-1" OnClick="btnThemCauHoiTracNghiem3_Click" />
                            <a href="#" id="btnThemCauHoiTuLuan" runat="server" class="btn btn-primary mb-1" onserverclick="btnThemCauHoiTuLuan_ServerClick">Nhập kho tự luận</a>
                            <asp:Button ID="btnXemTruocCauHoi" runat="server" ClientIDMode="Static" Text="Xem câu hỏi" CssClass="btn btn-primary mb-1" OnClientClick="DisplayLoadingIcon()" OnClick="btnXemTruocCauHoi_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="mt-2">
                    <p class="heading-nhapsach">THỐNG KÊ NHẬP KHO DỮ LIỆU</p>
                </div>
                <div class="form-row row">
                    <table class="table table-bordered table-hover table-striped table-thongke">
                        <thead>
                            <tr class="text-center">
                                <th>Khối</th>
                                <th>Chủ đề</th>
                                <th>Bài</th>
                                <th>Tổng câu hỏi đã nhập</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater runat="server" ID="rpDanhSachBai">
                                <ItemTemplate>
                                    <tr>
                                        <td><%#Eval("khoi_name") %></td>
                                        <td><%#Eval("chapter_name") %></td>
                                        <td><%#Eval("lesson_name") %></td>
                                        <td><%#Eval("count") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
                <div class="form-row row">
                    <table class="table table-bordered table-hover table-striped table-thongke">
                        <thead>
                            <tr class="text-center">
                                <th>Tháng</th>
                                <%-- <th>Họ tên</th>--%>
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
                                <th>Số câu đã được duyệt</th>
                                <th>Số câu được y/c phản hồi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>Số câu đã nhập</th>
                                <%--<th class="text-center"><%#Container.ItemIndex+1 %></th>
                                        <td class="tiet"><%#Eval("username_fullname") %></td>--%>
                                <asp:Repeater ID="rpThongKeTracNghiem" runat="server">
                                    <ItemTemplate>
                                        <td class="text-center"><%#Eval("soluong") %></td>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <%-- <td class="text-center"><%#Eval("countDuyet") %></td>
                                <td class="text-center"><%#Eval("countPhanHoi") %></td>--%>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <dx:ASPxPopupControl ID="popupControl" runat="server" Width="460px" Height="180px" CloseAction="CloseButton" ShowCollapseButton="True" ShowMaximizeButton="True" ScrollBars="Auto" CloseOnEscape="true" Modal="True"
                    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popupControl" ShowFooter="true"
                    HeaderText="Thêm chủ đề" AllowDragging="True" PopupAnimationType="Fade" EnableViewState="False" AutoUpdatePosition="true">
                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server">
                            <asp:UpdatePanel ID="udPopup" runat="server">
                                <ContentTemplate>
                                    <div class="popup-main">
                                        <asp:TextBox ID="txtTenChuDe" runat="server" ClientIDMode="Static" CssClass="form-control"> </asp:TextBox>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                    <FooterContentTemplate>
                        <div class="mar_but ">
                            <asp:UpdatePanel ID="udSave" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnLuu" runat="server" ClientIDMode="Static" Text="Lưu" CssClass="btn btn-primary" OnClientClick="return checkNull()" OnClick="btnLuu_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </FooterContentTemplate>
                    <ContentStyle>
                        <Paddings PaddingBottom="0px" />
                    </ContentStyle>
                </dx:ASPxPopupControl>
                <dx:ASPxPopupControl ID="popupThemBai" runat="server" Width="460px" Height="180px" CloseAction="CloseButton" ShowCollapseButton="True" ShowMaximizeButton="True" ScrollBars="Auto" CloseOnEscape="true" Modal="True"
                    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popupThemBai" ShowFooter="true"
                    HeaderText="Thêm bài" AllowDragging="True" PopupAnimationType="Fade" EnableViewState="False" AutoUpdatePosition="true">
                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="popup-main">
                                        <asp:TextBox ID="txtTenBai" runat="server" ClientIDMode="Static" CssClass="form-control"> </asp:TextBox>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                    <FooterContentTemplate>
                        <div class="mar_but">
                            <asp:UpdatePanel ID="udSave" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnLuuBai" runat="server" ClientIDMode="Static" Text="Lưu" CssClass="btn btn-primary" OnClientClick="return checkThemBai()" OnClick="btnLuuBai_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </FooterContentTemplate>
                    <ContentStyle>
                        <Paddings PaddingBottom="0px" />
                    </ContentStyle>
                </dx:ASPxPopupControl>
            </div>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="home page-view">
                        <div id="content-main">
                            <div class="container">
                                <div class="testing m-bottom get_width" id="content-test-detail">
                                    <div id="questionlist" data-exam-id="435">
                                        <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoi_ItemDataBound">
                                            <ItemTemplate>
                                                <div class="question-box">
                                                    <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                                        <div class="panel-body">
                                                            <div class="m-bottom question ">
                                                                <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong><%#Eval("noidungcauhoi") %>
                                                            </div>
                                                            <input type="text" name="txtQuestionID" value="<%#Eval("question_id") %>" hidden="hidden" />
                                                            <div class="row answer">
                                                                <%--<div class="flex">--%>
                                                                <asp:Repeater runat="server" ID="rpCauTraLoi">
                                                                    <ItemTemplate>
                                                                        <div class="answer-item col-sm-12 col-md-6">
                                                                            <label class="radio_question">
                                                                                <%#Eval("name_label") %>.&nbsp;<%#Eval("answer_content") %>
                                                                            </label>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                                <%--</div>--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

