<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vietnhatliencap_BaiKiemTra_TracNghiem.aspx.cs" Inherits="web_module_web_tracnghiem_vietnhatliencap_LamBaiLuyenTapChiTiet_Ver3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sổ liên lạc điện tử | Bài tập kiểm tra</title>
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="full-screen" content="yes" />
    <meta name="x5-full-screen" content="true" />
    <meta name="360-full-screen" content="true" />
    <meta name="mobile-web-app-capable" content="yes" />
    <%--<link href="../../css/pageTest.css?v=1" rel="stylesheet" />--%>

    <link href="/css/pageExams.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="/js/bootstrap462/jquery.slim.min.js"></script>
    <script src="/js/bootstrap462/bootstrap.bundle.min.js"></script>
    <link rel="icon" type="image/x-icon" href="/images/logo_mamnon.png" />
    <script src="../../admin_js/sweetalert.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.js"></script>
    <script>
        window.addEventListener("keydown", function (e) {
            if (e.key === "F5") {
                e.preventDefault();
            }
        });
        window.addEventListener("beforeunload", function (e) {
            e.preventDefault();
        });
    </script>
    <style>
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

        .modal-body .content_image img {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="page-view --exams">
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
                        <input type="text" id="txtMon" runat="server" style="display: none" />
                        <input type="text" id="txtThoiGian" runat="server" style="display: none" />
                        <input type="text" id="txtTongCauHoi" runat="server" style="display: none" />
                        <input type="text" id="txtTinhTrangLamBai" runat="server" style="display: none" />

                        <div class="testing m-bottom get_width" id="content-test-detail">
                            <div id="questionlist" class="question-list" data-exam-id="435">
                                <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoi_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="">
                                            <div class="question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                                <div class="question-item__content">
                                                    <div class="--number">Câu <%#Container.ItemIndex+1 %>:</div>
                                                    <div class="--content"><%#Eval("question_content") %></div>
                                                    <input type="text" name="questionPart1" value="<%#Eval("question_id") %>" data-true="<%#Eval("answer_True") %>" hidden="hidden" />
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
                                                    <button type="button" class="btn btn-sm btn-warning btnShowGiaiThich <%#Eval("style") %>" data-toggle="modal" data-target="#modalGiaiThich<%#Eval("question_id") %>" style="display: none">
                                                        Giải thích
                                                    </button>
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
                        <div class="text-center mb-3">
                            <a href="javascript:void(0)" id="btnNopBai" onclick="submitResult()" class="btn btn-primary">Nộp bài</a>
                            <a href="javascript:void(0)" id="btnReStart" onclick="funcReStart()" class="btn btn-secondary">Làm lại</a>
                            <a href="/slldt-luyen-tap" id="btnExit" class="btn btn-danger">Thoát</a>
                        </div>
                    </div>
                </div>

            </div>
            <%--popup giải thích--%>
            <asp:Repeater runat="server" ID="rpModal">
                <ItemTemplate>
                    <div class="modal fade modal-giaithich" id="modalGiaiThich<%#Eval("question_id") %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header bg-info text-light">
                                    <h5 class="modal-title">Giải thích</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div>
                                        <%#Eval("question_giaithich") %>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
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
                                <li>Điểm: <span id="pointCorrect">0</span></li>
                                <li>Thời gian: <span id="timeFinish">0</span></li>
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
                        <input type="text" id="txtTinhTrang" runat="server" placeholder="vipham" />
                        <input type="text" id="txtSoLanViPham" runat="server" placeholder="vipham" />
                        <input type="text" id="txtDSCauHoi" runat="server" placeholder="ds cau hoi" />
                        <input type="text" id="txtDSCauTraLoi" runat="server" placeholder="cau tl checked" />
                        <input type="text" id="txtResultChecked" runat="server" placeholder="result checked đap an" />
                        <input type="text" id="txtSoCauDung" runat="server" placeholder="so cau dung" />
                        <input type="text" id="txtFinish" runat="server" placeholder="so cau dung" />
                        <input type="text" id="txtThoiGianConLai" runat="server" />
                        <div class="timer">
                            <label id="minutes">00</label>
                            <label id="colon">:</label>
                            <label id="seconds">00</label>
                        </div>
                    </div>
                    <%-- <a id="btnBatDauBaiKiemTra" runat="server" onserverclick="btnBatDauBaiKiemTra_ServerClick"></a>--%>
                    <a href="#" id="btnLuuKetQua" runat="server" onserverclick="btnLuuKetQua_ServerClick"></a>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
    <script> 
        $(document).ready(function () {
            document.getElementById("btnExit").style.display = "none";
            document.getElementById("content-main").style.display = "none";
        });
        // hàm giải mã md5
        function md5js(ciphertext) {
            // Khóa mật khẩu (khóa và iv nên được quản lý an toàn)
            const key = CryptoJS.enc.Hex.parse('2b7e151628aed2a6abf7158809cf4f3c');
            const iv = CryptoJS.enc.Hex.parse('3ad77bb40d7a3660a89ecaf32466ef97');
            // Giải mã chuỗi
            const decryptedBytes = CryptoJS.AES.decrypt(ciphertext, key, { iv: iv });
            const decryptedText = decryptedBytes.toString(CryptoJS.enc.Utf8);
            return decryptedText;
        }
        //count timer
        var minutesLabel = document.getElementById("minutes");
        var secondsLabel = document.getElementById("seconds");
        var totalSeconds = 0;
        const tongSoCau = document.getElementById("<%=txtTongCauHoi.ClientID%>").value;
        const monhoc = document.getElementById("<%=txtMon.ClientID%>").value;
        var statusSubmit = false;
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
        var statusTimer = true;
        let circularProgress = document.querySelector(".circular-progress"),
            progressValue = document.querySelector(".progress-value");
        const totalSecond = document.getElementById("<%=txtThoiGian.ClientID%>").value;
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
                    document.getElementById('<%=txtThoiGianConLai.ClientID%>').value = progressCurentValue;
                    document.getElementById("timeFinish").innerHTML = minutesLabel.innerHTML + ":" + secondsLabel.innerHTML;
                    document.getElementById('<%=txtFinish.ClientID%>').value = minutesLabel.innerHTML + ":" + secondsLabel.innerHTML;
                    checkValueFinish();
                    checkResultDungSai();
                    checkResultPart3();
                    var sum = Number(countPart1) * 0.25 + Number(countPart2) + Number(countPart3) * 0.25;
                    document.getElementById("pointCorrect").innerHTML = sum;
                    document.getElementById('<%=txtSoCauDung.ClientID%>').value = sum;
                    statusSubmit = true;
                    document.getElementById('<%=btnLuuKetQua.ClientID%>').click();
                    document.getElementById("content-test-detail").style.pointerEvents = "none";
                    $(".btnShowGiaiThich").css("pointer-events", "auto");
                    document.getElementById("btnNopBai").style.display = "none";
                    document.getElementById("btnReStart").style.display = "initial";
                    document.getElementById("btnExit").style.display = "initial";
                }
                progressStartValue++;
            }, 1000);
        }
        //func start làm bài
        function start() {
            document.getElementById("content-main").style.display = "block";
            document.getElementById("check__none").style.display = "none";
            if (statusTimer) {
                countDown();
            }
            myInterval = setInterval(setTime, 1000);
        }
        //list id answer true part 1
        var listValue = listValue = $('[name="questionPart1"]').map(function () {
            return md5js($(this).data('true'));
        }).get();
        var listId = new Array(listValue.length);
        function funChooseAnswer(stt_cau, value, id_check) {
            if (!listId.includes(id_check)) {
                listId[stt_cau - 1] = id_check;
            }
            //console.log("answer", listValue)
            //console.log("choose", listId);
        }
        var countPart1 = 0;
        function checkValueFinish() {
            var getQuestionID = $("input[name='questionPart1']").map(function () {
                return $(this).val();
            }).get();
            document.getElementById('<%=txtDSCauTraLoi.ClientID%>').value = listId.join(',');
            document.getElementById('<%=txtDSCauHoi.ClientID%>').value = getQuestionID;
            document.getElementById('<%=txtResultChecked.ClientID%>').value = listValue.join(',');
            for (var index = 0; index < listValue.length; index++) {
                if (listValue[index] == listId[index]) {
                    countPart1++;
                    $("#test" + listId[index] + "").parent().addClass("item-correct");
                }
                else {
                    $("#test" + listId[index] + "").parent().addClass("item-wrong");

                }
            }
        }
        //check đúng sai phần trắc nghiệm đúng sai
        var countPart2 = 0;
        function checkResultDungSai() {
            countPart2 = 0;
            // Lặp qua từng câu hỏi lớn
            $(".cau-hoi-lon").each(function () {
                var diemCauHoi = 0;
                var soCauDung = 0;
                // Lặp qua từng câu hỏi nhỏ trong câu hỏi lớn hiện tại
                $(this).find(".cau-hoi-nho").each(function () {
                    var checkedRadios = $(this).find("input[name*='checkDungSai_']");
                    checkedRadios.each(function () {
                        // Kiểm tra xem radio đã được chọn có đúng hay không
                        if ($(this).prop("checked")) {
                            if (md5js($(this).val()) == $(this).data("answer")) {
                                soCauDung++;
                                $(this).parent().addClass("item-correct");
                            } else {
                                $(this).parent().addClass("item-wrong");
                            }
                        }
                    });
                });
                // Tăng điểm câu hỏi lớn dựa trên số câu trả lời đúng của câu hỏi nhỏ
                if (soCauDung == 1) {
                    diemCauHoi += 0.1;
                } else if (soCauDung == 2) {
                    diemCauHoi += 0.25;
                } else if (soCauDung == 3) {
                    diemCauHoi += 0.5;
                } else if (soCauDung == 4) {
                    diemCauHoi += 1;
                }
                // Cộng điểm của câu hỏi lớn vào điểm tổng
                countPart2 += diemCauHoi;
            });
            //console.log(countPart2);
        }
        //check đáp án part 3:
        var countPart3 = 0;
        function checkResultPart3() {
            countPart3 = 0;
            //lấy tất cả các input part 3
            var elements = $("input[name='questionPart3']");
            elements.each(function (item) {
                if ($(this).val() == md5js($(this).data("value"))) {
                    countPart3++;
                    $(this).addClass("item-correct");

                } else {
                    $(this).addClass("item-wrong");
                }
                $(this).attr("readonly", "readonly");
            })
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
                        statusTimer = false;
                        statusSubmit = true;
                        clearInterval(myInterval);
                        clearInterval(downloadTimer);
                        document.getElementById('<%=txtThoiGianConLai.ClientID%>').value = progressCurentValue;
                        document.getElementById("timeFinish").innerHTML = minutesLabel.innerHTML + ":" + secondsLabel.innerHTML;
                        document.getElementById('<%=txtFinish.ClientID%>').value = minutesLabel.innerHTML + ":" + secondsLabel.innerHTML;
                        checkValueFinish();
                        checkResultDungSai();
                        checkResultPart3();
                        console.log("1", countPart1)
                        console.log("2", countPart2)
                        console.log("3", countPart3)
                        var sum = 0
                        if (monhoc == "1") {
                            sum = Number(countPart1) * 0.25 + Number(countPart2) + Number(countPart3) * 0.5;
                        }
                        else {
                            sum = Number(countPart1) * 0.25 + Number(countPart2) + Number(countPart3) * 0.25;
                        }
                        //kiểm tra xem số lượng câu làm đúng đã đạt 2/3 chưa để hiện đáp án đúng cho những câu sai
                        if ((progressCurentValue * 2 < totalSecond && sum >= 5) || sum >= 7 || document.getElementById('<%=txtTinhTrangLamBai.ClientID%>').value == "đã đạt") {
                            /*hiện đáp án đúng cho phần trắc nghiệm*/
                            for (var i = 0; i < listValue.length; i++) {
                                $("#test" + listValue[i] + "").parent().addClass("item-correct");
                            }
                            $(".btnShowGiaiThich").css("display", "block");
                        }
                        document.getElementById("pointCorrect").innerHTML = sum;
                        document.getElementById('<%=txtSoCauDung.ClientID%>').value = sum;
                        document.getElementById("btnPopup").click();
                        document.getElementById('<%=btnLuuKetQua.ClientID%>').click();
                        document.getElementById("content-test-detail").style.pointerEvents = "none";
                        $(".btnShowGiaiThich").css("pointer-events", "auto");
                        document.getElementById("btnNopBai").style.display = "none";
                        document.getElementById("btnReStart").style.display = "initial";
                        document.getElementById("btnExit").style.display = "initial";
                    }
                });
        }

        function funcReStart() {
            window.location.reload();
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
        var w = $(window).width() - ($(window).width() / 10);
        if (w > 960)
            $('.modal-giaithich .modal-dialog').css('max-width', 960);
        else
            $('.modal-giaithich .modal-dialog').css('max-width', w);

        let countError = 0;
        <%--document.addEventListener('visibilitychange', function () {
            var element = document.getElementById("content-main");
            if (element.style.display === "block" && document.hidden && statusSubmit == false) {
                countError++;
                if (countError >= 3) {
                    countError = 0;
                    statusTimer = false;
                    clearInterval(myInterval);
                    clearInterval(downloadTimer);
                    document.getElementById('<%=txtThoiGianConLai.ClientID%>').value = progressCurentValue;
                    checkValueFinish();
                    document.getElementById('<%=btnLuuKetQua.ClientID%>').click();
                    document.getElementById('<%=btnLuuChuyenTab.ClientID%>').click();
                    document.getElementById("content-test-detail").style.pointerEvents = "none";
                    $(".btnShowGiaiThich").css("pointer-events", "auto");
                    document.getElementById("btnNopBai").style.display = "none";
                    document.getElementById("btnReStart").style.display = "initial";
                    document.getElementById("btnExit").style.display = "initial";
                    swal({
                        title: "Bạn đã vi phạm quá số lần quy định!",
                        text: "Bài làm sẽ được nộp ngay",
                        type: "error",
                        confirmButtonText: "Cool"
                    });
                }
                else {
                    swal('Bạn đã rời khỏi trang làm bài!', '', 'warning');
                    document.getElementById('<%=btnLuuChuyenTab.ClientID%>').click();
                }
            }
        });--%>
        //function lockAccount() {
        //    swal({
        //        title: "Bạn đã vi phạm quá số lần quy định!",
        //        text: "Bài làm sẽ được nộp ngay",
        //        type: "error",
        //        confirmButtonText: "Cool"
        //    }).then(function () {
        //        window.location.href = "/";
        //    });
        //}
    </script>
</body>
</html>
