<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_MasterPage.master" AutoEventWireup="true" CodeFile="module_SLLDT_LuyenTap_Star.aspx.cs" Inherits="admin_page_module_function_module_App_SLLDT_module_SLLDT_LuyenTap_Star" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headlink" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hihead" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="himenu" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="hibodyhead" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="hibodywrapper" runat="Server">
    <script>
        function Them(id) {
            document.getElementById("<%=txtLuyenTap_id.ClientID%>").value = id;
            console.log(id)
            document.getElementById("<%=btnThem.ClientID%>").click();
        }
    </script>
    <div class="card">
        <div class="container-fluid">
            <h3 style="text-align: center; font-size: 28px; font-weight: bold; color: blue">Luyện tập</h3>
            <div class="col-12 mx-auto my-3">
                Chọn giáo viên:
                <dx:ASPxComboBox ID="ddlGiaoVien" runat="server" TextField="username_fullname" ValueField="username_id" ValueType="System.Int32" ClientInstanceName="ddlGiaoVien" Width="80%" OnSelectedIndexChanged="ddlGiaoVien_SelectedIndexChanged" AutoPostBack="true"></dx:ASPxComboBox>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Tên bài học</th>
                        <th scope="col">Ngôi sao</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rpList_BaiLuyenTap" runat="server">
                        <ItemTemplate>
                            <tr>
                                <th scope="row"><%# Container.ItemIndex + 1 %></th>
                                <td><%#Eval("luyentap_name") %></td>
                                <td><a href="javascript:void(0)" id="btnThem" onclick="Them(<%#Eval("luyentap_id") %>)" class="btn-favorite"><i class="<%#Eval("luyentap_star_class") %> btn-favorite"></i></a></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
        <div style="display: none">
            <input id="txtLuyenTap_id" type="text" runat="server" />
            <a href="javascript:void(0)" id="btnThem" runat="server" onserverclick="btnThem_ServerClick"></a>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="hibodybottom" runat="Server">
</asp:Content>
<asp:Content ID="Content7" ContentPlaceHolderID="hifooter" runat="Server">
</asp:Content>
<asp:Content ID="Content8" ContentPlaceHolderID="hifootersite" runat="Server">
</asp:Content>

