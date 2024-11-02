<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_DanhSachBaiKiemTra.aspx.cs" Inherits="web_module_module_THPT_thpt_DanhSachBaiKiemTra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff;
            color: #333;
            margin: 0;
            padding: 0 1px;
        }

        .container {
            display: flex;
            align-items: center;
            justify-content: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1px;
        }

        .block-card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
            width: 100%;
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
        }



        .header-top-qtux {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            background: linear-gradient(90deg, #17b5b6 0%, #5e00ff 100%);
            background-color: #4285f4;
            color: #fff;
            text-align: center;
            position: relative;
            margin-bottom: 20px;
            justify-content: center;
            display: flex;
            align-items: center;
        }

            .header-top-qtux .btn-back {
                position: absolute;
                left: 0;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 40px;
                height: 40px;
                color: #ffffff;
                text-decoration: none;
                transition: background-color 0.3s;
            }

                .header-top-qtux .btn-back:hover {
                    background-color: #0056b3;
                }

        .header-top-qtux__title {
            font-size: 14px;
            text-align: center;
            color: #fff;
        }

        .grid-qtux {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

      
        .grid-qtux-item {
            flex: 1;
            width: calc(20.1% - 10px);
            height: 109px;
            box-sizing: border-box;
            background-color: #fff;
            border: 1px solid #ddd;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            justify-content: center;
            align-items: center;
            box-shadow: rgba(0, 0, 0, .1) 0 4px 12px;
            min-width: 150px;
            padding: 20px;
            color: #007bff;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.3s;
        }

            .grid-qtux-item:hover {
                background-color: #0056b3;
                color: #fff;
                transform: translateY(-5px);
            }

            .grid-qtux-item i {
                display: block;
                margin-top: 10px;
                font-size: 25px;
            }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                padding: 0 10px;
            }

            .header-top-qtux {
                flex-direction: column;
                align-items: center;
            }

            .grid-qtux {
                flex-direction: column;
            }

            .grid-qtux-item {
                margin-bottom: 10px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <!doctype html>
    <div class="container">
        <div class="block-card">
            <div class="header-top-qtux">
                <a class="btn btn-back" href="/trang-chu-ung-xu">
                    <i class="fa fa-chevron-left" aria-hidden="true"></i>
                </a>
                <span class="header-top-qtux__title">BỘ ĐỀ THI</span>
            </div>
            <div class="grid-qtux">
                <a class="grid-qtux-item random-exam" href="/kiem-tra-ung-xu-ngau-nhien">Đề ngẫu nhiên<br>
                    <i class="fa fa-random" aria-hidden="true"></i></a>
                <a href="/bai-test-ung-xu-1" class="grid-qtux-item">Đề số 1</a>
                <a href="/bai-test-ung-xu-2" class="grid-qtux-item">Đề số 2 test</a>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>
