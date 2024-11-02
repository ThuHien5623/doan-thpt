<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_Home.aspx.cs" Inherits="web_module_module_THPT_thpt_Home" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>--%>
    <script src="../../admin_js/sweetalert.min.js"></script>
    <style>
        .menu-bottom .link-menu a.active {
            color: #0089c7;
        }

        .alert-item__header {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }

        .header-avatar-view {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .block-body #section-class .class-item__name {
            color: #0089c7;
        }

        .header {
            background-color: #ab0505;
            /*height: 20vh;*/
            /*box-shadow: rgba(0, 0, 0, 0.35) 0px -50px 36px -28px inset;*/
            padding: 10px;
            display: flex;
        }

        .header__avatar {
            width: 90px;
            height: 90px;
            background-image: url(/images/bg-avatar.png);
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
            background-color: #0089c7;
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

        .block-body #section-class .class-item__quantity {
            color: rgb(6, 124, 179)
        }

        .block-body {
            background-image: url(/images/bg-home-thpt.png);
        }

        .header-avatar-view .info-right__logout {
            display: inline-block;
            width: 40px;
            position: absolute;
            top: -5px;
            right: 0;
            transition: transform .5s;
        }

        #section-slide {
            background: linear-gradient(90deg, rgba(0, 241, 255, 1) 0%, rgba(4, 112, 204, 1) 100%);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">

    <uc1:global_header_avatar_THPT runat="server" ID="global_header_avatar_THPT" />
    <div class="home page-view m-bottom">
        <div id="section-slide">
            <div class="block-main">
                <div id="slide-main" class="owl-carousel owl-theme">
                    <asp:Repeater ID="rpSlide" runat="server">
                        <ItemTemplate>
                            <div class="item">
                                <img src="<%#Eval("tungcap_slide_image") %>" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="bg-bottom">
                    <img src="/images/bg_slide_thpt.png" alt="Alternate Text" />
                </div>
            </div>
        </div>
        <div class="block-body">
            <div id="section-class">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col">
                            <%--<a id="id_Lop10" runat="server" href="/app-danh-muc-khoi-thpt-10" onclick="checkKhoi('10')" class="class-item">--%>
                            <a id="id_Lop10" runat="server" href="javascript:void(0)" onclick="checkKhoi(10)" class="class-item">
                                <div class="class-item__name">Lớp 10</div>
                                <div class="class-item__quantity">
                                    <img src="/images/icon-class-room-thcs.png" alt="Alternate Text" />
                                    <asp:Label ID="lblSoLuongHocSinhLop10" runat="server"></asp:Label>
                                </div>
                            </a>
                        </div>
                        <div class="col">
                            <a id="id_Lop11" runat="server" href="javascript:void(0)" onclick="checkKhoi(11)" class="class-item">
                                <div class="class-item__name">Lớp 11</div>
                                <div class="class-item__quantity">
                                    <img src="/images/icon-class-room-thcs.png" alt="Alternate Text" />
                                    <asp:Label ID="lblSoLuongHocSinhLop11" runat="server"></asp:Label>
                                </div>
                            </a>
                        </div>
                        <div class="col">
                            <a id="id_Lop12" runat="server" href="javascript:void(0)" onclick="checkKhoi(12)" class="class-item">
                                <div class="class-item__name">Lớp 12</div>
                                <div class="class-item__quantity">
                                    <img src="/images/icon-class-room-thcs.png" alt="Alternate Text" />
                                    <asp:Label ID="lblSoLuongHocSinhLop12" runat="server"></asp:Label>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div id="section-alert">
                <div id="slide-alert" class="owl-carousel owl-theme">
                    <asp:Repeater ID="rpThongBaoBaiKiemTra" runat="server">
                        <ItemTemplate>
                            <div class="item">
                                <div class="alert-item">
                                    <div class="alert-item__title">
                                        <img src="/images/thpt_icon-thongbao.png" alt="Alternate Text" />
                                    </div>
                                    <div class="">
                                        <a href="javascrip:void(0)">
                                            <img src="/images/bg1.gif" />
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div id="section-ads">
                <div class="block-main">
                    <div id="slide-ads" class="owl-carousel owl-theme">
                        <div class="img-ads">
                            <img src="../../uploadimages/slldt_ThongBao/dxflgcwr.fv2.png" />
                        </div>
                        
                        <%--  <asp:Repeater ID="rpDangKyHocVaThiOnline" runat="server">
                            <ItemTemplate>
                                <div class="item">
                                    <div class="img-ads">
                                        <img src="<%#Eval("quangcao_image") %>" />
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>--%>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div style="display: none; margin-bottom: 200px">
        <input type="text" id="txtKhoi_id" name="name" runat="server" value="" />
        <asp:Button Text="text" ID="btnKhoi" OnClick="btnKhoi_Click" runat="server" />
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
    <script>
        function checkKhoi(khoi_id) {
            document.getElementById("<%=txtKhoi_id.ClientID%>").value = khoi_id;
            document.getElementById("<%=btnKhoi.ClientID%>").click();
        }
    </script>
    <script>
        jQuery("#slide-main").owlCarousel({
            animateOut: "slideOutDown",
            animateIn: "flipInX",
            items: 1,
            loop: false,
            dots: false,
            margin: 0,
            nav: false,
            //navText: [
            //    '<i class="fa fa-angle-left" aria-hidden="true"></i>',
            //    '<i class="fa fa-angle-right" aria-hidden="true"></i>',
            //],
        });
        //jQuery('#slide-class').owlCarousel({
        //    autoWidth: true,
        //    items: 4,
        //    loop: false,
        //    rewind: false,
        //    margin: 30,
        //    dots: false,

        //});
        jQuery('#slide-alert').owlCarousel({
            animateOut: "slideOutDown",
            animateIn: "flipInX",
            items: 1,
            loop: false,
            dots: false,
            margin: 0,
            nav: true,

        });
        jQuery('#slide-ads').owlCarousel({
            animateOut: "slideOutDown",
            animateIn: "flipInX",
            items: 1,
            loop: false,
            dots: false,
            margin: 0,
            nav: true,

        });
    </script>
</asp:Content>

