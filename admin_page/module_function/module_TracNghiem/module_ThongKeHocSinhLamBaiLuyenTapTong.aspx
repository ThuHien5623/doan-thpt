<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_ThongKeHocSinhLamBaiLuyenTapTong.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_ThongKeHocSinhLamBaiLuyenTapTong" %>

<%@ Register Src="~/web_usercontrol/Uc_MenuThongKeQuanTri.ascx" TagPrefix="uc1" TagName="Uc_MenuThongKeQuanTri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="../../../css/admin-style-lan.css" rel="stylesheet" />
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
        .btn-danger {
            color: #fff;
            background-color: rgb(0, 123, 255);
            border-color: rgb(0, 123, 255);
        }
        .btn-danger:hover{
            color: #fff;
            background-color: #1550da;
            border-color: #1550da;
        }
        .chon {
            display: flex;
            justify-content: flex-start;
            align-items: end;
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
        $(document).ready(function () {
            $("a#btn_tknx8").addClass("active");
        });
    </script>
     <input type="text" id="subMenu" value="7" hidden />
    <div class="container-fluid">
        <div class="block-card ">
            <div class="block-style block-style-1">
                <div class="block-menu">
                    <uc1:Uc_MenuThongKeQuanTri runat="server" ID="Uc_MenuThongKeQuanTri" />
                </div>
                <div class="block-content">
                    <%-- <div class="block-content__header">
                        <div class="title">Theo dõi kết quả làm bài luyện tập</div>
                    </div>--%>
                    <div class="buttom-tab">
                        <a href="/admin-thong-ke-giao-vien-nhap-cau-hoi-trac-nghiem" onclick="DisplayLoadingIcon()" class="btn btn-primary btn-sm buttom-edit">Thống kê nhập kho dữ liệu</a>
                        <a href="/admin-thong-ke-duyet-cau-hoi-kho-du-lieu" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm buttom-edit">Thống kê duyệt câu hỏi</a>
                        <a href="/admin-thong-ke-tao-de-luyen-tap" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm buttom-edit">Thống kê tạo đề</a>
                        <a href="/admin-thong-ke-ket-qua-luyen-tap-tong" onclick="DisplayLoadingIcon()" class="btn btn-primary  btn-sm buttom-edit" style="border-color: rgb(143, 1, 0); background-color: rgb(143, 1, 0);">Thống kê kết quả luyện tập</a>
                    </div>
                    <div class="up-1">
                        <div class="chon">
                            <span style="margin-right: 10px">Chọn lớp
                <dx:ASPxComboBox ID="ddlLop" runat="server" TextField="lop_name" ValueField="lop_id" ValueType="System.Int32" ClientInstanceName="ddlLop" OnSelectedIndexChanged="ddlLop_SelectedIndexChanged" AutoPostBack="true"></dx:ASPxComboBox>
                            </span>
                            <span>Chọn môn
                <dx:ASPxComboBox ID="ddlMon" runat="server" TextField="mon_name" ValueField="mon_id" ValueType="System.Int32" ClientInstanceName="ddlMon" OnSelectedIndexChanged="ddlMon_SelectedIndexChanged" AutoPostBack="true"></dx:ASPxComboBox>
                            </span>
                        </div>
                        <div class="form-row">
                            <div class="col-4">
                                <table class="table up-1">
                                    <tr>
                                        <th>STT</th>
                                        <th>Bài luyện tập</th>
                                        <th>Số lượng hs làm bài</th>
                                        <th></th>
                                    </tr>

                                    <asp:Repeater runat="server" ID="rpDanhSachBaiLuyenTap">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%#Container.ItemIndex+1 %>
                                                </td>
                                                <td><%#Eval("luyentap_name") %></td>
                                                <td><%#Eval("dalam") %>/<%#Eval("tonghs") %></td>
                                                <td>
                                                    <a href="javascript:void(0)" class="btn btn-danger btn-sm " id="btnXemLuyenTap<%#Eval("test_id") %>" onclick="funcXemChiTiet('<%#Eval("test_id") %>')">Xem</a>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
                            </div>

                            <div class="col-8">
                                <table class="table up-1">
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
                                                <td>
                                                    <%#Container.ItemIndex+1 %>
                                                </td>
                                                <td><%#Eval("hocsinh_name") %></td>
                                                <td><%#Eval("solanlambai") %></td>
                                                <td><%#Eval("ketqua") %>/<%#Eval("tongcauhoi") %></td>
                                                <td>
                                                    <a href="javascript:void(0)" class="btn btn-danger btn-sm " data-toggle="modal" data-target="#modalChiTiet-<%#Eval(" hocsinh_code")%>">Xem</a>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
                            </div>
                            <div style="display: none">
                                <input type="text" id="txtLuyenTapID" runat="server" />
                                <a href="#" id="btnXemChiTiet" runat="server" onserverclick="btnXemChiTiet_ServerClick">xem chi tiet</a>
                            </div>
                        </div>
                    </div>
                </div>
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

