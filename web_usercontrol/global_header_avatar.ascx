<%@ Control Language="C#" AutoEventWireup="true" CodeFile="global_header_avatar.ascx.cs" Inherits="web_usercontrol_global_header_avatar" %>

<div class="header-avatar-view">
    <a href="/app-quan-li-tai-khoan-thcs" class="user-avatar">
        <%--<img id="imgAvatar" src="<%=link_image %>" class="user-avatar__image" />--%>
        <img src="../images/avt.png" />
    </a>
    <div class="info-right">
        <div class="info-right__name"><%=fullname %></div>
       <%-- <div class="info-right__star">
            <img src="/images/icon-calendar-2.png" alt="Alternate Text">
            <span>&nbsp;<%=conlai_songay %> ngày</span>
        </div>--%>
        <a href="#" id="btnLogout" runat="server" onserverclick="btnLogout_ServerClick" class="info-right__logout">
            <img src="/images/icon-logout-thcs.png" alt="Alternate Text" /></a>
    </div>
</div>
