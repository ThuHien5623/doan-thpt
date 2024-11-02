<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vietnhatliencap_LamBaiLuyenTap_Ver2Copy.aspx.cs" Inherits="web_module_web_tracnghiem_vietnhatliencap_LamBaiLuyenTap_Ver2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Hệ thống giáo dục Việt Nhật | Trắc nghiệm</title>
    <link href="/css/pageExams.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="/js/bootstrap462/jquery.slim.min.js"></script>
    <script src="/js/bootstrap462/bootstrap.bundle.min.js"></script>
    <link rel="icon" type="image/png" href="../../images/logo_mamnon.png" />
    <script src="../../admin_js/sweetalert.min.js"></script>
    <link href="../../admin_css/css_index/Loading.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.js"></script>
    <style>
        * {
            user-select: none !important;
        }

        .circular-progress {
            position: fixed;
            height: 70px;
            width: 70px;
            border-radius: 50%;
            background: conic-gradient(#3bd70c 1deg, #ededed 0deg);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1;
            right: 30px;
            top: 30px;
        }

            .circular-progress::before {
                content: "";
                position: absolute;
                height: 56px;
                width: 56px;
                border-radius: 50%;
                background-color: #fff;
            }

        .progress-value {
            position: relative;
        }

        .answer-item:first-child {
            margin-top: 1rem !important
        }

        .item-wrong {
            background-color: red !important;
        }

            .item-wrong * {
                color: #ffffff !important;
                background-color: transparent !important;
            }

        .item-correct {
            background-color: #3fd03fa3 !important;
        }

        /*button.hidden-item {
            display: none !important;
        }

        .modal-body .content_image img {
            width: 100%;
        }*/
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="loading" id="img-loading-icon" style="display: none">
            <div class="loading">Loading&#8230;</div>
        </div>
        <div class="home page-view">
            <div id="video" class="text-center mt-2" style="display: none">
                <iframe width="560" height="315" src="https://www.youtube.com/embed/wpO8w8SLEtg?si=bztb3pFjxZZ-PiFU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
            </div>
            <div style="text-align: center; transform: translateY(50%)">
                <a href="javascript:void(0)" class="button pink serif round glass" id="check__none" onclick="start()">Bắt đầu làm bài</a>
            </div>
            <div class="circular-progress">
                <span class="progress-value">00:00</span>
            </div>
            <div id="content-main">
                <div class="exams-content">
                    <div class="container">
                        <div class="title-exercise">
                            <h4 id="txtName" runat="server"></h4>
                        </div>
                        <input type="text" id="txtThoiGian" runat="server" style="display: none" />
                        <input type="text" id="txtTongCauHoi" runat="server" style="display: none" />
                        <div class="testing m-bottom get_width" id="content-test-detail">
                            <div id="questionlist" data-exam-id="435">
                                <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoiDetals_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="">
                                            <div class="question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                                <div class="question-item__content">
                                                    <div class="--number">Câu  <%#Container.ItemIndex+1 %>:</div>
                                                    <div class="--content"><%#Eval("question_content") %></div>
                                                    <input type="text" name="txtQuestionID" value="<%#Eval("question_id") %>" data-true="<%#Eval("answer_true") %>" hidden="hidden" />
                                                </div>
                                                <div class="question-item__answer">
                                                    <asp:Repeater runat="server" ID="rpCauTraLoi">
                                                        <ItemTemplate>
                                                            <div class="answer-item">
                                                                <label class="radio_question">
                                                                    <input class="hidden-print mr-2" type="radio" id="test<%#Eval("answer_id") %>" value="<%#Eval("answer_true") %>" onclick="funChooseAnswer(<%#Eval("vitri") %>, this.value, <%#Eval("answer_id") %>)" name="check_<%#Eval("question_id") %>" />
                                                                    <%-- <%#Eval("answer_id") %>--%>
                                                                    <%#Eval("answer_content") %>
                                                                </label>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                                <div style="display: none">
                                                    <input type="text" name="value_<%#Eval("question_id") %>" />
                                                    <input type="text" name="ID_<%#Eval("question_id") %>" />
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                        </div>
                        <div class="text-center mb-3">
                            <a href="javascript:void(0)" id="btnNopBai" onclick="submitResult()" class="btn btn-primary">Nộp bài</a>
                            <a href="javascript:void(0)" id="btnReStart" onclick="funcReStart()" class="btn btn-secondary">Làm lại</a>
                            <a href="javascript:void(0)" id="btnExit" runat="server" onserverclick="btnExit_ServerClick" class="btn btn-danger">Thoát</a>
                        </div>
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
        </div>
    </form>
    <script> // hàm giải mã md5 
        function md5js(ciphertext) {
            // Khóa mật khẩu (khóa và iv nên được quản lý an toàn)
            const key = CryptoJS.enc.Hex.parse('2b7e151628aed2a6abf7158809cf4f3c');
            const iv = CryptoJS.enc.Hex.parse('3ad77bb40d7a3660a89ecaf32466ef97');

            // Giải mã chuỗi
            const decryptedBytes = CryptoJS.AES.decrypt(ciphertext, key, { iv: iv });
            const decryptedText = decryptedBytes.toString(CryptoJS.enc.Utf8);
            return decryptedText;
        }
    </script>
    <script>
        function DisplayLoadingIcon() {
            $("#img-loading-icon").show();
        }
        //func count timer
        var minutesLabel = document.getElementById("minutes");
        var secondsLabel = document.getElementById("seconds");
        const tongSoCau = document.getElementById("<%=txtTongCauHoi.ClientID%>").value;
        var totalSeconds = 0;
        //setInterval(setTime, 1000);

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
        var listValue = $('[name="txtQuestionID"]').map(function () {
            return md5js($(this).data('true'));
        }).get();
        //console.log("list value", listValue);
        var listId = new Array(listValue.length);
        //console.log("list id", listId);
        function funChooseAnswer(stt_cau, value, id_check) {
            //if (!listId.includes(id_check)) {
            //    listId[stt_cau - 1] = id_check;
            //}
            listId[stt_cau - 1] = id_check;
            //console.log("list id đúng", listValue);
            //console.log("list id chọn", listId);
            /*console.log(ques_id, md5js(value), id_check)*/
            //console.log( listValue.join(','), "+", listId.join(','))
        }
        //func count timer
        function start() {
            document.getElementById("content-main").style.display = "block";
            document.getElementById("check__none").style.display = "none";
            document.getElementById("video").style.display = "none";
            countDown();
            countTimer = setInterval(setTime, 1000);
        }
        function checkValueFinish() {
            var getQuestionID = $("input[name='txtQuestionID']").map(function () {
                return $(this).val();
            }).get();
            //debugger;
            document.getElementById('<%=txtDSCauTraLoi.ClientID%>').value = listId.join(',');
            document.getElementById('<%=txtDSCauHoi.ClientID%>').value = getQuestionID;
            document.getElementById('<%=txtResultChecked.ClientID%>').value = listValue.join(',');
            //console.log(listValue, listId, getQuestionID);
            var count = 0;
            for (var index = 0; index < listValue.length; index++) {
                if (listValue[index] == listId[index]) {
                    count++;
                    $("#test" + listId[index] + "").parent().addClass("item-correct");
                    //$("#test" + listId[index] + "").nextAll().css("color", "green");
                    //$("#test" + listId[index] + "").parent().css("color", "green");
                    //$("#test" + listId[index] + "").css("accent-color", "green");
                }
                else {
                    $("#test" + listId[index] + "").parent().addClass("item-wrong");
                    //$("#test" + listId[index] + "").nextAll().css("color", "red");
                    //$("#test" + listId[index] + "").parent().css("color", "red");
                    //$("#test" + listId[index] + "").css("accent-color", "red");
                }
            }
            // nếu đúng trên 70% thì show đáp án
            if (count / tongSoCau >= 7 / 10) {
                for (var index = 0; index < listValue.length; index++) {
                    $("#test" + listValue[index] + "").parent().addClass("item-correct");
                    //$("#test" + listValue[index] + "").nextAll().css("color", "green");
                    //$("#test" + listValue[index] + "").parent().css("color", "green");
                    //$("#test" + listValue[index] + "").css("accent-color", "green");
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
                        clearInterval(downloadTimer);
                        clearInterval(countTimer);
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
            $("#img-loading-icon").show();
            window.location.reload();
        }
        $(document).ready(function () {
            //document.getElementById("btnNopBai").style.display = "block";
            document.getElementById("btnReStart").style.display = "none";
            document.getElementById("btnExit").style.display = "none";
            document.getElementById("content-main").style.display = "none";
        });
        let circularProgress = document.querySelector(".circular-progress"),
            progressValue = document.querySelector(".progress-value");
        const totalSecond = document.getElementById("txtThoiGian").value;
        let progressStartValue = 0,
            progressEndValue = totalSecond,
            speed = 1000;
        var downloadTimer;
        function countDown() {
            downloadTimer = setInterval(function () {
                progressCurentValue = totalSecond - progressStartValue;
                minutes = parseInt(progressCurentValue / 60, 10);
                seconds = parseInt(progressCurentValue % 60, 10);
                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;
                progressValue.textContent = `${minutes}:${seconds}`
                circularProgress.style.background = `conic-gradient(#3bd70c ${(360 / totalSecond) * progressStartValue}deg, #ededed 0deg)`
                if (progressStartValue == progressEndValue) {
                    clearInterval(downloadTimer);
                    swal({
                        title: "Hết thời gian làm bài!",
                        text: "",
                        type: "error",
                        confirmButtonText: "Cool"
                    }).then(function () { document.getElementById("btnPopup").click(); });
                    checkValueFinish();
                    document.getElementById('<%=btnLuuKetQua.ClientID%>').click();
                    document.getElementById("content-test-detail").style.pointerEvents = "none";
                    //$(".btnShowGiaiThich").css("pointer-events", "auto");
                    document.getElementById("btnNopBai").style.display = "none";
                    document.getElementById("btnExit").style.display = "initial";
                }
                progressStartValue++;
            }, 1000);
        }
        function moveItemQuestion(id) {
            var element = document.getElementById(id);
            element.scrollIntoView();
            //location.href = "#" + id;
        }
        document.onkeydown = function (e) {
            if (event.keyCode == 123) {
                return false;
            }
            if (e.ctrlKey && e.shiftKey && e.keyCode == 'I'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.shiftKey && e.keyCode == 'C'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.shiftKey && e.keyCode == 'J'.charCodeAt(0)) {
                return false;
            }
            if (e.ctrlKey && e.keyCode == 'U'.charCodeAt(0)) {
                return false;
            }
        }
        //hàm ngăn copy paste test
        document.addEventListener("contextmenu", function (evt) {
            evt.preventDefault();
        });

        document.addEventListener("copy", function (evt) {
            evt.clipboardData.setData("text/plain", "");
            evt.preventDefault();
        });
        //var w = $(window).width() - ($(window).width() / 10);
        //if (w > 960)
        //    $('.modal-giaithich .modal-dialog').css('max-width', 960);
        //else
        //    $('.modal-giaithich .modal-dialog').css('max-width', w);

    </script>
    <script> // bắt sự kiện rời khỏi trang
        //let count = 0;
        //document.addEventListener('visibilitychange', function () {
        //    if (document.hidden) {
        //        count++;
        //        alert("Bạn đã rời trang làm bài. Số lần vi phạm: " + count)
        //    }
        //});
    </script>

</body>
</html>
