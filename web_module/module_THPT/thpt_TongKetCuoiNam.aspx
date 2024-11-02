<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageLandingPage_THPT.master" AutoEventWireup="true" CodeFile="thpt_TongKetCuoiNam.aspx.cs" Inherits="web_module_module_THPT_thpt_TongKetCuoiNam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <style>
        /* styles.css */

        /*body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f8f8;
        }*/

        header {
            text-align: center;
            background-color: #5193cb;
            color: white;
            padding: 20px;
        }

        nav {
            background-color: #3c3e7f;
            padding: 10px;
        }

            nav ul {
                list-style: none;
                display: flex;
                justify-content: center;
                padding: 0;
                margin: 0;
            }

                nav ul li {
                    margin: 0 15px;
                }

                    nav ul li a {
                        color: white;
                        text-decoration: none;
                        font-weight: bold;
                    }

        main {
            background: #f3ffff;
            padding: 20px;
        }

        section {
            background-color: white;
            margin-bottom: 20px;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

            section h3 {
                color: #05567d;
            }

        footer {
            text-align: center;
            background-color: #1c2959;
            color: white;
            padding: 10px 0;
        }

        @media (max-width: 768px) {
            nav ul {
                flex-direction: column;
            }

                nav ul li {
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
    <header>
        <h1>Chào mừng đến với buổi họp phụ huynh</h1>
        <h2>Trình bày bởi Đỗ Minh Thùy 9A1</h2>
    </header>
    <nav>
        <ul>
            <li><a href="#muc-tieu">Mục tiêu</a></li>
            <li><a href="#danh-gia">Đánh giá</a></li>
            <li><a href="#ke-hoach">Kế hoạch</a></li>
            <li><a href="#suy-ngam">Suy ngẫm</a></li>
        </ul>
    </nav>
    <main>
         <section id="">
            <h3>Mục lục</h3>
            <div class="content">
                <p>Mục tiêu (1): Khái quát về mục tiêu (1)</p>
                <p>Đánh giá: Đưa ra nhận xét giữa kết quả đạt được và mục tiêu</p>
                <p>Mục tiêu (2): Tạo mục tiêu mới cho học kì 2</p>
                <p>Kế hoạch: Đưa ra các giải pháp thực hiện mục tiêu (2)</p>
            </div>
        </section>
        <section id="">
            <h3>Mục tiêu</h3>
            <div class="content">
                <p>Học lực: Giỏi, TBM trên 7.5, ba môn Toán, Văn, Anh TBM trên 8.0</p>
                <p>Kỹ năng: Phát triển các kỹ năng mềm như thuyết trình, làm việc nhóm, giải quyết vấn đề, tranh biện</p>
                <p>Hạnh kiểm: Tốt, trên 97.00</p>
            </div>
        </section>
        <section id="muc-tieu">
            <h3>Đánh giá</h3>
            <div class="content">
                <p>Mục tiêu (1): Khái quát về mục tiêu (1)</p>
                <p>Đánh giá: Đưa ra nhận xét giữa kết quả đạt được và mục tiêu</p>
                <p>Mục tiêu (2): Tạo mục tiêu mới cho học kì 2</p>
                <p>Kế hoạch: Đưa ra các giải pháp thực hiện mục tiêu (2)</p>
                <p>CHƯA HOÀN THÀNH</p>
            </div>
        </section>
       
        <section id="ke-hoach">
            <h3>Kế hoạch</h3>
            <div class="content">
                <p>Giải pháp: Khoa học TN, Địa, Sử</p>
                <p>Thói quen: Tập trung, nghe giảng, phát biểu, sử dụng mind map</p>
                <p>Rút kinh nghiệm: Từ các thói xấu và lỗi sai để hoàn thành mục tiêu</p>
            </div>
        </section>
        <section id="suy-ngam">
            <h3>Suy ngẫm</h3>
            <div class="content">
                <p>Qua một năm học tại Vinschool</p>
            </div>
        </section>
    </main>
    <footer>
        <p>End of Thuy’s First Semester at Vinschool</p>
        <p>Thank you for listening!</p>
    </footer>
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
        });

    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

