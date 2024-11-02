<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_DanhMucKhoi.aspx.cs" Inherits="web_module_module_THPT_thpt_DanhMucKhoi" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>--%>
    <style>
        #slide-practice .owl-nav button.owl-next {
            right: 0;
            background-image: url(/images/arrow-slide-right-thpt.png);
        }

        #slide-practice .owl-nav button.owl-prev {
            left: 0;
            background-image: url(/images/arrow-slide-left-thpt.png);
        }

        .practice-item__other {
            justify-content: unset;
        }

        .btn-favorite {
            margin-right: 6px;
        }

        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .section-achievement .table thead tr {
            color: #1176a3;
        }

        .section-achievement .table thead th {
            border-bottom: 2px solid #0373a6;
        }

        .section-achievement {
            color: #1176a3;
        }

        .subject-item__name {
            color: #1176a3 !important;
        }

        .block-content.--bg-image-1 {
            background-image: url(/images/bg-danhmuckhoi-thpt.png);
        }

        .section-contest__title {
            color: #05587e;
        }

        .menu-bottom .link-menu a.active {
            color: #0089c7;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="page-view bg-color-1 m-bottom">
        <uc1:global_header_avatar_THPT runat="server" ID="global_header_avatar" />
        <div class="block-content --bg-image-1 min-h-1 pb-5">
            <div class="block-content__header">
                <a href="/app-thpt" runat="server" id="backSeverClick" class="btn-exit">
                    <img src="/images/exit_blue.png" />
                </a>
            </div>
            <div id="section-subjects">
                <div id="slide-subjects" class="owl-carousel owl-theme">
                    <asp:Repeater ID="rpMon" runat="server">
                        <ItemTemplate>
                            <div class="item">
                                <div class="subject-item" <%#Eval("mon_active") %>>
                                    <a href="javascript:void(0)" class="subject-item__img" onclick="xemMon( <%#Eval("mon_id") %>)">
                                        <img src="<%#Eval("mon_image") %>" alt="Alternate Text" />
                                    </a>
                                    <div class="subject-item__name">
                                        <%#Eval("mon_name") %>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="section-video">
                <div class="video-cate">
                    <div class="video-cate__title">
                        <img src="/images/thpt_icon-videohoctap.png" alt="Alternate Text" />
                    </div>
                    <div style="display: none">
                        <input type="text" id="txtTest" runat="server" name="name" value="" />
                        <input type="text" id="txtIndexTest" runat="server" name="name" value="" />
                    </div>
                    <asp:Repeater ID="rpVideoLuyentap" runat="server">
                        <ItemTemplate>
                            <a href="/app-video-hoc-tap-thpt-<%#Eval("videoluyentap_lop") %>-<%#Eval("monhoc_id") %>-<%#Eval("videoluyentap_id") %>" class="video-big">
                                <div class="video-big__image">
                                    <img src="<%#Eval("videoluyentap_image_path") %>" />
                                </div>
                                <div class="video-big__title">
                                    <%#Eval("videoluyentap_tenbai") %>
                                </div>
                            </a>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="section-practice">
                <div class="section-practice__header">
                    <img src="/images/thpt_icon-luyentap-topleft-thpt.png" alt="Alternate Text" />
                    <a href="/app-luyen-tap-thpt-<%=khoi_id %>-<%=mon_id %>" class="btn-view-all" id="btnXemTatCa" runat="server">Xem tất cả</a>
                </div>
                <div id="slide-practice" class="owl-carousel owl-theme">
                    <asp:Repeater ID="rpBaiLuyenTap" runat="server">
                        <ItemTemplate>
                            <div class="item">
                                <div class="practice-item">
                                    <div class="practice-item__other">
                                        <span class="icon"><i class="fa fa-eye">&nbsp;<%#Eval("count_view") %></i></span>
                                        <%--  <span class="icon"><i class="<%#Eval("luyentap_star_class") %>"></i></span>--%>
                                        <%-- <span class="icon"><i class="<%#Eval("luyentap_heart_class") %>"></i></span>--%>
                                        <%-- <img src="../../images/3sao.png" />--%>
                                    </div>
                                    <div class="practice-item__name">
                                        <%#Eval("luyentap_name") %>
                                    </div>
                                    <a href="/<%#Eval("test_link") %>" class="practice-item__button">
                                        <img src="/images/thpt_icon-lambai-luyentap.png" alt="Alternate Text" />
                                    </a>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <%--<div class="section-contest">
                <div class="section-contest__title">
                    Bài kiểm tra
                        <a href="/app-bai-kiem-tra-thpt-<%=khoi_id %>" class="btn-view-all">Xem tất cả</a>
                </div>
                <div id="slide-contest" class="owl-carousel owl-theme">
                    <asp:Repeater ID="rpBaiKiemTra" runat="server">
                        <ItemTemplate>
                            <div class="item">
                                <div class="contest-item">
                                    <div class="contest-item__img">
                                        <img src="/images/thcs-avt-test.png" alt="Alternate Text" />
                                    </div>
                                    <div class="contest-item__name">
                                        <%#Eval("luyentap_name") %>
                                    </div>
                                    <a href="/<%#Eval("test_link") %>" class="contest-item__button">
                                        <img src="/images/thpt_icon-lambai-luyentap.png" alt="Alternate Text" />
                                    </a>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>--%>
            <div id="" class="mb-3">
                <div class="section-achievement pb-5">
                    <div class="section-achievement__title">
                        <img src="/images/thpt_icon-thanhtich.png" alt="Alternate Text" />
                    </div>
                    <div class="section-achievement__info">
                        Lớp: <asp:Label ID="lblLop" runat="server"></asp:Label>
                        Môn: <asp:Label ID="lblMon" runat="server"></asp:Label>
                    </div>
                    <div class="">

                        <asp:ScriptManager ID="scrThanhTich" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="upThanhTich" runat="server">
                            <ContentTemplate>
                                <div class="section-achievement__select">
                                    <label class="form-control-label">Chọn bài luyện tập:</label>
                                    <div class="">
                                        <asp:DropDownList ID="ddlBaiLuyenTap" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlBaiLuyenTap_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                        <%--  <dx:ASPxComboBox ID="ddlTenBaiTest" runat="server" ValueType="System.Int32" TextField="luyentap_name" ValueField="luyentap_id" OnSelectedIndexChanged="ddlTenBaiTest_SelectedIndexChanged" ClientInstanceName="ddlTenBaiTest" AutoPostBack="true" CssClass="" Width="100%"></dx:ASPxComboBox>--%>
                                    </div>
                                </div>
                                <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th class="lobster-regular">STT</th>
                                            <th class="lobster-regular">Họ và tên</th>
                                            <th class="lobster-regular">Điểm số</th>
                                            <th class="lobster-regular">Số lần làm bài</th>
                                            <th class="lobster-regular">Thời gian làm bài</th>
                                        </tr>
                                    </thead>
                                    <body>
                                        <asp:Repeater ID="rpThanhTich" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td><%=STT++ %></td>
                                                    <td>
                                                        <%#Eval("children_fullname") %>
                                                    </td>
                                                    <td>
                                                        <%#Eval("ketqua") %>
                                                    </td>
                                                    <td>
                                                        <%#Eval("solanlambai") %>
                                                    </td>
                                                    <td>
                                                        <%#Eval("thoigianngannhat") %>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </body>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <div style="display: none">
        <input type="text" id="txtMonID" runat="server" />
    </div>
    <a href="#" id="btnChiTietMon" runat="server" onserverclick="btnChiTietMon_ServerClick">content</a>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
    <script>
        jQuery('#slide-subjects').owlCarousel({
            autoWidth: true,
            items: 4,
            loop: false,
            rewind: false,
            margin: 0,
            dots: false,
        });
        jQuery('#slide-contest').owlCarousel({
            autoWidth: true,
            items: 4,
            loop: false,
            rewind: false,
            margin: 0,
            dots: false,

        });
        jQuery('#slide-practice').owlCarousel({
            animateOut: "slideOutDown",
            animateIn: "flipInX",
            items: 3,
            loop: false,
            dots: false,
            margin: 0,
            nav: true,

        });
        jQuery('#slide-practiceCL').owlCarousel({
            animateOut: "slideOutDown",
            animateIn: "flipInX",
            items: 3,
            loop: false,
            dots: false,
            margin: 0,
            nav: true,
        });

        var index = parseInt(document.getElementById("<%= txtIndexTest.ClientID %>").value);
        console.log(index);

        jQuery("#slide-practice").trigger("to.owl.carousel", [index, 1]);
        jQuery("#slide-practiceCL").trigger("to.owl.carousel", [index, 1]);

        //func xem chi tiết môn học
        function xemMon(id) {
            document.getElementById('<%=txtMonID.ClientID%>').value = id;
            document.getElementById('<%=btnChiTietMon.ClientID%>').click();
        }
    </script>
</asp:Content>

