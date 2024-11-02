<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLandingPage_THPT.master" AutoEventWireup="true" CodeFile="thpt_Default.aspx.cs" Inherits="landingpage_THPT_thpt_Default" %>

<%@ Register Src="~/web_usercontrol/global_LandingPage_Menu_THPT.ascx" TagPrefix="uc1" TagName="global_LandingPage_Menu_THPT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <script src="/js/current-device.min.js"></script>
    <script src="/js/owl.carousel.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <style>
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="home page-view">
        <uc1:global_LandingPage_Menu_THPT runat="server" ID="global_LandingPage_Menu_THPT" />
        <div id="section-slide" data-aos="fade-down"
            data-aos-easing="linear"
            data-aos-duration="1000">
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
                    <img src="/images/bg-landingpage-tieuhoc-1.png" alt="Alternate Text" />
                </div>
            </div>
        </div>
        <div class="block-1" data-aos="fade-down"
            data-aos-easing="linear"
            data-aos-duration="1250">
            <div class="block-main">
                <asp:Repeater ID="rpSlogan" runat="server">
                    <ItemTemplate>
                        <img src="<%#Eval("slogan_image") %>"  style="width:100%"/>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        <div class="block-2" data-aos="fade-down"
            data-aos-easing="linear"
            data-aos-duration="1500">
            <asp:Repeater ID="rpVideo" runat="server">
                <ItemTemplate>
                    <div class=" block-header"><%#Eval("tungcap_video_title") %></div>
                    <div class="video-view">
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe class="embed-responsive-item" src="<%#Eval("tungcap_video_link") %>" allowfullscreen></iframe>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="block-3" data-aos="fade-up">
            <asp:Repeater ID="rpQuyTrinhTieuDe" runat="server">
                <ItemTemplate>
                    <img src="<%#Eval("tungcap_quytrinh_title") %>" alt="Alternate Text" />
                </ItemTemplate>
            </asp:Repeater>

        </div>
        <div class="block-4">
            <div class="content">
                <div class="content-item" data-aos="fade-up">
                    <asp:Repeater ID="rpQuyTrinh1" runat="server">
                        <ItemTemplate>
                            <div class="content-item__img">
                                <img src="<%#Eval("tungcap_quytrinh_image_1") %>" alt="Alternate Text" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
                <div class="content-item" data-aos="fade-up">
                    <asp:Repeater ID="rpQuyTrinh2" runat="server">
                        <ItemTemplate>
                            <div class="content-item__img">
                                <img src="<%#Eval("tungcap_quytrinh_image_2") %>" alt="Alternate Text" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="content-item" data-aos="fade-up">
                    <asp:Repeater ID="rpQuyTrinh3" runat="server">
                        <ItemTemplate>
                            <div class="content-item__img">
                                <img src="<%#Eval("tungcap_quytrinh_image_3") %>" alt="Alternate Text" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="" data-aos="fade-up">
                <div id="slide-ads" class="owl-carousel owl-theme">
                    <asp:Repeater ID="rpDangKyKhoaHoc" runat="server">
                        <ItemTemplate>
                            <div class="item">
                                <div class="img-ads">
                                    <img src=" <%#Eval("quangcao_image") %>" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        <div class="block-button">
            <a href="../../thcs-lien-he">
                <img src="/images/bg-landingpage-tieuhoc-6.png" /></a>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
    <script>
        jQuery("#slide-main").owlCarousel({
            animateOut: "slideOutDown",
            animateIn: "flipInX",
            items: 1,
            loop: false,
            dots: false,
            margin: 0,
            nav: false,
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
        AOS.init();
    </script>
</asp:Content>

