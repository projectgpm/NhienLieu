<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="KhaiBaoTuaChuyen.aspx.cs" Inherits="NhienLieu.nhap_lieu.KhaiBaoTuaChuyen" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">

        let Check = () => {
            if (cbBen.lastSuccessValue == null) {
                baoloi('Vui lòng chọn bến!');
                return false;
            }
            if (cbThang.lastSuccessValue == null) {
                baoloi('Vui lòng chọn tháng!');
                return false;
            }
            if (cbKy.lastSuccessValue == null) {
                baoloi('Vui lòng chọn kỳ!');
                return false;
            }
            return true;
        }
        let OnCallBack = () => {
            if (Check())
                cbpTuaChuyen.PerformCallback();
        }
        let EndCallBack = (s, e) => {
            gridTuaChuyen.ReFresh();
        }
    </script>
    <dx:ASPxCallbackPanel ID="cbpTuaChuyen" ClientInstanceName="cbpTuaChuyen" runat="server" Width="100%" OnCallback="cbpTuaChuyen_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
                

    <dx:ASPxFormLayout ID="fl_khaibao" ClientInstanceName="fl_khaibao" runat="server" ColCount="4" ColumnCount="4" Height="43px" Width="100%">
        <Items>
            <dx:LayoutItem Caption="Chọn bến" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox ID="cbBen" runat="server" ClientInstanceName="cbBen" DataSourceID="SqlDataSourceBen" NullText="-- Chọn bến --" TextField="TenBen" ValueField="ID" Width="100%">
                        </dx:ASPxComboBox>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem Caption="Chọn tháng" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox ID="cbThang" runat="server" ClientInstanceName="cbThang" Width="100%">
                        </dx:ASPxComboBox>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem Caption="Kỳ" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox ID="cbKy" runat="server" ClientInstanceName="cbKy" Width="100%">
                            <Items>
                                <dx:ListEditItem Text="Đầu kỳ (từ ngày 01 -&gt; 10)" Value="0" />
                                <dx:ListEditItem Text="Giữa kỳ (từ ngày 11 -&gt; 20)" Value="1" />
                                <dx:ListEditItem Text="Cuối kỳ (còn lại)" Value="2" />
                            </Items>
                        </dx:ASPxComboBox>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem Caption="" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton ID="btnXem" runat="server" AutoPostBack="False" Text="NHẬP LIỆU" Width="50%">
                            <ClientSideEvents Click="OnCallBack" />
                        </dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
        </Items>
    </dx:ASPxFormLayout>
                <dx:ASPxVerticalGrid ID="gridTuaChuyen" ClientInstanceName="gridTuaChuyen" runat="server" AutoGenerateRows="False" Width="100%" DataSourceID="SqlDataSourceChamCong">               
                    
                    
                    <Rows>
                        <dx:VerticalGridTextRow FieldName="TenPha" VisibleIndex="0">
                        </dx:VerticalGridTextRow>
                        <dx:VerticalGridTextRow FieldName="Ca2" VisibleIndex="1">
                        </dx:VerticalGridTextRow>
                        <dx:VerticalGridTextRow FieldName="Ca1" VisibleIndex="2">
                        </dx:VerticalGridTextRow>
                    </Rows>
<SettingsPager Mode="ShowPager"></SettingsPager>
                    
                    
                </dx:ASPxVerticalGrid>
                <asp:SqlDataSource ID="SqlDataSourcePha" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenPha] FROM [Pha]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceChamCong" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT ChamCong.PhaID, ChamCong.Ca2, ChamCong.Ca1, Pha.TenPha + '(' + Pha.SoPhaCu + ')' AS TenPha FROM ChamCong INNER JOIN Pha ON ChamCong.PhaID = Pha.ID INNER JOIN Ben ON Pha.BenID = Ben.ID WHERE (Ben.ID = @BenID)">
                    <SelectParameters>
                        <asp:Parameter Name="BenID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>   

            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents EndCallback="EndCallBack" />
    </dx:ASPxCallbackPanel>

</asp:Content>
