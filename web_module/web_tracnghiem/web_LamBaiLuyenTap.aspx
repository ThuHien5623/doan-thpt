<%@ Page Language="C#" AutoEventWireup="true" CodeFile="web_LamBaiLuyenTap.aspx.cs" Inherits="web_module_web_tracnghiem_web_LamBaiLuyenTap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hệ thống giáo dục Việt Nhật | Trắc nghiệm</title>
    <link href="../../css/pageTest.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="icon" type="image/png" href="../../images/logo_mamnon.png" />
    <script src="../../admin_js/sweetalert.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        <div id="content-main">
            <div class="container">
                <div class="testing m-bottom get_width" id="content-test-detail">
                    <div id="questionlist" data-exam-id="435">
                        <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoi_ItemDataBound">
                            <ItemTemplate>
                                <div class="question-box">
                                    <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                        <div class="panel-body">
                                            <div class="m-bottom question ">
                                                <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong><%#Eval("noidungcauhoi") %>
                                            </div>
                                            <input type="text" name="txtQuestionID" value="<%#Eval("question_id") %>" hidden="hidden" />
                                            <div class="row answer">
                                                <%-- <div class="flex">--%>
                                                <asp:Repeater runat="server" ID="rpCauTraLoi">
                                                    <ItemTemplate>
                                                        <div class="answer-item col-sm-12 col-md-6">
                                                            <label class="radio_question">
                                                                <input class="hidden-print" type="radio" id="test<%#Eval("answer_id") %>" value="<%#Eval("answer_true") %>" onclick="funChooseAnswer(<%#Eval("question_id") %>, this.value, <%#Eval("answer_id") %>)" name="check_<%#Eval("question_id") %>" />
                                                                <%#Eval("answer_content") %>
                                                            </label>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <%-- </div>--%>
                                            </div>
                                            <div style="display: none">
                                                <input type="text" name="value_<%#Eval("question_id") %>" />
                                                <input type="text" name="ID_<%#Eval("question_id") %>" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div>
                    <a href="javascript:void(0)" id="btnNopBai" onclick="submitResult()" class="btn btn-success">Nộp bài</a>
                    <a href="javascript:void(0)" id="btnReStart" onclick="funcReStart()" class="btn btn-success">Làm lại</a>
                    <a href="javascript:void(0)" id="btnExit" runat="server" onserverclick="btnExit_ServerClick" class="btn btn-danger">Thoát</a>
                </div>
            </div>
        </div>
        <%--popup submit--%>
        <a id="btnPopup" data-toggle="modal" data-target="#exampleModal"></a>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header bg-info text-light">
                        <h5 class="modal-title" id="exampleModalLabel">Kết quả làm bài</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <ul>
                            <li>Tổng số câu: <span><%=tongSoCau %></span></li>
                            <li>Số câu đúng: <span id="pointCorrect">0</span></li>
                            <li>Thời gian:<span id="timeFinish">0</span></li>
                        </ul>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div style="display: none">
                    <input type="text" id="txtDSCauHoi" runat="server" placeholder="ds cau hoi" />
                    <input type="text" id="txtDSCauTraLoi" runat="server" placeholder="cau tl checked" />
                    <input type="text" id="txtResultChecked" runat="server" placeholder="result checked đap an" />
                    <input type="text" id="txtSoCauDung" runat="server" placeholder="so cau dung" />
                    <input type="text" id="txtFinish" runat="server" placeholder="so cau dung" />
                    <div class="timer">
                        <label id="minutes">00</label>
                        <label id="colon">:</label>
                        <label id="seconds">00</label>
                    </div>
                </div>
                <a href="#" id="btnLuuKetQua" runat="server" onserverclick="btnLuuKetQua_ServerClick"></a>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <script>
        //func count timer
        var minutesLabel = document.getElementById("minutes");
        var secondsLabel = document.getElementById("seconds");
        var totalSeconds = 0;
        setInterval(setTime, 1000);

        function setTime() {
            ++totalSeconds;
            secondsLabel.innerHTML = pad(totalSeconds % 60);
            minutesLabel.innerHTML = pad(parseInt(totalSeconds / 60));
        }

        function pad(val) {
            var valString = val + "";
            if (valString.length < 2) {
                return "0" + valString;
            }
            else {
                return valString;
            }
        }
        //func choose answer
        function funChooseAnswer(ques_id, value, id_check) {
            $("input[name='value_" + ques_id + "']").val(value);
            $("input[name='ID_" + ques_id + "']").val(id_check);
        }
        function checkValueFinish() {
            var getValues = $("input[name*='value_']").map(function () {
                return $(this).val();
            }).get();
            var getId = $("input[name*='ID_']").map(function () {
                return $(this).val();
            }).get();
            var getQuestionID = $("input[name='txtQuestionID']").map(function () {
                return $(this).val();
            }).get();
            //debugger;
            document.getElementById('<%=txtDSCauTraLoi.ClientID%>').value = getId;
            document.getElementById('<%=txtDSCauHoi.ClientID%>').value = getQuestionID;
            document.getElementById('<%=txtResultChecked.ClientID%>').value = getValues;
            var count = 0;
            for (var index = 0; index < getValues.length; index++) {
                if (getValues[index] == "True") {
                    count++;
                    $("#test" + getId[index] + "").nextAll().css("color", "green");
                    $("#test" + getId[index] + "").parent().css("color", "green");
                    $("#test" + getId[index] + "").css("accent-color", "green");
                }
                else {
                    $("#test" + getId[index] + "").nextAll().css("color", "red");
                    $("#test" + getId[index] + "").parent().css("color", "red");
                    $("#test" + getId[index] + "").css("accent-color", "red");
                }
            }
            document.getElementById("pointCorrect").innerHTML = count;
            document.getElementById("timeFinish").innerHTML = minutesLabel.innerHTML + ":" + secondsLabel.innerHTML;
            document.getElementById('<%=txtFinish.ClientID%>').value = minutesLabel.innerHTML + ":" + secondsLabel.innerHTML;
            document.getElementById('<%=txtSoCauDung.ClientID%>').value = count;
        }
        function submitResult() {
            swal("Bạn có thực sự muốn nộp bài?",
                "Nếu đồng ý, kết quả sẽ không được thay đổi.",
                "warning",
                {
                    buttons: true,
                    successMode: true
                }).then(function (value) {
                    if (value == true) {
                        checkValueFinish();
                        document.getElementById("btnPopup").click();
                        document.getElementById('<%=btnLuuKetQua.ClientID%>').click();
                        document.getElementById("content-test-detail").style.pointerEvents = "none";
                        document.getElementById("btnNopBai").style.display = "none";
                        document.getElementById("btnReStart").style.display = "initial";
                        document.getElementById("btnExit").style.display = "initial";
                    }
                });
        }
        function funcReStart() {
            window.location.reload();
        }
        $(document).ready(function () {
            //document.getElementById("btnNopBai").style.display = "block";
            document.getElementById("btnReStart").style.display = "none";
            document.getElementById("btnExit").style.display = "none";
        });
    </script>
</body>
</html>
