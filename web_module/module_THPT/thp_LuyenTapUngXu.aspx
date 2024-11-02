<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thp_LuyenTapUngXu.aspx.cs" Inherits="web_module_module_THPT_thp_LuyenTapUngXu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <style>
        .container {
            width: 100%;
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
        }

        .block-card {
            box-shadow: 2px 3px 8px 5px rgba(128, 128, 128, .1607843137);
            background: #fff;
            border-radius: .75rem;
            padding: 15px;
        }

        .heading-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            background: linear-gradient(90deg, rgba(23, 181, 182, 1) 0%, rgba(94, 0, 255, 1) 100%);
            background-color: #4285f4;
            color: white;
        }
        .content {
            padding: 2rem 0;
        }
        .question {
            font-size: 16px;
            margin-bottom: 15px;
            color: #d32f2f;
        }
        .question-number {
            font-weight: bold;
        }
        .answers {
            display: flex;
            flex-direction: column;
        }
        .answers .answer {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            cursor: pointer;
            color: black;
        }
        .footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-top: 1px solid #ddd;
            background: linear-gradient(90deg, rgba(23, 181, 182, 1) 0%, rgba(94, 0, 255, 1) 100%);
            color: white;
        }
        .footer .nav-button {
            background-color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
            color: #4285f4;
        }
    </style>
    <div class="container">
        <div class="block-card">
            <div class="heading-section">
                <a href="/trang-chu-ung-xu">
                    <i class="fa fa-chevron-left" aria-hidden="true"></i>
                </a>
                Câu hỏi luyện tập
                <a class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Danh sách câu hỏi</a>
            </div>
            <div id="Wrapper_ctl00">
                <div class="content">
                    <div id="cauhoi-1">
                        <div class="question">
                            <span class="question-number">Câu 1:</span>
                            Tuân thủ, thực hiện đúng các tiêu chuẩn thương hiệu Việt Nhật nhằm mục đích gì?
                            <a href="javascript:void(0)" style="padding: 0 1rem" onclick="chooseFavourite()">
                                <i class="fa fa-bookmark-o" aria-hidden="true"></i>
                            </a>
                        </div>
                        <div class="answers">
                            <a class="answer item-answer  " data-dapan="" id="btnDapAn-1" onclick="myDapAn(1)">A. Nâng cao chất lượng thương hiệu</a>
                            <a class="answer item-answer  " data-dapan="" id="btnDapAn-2" onclick="myDapAn(2)">B. Duy trì tính nhất quán của thương hiệu</a>
                            <a class="answer item-answer  " data-dapan="đ" id="btnDapAn-3" onclick="myDapAn(3)">C. Cả A và B đều đúng</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer">
                <a id="Wrapper_btnBack" class="nav-button" href="javascript:__doPostBack('ctl00$Wrapper$btnBack','')">&lt;</a> 
                <a>1 / 500</a>
                <a id="Wrapper_btnNext" class="nav-button" href="javascript:__doPostBack('ctl00$Wrapper$btnNext','')">&gt;</a>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

