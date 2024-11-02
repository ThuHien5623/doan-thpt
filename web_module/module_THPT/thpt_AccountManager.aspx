<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_AccountManager.aspx.cs" Inherits="web_module_module_THPT_thpt_AccountManager" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .info-item__title {
            color: #0089c7 !important;
        }

        .card-menu .btn-logout {
            color: #0089c7 !important;
        }

        .menu-bottom .link-menu a.active {
            color: #0089c7 !important;
        }

        .title {
            display: block;
            width: 100%;
            text-align: center;
            color: #0089c7;
            font-size: 1.9rem;
            line-height: 1;
            padding: 1.5rem;
            font-family: "Coiny", system-ui;
        }

        .title-child {
            color: #0089c7;
            font-size: 1.2rem;
            line-height: 1;
            font-family: "Coiny", system-ui;
            margin-bottom: 1.3rem;
        }

        .inf {
            color: #0089c7;
            font-size: 1.2rem;
            line-height: 1;
            font-weight: 400;
            margin-bottom: 1.3rem;
        }

        ._8icz {
            align-items: center;
            border-bottom: 1px solid #dadde1;
            display: flex;
            margin: 20px 10px;
            text-align: center;
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
        <div class="block-content">
            <div class="block-content__header">
                <a href="../../app-thpt" runat="server" id="backSeverClick" class="btn-exit">
                    <img src="/images/exit_blue.png" />
                </a>
            </div>
            <div class="frame-page page-style-2">
                <div class="card-manager-account">
                    <%--   <div class="header-info-list">
                        <div class="info-item">
                            <div class="info-item__title">Thời hạn</div>
                            <div class="info-item__text"><%=conlai_songay %> ngày</div>
                            <div class="info-item__status"><small class="badge badge-pill badge-warning"><%=canhbao_hethan %> </small></div>
                        </div>
                        <div class="info-item">
                            <div class="info-item__title">Gói sử dụng</div>
                            <div class="info-item__text"><%=goi_sudung %></div>
                            <div class="info-item__button"><a href="/app-gia-han-goi-thpt" class="btn btn-sm btn-outline-primary">Gia hạn ngay</a></div>
                        </div>
                    </div>--%>
                    <div class="card-menu info-user">
                        <label class="title">Thông tin cá nhân</label>
                        <br />
                        <div class="row">
                            <div class="title-child col-3">Họ tên: </div>
                            <div class="inf">
                                <label><%=fullname %></label>
                            </div>
                        </div>
                        <div class="_8icz"></div>
                        <div class="row">
                            <div class="title-child col-3">Lớp: </div>
                            <div class="inf">
                                <label><%=lop %></label>
                            </div>
                        </div>
                        <div class="_8icz"></div>

                        <%--<a href="/app-thong-tin-ca-nhan-thpt" class="menu-row">
                            <div class="menu-row__left" for="">Thông tin cá tài khoản</div>
                            <div class="menu-row__right" for=""><i class="fa fa-angle-right"></i></div>
                        </a>
                        <a href="/app-doi-mat-khau-thpt" class="menu-row">
                            <div class="menu-row__left" for="">Đổi mật khẩu</div>
                            <div class="menu-row__right" for=""><i class="fa fa-angle-right"></i></div>
                        </a>--%>
                        <%-- <a href="/app-tai-khoan-yeu-thich-thpt" class="menu-row">
                            <div class="menu-row__left" for="">Yêu thích</div>
                            <div class="menu-row__right" for=""><i class="fa fa-angle-right"></i></div>
                        </a>
                        <a href="/app-tai-khoan-lich-su-thpt" class="menu-row">
                            <div class="menu-row__left" for="">Lịch sử</div>
                            <div class="menu-row__right" for=""><i class="fa fa-angle-right"></i></div>
                        </a>--%>

                    </div>
                    <div class="card-menu">
                        <a id="btnSave" href="/thpt-trang-chu" class="btn btn-logout">Đăng xuất</a>
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

