<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt-GiaoDienUngXu.aspx.cs" Inherits="web_module_module_THPT_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link rel="stylesheet" href="style.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
            line-height: 1.5;
            font-size: 14px;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .block-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .heading-section {
            align-items: center;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            background: linear-gradient(90deg, rgba(23, 181, 182, 1) 0%, rgba(94, 0, 255, 1) 100%);
            background-color: #4285f4;
            color: white;
        }

        .heading-section a {
            text-decoration: none;
            color: #fff;
            margin-right: 10px;
        }

            .heading-section a i {
                font-size: 1rem;
                color: white;
            }

        .heading-section .time {
            font-size: 14px;
            font-weight: bold;
        }

        .munber {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .munber-answer {
            background: #ffffff;
            border-radius: 5px;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: 0.3s;
            flex-direction: column;
            border: 1px solid #ddd;
            margin: 1px;
            font-weight: 700;
            box-shadow: rgba(0, 0, 0, 0.12) 0px 1px 3px, rgba(0, 0, 0, 0.24) 0px 1px 2px;
            text-decoration: none;
        }


        .munber-answer:hover,
        .munber-answer.active {
            background: #007bff;
            border-color: #007bff;
        }

        .content {
            border-radius: 10px;
            padding: 20px;
        }

        .question {
            display: flex;
            font-size: 16px;
            margin-bottom: 15px;
            color: #d32f2f;
        }

            .question .question-number {
                font-weight: bold;
                margin-right: 10px;
            }

        .answers {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .answer {
            border-radius: 10px;
            padding: 10px 20px;
            cursor: pointer;
            transition: 0.3s;
            border: 1px solid #ddd;
            color: black;
        }

            .answer:hover {
                background: #007b;
                color: #fff;
            }

            .answer.active {
                background: #28a745;
                color: #fff;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="container">
        <div class="block-card">
            <div id="Wrapper_upBaiLuyenTapChuDe">
                <div class="heading-section">
                    <a>
                        <i class="fa fa-chevron-left" aria-hidden="true"></i>
                    </a>
                    <div class="time">Ứng xử trong gia đình, cộng đồng</div>
                </div>
                <div class="munber">
                    <a>
                        <div id="block_cauhoi_1" class="munber-answer ">
                            1
                        </div>
                    </a>
                    <a>
                        <div id="block_cauhoi_2" class="munber-answer ">
                            2
                        </div>
                    </a>
                    <a>
                        <div id="block_cauhoi_3" class="munber-answer ">
                            3
                        </div>
                    </a>
                    <a>
                        <div id="block_cauhoi_4" class="munber-answer ">
                            4
                        </div>
                    </a>
                    <a>
                        <div id="block_cauhoi_5" class="munber-answer ">
                            5
                        </div>
                    </a>
                    <a>
                        <div id="block_cauhoi_6" class="munber-answer ">
                            6
                        </div>
                    </a>
                    <a>
                        <div id="block_cauhoi_7" class="munber-answer ">
                            7
                        </div>
                    </a>
                    <a>
                        <div id="block_cauhoi_8" class="munber-answer ">
                            8
                        </div>
                    </a>
                    <a>
                        <div id="block_cauhoi_9" class="munber-answer ">
                            9
                        </div>
                    </a>
                </div>
                <div class="content">
                    <div class="question">
                        <span class="question-number">Câu 1:</span>
                        Theo Bộ quy tắc ứng xử, cán bộ, giáo viên, nhân viên có trách nhiệm gì trong việc xây dựng gia đình?
                        <a  style="padding: 0 1rem">
                            <i class="fa fa-bookmark-o" aria-hidden="true"></i>
                        </a>
                    </div>
                    <div class="answers">
                        <a class="answer item-answer  ">A. Xây dựng gia đình văn hóa, hạnh phúc, hòa thuận
                        </a>
                        <a class="answer item-answer  ">B. Làm gương về chấp hành pháp luật cho người thân trong gia đình
                        </a>
                        <a class="answer item-answer  ">C. Cả A và B đều đúng
                        </a>
                        <a class="answer item-answer  ">D. Không có đáp án nào đúng
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

