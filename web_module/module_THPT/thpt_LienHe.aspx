<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_LienHe.aspx.cs" Inherits="web_module_module_THPT_thpt_LienHe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .m-bottom {
            background-color: #AB0505;
            height: 200px;
        }

        .avata {
            overflow: hidden;
            position: relative;
            left: -228px;
            top: 10px;
            background-image: url(/images/bg-change-avatar.png);
            background-position: center;
            background-repeat: no-repeat;
            background-size: contain;
            margin: 0 auto;
            border: 0;
            border-radius: 0;
            width: 120px;
            height: 120px;
            padding: 20px;
        }

        .text {
            position: relative;
            left: 140px;
            top: -154px;
            font-size: 20px;
            color: white;
            font-weight: bold;
        }

        .sao {
            position: relative;
            width: 20px;
            left: 135px;
            top: -46px;
        }

        .diem {
            position: relative;
            top: -83px;
            left: 162px;
            color: white;
            font-weight: 900;
        }

        .btn-left {
            width: calc(50% - 10px);
            margin-right: 20px;
        }

        .btn-left-2 {
            width: calc(50% - 10px);
            margin-right: 20px;
        }

        .nen-1 {
            display: flex;
            flex-wrap: wrap;
            margin: 1rem 1rem 3rem 1rem;
            padding: 1rem;
            border-radius: 1rem;
            box-shadow: 0 10px 15px 2px rgba(0,0,0,.5);
            -webkit-box-shadow: 0 10px 15px 2px rgba(0,0,0,.5);
            -moz-box-shadow: 0 10px 15px 2px rgba(0, 0, 0, .5);
            background-color: #fff;
            margin-top: 30px;
        }

        .nen-2 {
            display: flex;
            flex-wrap: wrap;
            margin: 1rem 1rem 3rem 1rem;
            padding: 1rem;
            border-radius: 1rem;
            box-shadow: 0 10px 15px 2px rgba(0,0,0,.5);
            -webkit-box-shadow: 0 10px 15px 2px rgba(0,0,0,.5);
            -moz-box-shadow: 0 10px 15px 2px rgba(0, 0, 0, .5);
            margin: 1rem 1rem 3rem 1rem;
            background-color: #fff;
        }


        .btn-right {
            width: calc(50% - 10px);
        }

        .btn-right-2 {
            width: calc(50% - 10px);
        }

        .title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .a {
            width: 20px;
            margin-right: 5px;
        }

        .diachi {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            font-size: 20px;
        }

        .sdt {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            font-size: 20px;
        }

        .logo {
            display: block;
            position: relative;
            top: 17px;
            text-align: center;
            height: 112px;
            object-fit: contain;
            object-position: center;
        }

        .backbround {
            padding: 0 10px;
            flex-grow: 1;
            height: 100vh;
            background-color: #F9F9FF;
            border: 3px;
            border-radius: 40px;
            margin-top: -10px;
        }

        .abc {
            width: 172px;
        }
    </style>





    <style>
        .header {
            background-color: #ab0505;
            /*height: 20vh;*/
            box-shadow: rgba(0, 0, 0, 0.35) 0px -50px 36px -28px inset;
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

        .main__logo img {
            margin-top: 20px;
            height: 150px;
            object-fit: contain;
            object-position: center;
            width: 100%;
        }

        .main__logo {
            width: 100%;
            text-align: center;
        }

        .block-content {
            background-color: #fff;
            background-image: url(http://localhost:59661/images/bg-thcs-contact.png);
        }

        .home-page {
            background-color: #ab0505;
        }

        .menu-bottom .link-menu a.active {
            color: #0089c7;
        }

        .block-content min-h-1 {
            margin-bottom: 20px;
        }

        .block-content {
            padding-bottom: 40px;
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
                <%--<img id="imgPreview1" src="../../images/user_noimage.jpg" class="user-avatar__image" />--%>
                <img src="../../images/avt.png" />
            </div>
            <div class="info-right">
                <div class="info-right__name"><%=fullname %></div>
                <%--   <div class="info-right__star">
                    <img src="/images/icon-star-2.png" alt="Alternate Text">
                    <span>100</span>
                </div>--%>
            </div>

        </div>
        <div class="block-content min-h-1">
            <div class="main__logo">
                <img src="../../images/contact.png" />
            </div>
            <div class="main__content">
                <asp:Repeater ID="rpCoSo" runat="server">
                    <ItemTemplate>
                        <div class="nen-1">
                            <div class="btn-left">
                                <img src="<%#Eval("thongtincoso_image") %>" />
                            </div>
                            <div class="btn-right">
                                <div class="title">
                                    <%#Eval("thongtincoso_title") %>
                                </div>
                                <div class="diachi">
                                    <img class="a" src="../../images/diachi-thpt.png" />
                                    Địa chỉ: <%#Eval("thongtincoso_address") %>
                                </div>
                                <div class="sdt">
                                    <img class="a" src="../../images/sdt-thpt.png" />
                                    SĐT: <%#Eval("thongtincoso_telephone") %>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <%--<div class="nen-2">
                    <div class="btn-left-2">
                        <div class="title">
                            TRƯỜNG TH, THCS VÀ THPT VIỆT NHẬT 
                        </div>
                        <div class="diachi">
                            <img class="a" src="../../images/image_THCS/diachi.png" />
                            Địa chỉ: 365 Phan Châu Trinh, Bình Thuận, Hải Châu, Đà Nẵng
                        </div>
                        <div class="sdt">
                            <img class="a" src="../../images/image_THCS/sdt.png" />
                            SĐT: 0935888955
                        </div>
                    </div>
                    <div class="btn-right-2">
                        <img src="../../images/image_THCS/vietnhat.png" />
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

