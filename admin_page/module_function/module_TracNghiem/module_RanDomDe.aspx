<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_RanDomDe.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_RanDomDe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <script
        src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js">
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
    <div class="card card-body">
        <div class="row">
            <a href="javascript:void(0)" id="btnTaoDe" class="btn btn-primary ml-4" runat="server" onserverclick="btnTaoDe_ServerClick">Tạo đề</a>
        </div>
        <br />
        <div class="row">
            <asp:Repeater runat="server" ID="rpCauHoi">
                <ItemTemplate>
                    <div class="col-2">
                        <%#Eval("question_content") %>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

