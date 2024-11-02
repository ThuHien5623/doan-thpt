<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLandingPage_THPT.master" AutoEventWireup="true" CodeFile="thpt_TongKetCuoiNam.aspx.cs" Inherits="web_module_module_THPT_thpt_TongKetCuoiNam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link rel="stylesheet" href="owlcarousel/owl.carousel.min.css">
    <link rel="stylesheet" href="owlcarousel/owl.theme.default.min.css">
    <script src="../../js/jquery.min.js"></script>
    <script src="../../js/owl.carousel.min.js"></script>
    <style>
        /*body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
        }*/

        .top {
            text-align: center;
            background-color: #5193cb;
            color: white;
            padding: 20px;
        }

        .menu {
            background-color: #3c3e7f;
            padding: 5px;
        }

        .menu-text {
            list-style: none;
            display: flex;
            justify-content: center;
            padding: 0;
            margin: 0;
        }

        .menu-text-part {
            margin: 0 15px;
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .container {
            background: rgb(203,232,238);
            background: linear-gradient(90deg, rgba(203,232,238,1) 1%, rgba(251,190,190,1) 100%);
            padding: 20px;
        }

        .content {
            background: #f3ffff;
            margin-bottom: 20px;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .bottom {
            text-align: center;
            background-color: #1c2959;
            color: white;
            padding: 10px 0;
        }

        .table-index {
            border: 3px groove;
            width: 100%;
        }

        .list {
            list-style-type: disc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        .table-left1 {
            background-color: #e4d6fe;
            border: 3px groove;
            font-weight: bold;
        }

        .table-left2 {
            background-color: #fbf1e9;
            border: 3px groove;
            font-weight: bold;
        }

        .table-right {
            background-color: white;
        }

        .table-target {
            width: 100%;
        }

            .table-target th {
                font-weight: bold;
                font-size: 14px;
            }

        .evaluate {
            display: flex;
        }

        .evaluate-left {
            width: 50%;
            padding-top: 2%;
            padding-right: 5%;
            height: 100%;
            
        }

        .evaluate-right {
            width: 45%;
            padding-left: 5%;
        }

        .evaluate-note {
            font-weight: bold;
            color: red;
            text-align: center;
            padding-top: 20px;
        }

        .evaluate-title {
            font-weight: bold;
            text-align: center;
        }


        .evaluate-content-left {
            background-color: pink;
            text-align: center;
        }

        .evaluate-content-right {
            background-color: navajowhite;
            text-align: center;
        }

        .content-solition-left-1 {
            font-weight: bold;
            background-color: #e4d6fe;
            border: 3px groove
        }

        .content-solition-left-2 {
            font-weight: bold;
            background-color: #fbf1e9;
            border: 3px groove
        }

        .content-solition-right {
            background-color: white;
            border: 3px groove
        }

        .board {
            width: 100%;
        }
        .think{
            padding-bottom: 15px;
            font-weight: bold;
        }
        .student{
            border-radius: 8px;
        }
        @media (max-width: 768px) {
            .menu-text {
                flex-direction: column;
            }

            .menu-text-part {
                margin: 10px 0;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
    <header class="top">
        <h1>Chào mừng đến với buổi họp phụ huynh</h1>
        <h2>Trình bày bởi Đỗ Minh Thùy 9A1</h2>
    </header>
    <div class="menu">
        <ul class="menu-text">
            <li class="menu-text-part"><a href="#muc-tieu">Mục tiêu</a></li>
            <li class="menu-text-part"><a href="#danh-gia">Đánh giá</a></li>
            <li class="menu-text-part"><a href="#ke-hoach">Kế hoạch</a></li>
            <li class="menu-text-part"><a href="#suy-ngam">Suy ngẫm</a></li>
        </ul>
    </div>
    <main class="container">
        <div id="">
            <h4>MỤC LỤC</h4>
            <div class="content">
                <table class="table-index">
                    <tr class="table-index ">
                        <td class="table-left1">MỤC TIÊU</td>
                        <td class="table-right">Khái quát về mục tiêu</td>
                    </tr>
                    <tr class="table-index ">
                        <td class="table-left2">ĐÁNH GIÁ</td>
                        <td class="table-right">Đưa ra nhận xét giữa kết quả đạt được và mục tiêu</td>
                    </tr>
                    <tr class="table-index ">
                        <td class="table-left1">MỤC TIÊU</td>
                        <td class="table-right">Tạo mục tiêu mới cho học kì 2</td>
                    </tr>
                    <tr>
                        <td class="table-left2">KẾ HOẠCH</td>
                        <td class="table-right">Đưa ra các giải pháp thực hiện mục tiêu</td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="">
            <h4>MỤC TIÊU</h4>
            <div class="content">
                <table class="table-target">
                    <tr>
                        <th>HẠNH KIỂM
                        </th>
                        <th>HỌC LỰC
                        </th>
                        <th>KỸ NĂNG
                        </th>
                    </tr>
                    <tr>
                        <td>HẠNH KIỂM TỐT
                            <p>TRÊN 97.00</p>

                        </td>
                        <td>
                            <ul class="list">
                                <li>HỌC LỰC GIỎI</li>
                                <li>TBM TRÊN 7.5</li>
                                <li>BA MÔN TOÁN, VĂN, ANH TBM TRÊN 8.0</li>
                            </ul>
                        </td>
                        <td>PHÁT TRIỂN CÁC KỸ NĂNG MỀM NHƯ:
                            <ul class="list">
                                <li>THUYẾT TRÌNH</li>
                                <li>LÀM VIỆC NHÓM</li>
                                <li>GIẢI QUYẾT VẤN ĐỀ</li>
                                <li>TRANH BIỆN</li>
                            </ul>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="muc-tieu">
            <h4>ĐÁNH GIÁ</h4>
            <div class="content">
                <table>
                    <tr class="evaluate">
                        <td class="evaluate-left">
                            <canvas id="myChart" height="300"></canvas>
                        </td>
                        <td class="evaluate-right">
                            <ul class="list">
                                <li>Khái quát về mục tiêu </li>
                                <li>Đưa ra nhận xét giữa kết quả đạt được và mục tiêu</li>
                                <li>Tạo mục tiêu mới cho học kì 2</li>
                                <li>Đưa ra các giải pháp thực hiện mục tiêu</li>
                            </ul>
                            <p class="evaluate-note">
                                CHƯA HOÀN THÀNH
                            </p>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="danh-gia2">
            <h4>ĐÁNH GIÁ</h4>
            <div class="content">
                <table class="board">
                    <tr>
                        <td class="evaluate-title">HẠNH KIỂM
                        </td>
                        <td class="evaluate-title">KỸ NĂNG
                        </td>
                    </tr>
                    <tr>
                        <td class="evaluate-content-left">ĐIỂM VĂN MINH 99.00
                        </td>
                        <td class="evaluate-content-right">TỰ TIN THUYẾT TRÌNH
                        </td>
                    </tr>
                </table>
                <div class="evaluate-note">
                    HOÀN THÀNH
                </div>
            </div>

        </div>
        <div id="ke-hoach">
            <h4>KẾ HOẠCH</h4>
            <div class="content">
                <table class="board">
                    <tr>
                        <td class="content-solition-left-1">GIẢI PHÁP</td>
                        <td class="content-solition-right">Khoa học TN, Địa, Sử</td>
                    </tr>
                    <tr>
                        <td class="content-solition-left-2">THÓI QUEN</td>
                        <td class="content-solition-right">Tập trung, nghe giảng, phát biểu, sử dụng mind map</td>
                    </tr>
                    <tr>
                        <td class="content-solition-left-1">RÚT KINH NGHIỆM</td>
                        <td class="content-solition-right">Từ các thói xấu và lỗi sai để hoàn thành mục tiêu</td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="danh-gia">
            <h4>SUY NGẪM</h4>
            <div class="content">
                <p class="think">Qua một năm học tại Vinschool</p>
                <div class="owl-carousel">
                    <div><img src="img/hocsinh1.png" class="student"/> </div>
                    <div><img src="img/hocsinh2.png" class="student"/></div>
                    <div><img src="img/hocsinh3.png" class="student"/></div>
                    <div><img src="img/hocsinh4.png" class="student"/></div>
                    <div><img src="img/hocsinh5.png" class="student"/></div>
                    <div><img src="img/hocsinh6.png" class="student"/></div>
                </div>
            </div>
        </div>


    </main>
    <footer class="bottom">
        <p>End of Thuy’s First Semester at Vinschool</p>
        <p>Thank you for listening!</p>
    </footer>
    <!-- Thêm thư viện Chart.js từ CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                        behavior: 'smooth'
                    });
                });
            });

            // Khởi tạo biểu đồ sau khi DOM đã được tải
            var xValues = ["Toán", "Lý", "Hóa", "Văn", "Anh"];
            var yValues = [10, 7, 6, 8, 9];
            var barColors = ["red", "green", "blue", "orange", "brown"];

            new Chart("myChart", {
                type: "bar",
                data: {
                    labels: xValues,
                    datasets: [{
                        backgroundColor: barColors,
                        data: yValues
                    }]
                },
                options: {
                    legend: { display: false },
                    title: {
                        display: true,
                        text: "Bảng điểm của Lê Văn A năm 2021"
                    }
                }
            });
        });


        $(document).ready(function () {
            $('.owl-carousel').owlCarousel({
                loop: false,
                margin: 10,
                nav: false,
                responsive: {
                    0: {
                        items: 1
                    },
                    600: {
                        items: 3
                    },
                    1000: {
                        items: 3
                    }
                }
            })
        });

    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>
