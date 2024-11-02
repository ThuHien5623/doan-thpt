<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_ThongKeHocSinhLamBaiLuyenTap.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_ThongKeHocSinhLamBaiLuyenTap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
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
    <script type="text/javascript">
        function loadCanvas(id) {
            var canvas = document.createElement('canvas');
            div = document.getElementById(id);
            canvas.id = "myChart-" + id;
            canvas.width = 400;
            canvas.height = 200;
            //canvas.style.zIndex = 8;
            //canvas.style.position = "absolute";
            //canvas.style.border = "1px solid";
            div.appendChild(canvas)
        }
    </script>
    <div class="card section-content">
        <div class="container mt-1">
            <p class="heading-nhapsach">Theo dõi kết quả làm bài luyện tập</p>
        </div>
        <div class="chon">
            <span>Chọn lớp
                <dx:ASPxComboBox ID="ddlLop" runat="server" TextField="lop_name" ValueField="lop_id" ValueType="System.Int32" ClientInstanceName="ddlLop" Width="80%" OnSelectedIndexChanged="ddlLop_SelectedIndexChanged" AutoPostBack="true"></dx:ASPxComboBox>
            </span>
            <span>Chọn môn
                <dx:ASPxComboBox ID="ddlMon" runat="server" TextField="mon_name" ValueField="mon_id" ValueType="System.Int32" ClientInstanceName="ddlMon" Width="80%" OnSelectedIndexChanged="ddlMon_SelectedIndexChanged" AutoPostBack="true"></dx:ASPxComboBox>
            </span>
           <%-- <span>Chọn loại bài tập
                <dx:ASPxComboBox ID="ddlLoai" runat="server" ValueType="System.Int32" ClientInstanceName="ddlLoai" Width="80%" OnSelectedIndexChanged="ddlLoai_SelectedIndexChanged" AutoPostBack="true">
                    <Items>
                        <dx:ListEditItem Text="Tự luận" Value="1" />
                        <dx:ListEditItem Text="Trắc nghiệm" Value="2" />
                    </Items>
                </dx:ASPxComboBox>
            </span>--%>
        </div>
        <div class="form-row">
            <div class="col-4">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>STT</th>
                        <th>Bài luyện tập</th>
                        <th>Số lượng hs làm bài</th>
                        <th></th>
                    </tr>

                    <asp:Repeater runat="server" ID="rpDanhSachBaiLuyenTap">
                        <ItemTemplate>
                            <tr>
                                <th>
                                    <%#Container.ItemIndex+1 %>
                                </th>
                                <td><%#Eval("luyentap_name") %></td>
                                <td><%#Eval("dalam") %>/<%#Eval("tonghs") %></td>
                                <td>
                                    <a href="javascript:void(0)" class="btn btn-danger btn-sm" id="btnXemLuyenTap<%#Eval("test_id") %>" onclick="funcXemChiTiet('<%#Eval("test_id") %>')">Xem</a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>

            <div class="col-8">
                
                <dx:ASPxGridView ID="grvList" runat="server" ClientInstanceName="grvList" KeyFieldName="hocsinh_id" Width="100%">
                    <Columns>
                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="0%">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataColumn Caption="STT" HeaderStyle-HorizontalAlign="Center" Width="0%">
                            <DataItemTemplate><%#Container.ItemIndex+1 %></DataItemTemplate>
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Họ tên" FieldName="hocsinh_name" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Số lần làm bài" FieldName="solanlambai" HeaderStyle-HorizontalAlign="Center" Width="0%"></dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="Kết quả tốt nhất" HeaderStyle-HorizontalAlign="Center" Width="0%">
                            <DataItemTemplate>
                                <%#Eval("ketqua") %>/<%#Eval("tongcauhoi") %>
                            </DataItemTemplate>
                        </dx:GridViewDataColumn>
                        <dx:GridViewDataColumn Caption="" HeaderStyle-HorizontalAlign="Center" Width="0%">
                            <DataItemTemplate>
                                <a href="javascript:void(0)" class="btn btn-danger text-light btn-sm" data-toggle="modal" data-target="#modalChiTiet-<%#Eval(" hocsinh_code")%>">Xem</a>
                            </DataItemTemplate>
                        </dx:GridViewDataColumn>
                    </Columns>
                    <%--<ClientSideEvents RowDblClick="btnChiTiet" />--%>
                    <SettingsSearchPanel Visible="false" />
                    <SettingsBehavior AllowFocusedRow="true" />
                    <SettingsText EmptyDataRow="Trống" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                    <SettingsLoadingPanel Text="Đang tải..." />
                    <SettingsPager PageSize="50" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
                </dx:ASPxGridView>
                <asp:Button Text="Chuyển điểm thường xuyên" ID="btnChuyenDiem" runat="server" CssClass="btn btn-danger btn-sm" OnClick="btnChuyenDiem_Click" />
                <%--<table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>STT</th>
                        <th>Họ tên</th>
                        <th>Số lần làm</th>
                        <th>Kết quả tốt nhất</th>
                        <th></th>
                    </tr>

                    <asp:Repeater runat="server" ID="rpDanhSachHocSinh">
                        <ItemTemplate>
                            <tr>
                                <th>
                                    <%#Container.ItemIndex+1 %>
                                </th>
                                <td><%#Eval("hocsinh_name") %></td>
                                <td><%#Eval("solanlambai") %></td>
                                <td><%#Eval("ketqua") %>/<%#Eval("tongcauhoi") %></td>
                                <td>
                                    <a href="javascript:void(0)" class="btn btn-danger" data-toggle="modal" data-target="#modalChiTiet-<%#Eval(" hocsinh_code")%>">Xem</a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>--%>

            </div>
            <div style="display: none">
                <input type="text" id="txtLuyenTapID" runat="server" />
                <a href="#" id="btnXemChiTiet" runat="server" onserverclick="btnXemChiTiet_ServerClick">xem chi tiet</a>
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
                            <%--biểu đồ--%>
                            <div>
                                <canvas id="chart-<%#Eval("hocsinh_code")%>" width="400" height="200"></canvas>
                            </div>
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
                        <%-- <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        </div>--%>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    <div style="display: none">
        <input type="text" id="txtDSHSDaLamBai" runat="server" />
    </div>
    <script>
        function funcXemChiTiet(id) {
            document.getElementById('<%=txtLuyenTapID.ClientID%>').value = id;
            document.getElementById('<%=btnXemChiTiet.ClientID%>').click();
        }
        function setActive(id) {
            document.getElementById("btnXemLuyenTap" + id).classList.add("button-active");
        }
        let arrHocSinh = document.getElementById("<%=txtDSHSDaLamBai.ClientID%>").value.split('|')
        for (var i = 0; i < arrHocSinh.length; i++) {
            //loadCanvas("chart-" + arrHocSinh[i]);
            //id chart = myChart-chart-HS00212
            //get ds ngày làm
            let arrNgay = $(".tdNgayLamBai-" + arrHocSinh[i]).map(function () { return $(this).html() }).get();
            let arrDiem = $(".tdSoCauDung-" + arrHocSinh[i]).map(function () { return $(this).html() }).get();
            console.log(arrNgay)
            console.log(arrDiem)
            let idChart = "chart-" + arrHocSinh[i]
            new Chart(idChart, {
                type: "line",
                data: {
                    labels: arrNgay,
                    datasets: [{
                        label: 'Kết quả',
                        lineTension: 0,
                        backgroundColor: "rgb(8, 120, 120)",
                        borderColor: "rgb(75, 192, 192)",
                        data: arrDiem,
                        fill: 0,
                    }]
                },
                options: {
                    legend: { display: false },
                    scales: {
                        yAxes: [{ ticks: { min: 0, } }],
                    }
                }
            })
        }
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

