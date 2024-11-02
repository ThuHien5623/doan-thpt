<%@ Control Language="C#" AutoEventWireup="true" CodeFile="golbal_Flip_Image.ascx.cs" Inherits="web_usercontrol_golbal_Flip_Image" %>
<style>
    .flip {
        pointer-events: none !important;
    }
    #frame-flip_picture {
  position: relative;
}
#frame-flip_picture .frame-game-main {
  /*margin-left: 27%;*/
  background-repeat: no-repeat;
  background-size: 100% 100%;
  padding: 5% 2%;
  width: 40%;
  max-height: 90vh;
  margin: 0 auto;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
  background-image: url(/imagesGame/GameLatHinh/frame-flip_picture.png);
  /*margin-top: -45%;*/
}
.--bg-image-1 {
  background-image: url("/imagesGame/GameLatHinh/bg-image-1.jpg");
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
.header-page {
  position: -webkit-sticky;
  position: sticky;
  top: 0;
  left: 0;
  width: 100%;
  padding: 5px 0;
  color: #FFF;
  background-image: -o-linear-gradient(315deg, #c4eeae 10%, #9ee994 100%);
  background-image: linear-gradient(135deg, #c4eeae 10%, #9ee994 100%);
  z-index: 1;
}

.header-content {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
  -webkit-box-pack: justify;
  -ms-flex-pack: justify;
  justify-content: space-between;
  -ms-flex-wrap: nowrap;
  flex-wrap: nowrap;
}
.header-content .btn-menu {
  width: 30px;
  height: 30px;
  line-height: 30px;
  text-align: center;
  font-size: 1rem;
  color: #fff;
  display: inline-block;
  text-decoration: none;
}
</style>
<header class="header-page">
    <div class="container">
        <div class="header-content">
            <a class="header-content__home btn-menu" id="btnHome" href="/tieu-hoc-trang-chu" data-id="2">
                <i class="fa fa-home"></i></a>
            <a id="global_BlockHeader_btnHomeHide" style="display:none" href="javascript:__doPostBack('global_BlockHeader$btnHomeHide','')"></a>
            <div class="header-content__title">Game Lật Hình</div>
        </div>
    </div>
</header>
<div class="container">
    <div class="title-page">
        <asp:Repeater ID="rpnoidunglathinh" runat="server">
            <ItemTemplate>
                <%#Eval("lathinh_noidung") %>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
<div id="frame-flip_picture" class="frame-game --style-1">


    <div class="frame-game-main">

        <asp:UpdatePanel runat="server" ID="up">
            <ContentTemplate>
                <input type="text" id="txtID" runat="server" style="display: none" />
                <div id="lat-hinh">
                    <div class="row">
                        <asp:Repeater ID="rpListHinhAnh" runat="server">
                            <ItemTemplate>
                                <div class="<%#Eval("col") %>">
                                    <a id="btnHinh<%#Eval("lathinh_id") %>" onclick="myfunction(<%#Eval("lathinh_id") %>)" class="mb-1 mt-1 img-item">
                                        <div class="img_bang">
                                            <img class="card-content" id="dauhoi_<%#Eval("lathinh_id") %>" src="/imagesGame/GameLatHinh/lat-hinh3.png" style="cursor: pointer; width: 100%" />
                                        </div>
                                        <div>
                                            <img id="ketqua_nen<%#Eval("lathinh_id") %>" style="display: none" src="/imagesGame/GameLatHinh/bang-null.png" />
                                            <audio hidden="hidden" id="audio_<%#Eval("lathinh_id") %>" src="<%#Eval("lathinh_mp3") %>" controls="controls" />
                                        </div>
                                        <div class="img_so">
                                            <img src="<%#Eval("lathinh_image") %>" style="display: none" id="<%#Eval("lathinh_id") %>" />
                                        </div>
                                        <input id="txtTraLoi<%#Eval("lathinh_id") %>" type="text" value="<%#Eval("lathinh_code") %>" style="display: none" />
                                    </a>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div style="display: none">
            <audio hidden="hidden" class="media" id="audioselect" src="/mp3Game/audio_select.mp3" controls="controls"></audio>
            <audio hidden="hidden" class="media" id="audioright" src="/mp3Game/audio_right.mp3" controls="controls"></audio>
            <input id="txtSoSaoDatDuoc" type="text" runat="server" />
        </div>
    </div>
    <div style="display: none">
        <input type="text" id="txtSoCauHoi" runat="server" />
        <input type="text" id="txtSoLuong" value="0" />
        <input id="id1" type="text" />
        <input id="id2" type="text" />
        <input id="txtHinh1" type="text" />
        <input id="txtHinh2" type="text" />
        <input type="text" id="txtTimeStartFlipImage" runat="server" value="" />
        <input type="text" id="txtOrderGameFlipImage" runat="server" value="" />
    </div>
    <a href="#" id="btnChoiLai" runat="server" onserverclick="btnChoiLai_ServerClick"></a>

</div>
<script> 
    var deem = 0;
    function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
    
    var socauhoi = document.getElementById("<%=txtSoCauHoi.ClientID%>").value;
    var phantram = 100 / parseInt(socauhoi);
    async function demo(id1, id2, hinh1, hinh2) {
        await sleep(1000);
        if (hinh1 === hinh2 && id1 != id2) {
            console.log(hinh1, hinh2)
            document.getElementById("dauhoi_" + id1).style.display = "none";
            document.getElementById("dauhoi_" + id2).style.display = "none";
            document.getElementById(id1).style.display = "none";
            document.getElementById(id2).style.display = "none";
            document.getElementById("ketqua_nen" + id1).style.display = "inline-block";
            document.getElementById("btnHinh" + id1).style.pointerEvents = "none";
            document.getElementById("ketqua_nen" + id2).style.display = "inline-block";
            document.getElementById("btnHinh" + id2).style.pointerEvents = "none";
            document.getElementById("btnHinh" + id1).style.pointerEvents = "none";
            document.getElementById("btnHinh" + id2).style.pointerEvents = "none";
            document.getElementById('btnHinh' + id1).classList.add('flip');
            document.getElementById('btnHinh' + id2).classList.add('flip');
            deem++;
            audioright.play();
            console.log("phantram:" + phantram);
            console.log("deem:" + deem);
            console.log("socauhoi:" + socauhoi);
            if (deem == socauhoi) {
                let timeStart = $("#<%=txtTimeStartFlipImage.ClientID %>").val();
                let orderGame = $("#<%=txtOrderGameFlipImage.ClientID %>").val();
                showPopup('3', '6/6', timeStart, orderGame);
                deem = 0;
                //btnSubmit();
                
            }
            document.getElementById("txtSoLuong").value = deem;
        }
        else {
            document.getElementById("dauhoi_" + id1).style.display = "inline-block";
            document.getElementById("dauhoi_" + id2).style.display = "inline-block";
            document.getElementById(id1).style.display = "none";
            document.getElementById(id2).style.display = "none";
            document.getElementById("id1").value = "";
        }
        document.getElementById("id1").value = "";
        document.getElementById("id2").value = "";
        document.getElementById("txtHinh1").value = "";
        document.getElementById("txtHinh2").value = "";
    }
    function myfunction(id) {
        /* $(".img-item").css("pointer-events", "none");*/
        //Sự kiện khi klick vào
        if (document.getElementById("txtHinh1").value == "" || document.getElementById("txtHinh2").value == "") {
            audioselect.play();
            jQuery("#dauhoi_" + id).hide()
            jQuery("#" + id).fadeIn();
            document.getElementById("audio_" + id).play();
            //Điều kiện để gán điểm cho thẻ input
            if (document.getElementById("txtHinh1").value == "") {
                document.getElementById("id1").value = id;
                document.getElementById("txtHinh1").value = document.getElementById("txtTraLoi" + id).value;
            }
            else {
                if (id != document.getElementById("id1").value) {
                    document.getElementById("id2").value = id;
                    document.getElementById("txtHinh2").value = document.getElementById("txtTraLoi" + id).value;
                    demo(document.getElementById("id1").value, document.getElementById("id2").value, document.getElementById("txtHinh1").value, document.getElementById("txtHinh2").value)
                }
            }
        }
        //document.getElementById("audio_" + id).addEventListener('ended', function () {
        //    $(".img-item").css("pointer-events", "auto");
        //});
    }
</script> 