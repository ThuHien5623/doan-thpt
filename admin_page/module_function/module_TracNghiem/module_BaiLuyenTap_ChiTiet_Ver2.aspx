<%@ Page Language="C#" AutoEventWireup="true" CodeFile="module_BaiLuyenTap_ChiTiet_Ver2.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_BaiLuyenTap_ChiTiet_Ver2" %>

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
    <script>
        function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;
            window.print();
            document.body.innerHTML = originalContents;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="content-app" id="content-id">
            <div class="main__tracnghiem" id="popupBlur">
                <div id="div_BaiTap" runat="server">
                    <div class="tracnghiem__heading-box">
                        <div class="content__heading">
                            <h3 class="tracnghiem__heading">BÀI LUYỆN TẬP</h3>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="testing m-bottom get_width" id="top">
                                <div id="questionlist">
                                    <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoiDetals_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="question-box">
                                                <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                                    <div class="panel-body">
                                                        <div class="m-bottom question ">
                                                            <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong><%#Eval("question_content") %>
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
                                <a id="btnQuayLai" class="btn btn-primary btn-sm" href="/admin-danh-sach-bai-luyen-tap">Quay lại </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="/js/jquery-3.5.1.min.js"></script>
    <!-- Popper JS-->
    <script src="/js/popper.min.js"></script>
    <!-- Bootstrap JS-->
    <script src="/js/bootstrap.min.js"></script>

</body>
</html>
