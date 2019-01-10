<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="tua-chuyen.aspx.cs" Inherits="NhienLieu.nhap_lieu.tua_chuyen.index" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
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
                cbpBtn.PerformCallback();
        }
    </script>

    <dx:ASPxCallbackPanel ID="cbpBtn" ClientInstanceName="cbpBtn" runat="server" Width="100%" OnCallback="cbpBtn_Callback">
        <PanelCollection>
<dx:PanelContent runat="server">
    <dx:ASPxFormLayout ID="fl_khaibao" runat="server" ColCount="5" ColumnCount="5" Height="43px" Width="100%">
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
            <dx:LayoutItem Caption="Chọn năm" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox ID="cbNam" runat="server" ClientInstanceName="cbNam">
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
      
<dx:ASPxGridView ID="gridChamCong" runat="server" AutoGenerateColumns="False" KeyFieldName="TT" Width="100%" OnRowUpdating="gridChamCong_RowUpdating" SettingsBehavior-AllowDragDrop="False" OnInit="gridChamCong_Init">
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>
        <SettingsPager PageSize="15">
        </SettingsPager>

        <SettingsEditing EditFormColumnCount="1" Mode="Batch">
        </SettingsEditing>
        <SettingsBehavior AllowDragDrop="False" AllowGroup="False" />
        <SettingsCommandButton>
            <UpdateButton Text="Lưu">
                <Image IconID="save_save_32x32">
                </Image>
            </UpdateButton>
            <CancelButton Text="Làm lại">
                <Image IconID="actions_refresh2_32x32">
                </Image>
            </CancelButton>
        </SettingsCommandButton>

    <SettingsText EmptyDataRow="Chưa có dữ liệu" EmptyHeaders=" " />

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
    <Columns>
        <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0">
        </dx:GridViewCommandColumn>
    </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSourcePha" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenPha] FROM [Pha]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceChamCong" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT ChamCong.PhaID, ChamCong.Ca2, ChamCong.Ca1 FROM ChamCong INNER JOIN Pha ON ChamCong.PhaID = Pha.ID INNER JOIN Ben ON Pha.BenID = Ben.ID WHERE (Ben.ID = @BenID)">
        <SelectParameters>
            <asp:Parameter Name="BenID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>   
          </dx:PanelContent>
</PanelCollection>
    </dx:ASPxCallbackPanel>
    </asp:Content>
