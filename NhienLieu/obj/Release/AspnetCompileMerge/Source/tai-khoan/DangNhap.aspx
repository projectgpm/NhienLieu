<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="NhienLieu.tai_khoan.DangNhap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
       
        html {
            height: 100%
        }
    </style>
    <script>
        function lblBanQuyenOnClick() {
            pcBanQuyen.Show();
        }
        function btnDangKyClick() {
            if (ASPxClientEdit.ValidateGroup('entryGroupBanQuyen')) {

                cbpBanQuyen.PerformCallback('kichhoat');
            }
        }
        function lammoilogin(s,e) {
            ASPxClientEdit.ClearGroup('entryGroup');
            tbLogin.Focus();
            s.UpdatePosition();
            lblBanQuyen.SetText('');
            lblError.SetText('');
        }
    </script>
</head>
<body>
    <form id="form_DangNhap" runat="server">
    <dx:ASPxPopupControl ID="pcLogin" ClientInstanceName="pcLogin" runat="server"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        ShowOnPageLoad="true" ShowCloseButton="False" CloseAction="None"
        PopupAction="None" FooterText="© 2018" Width="250px" 
        HeaderText="QUẢN LÝ NHIÊN LIỆU" ShowFooter="False">
        <HeaderImage Url="~/images/gpmvn.png" Width="100px">
        </HeaderImage>
        <ClientSideEvents PopUp="function(s, e) { ASPxClientEdit.ClearGroup('entryGroup'); tbLogin.Focus(); s.UpdatePosition(); }" />
        <FooterStyle HorizontalAlign="Center" BackColor="#009688" Font-Names="&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif" ForeColor="White" />
        <HeaderStyle BackColor="#009688" Font-Bold="True" ForeColor="White" Font-Names="&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif" Font-Size="Large" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server">
                    <Items>
                        <dx:LayoutItem Caption="Tên đăng nhập" VerticalAlign="Top">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="tbLogin" runat="server" ClientInstanceName="tbLogin">
                                    <ValidationSettings EnableCustomValidation="True" ValidationGroup="entryGroup" SetFocusOnError="True"
                                        ErrorDisplayMode="Text" ErrorTextPosition="Bottom" CausesValidation="True">
                                        <RequiredField ErrorText="Chưa nhập tên đăng nhập" IsRequired="True" />
                                        <RegularExpression ErrorText="Chưa nhập tên đăng nhập" />
                                        <ErrorFrameStyle Font-Size="10px">
                                            <ErrorTextPaddings PaddingLeft="0px" />
                                        </ErrorFrameStyle>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Mật khẩu">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="tbPassword" runat="server" Password="True">
                                        <ValidationSettings EnableCustomValidation="True" ValidationGroup="entryGroup" SetFocusOnError="True"
                                            ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                            <RequiredField ErrorText="Chưa nhập mật khẩu" IsRequired="True" />
                                            <ErrorFrameStyle Font-Size="10px">
                                                <ErrorTextPaddings PaddingLeft="0px" />
                                            </ErrorFrameStyle>
                                        </ValidationSettings>
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxCheckBox ID="chbRemember" runat="server" Text="Ghi nhớ đăng nhập">
                                    </dx:ASPxCheckBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem HorizontalAlign="Center" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="btOK" runat="server" Text="Đăng nhập" Width="150px" AutoPostBack="True" OnClick="btOK_Click">
                                        <ClientSideEvents Click="function(s, e) { if(!ASPxClientEdit.ValidateGroup('entryGroup')) e.processOnServer = false; }" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxLabel ID="lblError" ClientInstanceName="lblError" runat="server" ForeColor="Red">
                                    </dx:ASPxLabel>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                    <dx:ASPxLabel ID="lblBanQuyen" ClientInstanceName="lblBanQuyen" runat="server" ForeColor="Red">
                                        <ClientSideEvents Click="lblBanQuyenOnClick" />
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
    </form>

</body>
</html>
