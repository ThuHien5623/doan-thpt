<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_Favorite.aspx.cs" Inherits="web_module_module_THPT_thpt_Favorite" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">

    <style>
        .subject-item__name {
            font-size: 1.0rem;
            font-weight: 600;
            color: #0089c7;
            height: 32px;
            line-height: 1;
        }

        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .tabs-user .class-item__name {
            font-size: 1.5rem;
            line-height: 2;
            font-weight: 700;
            color: #0089c7;
        }

        .subject-item__name {
            color: #0089c7 !important;
        }

        .tabs-user .nav .nav-item .nav-link.active {
            color: #0089c7;
            border-bottom-color: #0089c7;
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
        <uc1:global_header_avatar_THPT runat="server" ID="global_header_avatar_THPT" />
        <div class="block-content">
            <div class="block-content__header">
                <img class="--title" src="/images/bg_favorite.png" alt="Alternate Text" />
                <a class="btn-exit" href="/app-quan-li-tai-khoan-thpt">
                    <img src="/images/exit_blue.png">
                </a>
            </div>
            <div class="">
                <div class="tabs-user">
                    <div class="select-class">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col">
                                    <a id="btnLop10" runat="server" href="javascript:void(0)" onserverclick="btnLop10_ServerClick" class="class-item">
                                        <div class="class-item__name">Lớp 10</div>
                                    </a>
                                </div>
                                <div class="col">
                                    <a id="btnLop11" runat="server" href="javascript:void(0)" onserverclick="btnLop11_ServerClick" class="class-item">
                                        <div class="class-item__name">Lớp 11</div>
                                    </a>
                                </div>
                                <div class="col">
                                    <a id="btnLop12" runat="server" href="javascript:void(0)" onserverclick="btnLop12_ServerClick" class="class-item">
                                        <div class="class-item__name">Lớp 12</div>
                                    </a>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="subject-slide">
                        <div id="slide-subjects" class="owl-carousel owl-theme">
                            <asp:Repeater ID="rpMon" runat="server">
                                <ItemTemplate>
                                    <div class="item">
                                        <a href="javascript:void(0)" class="subject-item" <%#Eval("mon_active") %> onclick="xemMon( <%#Eval("mon_id") %>)">
                                            <div class="subject-item__img">
                                                <img src=" <%#Eval("mon_image") %> " />
                                            </div>
                                            <div class="subject-item__name">
                                                <%#Eval("mon_name") %>
                                            </div>
                                        </a>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                    <script>
                        $(document).ready(function () {
                            $('#slide-subjects').owlCarousel({
                                autoWidth: true,
                                items: 4,
                                loop: false,
                                rewind: false,
                                margin: 0,
                                dots: false,
                            })
                        });
                    </script>
                    <%-- <asp:ScriptManager ID="scrYeuThich" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel ID="upYeuThich" runat="server">
                        <ContentTemplate>--%>
                    <ul class="nav nav-pills" id="pills-tab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="pills-home-tab" data-toggle="pill" data-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">Video</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-profile-tab" data-toggle="pill" data-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">Bài luyện tập</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-contact-tab" data-toggle="pill" data-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">Bài kiểm tra</button>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                            <div class="video-detail">
                                <div class="video-detail__title"><%=tenbai %></div>
                                <div class="video-detail__view">
                                    <div class="embed-responsive embed-responsive-16by9">
                                        <iframe class="embed-responsive-item" src="<%=link_baitap %>" allowfullscreen></iframe>
                                    </div>
                                </div>
                            </div>
                            <div class="video-thuimbs-list">

                                <asp:Repeater ID="rpListVideo" runat="server">
                                    <ItemTemplate>
                                        <%--active--%>
                                        <a href="#" class="video-thuimb-item ">
                                            <div class="video-thuimb-item__img">
                                                <img src="/images/img-thuimb-video-thcs.png" />
                                            </div>
                                            <div class="video-thuimb-item__right">
                                                <div class="info-video">
                                                    <div class="info-video__title">
                                                        <%#Eval("videoluyentap_tenbai") %>
                                                    </div>
                                                    <div class="info-video__other">

                                                        <div class="icon important">
                                                            <i class="fa fa-star"></i>&nbsp;Quan trọng
                                                        </div>
                                                        <div class="icon favorite"><i class="fa fa-heart"></i>&nbsp;Yêu thích</div>
                                                        <div class="icon views"><i class="fa fa-eye"></i>&nbsp;15</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                            <div class="practice-list">
                                <asp:Repeater ID="rpList_BaiLuyenTap" runat="server">
                                    <ItemTemplate>
                                        <div class="practice-item">
                                            <div class="practice-item__left">
                                                <img src="../../images/thcs-avt-test.png">
                                            </div>
                                            <div class="practice-item__right">
                                                <div class="--info">
                                                    <div class="title">
                                                        <%#Eval("luyentap_name") %>
                                                    </div>
                                                    <div class="other">
                                                        <a href="javascript:void(0)" class="icon history"><i class="fa fa-pencil">&nbsp;<%#Eval("count_view") %></i></a>
                                                        <a class="icon important" href="javascript:void(0)"><i class="fa fa-star"></i></a>
                                                        <a href="javascript:void(0)" id="" class="icon favorite"><i class="fa fa-heart"></i></a>
                                                        <a href="<%#Eval("test_link") %>" class="play">
                                                            <img src="/images/thpt_icon-lambai-luyentap.png" alt="Alternate Text">
                                                        </a>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
                            <div class="practice-list">
                                <asp:Repeater runat="server" ID="rpBaiKiemTraYeuThich">
                                    <ItemTemplate>
                                        <div class="practice-item">
                                            <div class="practice-item__left">
                                                <img src="../../images/thcs-avt-test.png">
                                            </div>
                                            <div class="practice-item__right">
                                                <div class="--info">
                                                    <div class="title">
                                                        <%#Eval("luyentap_name") %>
                                                    </div>
                                                    <div class="other">
                                                        <a href="javascript:void(0)" class="icon history"><i class="fa fa-pencil">&nbsp;<%#Eval("count_view") %></i></a>
                                                        <a class="icon important" href="javascript:void(0)"><i class="fa fa-star"></i></a>
                                                        <a href="javascript:void(0)" id="" class="icon favorite"><i class="fa fa-heart-o"></i></a>
                                                        <a href="<%#Eval("test_link") %>" class="play">
                                                            <img src="/images/thpt_icon-lambai-luyentap.png" alt="Alternate Text">
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                    <%-- </ContentTemplate>
                    </asp:UpdatePanel>--%>
                </div>
            </div>
        </div>
    </div>
    <div style="display: none">
        <input type="text" id="txtMonID" runat="server" />
        <a href="#" id="btnChiTietMon" runat="server" onserverclick="btnChiTietMon_ServerClick">content</a>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
    <script>
        function xemMon(id) {
            document.getElementById('<%=txtMonID.ClientID%>').value = id;
            document.getElementById('<%=btnChiTietMon.ClientID%>').click();
        }
    </script>
</asp:Content>

