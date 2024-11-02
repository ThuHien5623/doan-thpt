<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_RenewPackage.aspx.cs" Inherits="web_module_module_THPT_thpt_RenewPackage" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .renew-package .step-contact .step-header .step-circle.step-one {
            border: 2px solid #15aaed !important;
            color: #15aaed;
        }

        .renew-package .step-contact .step-content .packages-list .packages-item__name {
            color: #0089c7;
        }

        .step-header .step-circle.active {
            border: 2px solid #15aaed !important;
            color: #0089c7 !important;
        }

        .renew-package .step-contact .step-header .progress-bar {
            background-color: #0089c7 !important;
        }

        .step-header .progress-bar {
            color: #0089c7 !important;
        }

        .renew-package .step-contact .step-content .step-payment__info .--txt-1 a {
            font-weight: 700;
            color: #0089c7 ;
        }
        .renew-package .step-contact .step-content .step-congratulation .btn-success {
            background-color: #0089c7;
            border-color: #0089c7;
        }
        .menu-bottom .link-menu a.active{
            color: #0089c7 ;
        }
    </style>
    <script src="../../admin_js/sweetalert.min.js"></script>
    <script>
        function mygoi(goi) {
            var selectedText = $("#Wrapper_ddlGoi option:selected").text();
            document.getElementById("<%=lblGoi.ClientID%>").innerHTML = goi;
            document.getElementById("<%=lblGoiThanhToan.ClientID%>").innerHTML = goi;
            document.getElementById("<%=txtGoiGiaHan.ClientID%>").value = goi;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="page-view bg-color-1 m-bottom">
        <uc1:global_header_avatar_THPT runat="server" ID="global_header_avatar_thpt" />
        <div class="block-content">
            <div class="block-content__header">
                <a href="../../app-thpt" runat="server" id="backSeverClick" class="btn-exit">
                    <img src="/images/exit_blue.png" />
                </a>
            </div>
            <div class="frame-page">
                <div class="renew-package">
                    <div id="" class="step-contact">
                        <div class="step-header">
                            <div class="progress px-1" style="height: 3px;">
                                <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="step-container d-flex justify-content-between">
                                <div class="step-circle step-one">1</div>
                                <div class="step-circle step-two">2</div>
                                <div class="step-circle step-three">3</div>
                            </div>
                        </div>
                        <div id="multi-step-form" class="step-content">
                            <div class="step step-1">

                                <div class="step-block">
                                    <div class="choise-package">
                                        <div class="choise-package__title">Chọn gói</div>
                                        <div class="packages-list">
                                            <asp:Repeater ID="rpGoiThanhToan" runat="server">
                                                <ItemTemplate>
                                                    <a href="javascript:void(0)" class="packages-item" id="btnGoi" onclick="mygoi('<%#Eval("banggiachitiet_gia") %>')">
                                                        <div class="packages-item__name">
                                                            <%#Eval("banggiachitiet_gia") %>
                                                        </div>
                                                        <div class="packages-item__button">
                                                            Đăng kí
                                                        </div>
                                                    </a>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                        <div class="choise-package__btn">
                                            <a href="javascript:void(0)" class=" next-step">Tiếp theo</a>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="step step-2">
                                <!-- Step 2 form fields here -->
                                <div class="step-block">
                                    <div class="step-payment">
                                        <div class="step-payment__title">Thông tin sản phẩm</div>
                                        <div class="step-payment__order">
                                            <table>
                                                <tbody>
                                                    <tr>
                                                        <td>Họ và tên</td>
                                                        <td>:</td>
                                                        <td><b id="">
                                                            <asp:Label ID="lblHoTen" runat="server"></asp:Label></b></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Số điện thoại</td>
                                                        <td>:</td>
                                                        <td><b id="">
                                                            <asp:Label ID="lblSoDienThoai" runat="server"></asp:Label></b></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Lớp</td>
                                                        <td>:</td>
                                                        <td><b id="">
                                                            <asp:Label ID="lblLop" runat="server"></asp:Label></b></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Gói</td>
                                                        <td>:</td>
                                                        <td><b id="">
                                                            <asp:Label ID="lblGoi" runat="server"></asp:Label></b></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>

                                    </div>
                                </div>
                                <div class="step-block">
                                    <div class="step-payment">
                                        <div class="step-payment__title">Thông tin thanh toán</div>
                                        <div class="step-payment__info">

                                            <div class="--txt-1">
                                                Hình thức thanh toán: <b>Chuyển khoản ngân hàng</b>
                                            </div>
                                            <div class="--txt-1">
                                                💥Số tiền thanh toán: <b class="txt-red">
                                                    <asp:Label ID="lblGoiThanhToan" runat="server"></asp:Label></b>
                                            </div>
                                            <asp:Repeater ID="rpThongTinThanhToan" runat="server">
                                                <ItemTemplate>
                                                    <div class="bank">
                                                        <div class="bank-info">
                                                            💥<%#Eval("thongtinthanhtoan_tennganhang") %><br />
                                                            💥Số tài khoản: <b><%#Eval("thongtinthanhtoan_sotaikhoan") %></b>
                                                            <br />
                                                            💥Chủ tài khoản:<%#Eval("thongtinthanhtoan_chutaikhoan") %><br />
                                                            💥Nội dung chuyển khoản ghi rõ:<%#Eval("thongtinthanhtoan_noidungchuyenkhoan") %><br />
                                                            ✔️Ví dụ: <b><%#Eval("thongtinthanhtoan_vidu") %></b>
                                                        </div>
                                                        <div class="bank-qr">
                                                            <img src="/images/img-qr.jpg" alt="Alternate Text" />
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <br />
                                            <div class="--txt-1">
                                                📱Số điện thoại tư vấn: <a href="tel:0818795939" target="_blank">0818.79.59.39</a>
                                            </div>
                                        </div>
                                        <div class="step-payment__button">
                                            <button type="button" class="btn prev-step">Lùi lại</button>
                                            <button type="button" class="btn next-step">Tiếp theo</button>
                                        </div>
                                    </div>
                                </div>




                            </div>
                            <div class="step step-3">
                                <!-- Step 3 form fields here -->
                                <div class="step-block">
                                    <div class="step-congratulation">
                                        <div style="display: none">
                                            <input id="txtGoiGiaHan" type="text" runat="server" />
                                        </div>
                                        <img src="/images/congratulation-2.png" class="img-congratulation" alt="Alternate Text" />
                                        <h4 class="--txt-1">Vui lòng bấm "xác nhận" đặt hàng</h4>
                                        <div class="--txt-2">Thông tin tài khoản kích hoạt sẽ được gửi qua tin nhắn điện thoại và Email đã đăng kí.</div>
                                        <div class="step-congratulation__button">
                                            <button type="button" class="btn prev-step">Lùi lại</button>
                                            <a href="javascript:void(0)" class="btn btn-success" id="btnXacNhan" runat="server" onserverclick="btnXacNhan_ServerClick">Xác nhận</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
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

        $(document).ready(function () {
            $('.packages-item').click(function () {
                $('.packages-item').removeClass('active');
                $(this).addClass('active');
            })
            $("#multi-step-form").find(".step").slice(1).hide();

            $(".next-step").click(function () {
                //debugger
                if (currentStep < 3) {
                    valid = true;
                    y = $("input.input-text, select"); //get input and select option
                    //console.log($('select#Wrapper_ddlLop').val())
                    for (i = 0; i < y.length; i++) {
                        if (y[i].value == "" || y[i].value == "Chọn lớp" || y[i].value == "Chọn gói") {
                            valid = false;
                        }
                    }
                    if (valid == false) {
                        swal('Vui lòng nhập đầy đủ thông tin trước khi qua bước tiếp theo', '', 'warning')
                    }
                    else {
                        $(".step-" + currentStep).addClass(
                            "animate__animated animate__fadeOutLeft"
                        );
                        currentStep++;
                        setTimeout(function () {
                            $(".step").removeClass("animate__animated animate__fadeOutLeft").hide();
                            $(".step-" + currentStep)
                                .show()
                                .addClass("animate__animated animate__fadeInRight");
                            updateProgressBar();
                        }, 500);
                    }
                }
            });

            $(".prev-step").click(function () {
                if (currentStep > 1) {
                    $(".step-" + currentStep).addClass(
                        "animate__animated animate__fadeOutRight"
                    );
                    currentStep--;
                    setTimeout(function () {
                        $(".step")
                            .removeClass("animate__animated animate__fadeOutRight")
                            .hide();
                        $(".step-" + currentStep)
                            .show()
                            .addClass("animate__animated animate__fadeInLeft");
                        updateProgressBar();
                    }, 500);
                }
            });

            updateProgressBar = function () {
                var progressPercentage = ((currentStep - 1) / 2) * 100;
                if (progressPercentage == 50) {
                    $('.step-two').addClass('active');
                    $('.step-three').removeClass('active');
                }
                else if (progressPercentage == 100) {
                    $('.step-three').addClass('active');
                }
                else {
                    $('.step-circle').removeClass('active');
                }
                $(".progress-bar").css("width", progressPercentage + "%");
            };
        });

    </script>
</asp:Content>

