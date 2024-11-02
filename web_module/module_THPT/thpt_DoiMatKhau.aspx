<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_DoiMatKhau.aspx.cs" Inherits="web_module_module_THPT_thpt_DoiMatKhau" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .block-content .info-user-row__left {
            width: 40%;
        }

        .block-content .info-user-row, .block-content .info-user .form-control-1 {
            font-size: 1rem;
        }

        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .info-user__title {
            color: #0089c7 !important;
        }

        .block-content .info-user-row__left {
            color: #0089c7 !important;
        }
        .menu-bottom .link-menu a.active {
             color: #0089c7 !important;
        }


        /* .block-content {
            min-height: calc(100vh - 2000px);
        }*/
    </style>
    <script src="../../admin_js/sweetalert.min.js"></script>
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
                <a class="btn-exit" href="/app-quan-li-tai-khoan-thpt">
                    <img src="/images/exit_blue.png">
                </a>
            </div>
            <div class="info-user">
                <div class="info-user__title">Đổi Mật Khẩu</div>
                <div class="info-user-row">
                    <div class="info-user-row__left" for="">Mật khẩu cũ</div>
                    <div class="info-user-row__right">
                        <input name="" type="password" id="txtMatKhauCu" runat="server" class="form-control-1 " placeholder="Mật Khẩu Cũ">
                    </div>
                </div>
                <div class="info-user-row">
                    <div class="info-user-row__left" for="">Mật khẩu mới</div>
                    <div class="info-user-row__right">
                        <input name="" type="password" id="txtMatKhauMoi" runat="server" class="form-control-1 " placeholder="Mật Khẩu Mới">
                    </div>
                </div>
                <div class="info-user-row">
                    <div class="info-user-row__left" for="">Nhập lại mật khẩu</div>
                    <div class="info-user-row__right">
                        <input name="" type="password" id="txtNhapLaiMatKhauMoi" runat="server" class="form-control-1 " placeholder="Nhập Lại mật Khẩu Mới">
                    </div>
                </div>
            </div>
            <div class="block-content__button">
                <a href="#" id="btnDoiMatKhau" runat="server" onserverclick="btnDoiMatKhau_ServerClick" class="btn btn-success">Đổi mật khẩu</a>
            </div>
        </div>


    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

