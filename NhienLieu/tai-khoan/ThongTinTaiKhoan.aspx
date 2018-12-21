<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ThongTinTaiKhoan.aspx.cs" Inherits="KobePaint.Pages.TaiKhoan.ThongTinTaiKhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function OnSubmitClick(s, e) {
            console.log()
            if (!ASPxClientEdit.ValidateGroup('entryGroup')) e.processOnServer = false;
        }
    </script>
    <dx:ASPxPopupControl ID="pcLogin" ClientInstanceName="pcLogin" runat="server"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        HeaderText="THÔNG TIN TÀI KHOẢN" ShowOnPageLoad="true" Modal="true" CloseAction="CloseButton" ShowCloseButton="true"  PopupAction="None"  Width="500px">
        <ClientSideEvents PopUp="function(s, e) { s.UpdatePosition(); }" />
        <HeaderStyle BackColor="#009688" Font-Bold="True" ForeColor="White" Font-Names="&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif" Font-Size="Large" />
        <FooterStyle HorizontalAlign="Center" />
        <%--  <HeaderImage Url="~/images/gpmvn.png" Width="100px">
        </HeaderImage>--%>
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxFormLayout ID="formLayout" runat="server" Width="100%" DataSourceID="TKDataSource">
                    <Items>
                        <dx:LayoutItem FieldName="HoTen" Caption="Họ tên">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblHoTen" runat="server">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem FieldName="TenNhom" Caption="Nhóm">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server" SupportsDisabledAttribute="True">
                                    <dx:ASPxLabel ID="txtNhom" runat="server">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem FieldName="TenDangNhap" Caption="Tên đăng nhập">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server" SupportsDisabledAttribute="True">
                                    <dx:ASPxLabel ID="lblTenDangNhap" runat="server">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>                        
                        <dx:LayoutItem Caption="Mật khẩu mới">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbPass1" runat="server" Width="100%" ClientInstanceName="pass1"
                                            Password="True">
                                            <ValidationSettings EnableCustomValidation="True" ValidationGroup="entryGroup"
                                                SetFocusOnError="True" ErrorDisplayMode="Text"
                                                ErrorTextPosition="Bottom" Display="Dynamic">
                                                <RequiredField IsRequired="True" ErrorText="Password is required" />
                                                <ErrorFrameStyle Font-Size="10px">
                                                    <ErrorTextPaddings PaddingLeft="0px" />
                                            </ErrorFrameStyle>
                                        </ValidationSettings>
                                            
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Xác nhận mật khẩu">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbConfPass2" runat="server" Width="100%" ClientInstanceName="pass2" Password="True">
                                        <clientsideevents validation="function(s, e) { e.isValid = (pass1.GetText()==pass2.GetText()); }" />
                                        <validationsettings display="Dynamic" enablecustomvalidation="True" errordisplaymode="Text" errortext="Password is incorrect" errortextposition="Bottom" setfocusonerror="True" validationgroup="entryGroup">
                                            <errorframestyle font-size="10px">
                                                <errortextpaddings paddingleft="0px" />
                                            </errorframestyle>
                                            <requiredfield errortext="Please, confirm your password" isrequired="True" />
                                        </validationsettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem FieldName="DienThoai" Caption="Điện thoại">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server" SupportsDisabledAttribute="True">
                                    <dx:ASPxTextBox ID="tbPhone" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem FieldName="DiaChi" Caption="Địa chỉ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbDiaChi" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="btOK" runat="server" Text="Cập nhật" Width="150px" OnClick="btOK_Click">
                                        <ClientSideEvents Click="OnSubmitClick" />                                    
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblError" runat="server" ForeColor="Red">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>

            </dx:PopupControlContentControl>
        </ContentCollection>
        <ContentStyle>
            <Paddings PaddingBottom="5px" />
        </ContentStyle>
    </dx:ASPxPopupControl>
    <dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	            pcLogin.UpdatePosition();
            }" />
    </dx:ASPxGlobalEvents>
    <asp:SqlDataSource ID="TKDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BanHangVietConnectionString %>" 
        SelectCommand="SELECT nvNhanVien.IDNhanVien, nvNhanVien.TenDangNhap, nvNhanVien.MatKhau, nvNhanVien.HoTen, nvNhanVien.DienThoai, nvNhanVien.DiaChi, nvNhom.IDNhom, nvNhom.TenNhom FROM nvNhanVien INNER JOIN nvNhom ON nvNhanVien.NhomID = nvNhom.IDNhom WHERE (nvNhanVien.IDNhanVien = @IDNhanVien)">
        <SelectParameters>
            <asp:Parameter Name="IDNhanVien" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
