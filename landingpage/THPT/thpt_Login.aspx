<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLandingPage_THPT.master" AutoEventWireup="true" CodeFile="thpt_Login.aspx.cs" Inherits="landingpage_THPT_thpt_Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <script src="../../admin_js/sweetalert.min.js"></script>
    <style>
        .login-background .login-container .login-content-right .login-button .btn-login {
            width: 40%;
            margin: 0rem;
        }

        ._8icz {
            align-items: center;
            border-bottom: 1px solid #dadde1;
            display: flex;
            margin: 20px 10px;
            text-align: center;
        }

        .forget-pass {
            color: #3f61e5;
        }

        .btn-create {
            background-color: #40c752;
            width: 30%;
            color: #f5f5f5;
            font-size: 1.3rem;
            border-radius: .75rem;
        }

            .btn-create:hover {
                color: #f5f5f5;
            }

        .login-background .login-container {
            padding-top: 1vh;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="login-background">
        <div class="login-container ">
            <div class="login-content-right ">
                <div class="logo">
                    <img src="../../uploadimages/avatar-hoc-sinh/logo-login1.png" />
                </div>

                <div class="col-12 text-login">
                    <h1>ĐĂNG NHẬP</h1>
                </div>
                <div class="col-12">
                    <div class="account-login">
                        <%-- <label for="username">Tài khoản</label>--%>
                        <input name="txtUser" type="text" id="txtUser" runat="server" class="form-account " placeholder="Tài khoản" />
                    </div>
                    <div class="account-login">
                        <%--<label for="password">Mật khẩu</label>--%>
                        <input name="txtPassword" type="password" id="txtPassword" runat="server" class="form-account " placeholder="Mật khẩu" />
                    </div>
                    <ul class="remember_me">
                        <li>
                            <input type="checkbox" id="brand1" value="" />
                            <label for="brand1"><span></span>Nhớ tài khoản</label>
                            <%--<a href="#">Forgot password?</a>--%>
                        </li>
                    </ul>
                    
                    <div class="login-button ">
                        <%--<a class=" btn-login" href="/thpt-trang-chu">Quay lại</a>--%>
                        <input id="btnLogin" runat="server" type="submit" class="btn btn-login" onserverclick="btnLogin_ServerClick" value="Đăng Nhập" />

                        <a href="/thpt-lien-he" class="btn btn-login">Tạo Tài Khoản</a>
                    </div>
                    <div class="_8icz"></div>
                    <div class="login-button ">
                        <%--<a href="/thpt-lien-he" class="btn btn-create">Tạo tài khoản</a>--%>
                        <%--<input id="Submit2" runat="server" type="submit" class="btn btn-create" value="Tạo tài khoản" />--%>
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

