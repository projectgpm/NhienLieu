<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="NhapXuatTon.aspx.cs" Inherits="NhienLieu.bao_cao.NhapXuatTon" %>

<%@ Register Assembly="DevExpress.XtraReports.v18.1.Web.WebForms, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
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
             var hformThongTin = formThongTin.GetHeight();
             UpdateHeightControlInPage(gridNhapXuatTon, hformThongTin);
         }
         function onXemBaoCaoClick() {
             gridNhapXuatTon.Refresh();
         }
        
         function endCallBackProduct(s, e) {
             //gridNhapXuatTon.Refresh();
         }
         function onReviewClick() {
             cbpInfo.PerformCallback('Review')
         }
         function cbpInfoEndCallback(s, e) {
             if (s.cp_rpView) {
                 hdfViewReport.Set('view', '1');
                 popupViewReport.Show();
                 reportViewer.GetViewer().Refresh();
                 delete (s.cp_rpView);
             }
         }
    </script>
     <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
            <PanelCollection>
                <dx:PanelContent ID="PanelContent2" runat="server">
                    <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
            <Items>
                <dx:LayoutGroup Caption="Báo cáo Nhập - Xuất - Tồn" ColCount="6" HorizontalAlign="Center" GroupBoxDecoration="HeadingLine" ColumnCount="6">
                    <Items>
                        <dx:LayoutItem Caption="Bến">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                    <dx:ASPxComboBox ID="cbbBen" ClientInstanceName="cbbBen" runat="server" DataSourceID="SqlDataSourceBen" TextField="TenBen" SelectedIndex="0" ValueField="ID" Width="100%">
                                        </dx:ASPxComboBox>
                                        <asp:SqlDataSource ID="SqlDataSourceBen" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" 
                                            SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Từ ngày">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                                    <dx:ASPxDateEdit ID="fromDay" AllowNull="false" ClientInstanceName="fromDay" runat="server" OnInit="dateEditControl_Init">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="đến ngày">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                    <dx:ASPxDateEdit ID="toDay" AllowNull="false" ClientInstanceName="toDay" runat="server" OnInit="dateEditControl_Init">
                                        <DateRangeSettings StartDateEditID="fromDay" />
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Xem báo cáo" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                    <dx:ASPxButton ID="btnXemBaoCao" runat="server" Text="Xem báo cáo" AutoPostBack="false">
                                        <ClientSideEvents Click="onXemBaoCaoClick" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Xuất excel" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                    <dx:ASPxButton ID="btnXuatExcel" runat="server" Text="Xuất excel" OnClick="btnXuatExcel_Click">
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="In phiếu" ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer6" runat="server">
                                    <dx:ASPxButton ID="btnInPhieu" runat="server" Text="In phiếu" AutoPostBack="false" >
                                        <ClientSideEvents Click="onReviewClick" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                    <SettingsItemCaptions Location="Left" />
                </dx:LayoutGroup>
            </Items>
            <Styles>
                <LayoutItem>
                    <Paddings PaddingTop="0px" />
                </LayoutItem>
            </Styles>
        </dx:ASPxFormLayout>
              </dx:PanelContent>
        </PanelCollection>
         <ClientSideEvents EndCallback="cbpInfoEndCallback" />
    </dx:ASPxCallbackPanel>
    <dx:ASPxGridView ID="gridNhapXuatTon" ClientInstanceName="gridNhapXuatTon" runat="server" AutoGenerateColumns="False" DataSourceID="dsNhapXuatTon" KeyFieldName="ID" Width="100%" OnCustomColumnDisplayText="grid_CustomColumnDisplayText">
        <Settings VerticalScrollBarMode="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" ShowHeaderFilterButton="True" HorizontalScrollBarMode="Visible"/>
        <SettingsBehavior ColumnResizeMode="Control" />
        <SettingsBehavior AllowFixedGroups="true" AutoExpandAllGroups="true" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
        </SettingsCommandButton>
        <SettingsBehavior AllowEllipsisInText="true" />
        <SettingsText HeaderFilterCancelButton="Hủy" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" PopupEditFormCaption="Cập nhật mã hóa đơn"  EmptyDataRow="Không có dữ liệu" CommandCancel="Hủy" ConfirmDelete="Bạn có chắc chắn muốn xóa?" HeaderFilterFrom="Từ" HeaderFilterLastMonth="Tháng trước" HeaderFilterLastWeek="Tuần trước" HeaderFilterLastYear="Năm trước" HeaderFilterNextMonth="Tháng sau" HeaderFilterNextWeek="Tuần sau" HeaderFilterNextYear="Năm sau" HeaderFilterOkButton="Lọc" HeaderFilterSelectAll="Chọn tất cả" HeaderFilterShowAll="Tất cả" HeaderFilterShowBlanks="Trống" HeaderFilterShowNonBlanks="Không trống" HeaderFilterThisMonth="Tháng này" HeaderFilterThisWeek="Tuần này" HeaderFilterThisYear="Năm nay" HeaderFilterTo="Đến" HeaderFilterToday="Hôm nay" HeaderFilterTomorrow="Ngày mai" HeaderFilterYesterday="Ngày hôm qua" />
        <SettingsAdaptivity>
        <AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
        </SettingsAdaptivity>
        <SettingsPager PageSize="50" Mode="EndlessPaging">
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="Tên vật tư" VisibleIndex="1" FieldName="TenNhienLieu" Width="200px" FixedStyle="Left">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Ký hiệu" VisibleIndex="2" FieldName="MaNhienLieu" Width="100px" FixedStyle="Left">
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="STT" VisibleIndex="0" Width="40px" FieldName="ID" FixedStyle="Left">
                <Settings AllowAutoFilter="False" ShowFilterRowMenu="False" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="ĐVT" FieldName="TenDonViTinh" VisibleIndex="4" Width="80px" FixedStyle="Left">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Nhóm vật tư" FieldName="NhomID" FixedStyle="Left" ShowInCustomizationForm="True" VisibleIndex="3" GroupIndex="0" SortIndex="0" SortOrder="Ascending">
                <PropertiesComboBox DataSourceID="dsNhomVatTu" TextField="TenNhom" ValueField="ID">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewBandColumn Caption="Tồn đầu kỳ" VisibleIndex="6">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <Columns>
                    <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="SoLuongDauKy" VisibleIndex="0">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="n2" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" />
                    </dx:GridViewDataSpinEditColumn>
                    <dx:GridViewDataSpinEditColumn Caption="ĐG" FieldName="DonGiaDauKy" VisibleIndex="1">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="n0" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" />
                    </dx:GridViewDataSpinEditColumn>
                    <dx:GridViewDataSpinEditColumn Caption="TT đầu kỳ" FieldName="ThanhTienDauKy" VisibleIndex="2" ToolTip="Thành tiền đầu kỳ">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="n0" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" />
                    </dx:GridViewDataSpinEditColumn>
                </Columns>
            </dx:GridViewBandColumn>
            <dx:GridViewBandColumn Caption="Nhập trong kỳ" VisibleIndex="7">
                <HeaderStyle HorizontalAlign="Center" />
                <Columns>
                    <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="NhapTrongKy" VisibleIndex="0">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N2" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataSpinEditColumn>
                    <dx:GridViewDataSpinEditColumn Caption="ĐG" FieldName="DonGiaNhapTrongKy" VisibleIndex="1">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N0" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataSpinEditColumn>
                    <dx:GridViewDataSpinEditColumn Caption="TT nhập" FieldName="ThanhTienNhapTrongKy" VisibleIndex="2">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N0" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataSpinEditColumn>
                </Columns>
            </dx:GridViewBandColumn>
            <dx:GridViewBandColumn Caption="Xuất trong kỳ" VisibleIndex="8">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <Columns>
                    <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="XuatTrongKy" VisibleIndex="0">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N2" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataSpinEditColumn>
                    <dx:GridViewDataSpinEditColumn Caption="ĐG" FieldName="DonGiaXuatTrongKy" VisibleIndex="1">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N0" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataSpinEditColumn>
                    <dx:GridViewDataSpinEditColumn Caption="TT xuất" FieldName="ThanhTienXuatTrongKy" VisibleIndex="2">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N0" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataSpinEditColumn>
                </Columns>
            </dx:GridViewBandColumn>
            <dx:GridViewBandColumn Caption="Tồn cuối kỳ" VisibleIndex="9">
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <Columns>
                    <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="SoLuongCuoiKy" VisibleIndex="0">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N2" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataSpinEditColumn>
                    <dx:GridViewDataSpinEditColumn Caption="ĐG" FieldName="DonGiaCuoiKy" VisibleIndex="1">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N0" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataSpinEditColumn>
                    <dx:GridViewDataSpinEditColumn Caption="TT tồn" FieldName="ThanhTienCuoiKy" VisibleIndex="2">
                        <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N0" NumberFormat="Custom">
                        </PropertiesSpinEdit>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </dx:GridViewDataSpinEditColumn>
                </Columns>
            </dx:GridViewBandColumn>
        </Columns>
        <Styles>
            <Footer Font-Bold="True">
            </Footer>
            <FixedColumn BackColor="LightYellow" />
        </Styles>
        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="ThanhTienDauKy" ShowInColumn="TT đầu kỳ" SummaryType="Sum" />
            <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="ThanhTienCuoiKy" SummaryType="Sum" ShowInColumn="TT tồn" />
            <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="ThanhTienNhapTrongKy" SummaryType="Sum" ShowInGroupFooterColumn="TT nhập" />
            <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="ThanhTienXuatTrongKy" SummaryType="Sum" ShowInGroupFooterColumn="TT xuất" />
        </TotalSummary>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsNhomVatTu" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenNhom] FROM [NhienLieu_Nhom]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhapXuatTon" runat="server" 
        ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" 
       SelectCommand="pr_NhapXuatTon" SelectCommandType="StoredProcedure">
        <SelectParameters>
             <asp:ControlParameter ControlID="cbpInfo$formThongTin$cbbBen" Name="BenID" PropertyName="Value" Type="String" />
             <asp:ControlParameter ControlID="cbpInfo$formThongTin$fromDay" Name="TuNgay" PropertyName="Value" Type="DateTime" />
            <asp:ControlParameter ControlID="cbpInfo$formThongTin$toDay" Name="DenNgay" PropertyName="Value" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxGridViewExporter ID="exporterGrid" runat="server" GridViewID="gridNhapXuatTon">
    </dx:ASPxGridViewExporter>
    <script>
        function popupViewReportClose() {
            hdfViewReport.Set('view', '0');
        }
    </script>
    <dx:ASPxPopupControl ID="popupViewReport"
    HeaderImage-Height="50px" CloseAction="CloseButton"
    ClientInstanceName="popupViewReport" runat="server"
    HeaderText="NHẬP XUẤT TỒN" Width="1200px" 
    Height="600px" ScrollBars="Auto" PopupHorizontalAlign="WindowCenter" 
    PopupVerticalAlign="WindowCenter" ShowHeader="true" Modal="True">
    <HeaderStyle  Font-Bold="True" BackColor="#009688" ForeColor="White" Font-Names="&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif" Font-Size="Large" />
    <ClientSideEvents CloseButtonClick="popupViewReportClose" />
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
            <dx:ASPxHiddenField ID="hdfViewReport" ClientInstanceName="hdfViewReport" runat="server">
            </dx:ASPxHiddenField>
            <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server">
            </dx:ASPxDocumentViewer>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

</asp:Content>
