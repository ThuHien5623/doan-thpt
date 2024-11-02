<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLandingPage_THPT.master" AutoEventWireup="true" CodeFile="thpt_Price.aspx.cs" Inherits="landingpage_THPT_thpt_Price" %>

<%@ Register Src="~/web_usercontrol/global_LandingPage_Menu_THPT.ascx" TagPrefix="uc1" TagName="global_LandingPage_Menu_THPT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
     
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <uc1:global_LandingPage_Menu_THPT runat="server" ID="global_LandingPage_Menu_THPT" />
    <div class="price-page">
        <div class="container-fluid">
            <div class="title-page">Bảng giá</div>
            <div class="price-list">
                <asp:Repeater ID="rpBangGia" runat="server" OnItemDataBound="rpBangGia_ItemDataBound">
                    <ItemTemplate>
                        <div class="price-item">
                            <div class="price-item__title"><%#Eval("banggia_title") %></div>
                            <div class="price-item__feature">
                                <div class="feature-list mb-3">
                                    <%#Eval("banggia_content") %>
                                </div>
                            </div>
                            <%--<div class="price-item__sumary"><%#Eval("banggia_summary") %>.</div>--%>
                            <div class="price-item__title">Gói hiện tại</div>
                            <div class="price-item__packages">
                                <div class="packages-list">
                                    <asp:Repeater ID="rpBangGiaChiTiet" runat="server">
                                        <ItemTemplate>
                                            <div class="packages-item">
                                                <div class="package"><%#Eval("banggiachitiet_gia") %> </div>
                                                <div class="button"><a href="javascript:void(0)" id="btnDangKi" onclick="btnMuaNgay('<%#Eval("banggiachitiet_id")%>')" class="btn btn-register">Đăng kí</a></div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div style="display: none">
                <input type="text" style="display: block" id="txtBangGiaChiTiet" runat="server" />
                <a href="#" id="btnLienHe" runat="server" onserverclick="btnLienHe_ServerClick"></a>
            </div>
        </div>
    </div>
    <script>
        function btnMuaNgay(id) {
            document.getElementById("<%=txtBangGiaChiTiet.ClientID%>").value = id;
            document.getElementById("<%=btnLienHe.ClientID%>").click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

