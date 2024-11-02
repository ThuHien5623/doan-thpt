<%@ Page Language="C#" AutoEventWireup="true" CodeFile="module_BaiLuyenTap_ChiTiet_FormatMoi.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_BaiLuyenTap_ChiTiet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Meta -->
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="keywords" content="SITE KEYWORDS HERE" />
    <meta name="description" content="" />
    <meta name='copyright' content='' />
     <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Title -->
    <title>Trang quản trị Việt Nhật | Bài luyện tập</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="/images/logo_mamnon.png" />
    <link rel="stylesheet" href="/css/bootstrap.min.css" />
    <script src="../admin_js/sweetalert.min.js"></script>
    <link href="../../../css/pageTest.css" rel="stylesheet" />
    <style>
        * {
            user-select: none;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="content-app" id="content-id">
            <a href="/admin-danh-sach-bai-luyen-tap" class="btn btn-primary mx-1">Quay lại</a>
            <div class="main__tracnghiem" id="popupBlur">
                <div id="div_BaiTap" runat="server">
                    <div class="tracnghiem__heading-box">
                        <div class="content__heading">
                            <h3 class="tracnghiem__heading">BÀI LUYỆN TẬP</h3>
                        </div>
                    </div>
                    <div class="testing m-bottom get_width" id="content-test-detail">
                         <p><b>PHẦN I: Câu hỏi trắc nghiệm 4 lựa chọn </b></p>
                        <div id="questionlist" data-exam-id="435">
                            <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoi_ItemDataBound">
                                <ItemTemplate>
                                    <div class="question-box">
                                        <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                            <div class="panel-body">
                                               <%-- <%#Eval("lesson_id") %>--%>
                                                <div class="m-bottom question ">
                                                    <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong>
                                                    <br />
                                                    <%#Eval("question_content") %>
                                                </div>
                                                <div class="row answer">
                                                    <%-- <div class="flex">--%>
                                                    <asp:Repeater runat="server" ID="rpCauTraLoi">
                                                        <ItemTemplate>
                                                            <div class="answer-item col-sm-12 col-md-6">
                                                                <label class="radio_question">
                                                                    <b> <%#Eval("name_label") %>.</b><%#Eval("answer_content") %>
                                                                </label>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <%-- </div>--%>
                                                </div>
                                            </div>
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
                                                   <%-- <%#Eval("lesson_id") %>--%>
                                                    <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong>
                                                    <br />
                                                    <%#Eval("question_content") %>
                                                </div>
                                                <div class="form-row answer">
                                                    <table class="table table-bordered">
                                                        <asp:Repeater runat="server" ID="rpCauHoiDungSaiChiTiet">
                                                            <ItemTemplate>
                                                                <tr class="cau-hoi-nho">
                                                                   <td> <b> <%#Eval("name_label") %>.</b><%#Eval("answer_content") %></td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </table>
                                                </div>
                                            </div>
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
                                        <%--<%#Eval("lesson_id") %>--%>
                                        <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                            <div class="panel-body">
                                                <div class="m-bottom question ">
                                                    <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong>
                                                    <br />
                                                    <%#Eval("question_content") %>
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
        <%-- End đề thi--%>
    </form>
    <script src="/js/jquery-3.5.1.min.js"></script>
    <script src="/js/jquery-migrate.min.js"></script>
    <!-- Popper JS-->
    <script src="/js/popper.min.js"></script>
    <!-- Bootstrap JS-->
    <script src="/js/bootstrap.min.js"></script>

</body>
</html>
