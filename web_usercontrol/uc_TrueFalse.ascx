<%@ Control Language="C#" AutoEventWireup="true" CodeFile="uc_TrueFalse.ascx.cs" Inherits="web_usercontrol_uc_TrueFalse" %>
<%@ Register Src="~/web_usercontrol/global_Popup.ascx" TagPrefix="uc1" TagName="global_Popup" %>

<%--<asp:ScriptManager runat="server"></asp:ScriptManager>
<uc1:global_Popup runat="server" ID="global_Popup" />--%>
<div class="frame-game --math">
    <div class="container">
        <asp:UpdatePanel ID="udLoad" runat="server">
            <ContentTemplate>
                <div class="frame-style p-2">
                    <div class="form-mutichoise form-mutichoise--style-1">
                        <div class="form-mutichoise__header">
                            <div class="title-page pt-0 pb-0">
                                <asp:Repeater ID="rpTitleTrueFalse" runat="server">
                                    <ItemTemplate>
                                        <%#Eval("Title") %>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <div class="form-mutichoise__header--title">
                                <%--<%=questionTrueFalse%>--%>
                                <asp:Label ID="txtCauHoiTrueFasle" Text="" runat="server" />
                                <a class="btn-sound-question" href="javascript:void(0)" id="btnVolume_Quesstion" onclick="playSoundTrueFalse()">
                                    <i class="fa fa-volume-up"></i>
                                </a>
                            </div>
                            <div class="ratio">
                                <div class="ratio__number">
                                    <asp:Label ID="txtSoLuongCauTrueFalse" Text="" runat="server" />
                                    /
                                    <asp:Label ID="txtMaxQuestionTrueFalse" Text="" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="form-mutichoise__question">
                            <div class="question-item">
                                <div class="question-item__image">
                                    <asp:Repeater ID="rpSrcCauHoi" runat="server">
                                        <ItemTemplate>
                                            <img src="<%#Eval("truefalse_image") %>" />
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        <div class="form-mutichoise__answer --item-3 answer">
                            <asp:Repeater ID="rpCauHoiTrueFalse" runat="server">
                                <ItemTemplate>
                                    <div class="answer-item">
                                        <a href="javascript:void(0)" class="answer-item__gather hvr-push" data-answer="<%# Eval("Item1")%>" id="<%#Eval("Item3")%>" onclick="checkDapAnTrueFalse(this.id, this.getAttribute('data-answer'))">
                                            <img class="answer-item__gather--img" src="<%# Eval("Item2")%>" />
                                            <img class="btn btn-true" id="<%# Eval("Item3")%>Dung" src="/images/images_button/btn-2.png" style="display: none;" />
                                            <img class="btn btn-false" id="<%# Eval("Item3")%>Sai" src="/images/images_button/btn-6.png" style="display: none;" />
                                        </a>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
                <input type="text" name="name" id="txtid" runat="server" value="" style="display: none" />
                <div style="display: none">
                    <input type="text" name="name" id="txtDapAnTrueFalse" runat="server" value="" />
                    <audio id="audioAnswerTrueFalse" src="" controls="controls" />
                    <input type="text" id="txtaudioAnswerTrueFalse" runat="server" />
                    <audio id="audioDungTrueFalse" src="../mp3Game/audio_right.mp3" controls="controls"></audio>
                    <audio id="audioSaiTrueFalse" src="../mp3Game/audio_false.mp3" controls="controls"></audio>
                    <a href="javascript:void(0)" id="btnNextCauTrueFalse" runat="server" onserverclick="btnNextCauTrueFalse_ServerClick"></a>
                    <a href="javascript:void(0)" id="btnReloadTrueFalse" runat="server" onserverclick="btnReloadTrueFalse_ServerClick"></a>
                    <input type="text" id="txtTimeStartTrueFalse" runat="server" value="" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</div>
<script>
    playSoundTrueFalse();
    var countTrueFalse = 0;
    function checkDapAnTrueFalse(id, value) {
        $('#audioAnswerTrueFalse').get(0).pause();
        let count = document.getElementById('<%= txtSoLuongCauTrueFalse.ClientID%>').innerText;
        let countMax = document.getElementById('<%= txtMaxQuestionTrueFalse.ClientID%>').innerText;
        let dapAn = document.getElementById("<%=txtDapAnTrueFalse.ClientID%>").value;

        if (dapAn == value) {
            document.getElementById(id + "Dung").style.display = "block";
            countTrueFalse++;
            $('#audioDungTrueFalse').get(0).play();
        }
        else {
            document.getElementById(id + "Sai").style.display = "block";
            $('#audioSaiTrueFalse').get(0).play();
        }
        console.log(countTrueFalse);

        if (count < countMax) {
            setTimeout(function () {
                document.getElementById('<%= btnNextCauTrueFalse.ClientID%>').click();
            }, 2000);
        }
        else {
            setTimeout(function () {
                let sao;
                let ketqua;
                if ((countTrueFalse / countMax) >= 0.8) {
                    sao = '3';
                } else if ((countTrueFalse / countMax) >= 0.5) {
                    sao = '2';
                } else {
                    sao = '1';
                }
                //debugger
                showPopup(sao);
                console.log(countTrueFalse);
                ketqua = "" + countTrueFalse + "/" + countMax
                let timeStart = $("#<%=txtTimeStartTrueFalse.ClientID %>").val();
                <%--let orderGame = $("#<%=txtOrderGameTrueFalse.ClientID %>").val();--%>
                btnSubmit(sao, ketqua, timeStart, orderGame);
                countTrueFalse = 0;
            }, 2000);

            setTimeout(function () {
                autoClick.click();
            }, 2000);
        }
    }
    function playSoundTrueFalse() {
        $("#audioAnswerTrueFalse").attr("src", $('#<%= txtaudioAnswerTrueFalse.ClientID %>').val());
        $('#audioAnswerTrueFalse').get(0).play();
    }
</script>
