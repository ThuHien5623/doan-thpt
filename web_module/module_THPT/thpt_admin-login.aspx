<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_admin-login.aspx.cs" Inherits="web_module_module_THPT_thpt_admin_login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link rel="stylesheet" href="style.css">
    <style>
        .auth-container {
            max-width: 400px;
            margin: 50px auto;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            min-height: 260px;
            background: #d8d0d0;
        }

        .auth-header {
            margin-bottom: 20px;
        }

        .auth-title {
            font-size: 24px;
            font-weight: bold;
            color: #ffffff;
            padding: 20px;
            text-align: center;
        }

        .auth-container .auth-title {
            color: #f4f5f7;
            background-color: #ad0c0c;
            padding: 20px;
            line-height: 30px;
            font-size: 24px;
            font-weight: 600;
            margin: -30px -30px 20px;
        }

        .auth-content .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

            .form-control.underlined {
                border-bottom: 2px solid #ddd;
                border-radius: 0;
            }

            .form-control::placeholder {
                color: #aaa;
            }

        .checkbox {
            display: none;
        }

            .checkbox + label {
                position: relative;
                padding-left: 30px;
                cursor: pointer;
                user-select: none;
            }

                .checkbox + label::before {
                    content: '';
                    position: absolute;
                    left: 0;
                    top: 0;
                    width: 20px;
                    height: 20px;
                    border: 2px solid #85CE36;
                    border-radius: 3px;
                    background: #d8d0d0;
                }

            .checkbox:checked + label::before {
                background-color: #85CE36;
            }

            .checkbox:checked + label::after {
                content: '\2713';
                position: absolute;
                left: 5px;
                top: 1px;
                font-size: 16px;
                color: #808080;
            }

        .btn-primary {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            color: #ffffff;
            background-color: #85CE36;
            border-color: #85CE36;
        }

            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }

        .btn-block {
            display: block;
            width: 100%;
        }

        .text-center {
            text-align: center;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="auth-container">
        <div class="card">
            <header class="auth-header">
                <h1 class="auth-title text-center">QUẢN TRỊ VIỆT NHẬT
                </h1>
            </header>
            <div class="auth-content">
                <div>
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input name="txtUser" type="text" id="txtUser" class="form-control underlined" placeholder="Tài khoản">
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input name="txtPassword" type="password" id="txtPassword" class="form-control underlined" placeholder="Mật khẩu">
                    </div>
                    <div class="form-group">
                        <input name="remember" type="checkbox" id="remember" class="checkbox" checked="checked">
                        <label for="remember"><span>Remember me</span></label>
                    </div>
                    <div class="form-group">
                        <div id="udLogin">
                            <input name="btnLogin" type="submit" id="btnLogin" class="btn btn-block btn-primary" value="Login">
                        </div>
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

