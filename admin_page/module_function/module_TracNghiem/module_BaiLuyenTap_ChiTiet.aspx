<%@ Page Language="C#" AutoEventWireup="true" CodeFile="module_BaiLuyenTap_ChiTiet.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_BaiLuyenTap_ChiTiet" %>

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
        <script>

            function printDiv(divName) {
                var printContents = document.getElementById(divName).innerHTML;
                var originalContents = document.body.innerHTML;
                document.body.innerHTML = printContents;
                window.print();
                document.body.innerHTML = originalContents;
            }
            function fucnGetValue(idCH, dangCH, typeCH) {
                document.getElementById("<%=txtID.ClientID%>").value = idCH;
                document.getElementById("<%=txtDang.ClientID%>").value = dangCH;
                document.getElementById("<%=txtType.ClientID%>").value = typeCH;
                document.getElementById("<%=btnThayDoi.ClientID%>").click();
                setActiveCauHoi(idCH);
                document.getElementById("<%=txtCauHoiThayDoi.ClientID%>").value = idCH;
            }
            function fucnGetValueNew(idCH, idBai) {
                document.getElementById("<%=txtIDnew.ClientID%>").value = idCH;
                document.getElementById("<%=txtBainew.ClientID%>").value = idBai;
                document.getElementById("<%=btnLuaChon.ClientID%>").click();
            }
            function setActiveCauHoi(id) {
                document.getElementById(id).style.borderColor = "red";
            }
        </script>
        <%--//--%>
        <asp:ScriptManager runat="server" />
        <div class="content-app" id="content-id">
            <div class="main__tracnghiem" id="popupBlur">
                <%--<asp:UpdatePanel runat="server">
                    <ContentTemplate>--%>
                <div id="div_BaiTap" runat="server">
                    <div class="tracnghiem__heading-box">
                        <div class="content__heading">
                            <h3 class="tracnghiem__heading">BÀI LUYỆN TẬP</h3>
                        </div>
                    </div>
                    <div class="container">
                        <div class="row">
                            <div class="col-6">
                                <div style="display: none">
                                    <input id="txtID" runat="server" />
                                    <input id="txtDang" runat="server" />
                                    <input id="txtType" runat="server" />
                                    <input id="txtIDnew" runat="server" />
                                    <input id="txtBainew" runat="server" />
                                </div>
                                <a id="btnThayDoi" runat="server" onserverclick="btnThayDoi_ServerClick"></a>
                                <a id="btnLuaChon" runat="server" onserverclick="btnLuaChon_ServerClick"></a>
                                <div name="Div_TracNghiem">
                                    <div class="testing m-bottom get_width" id="top">
                                        <div id="questionlist">
                                            <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoiDetals_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="question-box">
                                                        <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                                            <div class="panel-body">
                                                                <div class="m-bottom question ">
                                                                    <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong><%#Eval("noidungcauhoi") %>
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
                                                            <a class="btn btn-primary text-light" onclick="fucnGetValue(<%#Eval("question_id") %>,'<%#Eval("question_dangcauhoi") %>','<%#Eval("question_type") %>')">Thay đổi </a>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>
                                <input type="text" id="txtCauHoiThayDoi" runat="server" style="display: none" />
                                <div name="Div_TuLuan">
                                    <asp:Repeater ID="rpBaiTapTuaLuan" runat="server">
                                        <ItemTemplate>
                                            <legend class="tracnghiem__legend">Câu <%=STT++ %></legend>
                                            <a class="btn btn-primary" style="color: white">Thay đổi </a>
                                            <%#Eval("luyentap_baitaptuluan") %>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <a id="btnCapNhat" runat="server" class="btn btn-primary" onserverclick="btnCapNhat_ServerClick">Lưu thay đổi </a>
                                <a id="btnQuayLai" class="btn btn-primary" href="/admin-danh-sach-bai-luyen-tap">Quay lại </a>

                            </div>
                            <div class="col-6 div_ThayThe" style="border: 3px solid #d17079; border-radius: 10px;">
                                <h5 class="text-center">Danh sách câu hỏi thay thế</h5>
                                <div class="col-12">
                                    <asp:DropDownList ID="ddlChuong" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlChuong_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <div class="col-12">
                                    <asp:DropDownList ID="ddlBai" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlBai_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <div name="Div_ThayThe" id="divThayThe" runat="server">
                                    <asp:Repeater runat="server" ID="rpThayThe">
                                        <ItemTemplate>
                                            <fieldset class="tracnghiem__content">
                                                <legend class="tracnghiem__legend">Câu <%=STT++ %></legend>
                                                <a class="btn btn-primary  text-light" onclick="fucnGetValueNew(<%#Eval("question_id") %>,<%#Eval("lesson_id") %>)">Lựa chọn</a>
                                                <div class="tracnghiem__content-box">
                                                    <h4 class="tracnghiem__question"><%#Eval("noidungcauhoi") %>
                                                    </h4>
                                                </div>
                                            </fieldset>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- </ContentTemplate>
                </asp:UpdatePanel>--%>
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
