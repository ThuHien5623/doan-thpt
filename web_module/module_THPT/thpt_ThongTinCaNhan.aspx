<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_ThongTinCaNhan.aspx.cs" Inherits="web_module_module_THPT_thpt_ThongTinCaNhan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .block-content .info-user__title {
            color: #0089c7;
        }

        .block-content .info-user-row__left {
            color: #0089c7;
        }

        .block-content .info-user .form-control-1 {
            color: #0089c7;
        }

        .btn-success {
            background-color: rgb(28, 175, 243);
            border-color: rgb(28, 175, 243);
            padding: 5px 15px 10px 15px;
        }
        .menu-bottom .link-menu a.active{
            color: #0089c7 ;
        }
    </style>
    <script src="../../admin_js/sweetalert.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="page-view bg-color-1 m-bottom">
        <div class="header-avatar-edit">
            <div class="user-avatar ">
                <div id="up1" class="user-avatar__image">
                    <asp:FileUpload CssClass="hidden-xs-up" ID="FileUpload1" runat="server" onchange="showPreview1(this)" Style="display: none" accept=".png,.jpeg,.jpg" />
                    <button type="button" class="change-avatar" onclick="clickavatar1()">
                        <img id="imgPreview1" runat="server" src="../../images/user_noimage.jpg" class="user-avatar__image" />
                    </button>
                </div>
            </div>
        </div>
        <div class="block-content">
            <div class="block-content__header">
                <a href="/app-quan-li-tai-khoan-thpt" class="btn-exit">
                    <img src="/images/exit_blue.png" />
                </a>
            </div>
            <div class="info-user">

                <div class="info-user__title">Thông Tin Cá Nhân</div>
                <div class="info-user-row">
                    <div class="info-user-row__left ">Tài khoản</div>
                    <div class="info-user-row__right">
                        <input name="" type="text" id="txtSoDienThoai" runat="server" readonly class="form-control-1  " placeholder="Số Điện Thoại" value="<%=sdt %>">
                    </div>
                </div>
                <div class="info-user-row">
                    <div class="info-user-row__left ">Họ và tên</div>
                    <div class="info-user-row__right">
                        <input id="txtHoTen" runat="server" name="" type="text" class="form-control-1  " placeholder="Họ và tên" value="Họ và tên">
                    </div>
                </div>
                <div class="info-user-row">
                    <div class="info-user-row__left ">Lớp</div>
                    <div class="info-user-row__right">
                        <%--      <%=lop %>--%>
                        <input name="" type="text" id="txtLop" runat="server" class="form-control-1  " onkeypress="return onlyNumberKey(event)" placeholder="Lớp" value="Lớp">
                    </div>
                </div>
                <%--   <div class="info-user-row">
                    <div class="info-user-row__left ">Ngày sinh</div>
                    <div class="info-user-row__right">
                        <input name="" type="date" id="dteNgaySinh" runat="server" class="form-control-1  " placeholder="Ngày sinh">
                    </div>
                </div>--%>
                <div class="info-user-row">
                    <div class="info-user-row__left ">Giới tính</div>
                    <div class="info-user-row__right">
                        <div class="checkbox-sex">
                            <input type="radio" id="rdNam" runat="server" name="sex" value="male">
                            <label for="male">Nam</label>
                            <input type="radio" id="rdNu" runat="server" name="sex" value="female">
                            <label for="female">Nữ</label>
                        </div>
                    </div>
                </div>

            </div>
            <div class="block-content__button">
                <a href="#" id="btnLuu" runat="server" onserverclick="btnLuu_ServerClick" class="btn btn-success">Lưu</a>
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
    <script>
        function clickavatar1() {
            $("#up1 input[type=file]").click();
        }
        function showPreview1(input) {
            if (input.files && input.files[0]) {
                var filerdr = new FileReader();
                filerdr.onload = function (e) {
                    $('#Wrapper_imgPreview1').attr('src', e.target.result);
                }
                filerdr.readAsDataURL(input.files[0]);
            }
        }
        function showImg1(img) {
            $('#Wrapper_imgPreview1').attr('src', img);
        }
        function onlyNumberKey(evt) {
            // Lấy mã ASCII của ký tự được nhập vào
            var ASCIICode = (evt.which) ? evt.which : event.keyCode;
            // Kiểm tra nếu ký tự không phải là số hoặc không phải các phím điều khiển (control keys)
            if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57)) {
                return false;
            }
            return true;
        }
    </script>
</asp:Content>

