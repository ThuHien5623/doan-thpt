<%@ Control Language="C#" AutoEventWireup="true" CodeFile="global_Popup.ascx.cs" Inherits="web_usercontrol_global_Popup" %>
<style>
    #popup-submit {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 24;
        background: rgba(0, 0, 0, 0.2588235294);
    }

        #popup-submit .popup .popup-main {
            position: relative;
            display: flex;
            height: 100vh;
        }

            #popup-submit .popup .popup-main .bg-popup {
                position: absolute;
                width: 100%;
                height: 100vh;
                display: flex;
                z-index: 2;
            }

                #popup-submit .popup .popup-main .bg-popup .bg-popup-main {
                    max-width: 300px;
                    position: relative;
                    margin: auto;
                }

                #popup-submit .popup .popup-main .bg-popup .btn-close {
                    background: transparent;
                    border: 0px;
                    width: 50px;
                    position: absolute;
                    top: 45px;
                    right: 0;
                    z-index: 2;
                }

                #popup-submit .popup .popup-main .bg-popup .bg-popup-main .popup-nen {
                    position: relative;
                }

                #popup-submit .popup .popup-main .bg-popup .bg-popup-main #popup-img {
                    width: 60%;
                    position: absolute;
                    top: 5px;
                    left: 20%;
                }

                #popup-submit .popup .popup-main .bg-popup .bg-popup-main #popup-img-1 {
                    bottom: 0;
                    width: 30%;
                    position: absolute;
                    right: -15%;
                }

                #popup-submit .popup .popup-main .bg-popup .bg-popup-main .cancel {
                    position: absolute;
                    top: 11%;
                    right: 1%;
                    width: 35px;
                    height: 35px;
                    background: none;
                    border: 0;
                    cursor: pointer;
                }

                #popup-submit .popup .popup-main .bg-popup .bg-popup-main .home {
                    position: absolute;
                    width: 45px;
                    height: 40px;
                    right: 24%;
                    bottom: 10%;
                    background: none;
                    border: 0;
                    cursor: pointer;
                }

                #popup-submit .popup .popup-main .bg-popup .bg-popup-main .next {
                    position: absolute;
                    width: 45px;
                    height: 45px;
                    left: 43%;
                    bottom: 10%;
                    background: none;
                    border: 0;
                    cursor: pointer;
                }

                #popup-submit .popup .popup-main .bg-popup .bg-popup-main .load {
                    position: absolute;
                    width: 45px;
                    height: 45px;
                    left: 24%;
                    bottom: 10%;
                    background: none;
                    border: none;
                    cursor: pointer;
                }

                #popup-submit .popup .popup-main .bg-popup .bg-popup-main .play {
                    position: absolute;
                    top: 55%;
                    left: 50%;
                    width: 70px;
                    margin-left: -35px;
                }

            #popup-submit .popup .popup-main img.halo {
                position: relative;
                z-index: -1;
                height: 90vh;
                margin: auto;
            }

            #popup-submit .popup .popup-main img.phao {
                position: absolute;
                left: 32.5%;
                z-index: -1;
                width: 35%;
            }

            #popup-submit .popup .popup-main img.phao-1 {
                position: absolute;
                bottom: 15%;
                left: 10.5%;
                width: 30%;
                z-index: -1;
            }

            #popup-submit .popup .popup-main img.phao-2 {
                position: absolute;
                bottom: 15%;
                right: 10.5%;
                width: 30%;
                z-index: -1;
            }

    img {
        max-width: 100%;
    }

    #popup-submit .popup .popup-main .text-1 {
        text-align: center;
        font-size: 1.25rem;
        color: #76bd44;
        position: absolute;
        width: 100%;
        top: 35%;
    }

    #popup-submit .popup .popup-main .text-2 {
        text-align: center;
        font-size: 1rem;
        color: black;
        font-weight: 700;
        position: absolute;
        width: 100%;
        top: 45%;
    }
</style>
<audio hidden="hidden" class="media" id="uadiowin" src="/mp3Game/win1.mp3" controls="controls"></audio>
<audio hidden="hidden" class="media" id="uadiolose" src="/mp3Game/lose.mp3" controls="controls"></audio>
<div id="popup-submit" style="display: none">
    <div class="popup">
        <div class="popup-main">
            <img class="halo" src="/images/hh'.png">
            <img class="phao" src="/images/twinkle.gif">
            <img class="phao-1" src="/images/phao_hoa.gif">
            <img class="phao-2" src="/images/giphy.gif">
            <div class="bg-popup">
                <div class="bg-popup-main">
                    <button type="button" class="btn-close" onclick="closePopup()">
                        <img src="/images/btn-exit.png" alt="Alternate Text" /></button>
                    <img class="popup-nen" src="/images/popup-complate-3.png">
                    <div class="text-1">
                        Hoàn thành
                    </div>
                    <div class="text-2" id="nameBaiTapModal" runat="server"></div>
                    <img src="" id="popup-img" />
                    <a id="playGame" class="play button_popup" href="javascript:void(0);" onclick="startGame()">
                        <img src="/images/btn-play-1.png" /></a>
                </div>
            </div>
            <input type="text" id="txtLink" runat="server" name="name" value="" style="display: none" />
            <input type="hidden" id="txtbaitapid" runat="server" />
        </div>

    </div>
</div>
<asp:UpdatePanel ID="upPopup" runat="server">
    <ContentTemplate>
        <div style="display: none">
            <%--<a id="btnSatrt" runat="server" onserverclick="btnSatrt_ServerClick"></a>--%>
            <input type="text" id="txtSao" runat="server" name="name" value="" />
            <%--<input type="text" id="txtTimeStartPopup" runat="server" name="name" value="" />--%>
            <a id="loadServerPopup" runat="server" onserverclick="loadServerPopup_ServerClick"></a>
            <a id="returnTrangChu" runat="server" onserverclick="returnTrangChu_ServerClick"></a>
            <%--<input type="text" id="txtOrderGamePopup" runat="server" name="name" value="" />--%>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>
<script>
    function showPopup(sao) {
        //debugger
        document.getElementById("popup-submit").style.display = "block";
        document.getElementById('popup-img').src = "/images/popup_" + sao + "_sao.png";
        document.getElementById('<%=txtSao.ClientID%>').value = sao;
        document.getElementById('<%=loadServerPopup.ClientID%>').click();
    }

    function closePopup() {
        document.getElementById("<%=returnTrangChu.ClientID%>").click();
    }
    function startGame() {
        window.location.href = "/app-tieu-hoc-trang-chu";
    }

    // Sử dụng hàm để tạo cookie với tên là "myCookie" và giá trị là "Hello, this is my cookie value."
    //function deleteCookie(cookieName) {
    //    document.cookie = cookieName + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
    //}

</script>
