<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_DanhSachBaiKiemTra.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_DanhSachBaiKiemTra" %>

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
        .link {
            position: absolute;
            top: 100px;
            z-index: -1;
        }

        #myTooltip {
            width: auto;
            height: 42px;
            color: white;
            text-align: center;
            border-radius: 6px;
            padding: 5px;
            position: fixed;
            z-index: 7;
            right: 40%;
            top: 50%;
            background: #656767;
            line-height: 30px;
        }

        .tooltiptext {
            opacity: 0;
            visibility: hidden;
            transform: scale(0);
            transition: transform 0.3s linear;
        }

            .tooltiptext.tooltiptext__show {
                opacity: 1;
                visibility: visible;
                transform: scale(1);
            }

        .heading-nhapsach {
            font-size: 40px;
            font-weight: bold;
            text-align: center;
            color: darkblue;
        }
    </style>
    <div class="card section-content">
        <div class="container-fluid mt-1">
            <p class="heading-nhapsach">Danh sách bài kiểm tra</p>
            <input type="text" name="name" value="" hidden="hidden" runat="server" id="id_key" placeholder="id_click" />
            <div class="col-sm-12">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <a class="btn btn-primary" href="/admin-tao-bai-kiem-tra-trac-nghiem-0">Nhập đề trắc nghiệm</a>
                        <a class="btn btn-primary" href="/admin-tao-bai-kiem-tra-kieu-moi-0">Nhập đề trắc nghiệm (cấu trúc mới)</a>
                        <a class="btn btn-primary" href="/admin-tao-bai-kiem-tra-tu-chon">Tạo đề kiểm tra tự chọn</a>
                        <%--<a class="btn btn-primary" href="#" id="btnChiTiet" runat="server" onserverclick="btnChiTiet_ServerClick">Chi tiết</a>--%>
                        <input type="submit" class="btn btn-primary" value="Xóa" onclick="confirmDel()" />
                        <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" />
                        <asp:Button Text="Chuyển qua luyện tập" ID="btnChuyenLuyenTap" runat="server" CssClass="btn btn-primary" OnClick="btnChuyenLuyenTap_Click" />
                        <input type="text" class="link" runat="server" id="url" />
                        <asp:Button Text="text" ID="build_url" runat="server" CssClass="invisible" OnClick="build_url_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <%--  <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>--%>
                <div class="form-group table-responsive">
                    <span class="tooltiptext" id="myTooltip">Đã sao chép đường liên kết</span>
                    <dx:ASPxGridView ID="grvList" runat="server" ClientInstanceName="grvList" KeyFieldName="test_id" Width="100%">
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
                            <dx:GridViewDataColumn Caption="Tên bài kiểm tra" FieldName="luyentap_name" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="Loại" FieldName="bkt_loai" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="Ngày tạo" FieldName="test_createdate" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                            <dx:GridViewDataColumn Caption="Tình trạng" FieldName="bkt_tinhtrang" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                            <dx:GridViewDataColumn HeaderStyle-HorizontalAlign="Center" Width="0%" >
                                <DataItemTemplate>
                                    <a href="<%#Eval("link_xemde") %>" class="btn btn-primary btn-sm text-light">Xem đề</a>
                                </DataItemTemplate>
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataColumn HeaderStyle-HorizontalAlign="Center" Width="0%" >
                                <DataItemTemplate>
                                    <a href="<%#Eval("link_detail") %>" style ="<%#Eval("style_link")%>" class="btn btn-primary btn-sm text-light">Nhập câu hỏi</a>
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

                <%--  </ContentTemplate>
                </asp:UpdatePanel>--%>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

