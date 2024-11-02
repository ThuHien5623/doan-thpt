<%@ Page Language="C#" AutoEventWireup="true" CodeFile="THPT_TrangChu.aspx.cs" Inherits="landingpage_THPT_THPT_TrangChu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
    <video autoplay muted loop id="myVideo">
        <asp:Repeater runat="server" ID="rpVideoGioiTHCS">
            <ItemTemplate>
                <iframe src="<%#Eval("introduce_link") %>" allow="autoplay" frameborder="0" allowfullscreen></iframe>
            </ItemTemplate>
        </asp:Repeater>
        Your browser does not support HTML5 video.
    </video>
    <div class="video-background">
        <div class="video-foreground">
            <iframe src="https://www.youtube.com/embed/uF9SMGXzPDM?&autoplay=1&mute=1&playsinline=1&playlist=uF9SMGXzPDM&loop=1" allow="autoplay" frameborder="0" allowfullscreen></iframe>
        </div>
    </div>
    <div class="header_menu">
       
        
         <div class="background-overlay">
                <img class="img-1" src="../../images/bg-home.png" />
        </div>
        <ul class="menu">
            <div class="logo">
                <img src="../../images/logo-horizontal.png" />
            </div>
            <li>
                <a
                    class="nav-link"
                    href="javascript:void(0)"
                    id="menu-1"
                    onclick="showVideoList(this.id,this.getAttribute('data-url'))"
                    data-url="videos/rain.mp4">Giới thiệu</a>
            </li>
            <li>
                <a
                    class="nav-link"
                    href="javascript:void(0)"
                    id="menu-2"
                    onclick="showVideoList(this.id,this.getAttribute('data-url'))"
                    data-url="videos/mov_bbb.mp4">Bảng giá</a>
            </li>
            <li>
                <a class="nav-link"
                    href="javascript:void(0)"
                    id="menu-3"
                    onclick="showVideoList(this.id,this.getAttribute('data-url'))"
                    data-url="videos/rain.mp4">Hướng dẫn bài tập
                </a>
            </li>
            <li>
                <a
                    class="nav-link"
                    href="javascript:void(0)"
                    id="menu-4"
                    onclick="showVideoList(this.id,this.getAttribute('data-url'))"
                    data-url="videos/mov_bbb.mp4">Liên hệ</a>
            </li>
            <li>
                <a
                    class="nav-link"
                    href="javascript:void(0)"
                    id="menu-5"
                    onclick="showVideoList(this.id,this.getAttribute('data-url'))"
                    data-url="videos/mov_bbb.mp4">Đăng Nhập</a>
            </li>
        </ul>
       
    </div>
    
    <script>
        const showVideoList = (id, url) => {
            var navLink = document.getElementsByClassName("nav-link");

            // Chuyển danh sách các phần tử thành mảng để dễ quản lý hơn
            var navLinkArray = Array.from(navLink);

            // Lặp qua mảng và loại bỏ class "remove" từ mỗi phần tử
            navLinkArray.forEach(function (element) {
                element.classList.remove("active");
            });
            //navLink.classList.remove("active");
            // jQuery(".menu li a").removeClass("active");

            document.getElementById(id).classList.add("active");
            //jQuery("#" + id).addClass("active");
            document.getElementById("urlVideo").src = url;
            document.getElementById("myVideo").load();
            //jQuery("#myVideo source").attr("src", url);
            // jQuery("#myVideo")[0].load();
        };
        var video = document.getElementById("video-background");
        video.onplay = function () {
            // Ẩn thanh công cụ
            document.querySelector('header').classList.add('hide');
        };
        video.onended = function () {
            // Hiện thanh công cụ
            document.querySelector('header').classList.remove('hide');
        };
    </script>
    <style>
        .header_menu{
            position: fixed;
            top: 0;
            background: #F0E6D8;
            width: 100%;
            padding: 1px;
            text-align: center;
            height:53px;
            transition:top 3s;
        }
        
        .menu{
            display: flex;
            justify-content: center;
            list-style: none;
            height:20px;
            padding-left: 0.6rem;
            margin-right: -100px;
            position: relative;
            top: -39px;
            text-decoration:inherit;
        }
        .menu .nav-link{
            display: block;
            margin: 0 0.14999999999999858mm;
            font-size: 15px;
            font-weight: 500;
            color: #000000;
            text-transform: uppercase;
            transition: color 0.3s ;
            
        }
        .logo{
            padding:45px 6px;
            background-color:white;
            width :155px;
            border:3px ;
            border-radius:10px;
            position:relative;
            height:105px;
            top:-20px;
            margin-left:-110px;
            box-shadow: 0px 3px 27px -5px rgba(0,0,0,0.75);
        }
        .menu li a.active, .menu li a:hover{
            color:#F0645E;
            border-color: rgba(0, 0, 0, 0);
        }
        img{
            max-width:150px;
            position:relative;
            top:-30px;
        }
        .background-overlay{
            min-width:100%;   
            object-fit:cover;
            position:relative;
            top:80px;
            margin-left:-2px;
        }
        .img-1{
            max-width:1500px;
        }
         .video-background {
            background: #000;
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            z-index: -99;
        }

            .video-foreground,
            .video-background iframe {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            }
            @media (min-aspect-ratio: 16/9) {
            .video-foreground {
                height: 300%;
                top: -100%;
            }
        }

        @media (max-aspect-ratio: 16/9) {
            .video-foreground {
                width: 300%;
                left: -100%;
            }
        }
    </style>
</body>
</html>