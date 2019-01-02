<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="lap-bang-quyet-toan.aspx.cs" Inherits="NhienLieu.nhap_lieu.lap_bang_quyet_toan" %>
<asp:Content ID="BangQuyetToan" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function AdjustSize() {
             var hformThongTin = form_BQT.GetHeight();
             UpdateHeightControlInPage(gridBangQuyetToan, hformThongTin);
         }
        let LapBang = () => {
            if (cbb_Ben.GetSelectedIndex() == -1) {
                baoloi('Vui lòng chọn bến!');
                return;
            }
            cbp_BQT.PerformCallback('LapPhieu');
        }
    </script>
    <dx:ASPxCallbackPanel ID="cbp_BQT" ClientInstanceName="cbp_BQT" runat="server" Width="100%" OnCallback="cbp_BQT_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <dx:ASPxFormLayout ID="form_BQT" ClientInstanceName="form_BQT" runat="server" ColCount="4" ColumnCount="4" Width="100%">
                    <Items>
                        <dx:LayoutItem Caption="Bến" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cbb_Ben" ClientInstanceName="cbb_Ben" runat="server" DataSourceID="dsBen" TextField="TenBen" ValueField="ID" Width="100%">
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="dsBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Từ ngày" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="fromDay" runat="server" AllowNull="False" ClientInstanceName="fromDay" OnInit="dateEditControl_Init">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="đến ngày" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="toDay" runat="server" AllowNull="False" ClientInstanceName="toDay" OnInit="dateEditControl_Init">
                                        <DateRangeSettings StartDateEditID="fromDay" />
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="btnOK" ClientInstanceName="btnOK" runat="server" Text="LẬP BẢNG" AutoPostBack="false">
                                        <ClientSideEvents Click="LapBang" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
                <dx:ASPxGridView ID="gridBangQuyetToan" runat="server" Width="100%" ClientInstanceName="gridBangQuyetToan" KeyFieldName="ID">
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="1">
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <SettingsPager PageSize="25">
                    </SettingsPager>
                    <EditFormLayoutProperties ColCount="1">
                    </EditFormLayoutProperties>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsBangQuyetToan" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="pr_BangQuyetToan" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbp_BQT$form_BQT$fromDay" Name="TuNgay" PropertyName="Value" Type="DateTime" />
                        <asp:ControlParameter ControlID="cbp_BQT$form_BQT$toDay" Name="DenNgay" PropertyName="Value" Type="DateTime" />
                        <asp:ControlParameter ControlID="cbp_BQT$form_BQT$cbb_Ben" Name="BenID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
                    <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
                </dx:ASPxGlobalEvents>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

</asp:Content>
