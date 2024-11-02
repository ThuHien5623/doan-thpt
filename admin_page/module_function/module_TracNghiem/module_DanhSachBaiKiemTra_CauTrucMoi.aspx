<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_DanhSachBaiKiemTra_CauTrucMoi.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_DanhSachBaiKiemTra_CauTrucMoi" %>

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
        function confirmDel() {
            swal("Bạn có thực sự muốn xóa?",
                "Nếu xóa, dữ liệu sẽ không thể khôi phục.",
                "warning",
                {
                    buttons: true,
                    dangerMode: true
                }).then(function (value) {
                    if (value == true) {
                        var xoa = document.getElementById('<%=btnXoa.ClientID%>');
                        xoa.click();
                    }
                });
        }
        function confirmDelete(id) {
            swal("Bạn có thực sự muốn xóa nội dung câu hỏi?",
                "Nếu xóa, dữ liệu sẽ không thể khôi phục.",
                "warning",
                {
                    buttons: true,
                    dangerMode: true
                }).then(function (value) {
                    if (value == true) {
                        document.getElementById('<%=txtCauHoiID.ClientID%>').value = id;
                        document.getElementById('<%=btnXoaCauHoi.ClientID%>').click();
                    }
                });
        }
        function checkNULL() {
            var tenBLT = document.getElementById('<%= txtTenBaiLuyenTap.ClientID%>');

            if (tenBLT.value.trim() == "") {
                swal('Tên bài luyện tập không được để trống!', '', 'warning').then(function () { tenBLT.focus(); });
                return false;
            }
            return true;
        }
        function viewDetail(id) {
            document.getElementById('<%=txtBaiKiemTraID.ClientID%>').value = id;
            document.getElementById('<%=btnXemChiTiet.ClientID%>').click();
        }
    </script>

    <style>
        .heading-nhapsach {
            font-size: 40px;
            font-weight: bold;
            text-align: center;
            color: darkblue;
        }
    </style>
    <link href="../../../css/pageTest.css?v=1" rel="stylesheet" />
    <div class="card section-content">
        <div class="container-fluid mt-1">
            <p class="heading-nhapsach">Danh sách bài kiểm tra</p>
            <input type="text" name="name" value="" hidden="hidden" runat="server" id="id_key" placeholder="id_click" />
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <a class="btn btn-primary" href="/admin-danh-sach-bai-kiem-tra-kieu-moi-0">Tạo bài kiểm tra mới</a>
                    <a class="btn btn-primary" href="#" id="btnChiTiet" runat="server" onserverclick="btnChiTiet_ServerClick">Chi tiết</a>
                    <a class="btn btn-primary" href="#" id="btnCapNhat" runat="server" onserverclick="btnCapNhat_ServerClick">Thay đổi tên bài</a>
                    <input type="submit" class="btn btn-primary" value="Xóa" onclick="confirmDel()" />
                    <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" />
                    <a class="btn btn-primary" href="#" id="btnHidden" runat="server" onserverclick="btnHidden_ServerClick">Chuyển cho học sinh làm bài</a>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="form-group table-responsive">
                <dx:ASPxGridView ID="grvList" runat="server" ClientInstanceName="grvList" KeyFieldName="baikiemtra_id" Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="0%">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataColumn Caption="STT" HeaderStyle-HorizontalAlign="Center" Width="0%">
                            <DataItemTemplate>
                                <%#Container.ItemIndex+1 %>
                            </DataItemTemplate>
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Khối" FieldName="khoi_name" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Môn học" FieldName="mon_name" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Tên bài kiểm tra" FieldName="baikiemtra_name" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Ngày tạo" FieldName="baikiemtra_ngaytao" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Tình trạng" FieldName="status" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Tình trạng hiển thị" FieldName="baikiemtra_tinhtrang" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn HeaderStyle-HorizontalAlign="Center" Width="0%">
                            <DataItemTemplate>
                                <a href="/admin-xem-truoc-bai-kiem-tra-kieu-moi-<%#Eval("baikiemtra_id") %>" id="<%#Eval("baikiemtra_id") %>" class="btn btn-sm btn-primary text-light">Xem đề</a>
                            </DataItemTemplate>
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn HeaderStyle-HorizontalAlign="Center" Width="0%">
                            <DataItemTemplate>
                                <a href="javascript:void(0)" onclick="viewDetail(<%#Eval("baikiemtra_id") %>)" class="btn btn-sm btn-primary text-light">Cập nhật đề</a>
                            </DataItemTemplate>
                        </dx:GridViewDataColumn>
                    </Columns>
                    <SettingsSearchPanel Visible="true" />
                    <SettingsBehavior AllowFocusedRow="true" />
                    <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                    <SettingsLoadingPanel Text="Đang tải..." />
                    <SettingsPager PageSize="10" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
                </dx:ASPxGridView>
            </div>
        </div>
    </div>

    <dx:ASPxPopupControl ID="popupControl" runat="server" Width="800" Height="400" CloseAction="CloseButton" ShowCollapseButton="True" ShowMaximizeButton="True" ScrollBars="Auto" CloseOnEscape="true" Modal="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ClientInstanceName="popupControl" ShowFooter="true"
        HeaderText="Bài kiểm tra" AllowDragging="True" PopupAnimationType="Fade" EnableViewState="False" AutoUpdatePosition="true" ClientSideEvents-CloseUp="function(s,e){grvList.Refresh();}">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <asp:UpdatePanel ID="udPopup" runat="server">
                    <ContentTemplate>
                        <div class="popup-main">
                            <div class="div_content col-12">
                                <div class="form-row">
                                    <label class="col-sm-2 form-control-label">Tên bài kiểm tra:</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="txtTenBaiLuyenTap" runat="server" ClientIDMode="Static" CssClass="form-control boxed" Width="100%"> </asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <FooterContentTemplate>
            <div class="mar_but button" id="buttonUpdate">
                <asp:UpdatePanel ID="udSave" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnCapNhatTen" runat="server" ClientIDMode="Static" Text="Lưu" CssClass="btn btn-primary" OnClientClick="return checkNULL()" OnClick="btnCapNhatTen_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </FooterContentTemplate>
        <ContentStyle>
            <Paddings PaddingBottom="0px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <input type="text" id="txtBaiKiemTraID" runat="server" style="display: none" />
            <a href="javascript:void(0)" id="btnXemChiTiet" runat="server" onserverclick="btnXemChiTiet_ServerClick"></a>
            <input type="text" id="txtCauHoiID" runat="server" style="display: none" />
            <a href="javascript:void(0)" id="btnXoaCauHoi" runat="server" onserverclick="btnXoaCauHoi_ServerClick"></a>
            <div class="card">
                <div class="testing m-bottom get_width p-3" id="content-test-detail">
                    <p><b>PHẦN I: Câu hỏi trắc nghiệm 4 lựa chọn </b></p>
                    <div id="questionlist" data-exam-id="435">
                        <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoi_ItemDataBound">
                            <ItemTemplate>
                                <div class="question-box">
                                    <div class="panel panel-default question-item">
                                        <div class="panel-body">
                                            <div class="m-bottom question ">
                                                <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong>
                                                <br />
                                                <%#Eval("noidungcauhoi") %>
                                            </div>
                                            <input type="text" name="txtQuestionID" value="<%#Eval("question_id") %>" hidden="hidden" />
                                            <div class="row answer">
                                                <asp:Repeater runat="server" ID="rpCauTraLoi">
                                                    <ItemTemplate>
                                                        <div class="answer-item col-sm-12 col-md-6">
                                                            <label class="radio_question">
                                                                <b>  <%#Eval("name_label") %>.</b><%#Eval("answer_content") %>
                                                            </label>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </div>
                                        </div>
                                        <a href="javascript:void(0)" class="btn btn-sm btn-danger" title="Xóa câu hỏi" onclick="confirmDelete(<%#Eval("question_id") %>)">Xóa</a>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <%--trắc nghiệm đúng sai--%>
                    <p><b>PHẦN II: Câu hỏi trắc nghiệm đúng sai </b></p>
                    <div>
                        <asp:Repeater runat="server" ID="rpCauHoiDungSai" OnItemDataBound="rpCauHoiDungSai_ItemDataBound">
                            <ItemTemplate>
                                <div class="question-box">
                                    <div class="panel panel-default question-item">
                                        <div class="panel-body  cau-hoi-lon">
                                            <div class="m-bottom question">
                                                <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong>
                                                <br />
                                                <%#Eval("question_content") %>
                                            </div>
                                            <div class="form-row answer">
                                                <table class="table table-bordered">
                                                    <asp:Repeater runat="server" ID="rpCauHoiDungSaiChiTiet">
                                                        <ItemTemplate>
                                                            <tr class="cau-hoi-nho">
                                                                <td><%#Eval("answer_content") %></td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </table>
                                            </div>
                                        </div>
                                        <a href="javascript:void(0)" class="btn btn-sm btn-danger" title="Xóa câu hỏi" onclick="confirmDelete(<%#Eval("question_id") %>)">Xóa</a>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <%-- phần tự luận--%>
                    <p><b>PHẦN III: Câu trắc nghiệm trả lời ngắn</b></p>
                    <div>
                        <asp:Repeater runat="server" ID="rpCauHoiTuLuan">
                            <ItemTemplate>
                                <div class="question-box">
                                    <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                        <div class="panel-body">
                                            <div class="m-bottom question ">
                                                <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong>
                                                <br />
                                                <%#Eval("question_content") %>
                                            </div>
                                        </div>
                                        <a href="javascript:void(0)" class="btn btn-sm btn-danger" title="Xóa câu hỏi" onclick="confirmDelete(<%#Eval("question_id") %>)">Xóa</a>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>
