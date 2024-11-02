<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Uc_ScreenNotification.ascx.cs" Inherits="web_usercontrol_Uc_ScreenNotification" %>

<style>
    .form-game {
        display: contents;
    }

    .notification {
        display: none;
    }

    @media screen and (orientation: portrait) {
        body {
            overflow: hidden;
            /*  background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
            background-position: center;*/
            background-image: none;
        }

        .form-game {
            display: none;
        }

        .notification {
            display: block;
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
        <p>Để trải nghiệm các trò chơi học tập tốt hơn, quý phụ huynh vui lòng chuyển qua chế độ xoay màn hình!</p>
    </div>
</div>

