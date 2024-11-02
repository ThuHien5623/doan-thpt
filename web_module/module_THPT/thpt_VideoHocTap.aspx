<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_VideoHocTap.aspx.cs" Inherits="web_module_module_THPT_thpt_VideoHocTap" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .color-red {
            color: #b51a1a !important;
        }

        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .subject-item__name {
            color: #15aaed !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="page-view bg-color-1 m-bottom">
        <uc1:global_header_avatar_THPT runat="server" ID="global_header_avatar_THPT" />
        <div class="block-content min-h-1">
            <div class="block-content__header">

                <img class="--title" src="/images/thpt_icon-videohoctap_1.png" alt="Alternate Text" />
                <a href="/app-danh-muc-khoi-thpt-<%=khoi_id %>" id="backSeverClick" class="btn-exit">
                    <img src="/images/exit_blue.png" />
                </a>
            </div>
            <div class="video-detail">
                <div class="video-detail__title">
                    <%=tenbai %>
                    <a href="#" class="btn-favorite" id="btnHeart" runat="server" onserverclick="btnHeart_ServerClick"><i class="<%=video_heart %>"></i></a>
                    <%-- <a href="#" class="btn-favorite"><i class="fa fa-heart"></i></a>--%>
                </div>
                <div class="video-detail__view">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src="<%=link_baitap %>" allowfullscreen></iframe>
                    </div>
                </div>

            </div>
            <div class="video-thuimbs-list">
                <%--<div class="video-thuimbs-list__title">playlist music</div>--%>
                <asp:Repeater ID="rpDanhSach" runat="server">
                    <ItemTemplate>
                        <a href="/app-video-hoc-tap-thpt-<%=khoi_id%>-<%=mon_id%>-<%#Eval("videoluyentap_id") %>" class="video-thuimb-item <%#Eval("active") %>">
                            <div class="video-thuimb-item__img">
                                <img src=" <%#Eval("videoluyentap_image_path") %>" />
                            </div>
                            <div class="video-thuimb-item__right">
                                <div class="info-video">
                                    <div class="info-video__title">
                                        <%#Eval("videoluyentap_tenbai") %>
                                    </div>
                                    <div class="info-video__other">

                                        <%--<div class="icon important">
                                            <i class="<%#Eval("video_star_class") %>"></i>&nbsp;Quan trọng
                                        </div>
                                        <div class="icon favorite"><i class="<%#Eval("video_heart_class") %>"></i>&nbsp;Yêu thích</div>--%>
                                        <div class="icon views"><i class="fa fa-eye"></i>&nbsp;<%#Eval("video_view_count") %></div>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>


