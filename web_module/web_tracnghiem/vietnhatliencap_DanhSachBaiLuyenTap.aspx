<%@ Page Title="" Language="C#" MasterPageFile="~/SoLienLacMasterPage.master" AutoEventWireup="true" CodeFile="vietnhatliencap_DanhSachBaiLuyenTap.aspx.cs" Inherits="web_module_web_tracnghiem_vietnhatliencap_DanhSachBaiLuyenTap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="../../css/css_tracnghiem/tracnghiem.css" rel="stylesheet" />
    <link href="../../admin_css/css_index/Loading.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <script>
        function DisplayLoadingIcon() {
            $("#img-loading-icon").show();
        }
    </script>
    <div class="loading" id="img-loading-icon" style="display: none">
        <div class="loading">Loading&#8230;</div>
    </div>
    <div class="page-view m-bottom">
        <div class="sticky-view">
            <div class=" header-top">
                <div class="container-fluid">
                    <a href="/slldt-home" class="btn-back">
                        <i class="ti-angle-left"></i>
                    </a>
                    <h5 class="text-center">LUYỆN TẬP</h5>
                </div>
            </div>
        </div>
        <div class="mainpage-main">
            <div class="container">
                <h4 class="event__title">DANH SÁCH BÀI LUYỆN TẬP</h4>
                <div class="content">
                    <div class="test viewlist">
                        <asp:Repeater ID="rpTracNghiem" runat="server">
                            <ItemTemplate>
                                <a href="#">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <h4>
                                                <a class="name-exercise" onclick="DisplayLoadingIcon()" href="/<%#Eval("test_link") %>" title="<%#Eval("luyentap_name") %>"><strong><%#Eval("luyentap_name") %></strong></a>
                                                <span class="icon_new"></span>
                                            </h4>
                                            <ul class="exam-info css-exam-info list-inline form-tooltip">
                                                <li class="pointer" data-toggle="tooltip" data-original-title="Số câu"><em class="fa fa-flag">&nbsp;</em><%#Eval("tongcauhoi") %><span class="hidden-xs"> câu hỏi</span></li>
                                            </ul>
                                            <ul class="list-inline help-block">
                                                <li>Thời gian làm bài: <%#Eval("thoigianlambai") %></li>
                                                <li>Tình trạng: <%#Eval("tinhtrang") %></li>
                                            </ul>
                                        </div>
                                    </div>
                                </a>
                            </ItemTemplate>
                        </asp:Repeater>
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

