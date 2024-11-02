<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLandingPage_THPT.master" AutoEventWireup="true" CodeFile="thpt_Contact.aspx.cs" Inherits="landingpage_THPT_thpt_Contact" %>

<%@ Register Src="~/web_usercontrol/global_LandingPage_Menu_THPT.ascx" TagPrefix="uc1" TagName="global_LandingPage_Menu_THPT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <script src="../../admin_js/sweetalert.min.js"></script>
    <%-- <script>
        function myTiepTheo(hoten, sdt, email, lop, goi) {
            var selectedText = $("#Wrapper_ddlGoi option:selected").text();
            document.getElementById("<%=lblHoTen.ClientID%>").innerHTML = hoten;
            document.getElementById("<%=lblSoDienThoai.ClientID%>").innerHTML = sdt;
            document.getElementById("<%=lblEmail.ClientID%>").innerHTML = email;
            document.getElementById("<%=lblLop.ClientID%>").innerHTML = lop;
            document.getElementById("<%=lblGoi.ClientID%>").innerHTML = selectedText;
            document.getElementById("<%=lblGoiThanhToan.ClientID%>").innerHTML = selectedText.split('/')[0];
        }
    </script>--%>
    <style>
        .step-contact .step-content {
            margin: 0rem 1rem 0 1rem;
        }

        .form-contact__title {
            color: #ab0505 !important;
        }

        .step-contact .step-content .section-contact .form-contact .contact-label {
            font-weight: 600;
            font-size: 17px;
            color: #393939;
            line-height: 1.5;
            text-transform: uppercase;
        }

        .step-contact .step-content .section-contact .form-contact .input-text {
            background-color: white;
        }

        .step-contact .step-content .section-contact .form-contact .input-text {
            display: block;
             font-weight: 100; 
            font-size: 14px;
            width: 100%;
            color: #555;
            line-height: 1.2;
            padding-right: 15px;
            border: 0;
            background-color: white;
            font-style: italic;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <uc1:global_LandingPage_Menu_THPT runat="server" ID="global_LandingPage_Menu_THPT" />
    <asp:ScriptManager runat="server" />
    <div id="" class="step-contact">
        <div id="multi-step-form" class="step-content">
            <div class="step mt-5">
                <div class="step-block">
                    <div class="section-contact">
                        <div class="form-contact">
                            <h3 class="form-contact__title">ĐĂNG KÝ TÀI KHOẢN</h3>
                            <div class="form-contact__input-2">
                                <label for="" class="contact-label">Họ tên *</label>
                                <input id="txtHoTen" type="text" class="input-text" runat="server" name="txtName" value="" placeholder="Nhập họ tên" autocomplete="off" />
                            </div>
                            <div class="form-contact__input-2">
                                <label for="" class="contact-label">Tài khoản *</label>
                                <input id="txtTaiKhoan" type="text" class="input-text" runat="server" name="txtName" value="" placeholder="Nhập tài khoản" autocomplete="off" />
                            </div>
                            <div class="form-contact__input-2">
                                <label for="" class="contact-label">Mật khẩu *</label>
                                <input id="txtMatKhau" type="password" class="input-text" runat="server" name="txtName" value="" placeholder="Nhập mật khẩu" autocomplete="off" />
                            </div>
                            <div class="form-contact__input-2">
                                <label for="" class="contact-label">Nhập lại mật khẩu *</label>
                                <input id="txtNhapLaiMatKhau" type="password" class="input-text" runat="server" name="txtName" value="" placeholder="Nhập lại mật khẩu" autocomplete="off" />
                            </div>
                            <div class="form-contact__input-2">
                                <label for="" class="contact-label">Điện thoại *</label>
                                <input id="txtSoDienThoai" type="text" class="input-text" runat="server" name="txtPhone" value="" onkeypress="return onlyNumberKey(event)" placeholder="Nhập số điện thoại" autocomplete="off" />
                            </div>
                            <div class="form-contact__input-2">
                                <asp:DropDownList ID="ddlLop" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                            <div class="form-contact__btn">
                                <asp:Button Text="Đăng ký" ID="btnDangKy" OnClick="btnDangKy_ServerClick" OnClientClick="return checkNULL()" CssClass="next-step" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function checkNULL() {
            var txtHoTen = document.getElementById('<%= txtHoTen.ClientID%>');
            var txtTaiKhoan = document.getElementById('<%= txtTaiKhoan.ClientID%>');
            var txtMatKhau = document.getElementById('<%= txtMatKhau.ClientID%>');
            var txtNhapLaiMatKhau = document.getElementById('<%= txtNhapLaiMatKhau.ClientID%>');
            var txtSoDienThoai = document.getElementById('<%= txtSoDienThoai.ClientID%>');

            if (txtHoTen.value.trim() == "") {
                swal('Vui lòng nhập họ tên!', '', 'warning').then(function () { txtHoTen.focus(); });
                return false;
            }
            if (txtTaiKhoan.value.trim() == "") {
                swal('Vui lòng nhập tài khoản!', '', 'warning').then(function () { txtTaiKhoan.focus(); });
                return false;
            }
            if (txtMatKhau.value.trim() == "") {
                swal('Vui lòng nhập mật khẩu!', '', 'warning').then(function () { txtMatKhau.focus(); });
                return false;
            }
            if (txtNhapLaiMatKhau.value.trim() == "") {
                swal('Vui lòng nhập lại mật khẩu!', '', 'warning').then(function () { txtNhapLaiMatKhau.focus(); });
                return false;
            }
            if (txtSoDienThoai.value.trim() == "") {
                swal('Vui lòng nhập số điện thoại!', '', 'warning').then(function () { txtSoDienThoai.focus(); });
                return false;
            }
            return true;
        }
    </script>
    <script>
        function onlyNumberKey(evt) {
            // Lấy mã ASCII của ký tự được nhập vào
            var ASCIICode = (evt.which) ? evt.which : event.keyCode;
            // Kiểm tra nếu ký tự không phải là số hoặc không phải các phím điều khiển (control keys)
            if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57)) {
                return false;
            }
            return true;
        }
        var currentStep = 1;
        var updateProgressBar;

        function displayStep(stepNumber) {
            if (stepNumber >= 1 && stepNumber <= 3) {
                $(".step-" + currentStep).hide();
                $(".step-" + stepNumber).show();
                currentStep = stepNumber;
                updateProgressBar();
            }
        }


    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

