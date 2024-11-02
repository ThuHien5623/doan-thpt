<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_History.aspx.cs" Inherits="web_module_module_THPT_thpt_History" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .menu-bottom .link-menu a.active {
            color: #0089c7 !important;
        }

        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .tabs-user .class-item__name {
            color: #0089c7;
        }

        .subject-item__name {
            color: #0089c7;
        }

        .tabs-user .nav .nav-item .nav-link.active {
            color: #0089c7;
            border-bottom-color: #0089c7;
        }

        .tb-style .table thead {
            color: #0089c7;
        }

        table {
            border-collapse: inherit;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <asp:ScriptManager runat="server" />
    <div class="page-view bg-color-1 m-bottom">
        <uc1:global_header_avatar_THPT runat="server" ID="global_header_avatar_THPT" />
        <div class="block-content">
            <div class="block-content__header">
                <img class="--title" src="/images/thpt_icon-lichsu.png" alt="Alternate Text" />
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
                                    <a id="btnLop10" href="javascript:void(0)" runat="server" class="class-item" onserverclick="btnLop10_ServerClick">
                                        <div class="class-item__name">Lớp 10</div>
                                    </a>
                                </div>
                                <div class="col">
                                    <a id="btnLop11" href="javascript:void(0)" runat="server" class="class-item" onserverclick="btnLop11_ServerClick">
                                        <div class="class-item__name">Lớp 11</div>
                                    </a>
                                </div>
                                <div class="col">
                                    <a id="btnLop12" href="javascript:void(0)" runat="server" class="class-item" onserverclick="btnLop12_ServerClick">
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
                                        <a href="javascript:void(0)" class="subject-item" <%#Eval("mon_active") %> onclick="xemMon(<%#Eval("mon_id") %>)">
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
                                nav: false,
                            })
                        });
                    </script>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>


                            <ul class="nav nav-pills" id="pills-tab" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="pills-home-tab" data-toggle="pill" data-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">Bài luyện tập</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="pills-profile-tab" data-toggle="pill" data-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">Bài kiểm tra</button>
                                </li>
                            </ul>
                            <div class="tab-content" id="pills-tabContent">
                                <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                                    <div id="" class="mb-3">
                                        <div class="tb-style pb-5">
                                            <div class="tb-style__select">
                                                <label>Bài luyện tập:</label>
                                                <asp:DropDownList runat="server" ID="ddlBaiLuyenTap" OnSelectedIndexChanged="ddlBaiLuyenTap_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </div>
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th class="lobster-regular">STT</th>
                                                        <th class="lobster-regular">Điểm số</th>
                                                        <th class="lobster-regular">Ngày làm bài</th>
                                                        <th class="lobster-regular">Thời gian làm bài</th>
                                                        <%--<th class="lobster-regular">Chi tiết</th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater runat="server" ID="rpThanhTichBaiLuyenTap">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td><%#Container.ItemIndex+1 %></td>
                                                                <td><%#Eval("resulttest_result") %></td>
                                                                <td><%#Eval("resulttest_datetime","{0: dd/MM/yyyy}") %></td>
                                                                <td><%#Eval("result_thoigianlambai") %></td>
                                                                <%-- <td>
                                                            <a href="#" class="btn-detail">Xem</a>
                                                        </td>--%>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                                    <div id="" class="mb-3">
                                        <div class="tb-style pb-5">
                                            <div class="tb-style__select">
                                                <label>Bài kiểm tra:</label>
                                                <asp:DropDownList runat="server" ID="ddlBaiKiemTra" OnSelectedIndexChanged="ddlBaiKiemTra_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </div>
                                            <table class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>
                                                        <th class="lobster-regular">STT</th>
                                                        <th class="lobster-regular">Điểm số</th>
                                                        <th class="lobster-regular">Ngày làm bài</th>
                                                        <th class="lobster-regular">Thời gian làm bài</th>
                                                        <%--<th class="lobster-regular">Chi tiết</th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <asp:Repeater runat="server" ID="rpThanhTichBaiKiemTra">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td><%#Container.ItemIndex+1 %></td>
                                                                <td><%#Eval("resulttest_result") %></td>
                                                                <td><%#Eval("resulttest_datetime","{0: dd/MM/yyyy}") %></td>
                                                                <td><%#Eval("result_thoigianlambai") %></td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="display: none">
                                
                                <input type="text" id="txtMonID" runat="server" />
                                <a href="#" id="btnChiTietMon" runat="server" onserverclick="btnChiTietMon_ServerClick">mon</a>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
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

