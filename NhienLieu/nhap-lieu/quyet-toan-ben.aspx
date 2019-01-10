<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="quyet-toan-ben.aspx.cs" Inherits="NhienLieu.nhap_lieu.quyet_toan_ben" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function AdjustSize() {
            var hformThongTin = form_BQT.GetHeight();
            UpdateHeightControlInPage(gridQuyetToan, hformThongTin);
        }
        let LapBang = () => {
            if (cbb_Ben.GetSelectedIndex() == -1) {
                baoloi('Vui lòng chọn bến!');
                return;
            }
            cbp_BQT.PerformCallback('LapPhieu');
        }
        let EndCallBack = (s, e) => {}

        let onUnitReturnChanged = (s,e,key) => {
            console.log(s.name);
            let index = s.name.lastIndexOf('_'); // lấy index
            let sub = s.name.substr(index + 1, s.name.length - index); //cắt chuỗi
            cbp_BQT.PerformCallback(`UnitChange|${key}|${sub}`);
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
                                    <dx:ASPxDateEdit ID="fromDay" runat="server" AllowNull="False" ClientInstanceName="fromDay" OnInit="dateEditControl_Init" Width="100%">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="đến ngày" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="toDay" runat="server" AllowNull="False" ClientInstanceName="toDay" OnInit="dateEditControl_Init" Width="100%">
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
                <dx:ASPxVerticalGrid ID="gridQuyetToan" ClientInstanceName="gridQuyetToan" runat="server" Width="100%" AutoGenerateRows="False" KeyFieldName="ID">
                    <Rows>
                        <dx:VerticalGridTextRow FieldName="TenPha" VisibleIndex="0" Caption="Chỉ tiêu">
                        </dx:VerticalGridTextRow>
                        <dx:VerticalGridTextRow FieldName="TongTua" ReadOnly="True" VisibleIndex="2" Caption="I. TUA">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                            <Rows>
                                <dx:VerticalGridTextRow Caption="1. Tua ngày" FieldName="TuaNgay" ReadOnly="True" VisibleIndex="0">
                                    <PropertiesTextEdit DisplayFormatString="N2">
                                    </PropertiesTextEdit>
                                </dx:VerticalGridTextRow>
                                <dx:VerticalGridTextRow Caption="2. Tua đêm" FieldName="TuaDem" ReadOnly="True" VisibleIndex="1">
                                    <PropertiesTextEdit DisplayFormatString="N2">
                                    </PropertiesTextEdit>
                                </dx:VerticalGridTextRow>
                            </Rows>
                            <HeaderStyle Font-Bold="True" />
                            <RecordStyle Font-Bold="True">
                            </RecordStyle>
                        </dx:VerticalGridTextRow>
                        <dx:VerticalGridTextRow FieldName="DinhMuc" ReadOnly="True" VisibleIndex="1" Caption="Định mức">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                            <HeaderStyle Font-Bold="True" Font-Italic="True" HorizontalAlign="Center" />
                            <RecordStyle Font-Italic="True">
                            </RecordStyle>
                        </dx:VerticalGridTextRow>
                        <dx:VerticalGridSpinEditRow Caption="II. Dầu D.O (Lít)" FieldName="TongDau" VisibleIndex="6">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <Rows>
                                <dx:VerticalGridSpinEditRow Caption="2. Bơm nước vệ sinh phà" FieldName="BomNuoc" VisibleIndex="1">
                                    <PropertiesSpinEdit DisplayFormatString="g">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="se_bomnuoc" runat="server" AllowNull="false" ClientInstanceName="se_bomnuoc" ClientEnabled="true" DisplayFormatString="N2" HorizontalAlign="Right" MaxValue="10000000000000000000000000" MinValue="0" Number='<%# Convert.ToDouble(Eval("BomNuoc")) %>' OnInit="sp_Init">
                                            <SpinButtons ShowIncrementButtons="false">
                                            </SpinButtons>
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:VerticalGridSpinEditRow>
                                <dx:VerticalGridSpinEditRow Caption="3. Máy phát trên phà" FieldName="MayPhat" VisibleIndex="2">
                                    <PropertiesSpinEdit DisplayFormatString="g">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="se_mayphat" runat="server" AllowNull="false" DisplayFormatString="N2" HorizontalAlign="Right" MaxValue="10000000000000000000000000" MinValue="0" Number='<%# Convert.ToDouble(Eval("MayPhat")) %>' OnInit="sp_Init">
                                            <SpinButtons ShowIncrementButtons="false">
                                            </SpinButtons>
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:VerticalGridSpinEditRow>
                                <dx:VerticalGridSpinEditRow Caption="4. Công tác" FieldName="CongTac" VisibleIndex="3">
                                    <PropertiesSpinEdit DisplayFormatString="g">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="se_congtac" runat="server" AllowNull="false" DisplayFormatString="N2" HorizontalAlign="Right" MaxValue="10000000000000000000000000" MinValue="0" Number='<%# Convert.ToDouble(Eval("CongTac")) %>' OnInit="sp_Init">
                                            <SpinButtons ShowIncrementButtons="false">
                                            </SpinButtons>
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:VerticalGridSpinEditRow>
                                <dx:VerticalGridSpinEditRow Caption="1. Vận chuyển" FieldName="VanChuyen" ReadOnly="True" VisibleIndex="0">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <Rows>
                                        <dx:VerticalGridSpinEditRow Caption="- Ngày" FieldName="VCNgay" ReadOnly="True" VisibleIndex="0">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                        </dx:VerticalGridSpinEditRow>
                                        <dx:VerticalGridSpinEditRow Caption="- Đêm" FieldName="VCDem" ReadOnly="True" VisibleIndex="1">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                        </dx:VerticalGridSpinEditRow>
                                    </Rows>
                                    <HeaderStyle Font-Bold="False" />
                                </dx:VerticalGridSpinEditRow>
                            </Rows>
                            <HeaderStyle Font-Bold="True" />
                            <RecordStyle Font-Bold="True">
                            </RecordStyle>
                        </dx:VerticalGridSpinEditRow>
                        <dx:VerticalGridSpinEditRow Caption="III. Nhớt (Lít)" FieldName="TongNhot" VisibleIndex="7">
                            <PropertiesSpinEdit DisplayFormatString="g">
                            </PropertiesSpinEdit>
                            <Rows>
                                <dx:VerticalGridSpinEditRow Caption="1. Châm máy" FieldName="ChamMay" VisibleIndex="0">
                                    <PropertiesSpinEdit DisplayFormatString="N2">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="se_chammay" runat="server" AllowNull="false" NumberType="Float" DisplayFormatString="N2" HorizontalAlign="Right" MaxValue="100000000000" MinValue="0" Number='<%# Convert.ToDouble(Eval("ChamMay")) %>' OnInit="sp_Init">
                                            <SpinButtons ShowIncrementButtons="false">
                                            </SpinButtons>
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:VerticalGridSpinEditRow>
                                <dx:VerticalGridSpinEditRow Caption="2. Thay máy" FieldName="ThayMay" VisibleIndex="1">
                                    <PropertiesSpinEdit DisplayFormatString="N2">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="se_thaymay" runat="server" AllowNull="false" NumberType="Float" DisplayFormatString="N2" HorizontalAlign="Right" MaxValue="100000000000" MinValue="0" Number='<%# Convert.ToDouble(Eval("ThayMay")) %>' OnInit="sp_Init">
                                            <SpinButtons ShowIncrementButtons="false">
                                            </SpinButtons>
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:VerticalGridSpinEditRow>
                            </Rows>
                            <HeaderStyle Font-Bold="True" />
                            <RecordStyle Font-Bold="True">
                            </RecordStyle>
                        </dx:VerticalGridSpinEditRow>
                    </Rows>
                    <Settings ShowSummaryPanel="True" />
                    <SettingsPager Mode="ShowPager" PageSize="10"></SettingsPager>
                    <TotalSummary>
                        <dx:ASPxVerticalGridSummaryItem FieldName="TuaNgay" SummaryType="Sum" />
                    </TotalSummary>
                </dx:ASPxVerticalGrid>
                <asp:SqlDataSource ID="dsQuyetToan" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="pr_QuyetToanBen" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbp_BQT$form_BQT$fromDay" Name="TuNgay" PropertyName="Value" Type="DateTime" />
                        <asp:ControlParameter ControlID="cbp_BQT$form_BQT$toDay" Name="DenNgay" PropertyName="Value" Type="DateTime" />
                        <asp:ControlParameter ControlID="cbp_BQT$form_BQT$cbb_Ben" Name="BenID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
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
        <ClientSideEvents EndCallback="EndCallBack" />
    </dx:ASPxCallbackPanel>
</asp:Content>
