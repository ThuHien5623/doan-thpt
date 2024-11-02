<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_CacBaiChuaLam.aspx.cs" Inherits="web_module_module_THPT_thpt_CacBaiChuaLam" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .header-avatar-view {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }
        .menu-bottom .link-menu a.active{
            color:#0089c7;
        }
        .page-view.bg-color-1{
            background-color: white;
        }
        
    </style>
    <script>
        function myHeart(id) {
            document.getElementById("<%=txtLuyenTap_id.ClientID%>").value = id;
            document.getElementById("<%=btnMyHeart.ClientID%>").click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <div class="page-view bg-color-1 m-bottom">
        <uc1:global_header_avatar_THPT runat="server" ID="global_header_avatar_THPT" />
        <div class="block-content no-pd">
            <div class="block-content__header">
                <img class="--title" src="/images/bg_luyentap.png" alt="Alternate Text" />
                <a href="/app-danh-muc-khoi-thpt-<%=khoi-id %>" runat="server" id="backSeverClick" class="btn-exit">
                    <img src="/images/exit_blue.png" />
                </a>
            </div>
            <div class="practice-list max-height-1 p-3">
                <%--<asp:ScriptManager ID="scrList" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="upList" runat="server">
                    <ContentTemplate>--%>
               <%-- <div>
                    <asp:DropDownList runat="server" ID="ddlChonKhoi" CssClass="form-control">
                        <asp:ListItem Text="Chọn khối" Value="chon" />
                        <asp:ListItem Text="Khối 10" Value="10" />
                        <asp:ListItem Text="Khối 11" Value="11" />
                        <asp:ListItem Text="Khối 12" Value="12" />
                    </asp:DropDownList>
                </div>--%>

                <%--<div>
                    <label>Chọn môn:</label>
                    <asp:DropDownList ID="ddlChonMon" runat="server" OnSelectedIndexChanged="ddlChonMon_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                </div>--%>

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
                                        <a href="/app-lich-su-bai-luyen-tap-thpt-<%#Eval("khoi_id") %>-<%#Eval("mon_id") %>-<%#Eval("luyentap_id") %>" class="icon history"><i class="fa fa-pencil"></i>&nbsp;<%#Eval("count_view") %></a>
                                        <a class="icon important" href="javascript:void(0)"><i class="<%#Eval("luyentap_star_class") %>"></i></a>
                                        <a href="javascript:void(0)" id="btnHeart<%#Eval("luyentap_id") %>" onclick="myHeart(<%#Eval("luyentap_id") %>)" class="icon favorite"><i class="<%#Eval("luyentap_heart_class") %>"></i></a>
                                        <a href="/<%#Eval("test_link") %>" class="play">
                                            <img src="/images/btn-lambai.png" alt="Alternate Text">
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <%-- </ContentTemplate>
                </asp:UpdatePanel>--%>
            </div>
            <div style="display: none;">
                <input id="txtLuyenTap_id" type="text" runat="server" />
                <a href="javascript:void(0)" id="btnMyHeart" runat="server" onserverclick="btnMyHeart_ServerClick"></a>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

