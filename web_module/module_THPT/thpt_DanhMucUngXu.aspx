<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageGameTHPT.master" AutoEventWireup="true" CodeFile="thpt_DanhMucUngXu.aspx.cs" Inherits="web_module_module_THPT_thpt_DanhMucUngXu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" Runat="Server">
    <style>
        /*.block-card {
            box-shadow: 2px 3px 8px 5px rgba(128, 128, 128, .1607843137);
            background: #fff;
            border-radius: .75rem;
            padding: 15px;
        }
        .qtux-content .menu-icon .menu-item {
            width: calc(50% - .75rem);
            margin-right: 1rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            padding: 20px;
            border-radius: .25rem;
            border: 0;
            box-shadow: rgba(0, 0, 0, .24) 0 3px 8px;
            flex-direction: column;
        }
        .menu-icon .menu-item__title {
            color: #000;
            font-weight: 600;
            line-height: 1.2;
            font-size: 12px;
            height: 29px;
            display: block;
            white-space: normal;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            background-color: transparent;
            padding: 0;
        }
        .menu-icon-list .menu-item__image {
            position: relative;
            padding: 7.5px;
        }
        .menu-icon-list {
            display: flex;
            flex-wrap: nowrap;
            white-space: nowrap;
            width: 100%;
            overflow-x: auto;
            padding: .25rem;
            border-radius: .5rem;
        }
        .menu-icon-list .menu-item {
            width: 85px;
            min-width: 85px;
            text-align: center;
            display: block;
            padding: .25rem;
            border: 0;
            border-right: 1px solid #8f0100;
        }

        .qtux-content .menu-icon .menu-item__icon i {
            color: #fff;
            margin: 3px 0;
            font-size: 60px;
            height: 73px;
        }
        .qtux-content .menu-icon .menu-item__title {
            font-weight: 500;
            background-color: transparent;
            color: #fff;
            white-space: normal;
            flex-grow: 1;
            font-size: 1rem;
        }
        .qtux-content .menu-icon .menu-item__image {
            width: 60px;
            min-width: 60px;
            height: 60px;
            padding: .5rem;
        }

        .qtux-content .menu-icon .menu-item.bg-c-red {
            background: linear-gradient(90deg, #de2fed 0%, #fe093b 100%);
            width: 100%;
        }
        .qtux-content .menu-icon .menu-item.bg-c-blue {
            background: linear-gradient(90deg,#78dbff 0%,#1d83fd 100%);
            width: 100%;
            margin-left: 20px;  
        }
        .qtux-content .menu-icon .menu-item.bg-c-green {
            background: linear-gradient(90deg,#a8f988 0%,#23b52c 100%);
            width: 100%;
        }

        .qtux-content .menu-icon .menu-item.bg-c-yellow {
            background: linear-gradient(90deg,#ff4105 0%,#ff8f00 100%);
            width: 100%;
            margin-left: 20px;  
        }
        .qtux-content .menu-icon {
            display: flex;
            flex-wrap: wrap;
        }
        .menu-item {
            display: table-cell;
            vertical-align: top;
            border-right: 1px solid #8f0100;
            border-bottom: 1px solid #8f0100;
        }
        *, *::before, *::after {
            box-sizing: border-box;
        }
        .header-ungxu__title {
            font-size: 1.5rem;
            font-weight: 500;
        }
        .header-ungxu {
            text-align: center;
            margin-bottom: 1rem;
        }
        .header-ungxu__bottom {
            padding: 2% 0;
        }*/

        .block-card {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            background-color: #eee;
            margin: 0;
            padding: 20px;
        }
        .menu-icon{
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            background-color: #f9f9ff;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            border-bottom-left-radius: 20px;
            box-shadow: 0 -10px 45px -10px rgba(0, 0, 0, .75);
            padding-top: 1rem;
            padding-bottom: 1rem;
        }
        .block-content{
            display: flex;
            flex-wrap: wrap;
            align-content: flex-start;
        }
        .menu-item{
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 200px;
            height: 150px;
            border-radius: 10px;
            color: white;
            font-size: 20px;
            text-align: center;
            cursor: pointer;
        }
        .menu-icon .menu-item.bg-c-red {
            background: linear-gradient(90deg, #de2fed 0%, #fe093b 100%);
        }
        .menu-icon .menu-item.bg-c-red i{
            font-size: 40px;
            margin-bottom: 10px;
        }

        .menu-icon .menu-item.bg-c-blue {
            background: linear-gradient(90deg,#78dbff 0%,#1d83fd 100%);
        }
        .menu-icon .menu-item.bg-c-blue i{
            font-size: 40px;
            margin-bottom: 10px;
        }

        .menu-icon .menu-item.bg-c-green {
            background: linear-gradient(90deg,#a8f988 0%,#23b52c 100%);
        }
        .menu-icon .menu-item.bg-c-green i{
            font-size: 40px;
            margin-bottom: 10px;
        }

        .menu-icon .menu-item.bg-c-yellow {
            background: linear-gradient(90deg,#ff4105 0%,#ff8f00 100%);
        }
        .menu-icon .menu-item.bg-c-yellow i{
            font-size: 40px;
            margin-bottom: 10px;
        }
        .header-ungxu__title {
            font-size: 24px;
            font-weight: bold;
        }

        .header-ungxu{
            width: 100%;
            height: 50px;
            text-align:center;
            margin-bottom: 2rem;
            margin-top: 1rem;
        }

        .body-ungxu {
            width: 100%;
            height: 50px;
        }

        .ontap-ungxu-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            justify-content: space-between;
        }

        .ontap-ungxu-item__icon {
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #ddd;
            border-radius: 50%;
            margin-right: 10px;
        }

        .ontap-ungxu-item__title {
            flex-grow: 1;
        }

        .progress-circle {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 14px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" Runat="Server">
    <%--<div class="block-card ">
        <div class="qtux-content">
            <div class="menu-icon">
                <div class="menu-icon-1">
                    <a class="menu-item bg-c-red" href="/danh-sach-kiem-tra-ung-xu">
                        <div class="menu-item__icon"> 
                            <i class="fa fa-file-text" aria-hidden="true"></i>
                        </div>
                        <div class="menu-item__title">
                            Bài kiểm tra
                        </div>
                    </a>

                    <a id="Wrapper_btnCauHoiDaLuu" class="menu-item bg-c-green" href="javascript:__doPostBack('ctl00$Wrapper$btnCauHoiDaLuu','')">
                        <div class="menu-item__icon">
                            <i class="fa fa-floppy-o" aria-hidden="true"></i>
                        </div>
                        <div class="menu-item__title">
                            Các câu đã lưu
                        </div>
                    </a>
                </div>
                <div class="menu-icon-2">
                    <a class="menu-item bg-c-blue" href="javascript:void(0)" onclick="myCapNhat()">
                        <div class="menu-item__icon">
                            <i class="fa fa-file-image-o" aria-hidden="true"></i>
                        </div>
                        <div class="menu-item__title">
                            Bài test tình huống
                        </div>
                    </a>
                    
                    <a class="menu-item bg-c-yellow" href="/" onclick="myCapNhat()">
                        <div class="menu-item__icon">
                            <i class="fa fa-book" aria-hidden="true"></i>
                        </div>
                        <div class="menu-item__title">
                            Tài liệu
                        </div>
                    </a>
                </div>
            </div>


                
        </div>
        <div class="block-content">
            <div class="header-ungxu">
                <div class="header-ungxu__title">ÔN TẬP KIẾN THỨC</div>
                <a class="header-ungxu__bottom" href="javascript:void(0)" onclick="confirmDel()">
                    <i class="fa fa-undo" aria-hidden="true"></i>
                    <span>Làm lại từ đầu </span>
                </a>
            </div>
        </div>
    </div>--%>
    <div class="block-card">
        <div class="menu-icon">
            <a class="menu-item bg-c-red" href="/#">
                <div class="menu-item__icon">
                    <i class="far fa-file-alt"></i>
                </div>
                <div class="menu-item__title">
                    Bài kiểm tra
                </div>
            </a>
            <a class="menu-item bg-c-blue" href="#">
                <div class="menu-item__icon">
                    <i class="fa fa-file-image-o" aria-hidden="true"></i>
                </div>
                <div class="menu-item__title">
                    Bài test tình huống
                </div>
            </a>
            <a id="Wrapper_btnCauHoiDaLuu" class="menu-item bg-c-green" href="#">
                <div class="menu-item__icon">
                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                </div>
                <div class="menu-item__title">
                    Các câu đã lưu
                </div>
            </a>                                            
            <a class="menu-item bg-c-yellow" href="/">
                <div class="menu-item__icon">
                    <i class="fa fa-book" aria-hidden="true"></i>
                </div>
                <div class="menu-item__title">
                    Tài liệu
                </div>
            </a>
        </div>
        
        <div class="block-content">
            <div class="header-ungxu">
                <div class="header-ungxu__title">ÔN TẬP KIẾN THỨC</div>
                <a class="header-ungxu__bottom" href="javascript:void(0)" onclick="confirmDel()">
                    <i class="fa fa-undo" aria-hidden="true"></i>
                    <span>Làm lại từ đầu </span>
                </a>

            </div>
            <div class="body-ungxu">
                <a class="ontap-ungxu-item" href="/#">
                    <div>
                        <div class="ontap-ungxu-item__icon">500</div>
                        <div class="ontap-ungxu-item__title">Tất cả các câu</div>
                    </div>
                    
                    <div class="ontap-ungxu-item__quantity">
                        <div class="progress-circle" data-progress="" data-dalam="0" data-tongcau="500" style="background: conic-gradient(rgb(16, 156, 255) 0%, rgb(16, 156, 255) 0%, rgb(233, 236, 239) 0%, rgb(233, 236, 239) 100%);"><span class="progress-circle-text">0%</span></div>
                    </div>
                </a>           
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" Runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" Runat="Server">

</asp:Content>

