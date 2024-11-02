<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_BaiKiemTra.aspx.cs" Inherits="web_module_module_THPT_thpt_BaiKiemTra" %>

<%@ Register Src="~/web_usercontrol/global_header_avatar_THPT.ascx" TagPrefix="uc1" TagName="global_header_avatar_THPT" %>



<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        .page-view.bg-color-1 {
            background: rgb(0,241,255);
            background: linear-gradient(90deg, rgba(0,241,255,1) 0%, rgba(4,112,204,1) 100%);
        }

        .menu-bottom .link-menu a.active {
            color: #0089c7 !important;
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
        <div class="block-content no-pd">
            <div class="block-content__header">
                <img class="--title" src="/images/thpt_icon-baikiemtra.png" alt="Alternate Text" />
                <a href="/app-danh-muc-khoi-thpt-<%=khoi_id %>" class="btn-exit">
                    <img src="/images/exit_blue.png" />
                </a>
            </div>
            <div class="practice-list max-height-1 p-3">
                <asp:Repeater ID="rpBaiKiemTra" runat="server">
                    <ItemTemplate>
                        <div class="practice-item">
                            <div class="practice-item__left">
                                <img src="../../images/thcs-avt-test.png">
                            </div>
                            <div class="practice-item__right">
                                <div class="--info">
                                    <div class="title">
                                        <b><%#Eval("luyentap_name") %></b>
                                    </div>
                                    <div class="other">
                                        <span class="icon date"><i class="fa fa-calendar"></i>&nbsp;11/03/2024</span>
                                        <a class="icon important" href="javascript:void(0)"><i class="fa fa-star"></i></a>
                                        <a href="/app-lich-su-bai-kiem-tra-thcs" class="icon history"><i class="fa fa-pencil"></i></a>
                                        <a href="/slldt-bai-kiem-tra-trac-nghiem-chi-tiet-<%#Eval("test_id") %>" class="play">
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
    <div class="modal fade" id="modalNhapMaDe" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header ">
                    <img class="bg-top" src="../../images/bg-top-alert-test.png" />
                    <img class="btn_close" data-dismiss="modal" aria-label="Close" src="../../images/btn-exit.png" />
                    <h5>NHẬP MÃ BÀI KIỂM TRA</h5>
                </div>
                <div class="modal-body ">
                    <input class="form-control" type="text" name="name" value="" />
                </div>
                <div class="modal-footer">
                    <a href="javascript:void(0)" class="btn btn-danger" runat="server" id="madethi">Xác nhận</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

