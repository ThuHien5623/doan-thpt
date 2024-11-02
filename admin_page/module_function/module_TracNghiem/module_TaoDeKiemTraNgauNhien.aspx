<%@ Page Title="" Language="C#" MasterPageFile="~/ContactBookInternalMasterPage.master" AutoEventWireup="true" CodeFile="module_TaoDeKiemTraNgauNhien.aspx.cs" Inherits="admin_page_module_function_module_TracNghiem_module_TaoDeKiemTraNgauNhien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header" runat="Server">
    <link href="../../../css/pageTest.css" rel="stylesheet" />
    <script>
        function CloseGridLookup() {
            lkChuong.ConfirmCurrentSelection();
            lkChuong.HideDropDown();
            //lkChuong.Focus();
        }

        function checkNULLBai() {
            var txtTenBai = document.getElementById('<%= txtTenBai.ClientID%>');
            var txtThoiGian = document.getElementById('<%= txtThoiGian.ClientID%>');
            var txtHinhThuc = document.getElementById('<%= txtHinhThucThi.ClientID%>').value;
            var txtTN_NB = document.getElementById('<%= txtTracNghiem_NhanBiet.ClientID%>');
            var txtTN_TH = document.getElementById('<%= txtTracNghiem_ThongHieu.ClientID%>');
            var txtTN_VD = document.getElementById('<%= txtTracNghiem_VanDung.ClientID%>');
            var txtTN_VDC = document.getElementById('<%= txtTracNghiem_VanDungCao.ClientID%>');
            var txtTL_NB = document.getElementById('<%= txtTuLuan_NhanBiet.ClientID%>');
            var txtTL_TH = document.getElementById('<%= txtTuLuan_ThongHieu.ClientID%>');
            var txtTL_VD = document.getElementById('<%= txtTuLuan_VanDung.ClientID%>');
            var txtTL_VDC = document.getElementById('<%= txtTuLuan_VanDungCao.ClientID%>');
            var txtDiem_TL_NB = document.getElementById('<%= txtTuLuan_Diem_NhanBiet.ClientID%>');
            var txtDiem_TL_TH = document.getElementById('<%= txtTuLuan_Diem_ThongHieu.ClientID%>');
            var txtDiem_TL_VD = document.getElementById('<%= txtTuLuan_Diem_VanDung.ClientID%>');
            var txtDiem_TL_VDC = document.getElementById('<%= txtTuLuan_Diem_VanDungCao.ClientID%>');
            var lkChuong = document.getElementById('<%= lkChuong.ClientID%>').text;
            var lkBai = document.getElementById('<%= txtLessonID.ClientID%>').value;

            if (txtTenBai.value.trim() == "") {
                swal('Vui lòng nhập tên bài kiểm tra!', '', 'warning').then(function () { txtTenBai.focus(); });
                return false;
            }
            if (txtThoiGian.value.trim() == "") {
                swal('Vui lòng nhập thời gian làm bài!', '', 'warning').then(function () { txtThoiGian.focus(); });
                return false;
            }
            if (lkChuong == "") {
                swal('Bạn chưa chọn chương!', '', 'warning');
                return false;
            }
            if (lkBai == "") {
                swal('Bạn chưa chọn bài!', '', 'warning');
                return false;
            }
            if (txtHinhThuc == "") {
                swal('Bạn chưa chọn hình thức thi!', '', 'warning');
                return false;
            }
            if (txtHinhThuc == "1" && txtTN_NB.value == "" && txtTN_TH.value == "" && txtTN_VD.value == "" && txtTN_VDC.value == "") {
                swal('Bạn chưa nhập ma trận đề trắc nghiệm!', '', 'warning');
                return false;
            }
            if (txtHinhThuc == "3" && txtTN_NB.value == "" && txtTN_TH.value == "" && txtTN_VD.value == "" && txtTN_VDC.value == "") {
                swal('Bạn chưa nhập ma trận đề trắc nghiệm!', '', 'warning');
                return false;
            }
            if (txtHinhThuc == "2" && txtTL_NB.value == "" && txtTL_TH.value == "" && txtTL_VD.value == "" && txtTL_VDC.value == "") {
                swal('Bạn chưa nhập ma trận đề tự luận!', '', 'warning');
                return false;
            }
            //debugger;
            if (txtHinhThuc == "2" || txtHinhThuc == "3") {

                if (txtDiem_TL_NB.value == "" || txtTL_NB.value == "") {
                    swal('Bạn chưa nhập đủ thông tin điểm và số câu tự luận nhận biết!', '', 'warning').then(function () { txtTL_NB.focus(); });
                    return false;
                }
                if (txtDiem_TL_TH.value == "" || txtTL_TH.value == "") {
                    swal('Bạn chưa nhập đủ thông tin điểm và số câu tự luận thông hiểu!', '', 'warning').then(function () { txtTL_TH.focus(); });
                    return false;
                }
                if (txtDiem_TL_VD.value == "" || txtTL_VD.value == "") {
                    swal('Bạn chưa nhập đủ thông tin điểm và số câu tự luận vận dụng!', '', 'warning').then(function () { txtTL_VD.focus(); });
                    return false;
                }
                if (txtDiem_TL_VDC.value == "" || txtTL_VDC.value == "") {
                    swal('Bạn chưa nhập đủ thông tin điểm và số câu tự luận vận dụng cao!', '', 'warning').then(function () { txtTL_VDC.focus(); });
                    return false;
                }
            }
            DisplayLoadingIcon();
            return true;
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode
            if (charCode == 46 || (charCode > 47 && charCode < 58))
                return true; return false;
        }
        function myChange(id) {
            document.getElementById("<%=txtHinhThucThi.ClientID%>").value = id;
            if (id == 1) {
                document.getElementById("dv_TracNghiem").style.display = "flex";
                document.getElementById("dv_TuLuan").style.display = "none";
                document.getElementById("div_LuuY").style.display = "none";
            }
            if (id == 2) {
                document.getElementById("dv_TuLuan").style.display = "block";
                document.getElementById("dv_TracNghiem").style.display = "none";
                document.getElementById("div_LuuY").style.display = "none";
            }
            if (id == 3) {
                document.getElementById("dv_TuLuan").style.display = "block";
                document.getElementById("dv_TracNghiem").style.display = "flex";
                document.getElementById("div_LuuY").style.display = "block";
            }
        }
        function confirmDel() {
            swal("Bạn có thực sự muốn xóa đề này?",
                "Nếu có, dữ liệu sẽ không thể khôi phục.",
                "warning",
                {
                    buttons: true,
                    successMode: true
                }).then(function (value) {
                    if (value == true) {
                        var xoa = document.getElementById('<%=btnXoa.ClientID%>');
                        xoa.click();
                    }
                });

        }
        var arr = [];
        function checkValue(id) {
            if (arr.includes(id)) {
                arr = arr.filter(item => item !== id)
            }
            else {
                arr.push(id);
            }
            document.getElementById("<%=txtLessonID.ClientID%>").value = arr.toString();
        }

        function getDiemChiTietTuLuan() {
            let nhanBiet = 0, thongHieu = 0, vanDung = 0, vanDungCao = 0;
            var getElments = $("input[name='diemchitiet_tuluan']").map(function () {
                return $(this);
            }).get();
            //console.log(getElments.is(":empty"));
            for (var i = 0; i < getElments.length; i++) {
                //console.log(getElments[i].data('type'))
                if (getElments[i].data('type') == 'Nhận biết')
                    nhanBiet += parseFloat(getElments[i].val());
                if (getElments[i].data('type') == 'Thông hiểu')
                    thongHieu += parseFloat(getElments[i].val());
                if (getElments[i].data('type') == 'Vận dụng')
                    vanDung += parseFloat(getElments[i].val());
                if (getElments[i].data('type') == 'Vận dụng cao')
                    vanDungCao += parseFloat(getElments[i].val());
            }
            //console.log(nhanBiet, thongHieu, vanDung, vanDungCao)
            let sumNB = document.getElementById("<%=txtTuLuan_Diem_NhanBiet.ClientID%>").value;
            let sumTH = document.getElementById("<%=txtTuLuan_Diem_ThongHieu.ClientID%>").value;
            let sumVD = document.getElementById("<%=txtTuLuan_Diem_VanDung.ClientID%>").value;
            let sumVDC = document.getElementById("<%=txtTuLuan_Diem_VanDungCao.ClientID%>").value;
            if (sumNB != nhanBiet) {
                swal('Tổng điểm tự luận nhận biết không khớp với tổng điểm nhận biết ở ma trận!', '', 'warning');
                return false;
            }
            if (sumTH != thongHieu) {
                swal('Tổng điểm tự luận thông hiểu không khớp với tổng điểm thông hiểu ở ma trận!', '', 'warning');
                return false;
            }
            if (sumVD != vanDung) {
                swal('Tổng điểm tự luận vận dụng không khớp với tổng điểm vận dụng ở ma trận!', '', 'warning');
                return false;
            }
            if (sumVDC != vanDungCao) {
                swal('Tổng điểm tự luận vận dụng cao không khớp với tổng điểm vận dụng cao ở ma trận!', '', 'warning');
                return false;
            }

            let getDiemChiTiet = $("input[name='diemchitiet_tuluan']").map(function () {
                return $(this).val();
            }).get();
            let getId = $("input[name='diemchitiet_tuluan']").map(function () {
                return $(this).data('id');
            }).get();
            console.log(getDiemChiTiet);
            console.log(getId);
            document.getElementById("<%=txtArrDiemTuLuan.ClientID%>").value = getDiemChiTiet;
            document.getElementById("<%=txtArrCauHoiTuLuan.ClientID%>").value = getId;
            DisplayLoadingIcon();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Menu" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopWrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Wrapper" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomWrapper" runat="Server">
    <style>
        .heading-nhapsach {
            font-size: 40px;
            font-weight: bold;
            text-align: center;
            color: darkblue;
        }

        .table-matran tr th, .table-matran tr td {
            border: 1px solid #9d9595;
            padding: 5px;
            text-align: center
        }

        .table-matran input {
            width: 50px;
            display: inline-block;
        }
    </style>
    <div class="card section-content">
        <div class="container mt-1">
            <p class="heading-nhapsach">Tạo bài kiểm tra ngẫu nhiên</p>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div>
                        <div class="form-row">
                            <label class="col-2 col-form-label">Tên bài kiểm tra <span class="text-danger">(*)</span> :</label>
                            <div class="col-8">
                                <input type="text" class="form-control" id="txtTenBai" runat="server" />
                            </div>
                        </div>
                        <div class="form-row mt-1">
                            <label class="col-2 col-form-label">Thời gian làm bài <span class="text-danger">(*)</span>:</label>
                            <div class="form-row">
                                <div class="ml-2">
                                    <input type="text" class="form-control" id="txtThoiGian" runat="server" />
                                </div>
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="inputGroupPrepend2">phút</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-row my-1">
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddlKhoi" runat="server" CssClass="btn btn-primary" OnSelectedIndexChanged="ddlKhoi_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <asp:DropDownList ID="ddlMon" runat="server" CssClass="btn btn-primary" OnSelectedIndexChanged="ddlMon_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-4">
                                <dx:ASPxGridLookup ID="lkChuong" runat="server" SelectionMode="Multiple" ClientInstanceName="lkChuong"
                                    KeyFieldName="chapter_id" Width="300px" TextFormatString="{0}" MultiTextSeparator=", " Caption="Chương">
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" />
                                        <dx:GridViewDataColumn FieldName="chapter_name" Caption="Chương" Width="250px" />
                                        <dx:GridViewDataColumn FieldName="chapter_id" Settings-AllowAutoFilter="false" Visible="false" />
                                    </Columns>
                                    <GridViewProperties>
                                        <Templates>
                                            <StatusBar>
                                                <table class="OptionsTable" style="float: right">
                                                    <tr>
                                                        <td>
                                                            <dx:ASPxButton ID="Close" runat="server" AutoPostBack="true" Text="Chọn" ClientSideEvents-Click="CloseGridLookup" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </StatusBar>
                                        </Templates>
                                        <Settings ShowFilterRow="True" ShowStatusBar="Visible" />
                                        <SettingsPager PageSize="10" EnableAdaptivity="true" />
                                    </GridViewProperties>
                                </dx:ASPxGridLookup>
                            </div>
                            <div class="col-8">
                                <div class="row">
                                    <asp:Repeater runat="server" ID="rpLesson">
                                        <ItemTemplate>
                                            <div class="col-sm-6 col-lg-6">
                                                <label>
                                                    <input type="checkbox" id="ck_<%#Eval("lesson_id") %>" name="ckLesson" onclick="checkValue(this.value)" value="<%#Eval("lesson_id") %>">
                                                    <%#Eval("lesson_name") %>
                                                </label>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <input type="text" id="txtLessonID" runat="server" style="display: none" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <input type="radio" id="html" name="fav_language" value="1" onchange="myChange(1)">
                        <label for="html">Trắc nghiệm</label><br>
                        <input type="radio" id="css" name="fav_language" value="2" onchange="myChange(2)">
                        <label for="css">Tự luận</label><br>
                        <input type="radio" id="javascript" name="fav_language" value="3" onchange="myChange(3)">
                        <label for="javascript">Cả 2</label>
                        <br />
                    </div>

                    <div id="dv_TracNghiem" style="display: none" class="form-row">
                        <div class="mr-2">
                            Tỉ lệ ma trận của đề thi (Tỉ lệ chuẩn 4:3:2:1):
                         <table class="table-matran">
                             <tr>
                                 <th></th>
                                 <th>Nhận biết</th>
                                 <th>Thông hiểu</th>
                                 <th>Vận dụng</th>
                                 <th>Vận dụng cao</th>
                             </tr>
                             <tr>
                                 <th>Tỉ lệ</th>
                                 <th>
                                     <input type="text" class="form-control" id="txtTracNghiem_NhanBiet" onkeypress="return isNumberKey(event)" runat="server" /></th>
                                 <th>
                                     <input type="text" class="form-control" id="txtTracNghiem_ThongHieu" onkeypress="return isNumberKey(event)" runat="server" /></th>
                                 <th>
                                     <input type="text" class="form-control" id="txtTracNghiem_VanDung" onkeypress="return isNumberKey(event)" runat="server" /></th>
                                 <th>
                                     <input type="text" class="form-control" id="txtTracNghiem_VanDungCao" onkeypress="return isNumberKey(event)" runat="server" /></th>
                             </tr>
                         </table>
                        </div>
                        <div>
                            Điểm mỗi câu trắc nghiệm:
                        <asp:DropDownList ID="ddlDiem" runat="server" CssClass="form-control">
                            <asp:ListItem Value="5">0.2</asp:ListItem>
                            <asp:ListItem Value="4">0.25</asp:ListItem>
                            <asp:ListItem Value="2">0.5</asp:ListItem>
                            <asp:ListItem Value="1">1</asp:ListItem>
                        </asp:DropDownList>
                        </div>
                    </div>
                    <div id="div_LuuY" style="display: none; color: red; font-weight: 500">
                        (*)Tỉ lệ điểm ở các mức độ thuộc tự luận không được  vượt quá ma trận đề đã nhập ở phần trắc nghiệm 
                    </div>
                    <div id="dv_TuLuan" style="display: none">
                        Tự luận:
                        <table class="table-matran">
                            <tr>
                                <th></th>
                                <th>Tổng điểm
                                        <br />
                                    (không được vượt quá mức tỉ lệ ở ma trận)</th>
                                <th>Tổng số câu hỏi</th>
                            </tr>
                            <tr>
                                <th>Nhận biết</th>
                                <td>
                                    <input type="text" class="form-control" id="txtTuLuan_Diem_NhanBiet" onkeypress="return isNumberKey(event)" value="0" runat="server" />
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtTuLuan_NhanBiet" onkeypress="return isNumberKey(event)" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Thông hiểu</th>
                                <td>
                                    <input type="text" class="form-control" id="txtTuLuan_Diem_ThongHieu" onkeypress="return isNumberKey(event)" value="0" runat="server" />
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtTuLuan_ThongHieu" onkeypress="return isNumberKey(event)" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Vận dụng</th>
                                <td>
                                    <input type="text" class="form-control" id="txtTuLuan_Diem_VanDung" onkeypress="return isNumberKey(event)" value="0" runat="server" />
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtTuLuan_VanDung" onkeypress="return isNumberKey(event)" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <th>Vận dụng cao</th>
                                <td>
                                    <input type="text" class="form-control" id="txtTuLuan_Diem_VanDungCao" onkeypress="return isNumberKey(event)" value="0" runat="server" />
                                </td>
                                <td>
                                    <input type="text" class="form-control" id="txtTuLuan_VanDungCao" onkeypress="return isNumberKey(event)" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="mt-1">
                <input style="display: none" id="txtHinhThucThi" type="text" runat="server" />
                <input style="display: none" id="txtLockInsert" value="0" type="text" runat="server" />
                <asp:Button Text="Tạo bài kiểm tra" CssClass="btn btn-primary" OnClientClick="return checkNULLBai()" ID="btnLuu" runat="server" OnClick="btnLuu_Click" />
            </div>
            <div class="view-test">
                <div id="questionlist" runat="server" style="display: none">
                    <asp:Label Text="I/ Trắc nghiệm" runat="server" CssClass="title-section" />
                    <asp:Repeater runat="server" ID="rpCauHoi" OnItemDataBound="rpCauHoiDetals_ItemDataBound">
                        <ItemTemplate>
                            <div class="question-box">
                                <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                    <div class="panel-body">
                                        <div class="m-bottom question ">
                                            <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong><%#Eval("noidungcauhoi") %>
                                        </div>
                                        <div class="row answer">
                                            <div class="flex">
                                                <asp:Repeater runat="server" ID="rpCauTraLoi">
                                                    <ItemTemplate>
                                                        <div class="answer-item col-xs-6  col-md-6 col-sm-12">
                                                            <label class="radio_question">
                                                                <%#Eval("name_label") %>.&nbsp;<%#Eval("answer_content") %>
                                                            </label>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Label Text="II/ Tự luận" runat="server" CssClass="title-section" />
                    <div style="color: red; font-weight: 500">
                        (*)Tổng điểm của các câu hỏi mỗi dạng phải bằng tổng điểm tự luận của đã nhập ở trên. 
                    </div>
                    <asp:Repeater runat="server" ID="rpCauHoiTuLuan">
                        <ItemTemplate>
                            <div class="question-box">
                                <div class="panel panel-default question-item" id="<%#Eval("question_id") %>" data-question-number="<%#Eval("question_id") %>">
                                    <div class="panel-body">
                                        <div class="m-bottom question ">
                                            <strong class="text-red">Câu <%#Container.ItemIndex+1 %>:</strong><%#Eval("noidungcauhoi") %>
                                        </div>
                                    </div>
                                    Dạng câu hỏi: <%#Eval("question_dangcauhoi") %> - 
                                    Điểm chi tiết:<input type="text" name="diemchitiet_tuluan" data-type="<%#Eval("question_dangcauhoi") %>" data-id="<%#Eval("question_id") %>" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <a href="javascript:void(0)" class="btn btn-success" id="btnHoanThanh" runat="server" onclick="return getDiemChiTietTuLuan()" onserverclick="btnHoanThanh_Click">Hoàn thành</a><%-- onserverclick="btnHoanThanh_Click"--%>
                </div>
            </div>
            <input type="text" id="txtArrDiemTuLuan" runat="server" style="display: none" />
            <input type="text" id="txtArrCauHoiTuLuan" runat="server" style="display: none" />
            <%--<asp:Button Text="Hoàn thành" CssClass="btn btn-primary" OnClientClick="getDiemChiTietTuLuan()" ID="btnHoanThanh"  />--%> <%--OnClick="btnHoanThanh_Click"--%>
            <div style="display: block">
                <p class="heading-nhapsach">Danh sách đề đã tạo</p>
                <div class="row">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <input type="submit" class="btn btn-primary Xoa btnFunction" value="Xóa" onclick="confirmDel()" />
                            <asp:Button ID="btnXoa" runat="server" CssClass="invisible" OnClick="btnXoa_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="col-12">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <div class="form-group table-responsive">
                                    <dx:ASPxGridView ID="grvDeLuyenTap" runat="server" Width="100%" ClientInstanceName="grvDeLuyenTap" KeyFieldName="test_id">
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" SelectAllCheckboxMode="Page" VisibleIndex="0" Width="7%">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataColumn Caption="STT" HeaderStyle-HorizontalAlign="Center" Width="5%">
                                                <DataItemTemplate>
                                                    <%#Container.ItemIndex+1 %>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Đề" FieldName="luyentap_name" HeaderStyle-HorizontalAlign="Center" Width="15%"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Ngày tạo" FieldName="test_createdate" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Môn" FieldName="mon_name" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Khối" FieldName="khoi_name" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn Caption="Người tạo" FieldName="username_fullname" HeaderStyle-HorizontalAlign="Center" Width="10%"></dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn HeaderStyle-HorizontalAlign="Center" Width="7%">
                                                <DataItemTemplate>
                                                    <a href="/admin-de-luyen-tap-chi-tiet-<%#Eval("test_id") %>" style="color: white" id="<%#Eval("test_id") %>" class="btn btn-primary">Xem</a>
                                                </DataItemTemplate>
                                            </dx:GridViewDataColumn>
                                        </Columns>
                                        <SettingsSearchPanel Visible="true" />
                                        <SettingsBehavior AllowFocusedRow="true" />
                                        <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Gỏ từ cần tìm kiếm và enter..." />
                                        <SettingsLoadingPanel Text="Đang tải..." />
                                        <SettingsPager PageSize="10" Summary-Text="Trang {0} / {1} ({2} trang)"></SettingsPager>
                                    </dx:ASPxGridView>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="Footer" runat="Server">
</asp:Content>

