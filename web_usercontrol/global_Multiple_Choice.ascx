<%@ Control Language="C#" AutoEventWireup="true" CodeFile="global_Multiple_Choice.ascx.cs" Inherits="web_usercontrol_global_Multiple_Choice" %>
<%@ Register Src="~/web_usercontrol/global_Popup.ascx" TagPrefix="uc1" TagName="global_Popup" %>

<%--<asp:ScriptManager runat="server"></asp:ScriptManager>
<uc1:global_Popup runat="server" ID="global_Popup" />--%>
<div class="frame-game --math">
    <div class="container">
        <asp:UpdatePanel ID="udLoad" runat="server">
            <ContentTemplate>
                <div class="">
                    <div class="form-mutichoise form-mutichoise--style-1">

                        <div class="form-mutichoise__header">
                            <div class="title-page pt-0 pb-0">
                                <%--<asp:Repeater ID="rpnoidung" runat="server">
                                    <ItemTemplate>--%>
                                <%--<%#Eval("cauhoi_content") %>--%>
                                <h6>Hãy chọn đáp án đúng</h6>

                                <%--</ItemTemplate>
                                </asp:Repeater>--%>
                            </div>
                            <div class="form-mutichoise__header--title">
                                <%-- <asp:Repeater ID="rpTitle" runat="server">
                                    <ItemTemplate>--%>
                                <%-- <%#Eval("cauhoi_titlecauhoi") %>--%>
                                <h6>Câu 1: Trắc nghiệm</h6>
                                <%--</ItemTemplate>
                                </asp:Repeater> --%>
                                <a class="btn-sound-question" href="javascript:void(0)" id="btnVolume_Quesstion" onclick="audiobai1()">
                                    <i class="fa fa-volume-up"></i>
                                </a>
                            </div>
                            <%--<div class="ratio">
                                <div class="ratio__number">
                                    <%=SoCauDaLam %>/<%=Tong %>
                                </div>
                            </div>--%>
                        </div>
                        <div class="form-mutichoise__question">
                            <%-- <asp:Repeater ID="rpCauHoi" runat="server">
                                <ItemTemplate>--%>
                            <div class="question-item">
                                <%--<a class="question-item__image" href="javascript:void(0)" data-url="<%#Eval("cauhoi_mp3") %>">--%>
                                <a class="question-item__image" href="javascript:void(0)">
                                    <img src="/imagesGame/GameKeoTha/img.png" />
                                </a>
                                <%--<audio id="audioBai1" src="<%#Eval("cauhoi_mp3") %>" hidden="hidden" controls="controls"></audio>--%>
                            </div>
                            <%--</ItemTemplate>
                            </asp:Repeater>--%>
                        </div>
                        <div class="form-mutichoise__answer --item-3">
                            <%--<asp:Repeater ID="rpCauTraLoi" runat="server">
                                <ItemTemplate>--%>
                            <div class="answer-item">
                                <a href="javascript:void(0)" class="answer-item__gather hvr-push" onclick="myTraLoiMultiple('1','1','1')">
                                    <img src="/imagesGame/GameKeoTha/1.png" />
                                    <%--<img class="answer-item__gather--img" src="<%#Eval("cautraloi_image") %>" />--%>
                                    <%--<%#Eval("cautraloi_image") %>--%>
                                    <img class="btn btn-true" src="/images/images_button/btn-2.png" id="ic_Dung1" aria-hidden="true" style="display: none;" />
                                    <img class="btn btn-false" src="/images/images_button/btn-6.png" id="ic_Sai1" aria-hidden="true" style="display: none;" />
                                </a>
                                <%-- <a href="javascript:void(0)" class="answer-item__sound" id="mp3_1%>""
                                            onclick="audioDapAn(1)">
                                            <img src="../../../images/images_button/loa-xanhdt-m.png" />
                                        </a>--%>
                                <%--<audio hidden="hidden" id="audioDapAn_<%#Eval("cautraloi_id") %>" src="../../<%#Eval("cautraloi_mp3") %>" controls="controls" />--%>
                            </div>
                            <div class="answer-item">
                                <a href="javascript:void(0)" class="answer-item__gather hvr-push" onclick="myTraLoiMultiple('2','2','2')">
                                    <img src="/imagesGame/GameKeoTha/1.png" />

                                    <%--<img class="answer-item__gather--img" src="<%#Eval("cautraloi_image") %>" />--%>
                                    <%--<%#Eval("cautraloi_image") %>--%>
                                    <img class="btn btn-true" src="/images/images_button/btn-2.png" id="ic_Dung2" aria-hidden="true" style="display: none;" />
                                    <img class="btn btn-false" src="/images/images_button/btn-6.png" id="ic_Sai2" aria-hidden="true" style="display: none;" />
                                </a>
                                <%-- <a href="javascript:void(0)" class="answer-item__sound" id="mp3_1%>""
                                            onclick="audioDapAn(1)">
                                            <img src="../../../images/images_button/loa-xanhdt-m.png" />
                                        </a>--%>
                                <%--<audio hidden="hidden" id="audioDapAn_<%#Eval("cautraloi_id") %>" src="../../<%#Eval("cautraloi_mp3") %>" controls="controls" />--%>
                            </div>

                            <div class="answer-item">
                                <a href="javascript:void(0)" class="answer-item__gather hvr-push" onclick="myTraLoiMultiple('3','3','3')">
                                    <img src="/imagesGame/GameKeoTha/1.png" />

                                    <%--<img class="answer-item__gather--img" src="<%#Eval("cautraloi_image") %>" />--%>
                                    <%--<%#Eval("cautraloi_image") %>--%>
                                    <img class="btn btn-true" src="/images/images_button/btn-2.png" id="ic_Dung3" aria-hidden="true" style="display: none;" />
                                    <img class="btn btn-false" src="/images/images_button/btn-6.png" id="ic_Sai3" aria-hidden="true" style="display: none;" />
                                </a>
                                <%-- <a href="javascript:void(0)" class="answer-item__sound" id="mp3_1%>""
                                            onclick="audioDapAn(1)">
                                            <img src="../../../images/images_button/loa-xanhdt-m.png" />
                                        </a>--%>
                                <%--<audio hidden="hidden" id="audioDapAn_<%#Eval("cautraloi_id") %>" src="../../<%#Eval("cautraloi_mp3") %>" controls="controls" />--%>
                            </div>
                            <%--</ItemTemplate>
                            </asp:Repeater>--%>
                        </div>

                    </div>
                </div>

                <div style="display: none">
                    <input type="text" id="txtTimeStartMultipleChoice" runat="server" value="" />
                    <input type="text" id="txtOrderGameMultipleChoice" runat="server" value="" />
                    <input hidden="hidden" id="txtIDCauHoiDuocChon" placeholder="IDCauHoi" type="text" runat="server" />
                    <audio hidden="hidden" class="media" id="audioselect1" src="/Musics/audio_select.mp3" controls="controls"></audio>
                    <audio hidden="hidden" class="media" id="audioright1" src="/Musics/audio_right.mp3" controls="controls"></audio>
                    điểm<input id="txtDiemSo" type="text" style="" placeholder="diem so" runat="server" />
                    <input id="txtSoSaoDatDuoc" type="text" runat="server" />
                    tổng:<input type="text" id="txtTongSoCau" runat="server" />
                    đã làm:<input type="text" id="txtSoCau" runat="server" />
                    <input type="text" id="txtDem" runat="server" />
                    số đáp án a
                            <input type="text" id="txtDapAnA" runat="server" value="0" />
                    số đáp án b
                            <input type="text" id="txtDapAnB" runat="server" value="0" />
                    số đáp án c
                            <input type="text" id="txtDapAnC" runat="server" value="0" />
                    đáp án trước
                            <input type="text" id="txtDapAnTruoc" runat="server" value="0" />
                    <a href="javascript:void(0)" id="btnNextCauHoiMultiple" runat="server" onserverclick="btnNextCauHoiMultiple_ServerClick"></a>
                    <a href="javascript:void(0)" id="btnReLoadglobalMultipleChoice" runat="server" onserverclick="btnReLoadglobalMultipleChoice_ServerClick"></a>
                </div>
                <div class="">
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</div>
<script>
    const playSound1 = (url) => {
        audioBai1.pause();
        let audio = document.getElementById("mp3_" + url);
        audio.play();
    }
    var audioTraLoi;
    var deem = 0;

    var socauchoice = 0;
    //Hàm delay chuyển trang
    function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
    //Hàm âm thanh trả lời
    async function myTraLoiMultiple(id, vitri, dapan) {
        audioBai1.pause();
        var ic_Sai = document.getElementById("ic_Sai" + id);
        var ic_Dung = document.getElementById("ic_Dung" + id);
        if (dapan == "False") {
            ic_Sai.style.display = "block";
            audioselect1.play();
            $('a.answer-item').css({ pointerEvents: "none" })
        } else {
            //xác định đáp án chọn 
            if (vitri == 1) {
                document.getElementById("<%=txtDapAnA.ClientID%>").value = Number(document.getElementById("<%=txtDapAnA.ClientID%>").value) + 1;
            }
            if (vitri == 2) {
                document.getElementById("<%=txtDapAnB.ClientID%>").value = Number(document.getElementById("<%=txtDapAnB.ClientID%>").value) + 1;
            }
            if (vitri == 3) {
                document.getElementById("<%=txtDapAnC.ClientID%>").value = Number(document.getElementById("<%=txtDapAnC.ClientID%>").value) + 1;
            }
            $('a.answer-item').css({ pointerEvents: "none" })
            ic_Dung.removeAttribute("style");
            deem = document.getElementById("<%=txtDiemSo.ClientID%>").value;
            deem++;
            document.getElementById("<%=txtDiemSo.ClientID%>").value = deem;
            audioright1.play();
            await sleep(1000);
        }

        socauchoice++;
        document.getElementById("<%=txtSoCau.ClientID%>").value = socauchoice;
        if (document.getElementById("<%=txtSoCau.ClientID%>").value == document.getElementById("<%=txtTongSoCau.ClientID%>").value) {
            await sleep(1000);
            var count = document.getElementById("<%=txtDiemSo.ClientID%>").value;
            let tong = document.getElementById("<%=txtTongSoCau.ClientID%>").value;
            let sao;
            let ketqua;
            if (count == "") {
                count = 0;
            }
            console.log("sai hết" + count);
            if ((count / tong) * 100 > 80) {
                sao = '3'
            }
            else if ((count / tong) * 100 > 50) {
                sao = '2'
            }
            else {
                sao = '1'
            }
            ketqua = "" + count + "/" + tong
            let timeStart = $("#<%=txtTimeStartMultipleChoice.ClientID %>").val();
            let orderGame = $("#<%=txtOrderGameMultipleChoice.ClientID %>").val();
            console.log("số sao" + sao);
            console.log("kết quả" + ketqua);
            console.log("thời gian" + timeStart);
            console.log("vị trí game" + orderGame);
            btnSubmit(sao, ketqua, timeStart, orderGame);
            socauchoice = 0;
            document.getElementById("<%=btnReLoadglobalMultipleChoice.ClientID %>").click();
        }
        else {
            await sleep(1000);
            document.getElementById("<%=btnNextCauHoiMultiple.ClientID %>").click();
        }
    }

    function audiobai1() {
        let audioBai1 = document.getElementById("audioBai1");
        audioBai1.load();
        audioBai1.play();
    }
    function audioDapAn(DapAn_id) {
        audioDapan = document.getElementById("audioDapAn_" + DapAn_id);
        audioDapan.pause();
        audioBai1.pause();
        audioDapan.play();
    }

</script>
