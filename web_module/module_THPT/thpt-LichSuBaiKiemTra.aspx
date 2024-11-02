<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt-LichSuBaiKiemTra.aspx.cs" Inherits="web_module_module_THPT_thpt_LichSuBaiKiemTra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }
        .menu-bottom .link-menu a.active{
            color: #0089c7 !important;
        }
        .btn-detail {
            display: inline-block;
            text-decoration: underline;
        }

            .btn-detail img {
                height: 30px;
            }

        .alert-item__header {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }

        .header {
            background-color: #0089c7;
            /*height: 20vh;*/
            /*box-shadow: rgba(0, 0, 0, 0.35) 0px -50px 36px -28px inset;*/
            padding: 10px;
            display: flex;
        }

        .header__avatar {
            width: 90px;
            height: 90px;
            background-image: url(http://localhost:59661/images/bg-avatar.png);
            background-position: center;
            background-repeat: no-repeat;
            background-size: contain;
            border: 0;
            padding: 10px;
        }

            .header__avatar img {
                width: 70px;
                height: 70px;
                filter: grayscale(0%);
                border-radius: 50%;
            }

        .header__content__desc img {
            width: 20px;
            height: 20px;
        }

        .header__content {
            height: 90px;
            margin: 15px 0;
            padding-left: 10px;
        }

        .header__content__name {
            font-size: 20px;
            font-weight: bold;
            color: white;
        }

        .header__content__desc {
            display: flex;
            align-items: center;
        }

            .header__content__desc span {
                margin-left: 5px;
                color: white;
                font-weight: bold;
            }

        .home-page {
            background-color: #ab0505;
        }

        .main__title {
            display: flex;
            justify-content: space-between;
            margin-top: -3.0rem;
            width: 100%;
            text-align: center;
        }

            .main__title img {
                display: block;
                width: 100%;
                height: 60px;
                object-fit: contain;
                object-position: left;
            }

        .main {
            display: flex;
            flex-wrap: wrap;
            margin: 1rem 0;
            padding: 1rem;
            border-radius: 2rem 2rem 0 0;
            /*box-shadow: 0 10px 15px 2px rgba(0,0,0,.5);
            -webkit-box-shadow: 0 10px 15px 2px rgba(0,0,0,.5);
            -moz-box-shadow: 0 10px 15px 2px rgba(0, 0, 0, .5);*/
            background-color: #fff;
        }

        .main__content img {
            width: 200px;
            height: 100px;
        }

        .content-1__desc {
            display: flex;
            flex-direction: column;
            margin-left: 20px;
        }

        .main__content {
            margin-top: 40px;
            display: flex;
        }

        .main_content {
            margin-left: 20px;
        }

        .content-1__desc .--title, .content-1__desc .--date {
            font-weight: bold;
            color: black;
        }

        .content-madethi {
            /*position: relative;*/
            border-radius: 15px;
            border: solid;
            border-color: red;
            width: 60%;
        }

        .header-madethi {
            display: flex;
            justify-content: center;
            border: none;
        }

            .header-madethi h5 {
                margin: 10px 0px 0px 0px;
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
            display: flex;
            justify-content: center;
            height: 50px;
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
            left: 275px;
            height: 40px;
        }

        .modal-dia-madethi {
            display: flex;
            justify-content: center;
            height: 20vh;
        }

        .txtSoCauDung {
            color: green;
        }

        .txtMaDeThi {
            border-radius: 20px;
            border-color: red;
        }

        @media (max-width: 1000px) {
            .btn_exit {
                left: 10px;
            }

            .time {
                left: 70px;
            }

            .btn_close {
                left: 285px;
            }

            .header-madethi h5 {
                font-size: 11pt;
            }

            .modal-dia-madethi {
                height: 15vh;
            }
        }

        a {
            text-decoration: none;
        }
    </style>

    <style>
        .alert-item {
            background-color: #f9f9ff !important;
            box-shadow: none !important;
            border-radius: 0 !important;
        }

        .alert-item {
            color: #860114;
            font-family: Lobster, "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        }

        .section-practice__header {
            position: relative;
        }

        .btn-view-all {
            position: absolute;
            color: #000;
            font-weight: 700;
            text-decoration: none;
            bottom: 20px;
            right: 20px;
            font-size: 1rem;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", "Liberation Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
        }

        .table {
            margin: 0 10px;
            width: 100%;
            vertical-align: middle;
        }

        th, td {
            padding: 0 10px;
            text-align: center;
            font-size: 19px;
        }

        thead tr {
            border-bottom: 2px solid #ab0505;
        }

        tbody tr:first-child {
            margin-top: 10px;
        }

        .icon-top {
            height: 50px;
            width: 50px !important;
        }

        .rank-number {
            width: 50px !important;
            height: 50px !important;
            padding-top: 10px;
        }

        .star {
            height: 20px;
            width: 20px !important;
            display: inline-block !important;
        }

        tr td:first-child {
            display: flex;
            align-items: center;
            justify-content: center !important;
        }

        td {
            vertical-align: middle;
        }

        .alert-item {
            background-color: white;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
            border-radius: 40px 40px 20px 20px;
            font-size: 20px;
        }

        .alert-item__title img {
            height: 60px;
            object-fit: contain;
            object-position: center;
            margin-top: -1.5rem;
        }

        .alert-item__title {
            margin-bottom: 10px;
            margin-top: 20px;
            width: 100%;
            text-align: center;
            position: relative;
            font-size: 24px;
        }

        .video-big__title {
            text-align: center;
        }

        .subject-item__name {
            font-size: 1.0rem;
            font-weight: 600;
            color: #af0000;
            height: 32px;
            line-height: 1;
        }

        .block-content__header .btn-exit {
            position: absolute;
            top: -25px;
            right: 0;
            display: inline-block;
            width: 50px;
        }
        .alert-item {
             color: #1a98d1  !important;
        }
        .menu-bottom .link-menu a.active{
            color: #0089c7  !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="page-view bg-color-1 m-bottom">
        <div class="header-avatar-view">
            <div class="user-avatar">
                <img id="imgPreview1" src="../../images/user_noimage.jpg" class="user-avatar__image" />
            </div>
            <div class="info-right">
                <div class="info-right__name">Lưu Văn Quyết</div>
                <div class="info-right__star">
                    <img src="/images/icon-star-2.png" alt="Alternate Text">
                    <span>100</span>
                </div>
            </div>
        </div>
        <div class="block-content min-h-1">
            <div class="block-content__header">
                <img class="--title" src="/images/history.png" alt="Alternate Text" />
                <a href="/app-danh-muc-khoi-thcs-6" runat="server" id="backSeverClick" class="btn-exit">
                    <img src="/images/exit_blue.png" />
                </a>

            </div>
            <div id="section-alert" class="mb-3">
                <div class="alert-item pb-5">
                    <%--<div class="alert-item__title">
                        <img src="/images/bg-header-thcs-thanhtich.png" alt="Alternate Text" />
                    </div>--%>
                    <div class="container">
                        <div class="alert-item__title">
                            BÀI KIỂM TRA THƯỜNG XUYÊN 1
                        </div>
                        <div class="alert-item__header">
                            Lớp: 
                            <asp:Label ID="lblLop" runat="server">6</asp:Label>
                            Môn:
                            <asp:Label ID="lblMon" runat="server">Toán Học</asp:Label>
                        </div>
                        <asp:ScriptManager ID="scrThanhTich" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="upThanhTich" runat="server">
                            <ContentTemplate>

                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th class="lobster-regular">STT</th>
                                            <th class="lobster-regular">Điểm số</th>
                                            <th class="lobster-regular">Ngày làm bài</th>
                                            <th class="lobster-regular">Thời gian làm bài</th>
                                            <th class="lobster-regular">Chi tiết</th>
                                        </tr>
                                    </thead>
                                    <body>
                                        <tr>
                                            <td>1</td>
                                            <td>9</td>
                                            <td>04/02/2024</td>
                                            <td>15:00</td>
                                            <td>
                                                <a href="#" class="btn-detail">
                                                    <%--<img src="/images/btn-xemchitiet.png">--%>
                                                    Xem
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>9</td>
                                            <td>04/02/2024</td>
                                            <td>15:00</td>
                                            <td>
                                                <a href="#" class="btn-detail">
                                                    <%--<img src="/images/btn-xemchitiet.png">--%>
                                                    Xem
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>9</td>
                                            <td>04/02/2024</td>
                                            <td>15:00</td>
                                            <td>
                                                <a href="#" class="btn-detail">
                                                    <%--<img src="/images/btn-xemchitiet.png">--%>
                                                    Xem
                                                </a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>9</td>
                                            <td>04/02/2024</td>
                                            <td>15:00</td>
                                            <td>
                                                <a href="#" class="btn-detail">
                                                    <%--<img src="/images/btn-xemchitiet.png">--%>
                                                    Xem
                                                </a>
                                            </td>
                                        </tr>
                                    </body>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
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

