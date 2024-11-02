<%@ Control Language="C#" AutoEventWireup="true" CodeFile="uc_ScreenPortrait.ascx.cs" Inherits="web_usercontrol_uc_ScreenPortrait" %>
<style>
    .form-game {
        display: contents;
    }

    .notification {
        display: none;
    }

    @media screen and (orientation: landscape) {
        body {
            overflow: hidden;
            /*  background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
            background-position: center;*/
            background-image: none;
            max-width: 100%;
        }
        
        .desktop body {
           max-width: 600px;
        }
        .form-game {
            display: none;
        }

        .notification {
            display: block;
        }

        .desktop .notification {
            display: none;
        }

        .notification {
            position: relative;
            z-index: 9999999;
            width: 100vw;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: #fff;
        }

        .phone {
            height: 50px;
            width: 100px;
            border: 3px solid black;
            border-radius: 10px;
            animation: rotate 1.5s ease-in-out infinite alternate;
        }

        .message {
            color: black;
            font-size: 1em;
            margin-top: 40px;
            text-align: center;
            padding: 10px;
        }

        @keyframes rotate {
            0% {
                transform: rotate(0deg)
            }

            50% {
                transform: rotate(-90deg)
            }

            100% {
                transform: rotate(-90deg)
            }
        }
    }
</style>
<div class="notification">

    <div class="phone">
    </div>
    <div class="message">
        <p>Để có trải nghiệm được tốt nhất, vui lòng chuyển qua chế độ màn hình đứng!</p>
    </div>
</div>
