<%@ Page Language="C#" AutoEventWireup="true" CodeFile="module_MaTranDeThi_Detail_Version2.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_MaTranDeThi_Detail_Version2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Meta -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="keywords" content="SITE KEYWORDS HERE" />
    <meta name="description" content="" />
    <meta name='copyright' content='' />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Hệ thống giáo dục Việt Nhật | Trắc nghiệm</title>
    <link rel="icon" type="image/png" href="/images/logo_mamnon.png" />
    <link rel="stylesheet" href="/css/bootstrap.min.css" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="/css/font-awesome.min.css" />
    <link href="/css/pageTest.css" rel="stylesheet" />
    <script src="../../../admin_js/sweetalert.min.js"></script>
    <style>
        * {
            user-select: initial;
        }

        #context-noidung {
            font-family: 'Times New Roman';
        }

        .context-alige {
            text-align: center;
        }

        .tracnghiem__heading {
            font-size: 30px;
            font-weight: 600;
            color: #F45C43;
            text-transform: uppercase;
            transition: linear 0.3s;
            text-align: center;
            margin-bottom: 27px;
            padding-top: 17px;
        }

        .question-item .question {
            display: flex;
        }

        .content_image * {
            margin-bottom: 0 !important;
            line-height: 25px !important;
        }

        .format tr th, .format tr td {
            border: 1px solid gray;
            text-align: center;
        }
    </style>
</head>


<body>
    <form id="form1" runat="server">
        <script>
            function printDiv(divName) {
                var printContents = document.getElementById(divName).innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }
        </script>
        <asp:ScriptManager runat="server" />
        <%-- Start Khung ma trận đề--%>
        <div id="context-noidung" class="container">
            <div class="font-weight-bold">
                <h5>MA TRẬN ĐỀ KIỂM TRA .........
            NĂM HỌC: ..........
            MÔN ...........
                </h5>
                <h5>KHUNG MA TRẬN ĐỀ</h5>
            </div>
            <div>

                <table class="format table-bordered">
                    <tr>
                        <th rowspan="3">TT</th>
                        <th rowspan="3">Chương/chủ đề</th>
                        <th rowspan="3">Nội dung/đơn vị kiến thức</th>
                        <th colspan="8">Mức độ nhận thức</th>
                        <th rowspan="3">Tổng % điểm</th>
                    </tr>
                    <tr>
                        <th colspan="2">Nhận biết</th>
                        <th colspan="2">Thông hiểu</th>
                        <th colspan="2">Vận dụng</th>
                        <th colspan="2">Vận dung cao</th>
                    </tr>
                    <tr>
                        <th>TNKQ</th>
                        <th>TL</th>
                        <th>TNKQ</th>
                        <th>TL</th>
                        <th>TNKQ</th>
                        <th>TL</th>
                        <th>TNKQ</th>
                        <th>TL</th>
                    </tr>
                    <asp:Repeater ID="rpMaTranDeThi" runat="server" OnItemDataBound="rpMaTranDeThi_ItemDataBound">
                        <ItemTemplate>
                            <tr>
                                <td><%#Container.ItemIndex+1 %></td>
                                <td><%#Eval("chapter_name") %></td>
                                <td><%#Eval("lesson_name") %></td>
                                <asp:Repeater ID="rpMaTranChiTiet" runat="server">
                                    <ItemTemplate>
                                        <td><%#Eval("matranchitiet_socau") %> câu<br />
                                            (<%#Eval("matranchitiet_diem") %>đ)<br />
                                            <%#Eval("matranchitiet_phantram") %>%</td>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <td><%#Eval("tongphamtram") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr>
                        <td colspan="3">Tổng</td>
                        <td><%=sum_count_NB_TN%></td>
                        <td><%=sum_count_NB_TL%></td>
                        <td><%=sum_count_TH_TN%></td>
                        <td><%=sum_count_TH_TL%></td>
                        <td><%=sum_count_VD_TN%></td>
                        <td><%=sum_count_VD_TL%></td>
                        <td><%=sum_count_VDC_TN%></td>
                        <td><%=sum_count_VDC_TL%></td>
                        <td><%=(sum_count_NB_TN+sum_count_NB_TL+sum_count_TH_TN+sum_count_TH_TL+sum_count_VD_TN+sum_count_VD_TL+sum_count_VDC_TN+sum_count_VDC_TL)%></td>
                    </tr>
                    <tr>
                        <td colspan="3">Tỉ lệ %</td>
                        <td colspan="2"><%=tileNhanBiet%>%</td>
                        <td colspan="2"><%=tileThongHieu%>%</td>
                        <td colspan="2"><%=tileVanDung%>%</td>
                        <td colspan="2"><%=tileVanDungCao%>%</td>
                        <td><%=(tileVanDung+tileVanDungCao+tileNhanBiet+tileThongHieu) %>%</td>
                    </tr>

                    <tr>
                        <td colspan="3">Tỉ lệ chung</td>
                        <td colspan="4"><%=(tileNhanBiet+tileThongHieu) %>%</td>
                        <td colspan="4"><%=(tileVanDung+tileVanDungCao) %>%</td>
                        <td><%=(tileVanDung+tileVanDungCao+tileNhanBiet+tileThongHieu) %>%</td>
                    </tr>
                </table>
            </div>
            <%-- End Khung ma trận đề--%>
            <%-- Start đặc tả ma trận đề--%>
            <div class="font-weight-bold">
                <h5>BẢNG ĐẶC TẢ ĐỀ KIỂM TRA ...
            MÔN ...</h5>
            </div>
            <div>
                <table class="format table-bordered">
                    <tr>
                        <td rowspan="2">STT</td>
                        <td rowspan="2">Chương/ Chủ đề</td>
                        <td rowspan="2">Nội dung/ Đơn vị kiến thức</td>
                        <td rowspan="2">Mức độ đánh giá</td>
                        <td colspan="4">Số câu hỏi theo mức độ nhận thức</td>
                    </tr>
                    <tr>
                        <td>Nhận biết</td>
                        <td>Thông hiểu</td>
                        <td>Vận dụng</td>
                        <td>Vận dụng cao</td>
                    </tr>
                    <%-- <tr>
                        <td rowspan="5">1</td>
                        <td rowspan="5">Cấu tạo nguyên tử</td>
                        <td rowspan="3">Bài 1: Nguyên tố hóa học</td>
                        <td>Nguyên tố hoá học bao gồm những nguyên tử có cùng số đơn vị điện tích hạt nhân.</td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                    </tr>
                    <tr>
                        <td>Hiểu ý nghĩa kí hiệu nguyên tử: Trong đó X là kí hiệu hoá học của nguyên tố, số khối (A) là tổng số hạt proton và số hạt neutron.   </td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                    </tr>
                    <tr>
                        <td>Hiểu ý nghĩa kí hiệu nguyên tử: Trong đó X là kí hiệu hoá học của nguyên tố, số khối (A) là tổng số hạt proton và số hạt neutron.   </td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                    </tr>
                    <tr>
                        <td rowspan="2">Bài 2: Nguyên tố hóa học</td>
                        <td>Hiểu ý nghĩa kí hiệu nguyên tử: Trong đó X là kí hiệu hoá học của nguyên tố, số khối (A) là tổng số hạt proton và số hạt neutron.   </td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                    </tr>
                    <tr>

                        <td>Hiểu ý nghĩa kí hiệu nguyên tử: Trong đó X là kí hiệu hoá học của nguyên tố, số khối (A) là tổng số hạt proton và số hạt neutron.   </td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                    </tr>
                        <tr>
                        <td rowspan="4">2</td>
                        <td rowspan="4">Hóa trị</td>
                        <td rowspan="1">Bài 4: Nguyên tố hóa học</td>
                        <td>Nguyên tố hoá học bao gồm những nguyên tử có cùng số đơn vị điện tích hạt nhân.</td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                    </tr>
                    <tr>
                        <td rowspan="2">Bài 5: Nguyên tố hóa học</td>
                        <td>Hiểu ý nghĩa kí hiệu nguyên tử: Trong đó X là kí hiệu hoá học của nguyên tố, số khối (A) là tổng số hạt proton và số hạt neutron.   </td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                    </tr>
                    <tr>

                        <td>Hiểu ý nghĩa kí hiệu nguyên tử: Trong đó X là kí hiệu hoá học của nguyên tố, số khối (A) là tổng số hạt proton và số hạt neutron.   </td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                    </tr>
                    <tr>
                        <td>Bài 6: Nguyên tố hóa học</td>
                        <td>Hiểu ý nghĩa kí hiệu nguyên tử: Trong đó X là kí hiệu hoá học của nguyên tố, số khối (A) là tổng số hạt proton và số hạt neutron.   </td>
                        <td>1</td>
                        <td>2</td>
                        <td>3</td>
                        <td>4</td>
                    </tr>--%>
                    <%--load dữ liệu--%>
                    <asp:Repeater runat="server" ID="rpChung" OnItemDataBound="rpChung_ItemDataBound">
                        <ItemTemplate>
                            <asp:Repeater runat="server" ID="rpListChuong">
                                <ItemTemplate>
                                    <tr>
                                        <td rowspan="<%#Eval("rowspanbai") %>"><%#Container.ItemIndex+1 %></td>
                                        <td rowspan="<%#Eval("rowspanbai") %>"><%#Eval("chapter_name") %></td>
                                        <td rowspan="<%#Eval("rowspanbai") %>"><%#Eval("lesson_name") %></td>
                                        <td><%#Eval("dacta_content") %></td>
                                        <td><%#Eval("socau_nhanbiet") %></td>
                                        <td><%#Eval("socau_thonghieu") %></td>
                                        <td><%#Eval("socau_vandung") %></td>
                                        <td><%#Eval("socau_vandungcao") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Repeater runat="server" ID="rpListDacTa">
                                <ItemTemplate>
                                    <tr>
                                        <td><%#Eval("dacta_content") %></td>
                                        <td><%#Eval("socau_nhanbiet") %></td>
                                        <td><%#Eval("socau_thonghieu") %></td>
                                        <td><%#Eval("socau_vandung") %></td>
                                        <td><%#Eval("socau_vandungcao") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>



            <%-- End đặc tả ma trận đề--%>
            <div class="container" style="display: block">
                <div id="div_BaiTap" runat="server">
                    <div class="tracnghiem__heading-box">
                        <div class="content__heading">
                            <h3 class="tracnghiem__heading">Nội dung đề</h3>
                        </div>
                    </div>
                    <div>
                        <div class="testing m-bottom get_width" id="top">
                            <div id="questionlist" data-exam-id="435">
                                <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoiDetals_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="question-box">
                                            <div class="panel panel-default question-item">
                                                <div class="panel-body">
                                                    <div class="m-bottom question ">
                                                        <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:&nbsp;</strong><%#Eval("noidungcauhoi") %>
                                                    </div>
                                                    <div class="row answer">
                                                        <div class="flex">
                                                            <asp:Repeater runat="server" ID="rpCauTraLoi">
                                                                <ItemTemplate>
                                                                    <div class="answer-item col-xs-6  col-md-6 col-sm-12">
                                                                        <label class="radio_question">
                                                                            <%#Eval("name_label") %>.&nbsp;<%#Eval("answer_content") %>
                                                                        </label>
                                                                    </div>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                    <div>
                        <asp:Repeater ID="rpBaiTapTuaLuan" runat="server">
                            <ItemTemplate>
                                <%#Eval("luyentap_baitaptuluan") %>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <%--<a href="#" class="btn btn-success" onclick="printDiv('div_BaiTap')">In đề</a>--%>
                <a href="#" class="btn btn-success" onclick="Export2Doc('context-noidung');">Xuất file word</a>
                <a href="/admin-danh-sach-bai-kiem-tra" class="btn btn-success">Quay lại</a>
            </div>
        </div>
        <%-- End đề thi--%>
    </form>
    <script src="/js/jquery-3.5.1.min.js"></script>
    <script src="/js/jquery-migrate.min.js"></script>
    <!-- Popper JS-->
    <script src="/js/popper.min.js"></script>
    <!-- Bootstrap JS-->
    <script src="/js/bootstrap.min.js"></script>
    <!-- Main JS-->
    <script src="/js/main.js"></script>
    <script>
        function Export2Doc(element, filename = 'MaTranDeThi') {

            var preHtml = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'><head><meta charset='utf-8'><title>Export HTML To Doc</title></head><body>";
            var postHtml = "</body></html>";

            var html = preHtml + document.getElementById(element).innerHTML + postHtml;

            var blob = new Blob(['\ufeff', html], {
                type: 'application/msword'
            });

            var url = 'data:application/vnd.ms-word;charset=utf-8,' + encodeURIComponent(html);


            filename = filename ? filename + '.doc' : 'document.doc';


            var downloadLink = document.createElement("a");

            document.body.appendChild(downloadLink);

            if (navigator.msSaveOrOpenBlob) {
                navigator.msSaveOrOpenBlob(blob, filename);
            } else {

                downloadLink.href = url;
                downloadLink.download = filename;
                downloadLink.click();
            }

            document.body.removeChild(downloadLink);
        }
    </script>
</body>
</html>
