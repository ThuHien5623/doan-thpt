<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_LamLuyenTap.aspx.cs" Inherits="web_module_module_THPT_thpt_LamLuyenTap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" Runat="Server">
    <title>Toán 1</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="/css/books/globalBooks.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        #modalNhapMaDe .modal-dialog .modal-content{
            border: 2px solid #0089c7;
        }
        .btnSubmit {
            font-size: 15pt;
            margin: 20px 0px 60px 10px;
            border: none;
            background-color: #0089c7;
            height: 50px;
            font-weight: 800;
            color: white;
            width: 120px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0px 8px 15px 0px rgb(122 118 118);
        }
        .menu-bottom .link-menu a.active{
            color:#0089c7;
        }

        .btn {
            display: flex;
            margin-bottom: 100px
        }

        .btn_exit {
            height: 50px;
            position: fixed;
            top: 10px;
            left: 560px;
            z-index: 9999;
        }

        .header h2 {
            margin-top: 70px;
            text-align: center;
        }

        .time {
            height: 50px;
            position: fixed;
            top: 10px;
            left: 620px;
            z-index: 9999;
        }

        /*.modal-madethi {
            display: flex;
            justify-content:center;
        }*/

        .content-madethi {
            position: relative;
            border-radius: 15px;
            border-color: red;
            width: 80%;
        }

        .header-madethi {
            display: flex;
            justify-content: center;
            border: none;
        }

            .header-madethi h7 {
                color: #860505;
                font-weight: 800;
            }

        .bg-top {
            position: absolute;
            height: 60px;
            top: -12px;
            left: -12px;
        }

        .body-madethi {
            padding: 5px;
        }

        .lb_socaudung, .lb_thoigian {
            border: none;
            color: #860505;
            font-weight: 600;
        }

        .socaudung, .thoigianhoanthanh {
            margin: 10px;
        }

        .footer-madethi {
            display: flex;
            justify-content: center;
            border: none;
        }

            .footer-madethi a {
                background-color: red;
                text-decoration-line: none;
                font-weight: 700;
                color: white;
                height: 30px;
                width: 80px;
                display: flex;
                justify-content: center;
                align-items: center;
                box-shadow: 0px 8px 15px 0px rgb(122 118 118 / 65%);
            }

        .txtSoCauDung, .txtthoigian {
            color: green;
            border: none;
        }


        .btn_close {
            position: absolute;
            top: -18px;
            left: 375px;
            height: 40px;
        }

        .modal-dia-madethi {
            display: flex;
            justify-content: center;
        }

        .txtSoCauDung {
            color: green;
        }

        @media (max-width: 1000px) {
            .btn_exit {
                left: 10px;
            }

            .time {
                left: 70px;
            }

            .btn_close {
                left: 275px;
            }
        }

        .answer-i-radio {
            float: left;
        }

        .title h6 {
            padding: 0px;
            margin: 5px;
        }

        .answer-i {
            display: flex;
            justify-content: center;
            margin-bottom: 5px;
        }
        .answer.row {
            display: flex;
            justify-content: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" Runat="Server">
    <div class="header">
        <img class="btn_exit" src="/images/btn-exit.png" alt="Alternate Text" />

        <h2>Bài kiểm tra thường xuyên</h2>
    </div>
    <div class="content col-12">
        <div class="question">
            <div class="title row">
                <h6 class="">Câu hỏi 1:</h6>
                <h6 class="">Ai là người giàu nhất thế giới ?</h6>
            </div>
            <div class="answer row">
                <div class="answer-i col-6">
                    <input class="answer-i-radio" type="radio" />
                    <p>A: Phạm Nhật Vượng</p>
                </div>
                <div class="answer-i col-6">
                    <input class="answer-i-radio" type="radio" />
                    <p>B: Phạm Nhật Vượng</p>
                </div>
                <div class="answer-i col-6">
                    <input class="answer-i-radio" type="radio" />
                    <p>C: Phạm Nhật Vượng</p>
                </div>
                <div class="answer-i col-6">
                    <input class="answer-i-radio" type="radio" />
                    <p>D: Phạm Nhật Vượng</p>
                </div>
            </div>
        </div>
        <div class="question">
            <div class="title row">
                <h6 class="">Câu hỏi 2:</h6>
                <h6 class="">Cho biết các phép tính sau đúng hay sai ?</h6>
            </div>
            <div class="answer row">
                <p class="col-5">A: 1 + 1 = 2</p>
                <div class="answer-i col-3">
                    <input class="answer-i-radio " type="radio" />
                    <p>Đúng</p>
                </div>
                <div class="answer-i col-3">
                    <input class="answer-i-radio " type="radio" />
                    <p>Sai</p>
                </div>
            </div>
            <div class="answer row">
                <p class="col-5">B: 1 + 1 = 2</p>
                <div class="answer-i col-3">
                    <input class="answer-i-radio " type="radio" />
                    <p>Đúng</p>
                </div>
                <div class="answer-i col-3">
                    <input class="answer-i-radio " type="radio" />
                    <p>Sai</p>
                </div>
            </div>
            <div class="answer row">
                <p class="col-5">C: 1 + 1 = 2</p>
                <div class="answer-i col-3">
                    <input class="answer-i-radio " type="radio" />
                    <p>Đúng</p>
                </div>
                <div class="answer-i col-3">
                    <input class="answer-i-radio " type="radio" />
                    <p>Sai</p>
                </div>
            </div>
            <div class="answer row">
                <p class="col-5">D: 1 + 1 = 2</p>
                <div class="answer-i col-3">
                    <input class="answer-i-radio " type="radio" />
                    <p>Đúng</p>
                </div>
                <div class="answer-i col-3">
                    <input class="answer-i-radio " type="radio" />
                    <p>Sai</p>
                </div>
            </div>
        </div>
        <div class="question">
            <div class="title row">
                <h6 class="">Câu hỏi 3:</h6>
                <h6 class="">Tìm x, biết 2x + 2 = 4 ?</h6>
            </div>
            <div class="answer row">
                <textarea rows="8" cols="60"></textarea>
            </div>
        </div>

    </div>
    <!-- Popup thông báo thi xong-->
    <div class="modal fade modal-madethi" id="modalNhapMaDe" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dia-madethi">

            <div class="modal-content content-madethi">
                <div class="modal-header header-madethi">
                    <img class="bg-top" src="../../images/bg-top-left-luyentap.png" />
                    <img class="btn_close" src="../../images/btn-exit.png" />
                    <h7>CHÚC MỪNG BẠN ĐÃ HOÀN THÀNH</h7>
                </div>
                <div class="modal-body body-madethi">
                    <div class="row socaudung">
                        <input readonly="readonly" class="col-8 lb_socaudung" type="text" value="Tổng số câu đúng:" />
                        <input class="col-4 txtSoCauDung" type="text" name="name" value="8/10" />
                    </div>
                    <div class="row thoigianhoanthanh">
                        <input readonly="readonly" class="col-8 lb_thoigian" type="text" value="Thời gian hoàn thành:" />
                        <input class="col-4 txtthoigian" type="text" name="name" value="45 phút" />
                    </div>
                </div>
                <div class="modal-footer footer-madethi">
                    <a href="javascript:void(0)" runat="server" id="madethi">Xác nhận</a>
                </div>
            </div>
            <div>
            </div>

        </div>
    </div>
    <div class="btn">
        <a class="btnSubmit" data-toggle="modal" data-target="#modalNhapMaDe">Nộp bài</a>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" Runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" Runat="Server">
</asp:Content>

