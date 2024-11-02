<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLandingPage_THPT.master" AutoEventWireup="true" CodeFile="thpt_HuongDanBaiTap.aspx.cs" Inherits="landingpage_THPT_thpt_HuongDanBaiTap" %>
<%@ Register Src="~/web_usercontrol/global_LandingPage_Menu_THPT.ascx" TagPrefix="uc1" TagName="global_LandingPage_Menu_THPT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <uc1:global_LandingPage_Menu_THPT runat="server" ID="global_LandingPage_Menu_THPT" />
    <div class="container-fluid">
        <div class="video-guide">
            <asp:Repeater ID="rpVideoMoiNhat" runat="server">
                <ItemTemplate>
                    <div class="video-guide__title">
                       <%#Eval("videohuongdan_title") %>
                    </div>
                    <div class="video-guide__view">
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe class="embed-responsive-item" src="<%#Eval("videohuongdan_video_path") %>" allowfullscreen=""></iframe>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div id="_listThuimbs" class="video-thuimbs-list">
            <asp:Repeater ID="rpListVideo" runat="server">
                <ItemTemplate>
                    <a href="#" class="video-thuimb-item">
                        <div class="video-thuimb-item__img">
                            <img src="<%#Eval("videohuongdan_image_path") %>" alt=" <%#Eval("videohuongdan_title") %>">
                        </div>
                        <div class="video-thuimb-item__right">
                            <div class="info-video">
                                <div class="info-video__title">
                                   <%#Eval("videohuongdan_title") %>
                                </div>
                                <%--<div class="info-video__status">
                                    <img src="/images/icon-new.png" >
                                </div>--%>
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
    <%--<script>
        data = [{
            id: 0,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai01.jpg",
            title: "Bài 1: Đơn thức",
            new: true,
        }, {
            id: 1,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai02.jpg",
            title: "Bài 2: Đa thức",
            new: false,
        }, {
            id: 2,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai03.jpg",
            title: "Bài 3: Phép cộng và phép trừ đa thức",
            new: false,
        }, {
            id: 3,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai04.jpg",
            title: "Bài 4: Phép nhân đa thức",
            new: false,
        },
        {
            id: 4,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai05.jpg",
            title: "Bài 5: Phép chia đa thức cho đơn thức",
            new: false,
        }, {
            id: 5,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai06.jpg",
            title: "Bài 6: Hiệu hai bình phương. Bình phương của một tổng hay một hiệu",
            new: false,
        },
        {
            id: 6,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai07.jpg",
            title: "Bài 7: Lập phương của một tổng. Lập phương của một hiệu",
            new: false,
        }, {
            id: 7,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai08.jpg",
            title: "Bài 8: Tổng và hiệu hai lập phương",
            new: false,
        },
        {
            id: 8,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai09.jpg",
            title: "Bài 9: Phân tích đa thức thành nhân tử",
            new: false,
        }, {
            id: 9,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai10.jpg",
            title: "Bài 10: Tứ giác",
            new: false,
        },
        {
            id: 10,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai11.jpg",
            title: "Bài 11: Hình thang cân",
            new: false,
        }, {
            id: 11,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai12.jpg",
            title: "Bài 12: Hình bình hành",
            new: false,
        }, {
            id: 12,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai13.jpg",
            title: "Bài 13: Hình chữ nhật",
            new: false,
        }, {
            id: 13,
            link: "#",
            image: "/images/banner-video/khoi08/Toan-08-Bai14.jpg",
            title: "Bài 14: Hình thoi và hình vuông",
            new: false,
        },];
        let html = '';
        let _new = '';
        html = data.map(function (item) {

            if (item.new) {
                _new = '<div class="info-video__status"><img src="/images/icon-new.png" alt="${item.title}"></div>';
            }
            else { _new = ''; }
            let genHTML = `<a href="${item.link}" class="video-thuimb-item">
                         <div class="video-thuimb-item__img">
                             <img src="${item.image}" alt="${item.title}">
                         </div>
                         <div class="video-thuimb-item__right">
                             <div class="info-video">
                                 <div class="info-video__title">
                                     ${item.title}
                                 </div>
                                ${_new}
                             </div>
                         </div>
                     </a>`
            return genHTML;
        });

        html = html.join('');
        document.getElementById('_listThuimbs').innerHTML = html;
    </script>--%>
</asp:Content>

