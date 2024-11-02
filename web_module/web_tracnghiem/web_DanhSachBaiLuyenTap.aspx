<%@ Page Title="" Language="C#" MasterPageFile="~/MutipleChoiceMasterPage.master" AutoEventWireup="true" CodeFile="web_DanhSachBaiLuyenTap.aspx.cs" Inherits="web_module_web_tracnghiem_web_DanhSachBaiLuyenTap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headlink" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hihead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="himenu" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="higlobal" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="hislider" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="hibelowtop" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="hibodyhead" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="hibodywrapper" runat="Server">
    <style>
        .panel {
            padding: 10px;
            margin-bottom: 18px;
            background-color: #fff;
            border: 1px solid transparent;
            border-radius: 5px;
            -webkit-box-shadow: 0 5px 10px rgba(0,0,0,0.4);
            box-shadow: 0 5px 10px rgba(0,0,0,0.4);
        }

        .panel-body ul {
            margin: 0;
            padding: 0;
        }

        .exam-info {
            color: #428bca;
            font-size: 16px;
        }

        .list-inline {
            padding-left: 0;
            list-style: none;
            margin-left: -5px;
        }

            .list-inline > li {
                display: inline-block;
                padding-left: 5px;
                padding-right: 5px;
            }

        a:hover, a:focus {
            text-decoration: none;
            color: #c19d5e;
        }
    </style>
    <div class="mainpage-main">
        <div class="container">
            <h4 class="event__title">DANH SÁCH BÀI LUYỆN TẬP</h4>
            <div class="content">
                <div class="test viewlist">
                    <asp:Repeater ID="rpTracNghiem" runat="server">
                        <ItemTemplate>
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h4>
                                        <a href="/bai-luyen-tap-chi-tiet-<%#Eval("khoi_id") %>/<%# cls_ToAscii.ToAscii(Eval("luyentap_name").ToString().ToLower()) %>-<%#Eval("test_id") %>" title="<%#Eval("luyentap_name") %>"><strong><%#Eval("luyentap_name") %></strong></a>
                                        <span class="icon_new"></span>
                                    </h4>
                                    <ul class="exam-info css-exam-info list-inline form-tooltip">
                                        <li class="pointer" data-toggle="tooltip" data-original-title="Số câu"><em class="fa fa-flag">&nbsp;</em><%#Eval("tongcauhoi") %><span class="hidden-xs"> câu hỏi</span></li>
                                    </ul>
                                    <ul class="list-inline help-block">
                                        <li><em class="fa fa-clock-o">&nbsp;</em><%#Eval("test_createdate","{0: HH:mm dd/MM/yyyy}") %></li>
                                        <li><em class="fa fa-search">&nbsp;</em>Đã xem: 3</li>
                                    </ul>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content9" ContentPlaceHolderID="hibodybottom" runat="Server">
</asp:Content>
<asp:Content ID="Content10" ContentPlaceHolderID="hibelowbottom" runat="Server">
</asp:Content>
<asp:Content ID="Content11" ContentPlaceHolderID="hifooter" runat="Server">
</asp:Content>
<asp:Content ID="Content12" ContentPlaceHolderID="hifootersite" runat="Server">
</asp:Content>

