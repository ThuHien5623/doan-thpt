<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_DanhSachBaiLuyenTap.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_DanhSachBaiLuyenTap" %>

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
        function myfunction(id) {
            document.getElementById("<%=id_key.ClientID%>").value = id;
            var dd = document.getElementById("<%=build_url.ClientID%>");
            dd.click();
        }
        function geturl() {
            var copyText = document.getElementById("<%=url.ClientID%>");
            copyText.select();
            copyText.setSelectionRange(0, 99999)
            document.execCommand("copy");
            console.log(copyText.value);
            var tooltip = document.getElementById("myTooltip");
            tooltip.classList.add('tooltiptext__show');
            tooltip.innerHTML = "Đã sao chép đường liên kết";
            //tooltip.style.display = "block";
            setTimeout(function () {
                tooltip.style.transform = "scale(0)";
            }, 1500);
        }
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
    </script>

    <style>
        .heading-nhapsach {
            font-size: 40px;
            font-weight: bold;
            text-align: center;
            color: darkblue;
        }
    </style>
    <div class="card section-content">
        <div class="container mt-1">
            <p class="heading-nhapsach">Danh sách bài luyện tập</p>
            <input type="text" name="name" value="" hidden="hidden" runat="server" id="id_key" placeholder="id_click" />
            <div class="col-sm-12">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <a class="btn btn-primary mb-1" href="/admin-tao-bai-luyen-tap-ngau-nhien" id="btnNgauNhien" runat="server">Tạo bài trắc nghiệm ngẫu nhiên</a>
                       <%-- <a class="btn btn-primary mb-1" href="/admin-tao-bai-luyen-tap-format-moi" >Tạo bài trắc nghiệm format mới</a>
                        <a class="btn btn-primary mb-1" href="/admin-tao-bai-luyen-tap-tu-luan">Tạo bài luyện tập tự luận</a>--%>
                        <a class="btn btn-primary mb-1" href="#" id="btnChiTiet" runat="server" onserverclick="btnChiTiet_ServerClick">Chi tiết</a>
                        <input type="submit" class="btn btn-primary mb-1" value="Xóa" onclick="confirmDel()" />
                        <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" />
                        <asp:Button ID="btnChuyenLamBai" CssClass="btn btn-primary" runat="server" Text="Chuyển cho học sinh làm bài" OnClick="btnChuyenLamBai_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="form-group table-responsive">
                            <dx:ASPxGridView ID="grvList" runat="server" ClientInstanceName="grvList" KeyFieldName="test_id" Width="100%">
                                <Columns>
                                    <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="5%">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataColumn Caption="STT" HeaderStyle-HorizontalAlign="Center" Width="5%">
                                        <DataItemTemplate>
                                            <%#Container.ItemIndex+1 %>
                                        </DataItemTemplate>
                                    </dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn Caption="Lớp" FieldName="lop_name" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn Caption="Môn học" FieldName="mon_name" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn Caption="Tên bài luyện tập" FieldName="luyentap_name" HeaderStyle-HorizontalAlign="Center" Width="50%"></dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn Caption="Số lượng câu hỏi" FieldName="test_soluongcauhoi" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn Caption="Thời gian làm bài" FieldName="test_thoigianlambai" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn Caption="Ngày tạo" FieldName="test_createdate" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                    <dx:GridViewDataColumn Caption="Tình trạng" FieldName="tinhtrang" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                    <%--  <dx:GridViewDataColumn HeaderStyle-HorizontalAlign="Center" Width="15%" Settings-AllowEllipsisInText="true">
                                        <DataItemTemplate>
                                            <a href="javascript:void(0)" id="<%#Eval("test_id") %>" onclick="myfunction(this.id)" class="btn btn-primary text-light">Xem ma trận + đặc tả</a>
                                        </DataItemTemplate>
                                    </dx:GridViewDataColumn>--%>
                                </Columns>
                                <SettingsSearchPanel Visible="true" />
                                <SettingsBehavior AllowFocusedRow="true" />
                                <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                                <SettingsLoadingPanel Text="Đang tải..." />
                                <SettingsPager PageSize="10" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
                            </dx:ASPxGridView>
                        </div>
                        <input type="text" class="link" runat="server" id="url" hidden />
                        <asp:Button Text="text" ID="build_url" runat="server" CssClass="invisible" OnClick="build_url_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

