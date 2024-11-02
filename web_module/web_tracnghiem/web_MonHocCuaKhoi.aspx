<%@ Page Title="" Language="C#" MasterPageFile="~/MutipleChoiceMasterPage.master" AutoEventWireup="true" CodeFile="web_MonHocCuaKhoi.aspx.cs" Inherits="web_module_web_tracnghiem_web_MonHocCuaKhoi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headlink" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hihead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="himenu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="higlobal" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="hislider" Runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="hibelowtop" Runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="hibodyhead" Runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="hibodywrapper" Runat="Server">
    <div class="mainpage-main">
        <div class="container">
            <h2 class="title-heading">LUYỆN TẬP</h2>
            <div class="row content">
                <asp:Repeater runat="server" ID="rpMonHoc">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-4 col-sm-6 col-12 sl sl-show mb-4 type1">
                            <div class="single-brand">
                                <div class="single-brand-thumb">
                                    <img src="https://ielts.pasal.edu.vn/upload/images/education23.jpg" alt="" />
                                </div>
                                <div class="single-brand-text">
                                    <h5><%#Eval("mon_name") %></h5>
                                </div>
                                <div class="single-brand-footer">
                                    <a class="button-53" href="/danh-sach-bai-luyen-tap-<%#Eval("khoi_id") %>/<%#Eval("mon_id") %>">Làm Bài</a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content9" ContentPlaceHolderID="hibodybottom" Runat="Server">
</asp:Content>
<asp:Content ID="Content10" ContentPlaceHolderID="hibelowbottom" Runat="Server">
</asp:Content>
<asp:Content ID="Content11" ContentPlaceHolderID="hifooter" Runat="Server">
</asp:Content>
<asp:Content ID="Content12" ContentPlaceHolderID="hifootersite" Runat="Server">
</asp:Content>

