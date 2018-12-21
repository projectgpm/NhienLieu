<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="NhapKhoChiTiet.aspx.cs" Inherits="NhienLieu.bao_cao.NhapKhoChiTiet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>

    .dxflGroupCell_Material{
        padding: 0 5px;
    }
    .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > tbody > tr:first-child > .dxflGroupCell_Material > .dxflItem_Material, .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > .dxflChildInFirstRowSys > .dxflGroupCell_Material > .dxflItem_Material
    {
        padding-top: 1px;
    }
</style>
    <script type="text/javascript">
        function AdjustSize() {
            var hformThongTin = roundPanel.GetHeight();
            UpdateHeightControlInPage(gridChiTietNhapKho, hformThongTin);
        }
        function onXemBaoCaoClick() {

            gridChiTietNhapKho.Refresh();
        }
        
</script>
    <dx:ASPxRoundPanel ID="roundPanel" ClientInstanceName="roundPanel" HeaderText="BÁO CÁO NHẬP KHO CHI TIẾT" runat="server" Width="100%" ShowCollapseButton="True">
    <HeaderStyle Font-Bold="true" />
        <ClientSideEvents  CollapsedChanged="AdjustSize"/> 
        <PanelCollection>
        <dx:PanelContent>
            <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%" ColCount="3" ColumnCount="3">
                    <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                    <Items>
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
                        <dx:LayoutItem Caption="Xem báo cáo" ColSpan="1" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <table style="margin: 0 auto;">
                                        <tr>
                                            <td style="padding-right: 10px">
                                                <dx:ASPxButton ID="btnXemBaoCao" runat="server" AutoPostBack="False" Text="Xem báo cáo">
                                        <ClientSideEvents Click="onXemBaoCaoClick" />
                                    </dx:ASPxButton>
                                            </td>
                                            <td>
                                                    <dx:ASPxButton ID="btnXuatExcel" runat="server" OnClick="btnXuatExcel_Click" Text="Xuất excel">
                                    </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        
                </Items>
                <Styles>
                    <LayoutItem>
                        <Paddings PaddingTop="0px" />
                    </LayoutItem>
                </Styles>
            </dx:ASPxFormLayout>
            </dx:PanelContent>
    </PanelCollection>
</dx:ASPxRoundPanel>
    
<dx:ASPxGridView ID="gridChiTietNhapKho" ClientInstanceName="gridChiTietNhapKho" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTietNhapKho" Width="100%" OnCustomColumnDisplayText="gridChiTietNhapKho_CustomColumnDisplayText">
    <Settings VerticalScrollBarMode="Auto" ShowFilterRow="True" ShowFooter="True"/>
    <SettingsCommandButton>
        <ShowAdaptiveDetailButton ButtonType="Image">
        </ShowAdaptiveDetailButton>
        <HideAdaptiveDetailButton ButtonType="Image">
        </HideAdaptiveDetailButton>
    </SettingsCommandButton>
    <SettingsResizing ColumnResizeMode="NextColumn" />
    <SettingsText HeaderFilterCancelButton="Hủy" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" PopupEditFormCaption="Cập nhật mã hóa đơn"  EmptyDataRow="Không có dữ liệu" CommandCancel="Hủy" ConfirmDelete="Bạn có chắc chắn muốn xóa?" HeaderFilterFrom="Từ" HeaderFilterLastMonth="Tháng trước" HeaderFilterLastWeek="Tuần trước" HeaderFilterLastYear="Năm trước" HeaderFilterNextMonth="Tháng sau" HeaderFilterNextWeek="Tuần sau" HeaderFilterNextYear="Năm sau" HeaderFilterOkButton="Lọc" HeaderFilterSelectAll="Chọn tất cả" HeaderFilterShowAll="Tất cả" HeaderFilterShowBlanks="Trống" HeaderFilterShowNonBlanks="Không trống" HeaderFilterThisMonth="Tháng này" HeaderFilterThisWeek="Tuần này" HeaderFilterThisYear="Năm nay" HeaderFilterTo="Đến" HeaderFilterToday="Hôm nay" HeaderFilterTomorrow="Ngày mai" HeaderFilterYesterday="Ngày hôm qua" />
<SettingsAdaptivity AdaptivityMode="HideDataCells">
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>

    <SettingsPager PageSize="20">
        <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
    </SettingsPager>

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
    <Columns>
        <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" VisibleIndex="0">
            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Ký hiệu" FieldName="MaNhienLieu" VisibleIndex="1">
            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Tên vật tư" FieldName="TenNhienLieu" VisibleIndex="3">
            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="ĐVT" FieldName="TenDonViTinh" VisibleIndex="4">
            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataDateColumn Caption="Ngày lập phiếu" FieldName="NgayLapPhieu" VisibleIndex="8">
            <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
            </PropertiesDateEdit>
            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataSpinEditColumn Caption="Thành tiền" CellStyle-Font-Bold="true" FieldName="ThanhTien" VisibleIndex="7">
            <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N0" NumberFormat="Custom">
            </PropertiesSpinEdit>
            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />

<CellStyle Font-Bold="True"></CellStyle>
        </dx:GridViewDataSpinEditColumn>
        <dx:GridViewDataSpinEditColumn Caption="Đơn giá" FieldName="GiaNhap" VisibleIndex="6">
            <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="n2" NumberFormat="Custom">
            </PropertiesSpinEdit>
            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
        </dx:GridViewDataSpinEditColumn>
        <dx:GridViewBandColumn Caption="Số lượng" VisibleIndex="5">
            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            <Columns>
                <dx:GridViewDataSpinEditColumn Caption="Thực nhập" FieldName="SoLuong" ShowInCustomizationForm="True" VisibleIndex="1">
                    <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="n2" NumberFormat="Custom">
                    </PropertiesSpinEdit>
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                </dx:GridViewDataSpinEditColumn>
                <dx:GridViewDataSpinEditColumn Caption="Theo C.từ" FieldName="SoLuong" ShowInCustomizationForm="True" VisibleIndex="0">
                    <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="n2" NumberFormat="Custom">
                    </PropertiesSpinEdit>
                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                </dx:GridViewDataSpinEditColumn>
            </Columns>
        </dx:GridViewBandColumn>
        <dx:GridViewDataTextColumn Caption="Bến" FieldName="Ben" VisibleIndex="2">
            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
        </dx:GridViewDataTextColumn>
    </Columns>
         
    <TotalSummary>
        <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="ThanhTien" ShowInColumn="Thành tiền" SummaryType="Sum" />
        <dx:ASPxSummaryItem DisplayFormat="{0:N2}" FieldName="SLTheoChungTu" ShowInColumn="Số lượng theo C.từ" SummaryType="Sum" />
        <dx:ASPxSummaryItem DisplayFormat="{0:N2}" FieldName="SLThucNhap" ShowInColumn="Số lượng thực nhập" SummaryType="Sum" />
        <dx:ASPxSummaryItem DisplayFormat="Tổng mặt hàng: {0:n0}" FieldName="ID" ShowInColumn="Tên vật tư" SummaryType="Count" />
    </TotalSummary>
    <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="SLThucNhap" Expression="[SLThucNhap] < [SLTheoChungTu]" Format="LightRedFillWithDarkRedText" />
        <dx:GridViewFormatConditionHighlight FieldName="SLThucNhap" Expression="[SLThucNhap] = [SLTheoChungTu]" Format="GreenFillWithDarkGreenText" />
    </FormatConditions>
    <Styles>
        <Footer Font-Bold="True">
        </Footer>
    </Styles>

</dx:ASPxGridView>
<asp:SqlDataSource ID="dsChiTietNhapKho" runat="server" 
        ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" 
        SelectCommand="rp_nhapkho" SelectCommandType="StoredProcedure">
     <SelectParameters>
        <asp:ControlParameter ControlID="roundPanel$formThongTin$fromDay" Name="TuNgay" PropertyName="Value" Type="DateTime" />
        <asp:ControlParameter ControlID="roundPanel$formThongTin$toDay" Name="DenNgay" PropertyName="Value" Type="DateTime" />
    </SelectParameters>
</asp:SqlDataSource>
<dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
    <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
</dx:ASPxGlobalEvents>
<dx:ASPxGridViewExporter ID="exporterGrid" runat="server" GridViewID="gridChiTietNhapKho">
</dx:ASPxGridViewExporter>
</asp:Content>
