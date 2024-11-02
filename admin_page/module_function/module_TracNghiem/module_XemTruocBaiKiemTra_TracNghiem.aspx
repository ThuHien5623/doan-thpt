<%@ Page Language="C#" AutoEventWireup="true" CodeFile="module_XemTruocBaiKiemTra_TracNghiem.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_XemTruocBaiKiemTra_TracNghiem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản trị Việt Nhật | Bài kiểm tra trắc nghiệm</title>
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="full-screen" content="yes" />
    <meta name="x5-full-screen" content="true" />
    <meta name="360-full-screen" content="true" />
    <meta name="mobile-web-app-capable" content="yes" />
    <link href="../../../css/pageTest.css?v=1" rel="stylesheet" />

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="icon" type="image/x-icon" href="/images/logo_mamnon.png" />
    <script src="../../admin_js/sweetalert.min.js"></script>
    <script src="/js/current-device.min.js"></script>
    <style>
        .item-wrong {
            background-color: red !important;
        }

            .item-wrong * {
                color: #ffffff !important;
            }

        .item-correct {
            background-color: #3fd03fa3 !important;
        }

        button.hidden-item {
            display: none !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="home page-view">
            <div id="content-main">
                <div class="container">
                    <div class="title-exercise">
                        <h4 id="txtName" runat="server"></h4>
                    </div>
                    <input type="text" id="txtCauHoiID" runat="server" style="display: none" />
                    <a href="javascript:void(0)" id="btnXoaCauHoi" runat="server" onserverclick="btnXoaCauHoi_ServerClick"></a>
                    <div class="testing m-bottom get_width" id="content-test-detail">
                        <div id="questionlist" data-exam-id="435">
                            <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoi_ItemDataBound">
                                <ItemTemplate>
                                    <div class="question-box">
                                        <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                            <div class="panel-body">
                                                <div class="m-bottom question ">
                                                    <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong>
                                                    <br />
                                                    <%#Eval("noidungcauhoi") %>
                                                </div>
                                                <input type="text" name="txtQuestionID" value="<%#Eval("question_id") %>" hidden="hidden" />
                                                <div class="row answer">
                                                    <%-- <div class="flex">--%>
                                                    <asp:Repeater runat="server" ID="rpCauTraLoi">
                                                        <ItemTemplate>
                                                            <div class="answer-item col-sm-12 col-md-6">
                                                                <label class="radio_question">
                                                                    <b><%#Eval("name_label") %>.</b><%#Eval("answer_content") %>
                                                                </label>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                    <%-- </div>--%>
                                                </div>
                                                <a href="javascript:void(0)" class="btn btn-sm btn-danger" title="Xóa câu hỏi" onclick="confirmDelete(<%#Eval("question_id") %>)">Xóa</a>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                    <div>
                        <a href="/admin-danh-sach-bai-kiem-tra-version2" id="btnExit" class="btn btn-primary btn-sm">Quay lại</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
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
    </script>
</body>
</html>
