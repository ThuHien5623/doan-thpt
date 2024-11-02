<%@ Control Language="C#" AutoEventWireup="true" CodeFile="global_menu.ascx.cs" Inherits="web_usercontrol_global_menu" %>
<div class="box-header__left">
    <div class="box-header__login">
        <a class="btn btn-login" id="btnShowLogin" href="/app-login-tieu-hoc">Đăng nhập
        </a>
        <a href="/app-tieu-hoc-tai-khoan" class="box-header__login--avatar" id="btnShowInfo" style="display: none">
            <img src="<%=avata%>" alt="Alternate Text" /></a>
    </div>
    <div class="box-header__info">
        <div class="box-header__star">
            <img src="/images/icon-star-2.png" alt="Alternate Text" />
            <asp:Label ID="lblSao" runat="server"></asp:Label>
        </div>
        <div class="box-header__price">
            <img src="/images/icon-calendar-2.png" alt="Alternate Text">
            <span>&nbsp;Còn lại: <%=conlai_songay%></span>
        </div>
    </div>

    <div class="menu-icon-list">
        <%-- <a href="/app-tieu-hoc-lich-su-thanh-toan" runat="server" class="icon-item icon-history-payment" >
            <img src="/images/icon-history-2.png" alt="Alternate Text" />
        </a>--%>
        <a href="/app-tieu-hoc-cai-dat" class="icon-item icon-config">
            <img src="/images/icon-config-3.png" alt="Alternate Text" />
        </a>
        <a href="/app-tieu-hoc-doi-vat-pham" runat="server" id="A2" class="icon-item icon-gift">
            <img src="/images/icon-gift-2.png" alt="Alternate Text" />
        </a><a href="/app-tieu-hoc-gio-hang" class="icon-item icon-cart">
            <img src="/images/icon-cart-2.png" alt="Alternate Text" />
            <div class="number"><%=soluong%></div>
        </a>

    </div>
</div>
<script>
    function showLogin() {
        document.getElementById("btnShowLogin").style.display = 'none';
        document.getElementById("btnShowInfo").style.display = 'block';
     }
</script>

