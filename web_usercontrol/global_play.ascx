<%@ Control Language="C#" AutoEventWireup="true" CodeFile="global_play.ascx.cs" Inherits="web_usercontrol_global_play" %>
<style>
    #popup-submit {
        display: none;
        position: fixed; /* Thay đổi từ absolute thành fixed */
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%); /* Dịch chuyển popup đến giữa màn hình */
        width: 25%;
        height: 40%;
        z-index: 24;
        background: rgba(0, 0, 0, 0.2588235294);
        padding: 20px; /* Thêm padding cho nội dung trong popup */
        border: 1px solid #ccc;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 20px;
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

                    #popup-submit .popup .popup-main .bg-popup .bg-popup-main .popup-nen {
                        position: relative;
                    }

                    #popup-submit .popup .popup-main .bg-popup .bg-popup-main #popup-img {
                        width: 70%;
                        position: absolute;
                        top: 7%;
                        left: 16%;
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

    .title {
        font-size: 19px;
        position: absolute;
        top: 49%;
        left: 19%;
        font-family: 'Lexend';
        color: #76bd44;
    }

    .power {
        font-family: 'Lexend';
        font-size: 19px;
        position: absolute;
        top: 59%;
        left: 46%;
        color: #76bd44;
    }

    .popup-content {
        text-align: center;
    }

    .close-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 20px;
        cursor: pointer;
        color: #555; /* Màu chữ */
    }

    button {
        padding: 12px 24px;
        font-size: 18px;
        cursor: pointer;
        background-color: #4caf50; /* Màu nút */
        color: #fff; /* Màu chữ nút */
        border: none;
        border-radius: 5px;
    }

        button:hover {
            background-color: #45a049; /* Màu nút khi di chuột qua */
        }

    .play-label {
        position: absolute;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 24px;
        color: #333; /* Màu chữ Play */
        font-weight: bold; /* Đậm chữ Play */
    }
</style>

<div id="popup-submit" style="display: none">
    <div class="popup">
        <div class="popup-main">
            <div class="popup-content">
                <span class="close-btn" onclick="closePopup()">&times;</span>
                <h2 style="text-align: center">Level 11</h2>
                <%--<img src="../images/0sao.png" alt="" />--%>
                <img src="" id="imgSao" />
                <p>Click "Play" to start the game.</p>
                <a id="playLink" href="javascript:void(0);" onclick="startGame()">Play</a>
            </div>
        </div>
        <input type="hidden" id="txtLinkBT" runat="server" />
        
    </div>
</div>

<script>
    function displayGame(linkBT, sao) {
        if (sao == 0) {
            $('#imgSao').attr('src', '../images/0sao.png');
        } else if (sao == 1) {
            $('#imgSao').attr('src', '../images/1sao.png');
        } else if (sao == 2) {
            $('#imgSao').attr('src', '../images/2sao.png');
        } else {
            $('#imgSao').attr('src', '../images/3sao.png');
        }
        document.getElementById('<%=txtLinkBT.ClientID%>').value = linkBT;
        document.getElementById('popup-submit').style.display = "block";
    }

    function display(linkBT, sao) {
        if (sao == 0) {
            $('#imgSao').attr('src', '../images/0sao.png');
        } else if (sao == 1) {
            $('#imgSao').attr('src', '../images/1sao.png');
        } else if (sao == 2) {
            $('#imgSao').attr('src', '../images/2sao.png');
        } else {
            $('#imgSao').attr('src', '../images/3sao.png');
        }
        document.getElementById('<%=txtLinkBT.ClientID%>').value = linkBT;
        document.getElementById('popup-submit').style.display = "block";
    }
    function closePopup() {
        var popup = document.getElementById("popup-submit");
        popup.style.display = "none";
    }
    function startGame() {
        var playLink = document.getElementById("playLink");
        var text = document.getElementById('<%=txtLinkBT.ClientID%>').value
        playLink.setAttribute("href", text);
    }
</script>
