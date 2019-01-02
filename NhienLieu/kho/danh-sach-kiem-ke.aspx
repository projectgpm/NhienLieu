<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="danh-sach-kiem-ke.aspx.cs" Inherits="NhienLieu.kho.danh_sach_kiem_ke" %>
<%@ Register Assembly="DevExpress.XtraReports.v18.1.Web.WebForms, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxHtmlEditor.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxHtmlEditor" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxSpellChecker.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxSpellChecker" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<script>
    function onPrintClick(idPhieu) {
        popupViewReport.Show();
        cbpViewReport.PerformCallback('report|'+idPhieu);
    }
    
    function popupViewReport_Closing() {
        hdfViewReport.Set('view', '0');
    }
    function onEndCallBackViewRp(s, e) {
        if (s.cp_Suss) {
            delete s.cp_Suss;
            thongbao('Hủy phiếu nhập kho thành công!');
            gridDanhSach.Refresh();
        }
        if (s.cp_Errr) {
            delete s.cp_Errr;
            baoloi('Không thể xóa phiếu nhập kho này?');
        }
    }
</script>
    <dx:ASPxGridView ID="gridDanhSach" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridDanhSach" Width="100%" DataSourceID="dsKiemKe" KeyFieldName="ID" OnCustomColumnDisplayText="gridDanhSach_CustomColumnDisplayText" OnRowDeleting="gridDanhSach_RowDeleting" OnRowInserting="gridDanhSach_RowInserting" OnRowUpdating="gridDanhSach_RowUpdating">
       <%-- <ClientSideEvents RowDblClick="function(s, e) {
                s.StartEditRow(e.visibleIndex); }" EndCallback="message" />--%>
        <SettingsBehavior AllowEllipsisInText="true" />
        <SettingsBehavior ConfirmDelete="True" />
          <ClientSideEvents RowDblClick="function(s, e) {
                s.StartEditRow(e.visibleIndex); }" EndCallback="message" />
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <SettingsAdaptivity>
            <AdaptiveDetailLayoutProperties ColCount="1">
            </AdaptiveDetailLayoutProperties>
        </SettingsAdaptivity>
        <Templates>
            <DetailRow>
                <div style="width: 100%; text-align:center;">
                    <div style="display:inline-block;">
                        <dx:ASPxGridView ID="gridChiTiet" runat="server" AutoGenerateColumns="False" DataSourceID="dsChiTiet" KeyFieldName="ID" OnBeforePerformDataSelect="gridChiTiet_BeforePerformDataSelect" Width="98%" OnCustomColumnDisplayText="gridChiTiet_CustomColumnDisplayText">
                            <SettingsAdaptivity>
                                <AdaptiveDetailLayoutProperties ColCount="1">
                                </AdaptiveDetailLayoutProperties>
                            </SettingsAdaptivity>
                            <SettingsPager Mode="EndlessPaging">
                            </SettingsPager>
                            <Settings ShowTitlePanel="True" />
                            <SettingsCommandButton>
                                <ShowAdaptiveDetailButton ButtonType="Image">
                                </ShowAdaptiveDetailButton>
                                <HideAdaptiveDetailButton ButtonType="Image">
                                </HideAdaptiveDetailButton>
                                <NewButton ButtonType="Image" RenderMode="Image">
                                    <Image IconID="numberformats_accounting_16x16">
                                    </Image>
                                </NewButton>
                                <EditButton ButtonType="Image" RenderMode="Image">
                                    <Image IconID="tasks_edittask_16x16office2013">
                                    </Image>
                                </EditButton>
                                <DeleteButton ButtonType="Image" RenderMode="Image">
                                    <Image IconID="actions_close_16x16devav">
                                    </Image>
                                </DeleteButton>
                            </SettingsCommandButton>
                            <SettingsText EmptyDataRow="không có dữ liệu" Title="THÔNG TIN CHI TIẾT" />
                            <EditFormLayoutProperties ColCount="1">
                            </EditFormLayoutProperties>
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="0" ReadOnly="True" Caption="STT" Width="50px">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="KyHieu" Width="80px" VisibleIndex="1" Caption="Ký hiệu">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TenVatTu" CellStyle-HorizontalAlign="Left" VisibleIndex="2" Caption="Tên vật tư">
                                    <CellStyle HorizontalAlign="Left">
                                    </CellStyle>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="TenDVT" Width="100px" VisibleIndex="3" Caption="ĐVT">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Thực tế" FieldName="SoLuongThucTe" VisibleIndex="6">
                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Dở dang"  FieldName="SoLuongCongTrinhDoDang" VisibleIndex="7">
                                    <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewBandColumn Caption="Tồn cuối"  VisibleIndex="4">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <Columns>
                                        <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="SoLuongTonCuoi" ShowInCustomizationForm="True" VisibleIndex="0">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </dx:GridViewDataSpinEditColumn>
                                        <dx:GridViewDataSpinEditColumn  Caption="Giá trị" FieldName="GiaTriTonCuoi" ShowInCustomizationForm="True" VisibleIndex="1">
                                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </dx:GridViewDataSpinEditColumn>
                                    </Columns>
                                </dx:GridViewBandColumn>
                                <dx:GridViewBandColumn Caption="Nhập trong kỳ" VisibleIndex="5">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <Columns>
                                        <dx:GridViewDataSpinEditColumn Caption="SL" FieldName="SoLuongNhap" VisibleIndex="0">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </dx:GridViewDataSpinEditColumn>
                                        <dx:GridViewDataSpinEditColumn Caption="Giá trị" FieldName="GiaTriNhap" VisibleIndex="1">
                                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </dx:GridViewDataSpinEditColumn>
                                    </Columns>
                                </dx:GridViewBandColumn>
                                <dx:GridViewBandColumn Caption="Chênh lệch" VisibleIndex="8">
                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <Columns>
                                        <dx:GridViewDataSpinEditColumn Caption="Thừa" FieldName="ChenhLechThua" VisibleIndex="0">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </dx:GridViewDataSpinEditColumn>
                                        <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="TTChenhLechThua" VisibleIndex="1">
                                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </dx:GridViewDataSpinEditColumn>
                                        <dx:GridViewDataSpinEditColumn Caption="Thiếu" FieldName="ChenhLechThieu" VisibleIndex="2">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </dx:GridViewDataSpinEditColumn>
                                        <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="TTChenhLechThieu" VisibleIndex="3">
                                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </dx:GridViewDataSpinEditColumn>
                                    </Columns>
                                </dx:GridViewBandColumn>
                            </Columns>
                           
                            <Styles>
                                <Header HorizontalAlign="Center">
                                </Header>
                                <Footer Font-Bold="True">
                                </Footer>
                                <TitlePanel Font-Bold="True" Font-Size="14px" ForeColor="#00CC00">
                                </TitlePanel>
                            </Styles>
                        </dx:ASPxGridView>
                        <asp:SqlDataSource ID="dsChiTiet" runat="server" ConnectionString="<%$ ConnectionStrings:VatTuAnGiangConnectionString %>" SelectCommand="SELECT * FROM [View_KiemKeChiTiet] WHERE ([KiemKeID] = @KiemKeID)">
                            <SelectParameters>
                                <asp:SessionParameter Name="KiemKeID" SessionField="KiemKeID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </DetailRow>
        </Templates>
        <SettingsPager AlwaysShowPager="True" PageSize="30">
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowTitlePanel="true" VerticalScrollableHeight="50" VerticalScrollBarMode="Visible"/>
        <SettingsBehavior EnableRowHotTrack="true" />
        <SettingsResizing ColumnResizeMode="NextColumn" />
        <SettingsCommandButton>
            <ShowAdaptiveDetailButton ButtonType="Image">
            </ShowAdaptiveDetailButton>
            <HideAdaptiveDetailButton ButtonType="Image">
            </HideAdaptiveDetailButton>
            <NewButton Text="Thêm mới">
                <Image IconID="actions_add_16x16">
                </Image>
            </NewButton>
            <UpdateButton Text="Lưu">
                <Image IconID="save_save_32x32">
                </Image>
            </UpdateButton>
            <CancelButton Text="Hủy">
                <Image IconID="actions_close_32x32">
                </Image>
            </CancelButton>
            <EditButton Text="Sửa">
                <Image IconID="actions_edit_16x16devav">
                </Image>
            </EditButton>
            <DeleteButton Text="Xóa">
                <Image IconID="actions_cancel_16x16">
                </Image>
            </DeleteButton>
        </SettingsCommandButton>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu !!" HeaderFilterCancelButton="Hủy" HeaderFilterFrom="Từ" HeaderFilterOkButton="Lọc" HeaderFilterTo="Đến" SearchPanelEditorNullText="Nhập thông tin cần tìm..." ConfirmDelete="Xóa dữ liệu ??" PopupEditFormCaption="Thông tin" Title="DANH SÁCH KIỂM KÊ" />
        <EditFormLayoutProperties ColCount="2" ColumnCount="2">
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Caption="STT" Width="80px">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="NgayKiemKe" Caption="Ngày kiểm kê" VisibleIndex="2" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                </PropertiesDateEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="CanCu" VisibleIndex="4" Caption="Căn cứ">
                <EditFormSettings Visible="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DiaDiem" VisibleIndex="5" Caption="Địa điểm">
                <EditFormSettings Visible="True" />
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Thành phần tham gia" VisibleIndex="6" FieldName="ThanhPhanThamGia" Visible="False">
                <EditFormSettings Visible="True" />
                <EditItemTemplate>
                    <dx:ASPxHtmlEditor Width="100%" Height="100px" Html='<%# Eval("ThanhPhanThamGia") %>' ID="ThanhPhanThamGia" runat="server" ToolbarMode="None">
                        <Settings AllowDesignView="False" AllowHtmlView="False" AllowPreview="False">
                        </Settings>
                        <SettingsHtmlEditing EnterMode="BR">
                        </SettingsHtmlEditing>
                    </dx:ASPxHtmlEditor>
                </EditItemTemplate>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="NgayLapPhieu" VisibleIndex="7" Caption="Ngày lập phiếu" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" AllowNull="false" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                </PropertiesDateEdit>
                <EditFormSettings Visible="True" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="TonDenNgay" VisibleIndex="3" Caption="Tồn đến cuối ngày" Width="120px">
                <PropertiesDateEdit DisplayFormatString="dd/MM/yyyy" EditFormat="Custom" EditFormatString="dd/MM/yyyy">
                </PropertiesDateEdit>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="Kho kiểm kê" FieldName="KhoID" VisibleIndex="1">
                <PropertiesComboBox DataSourceID="dsKho" TextField="TenBen" ValueField="ID">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="Nhân viên lập" FieldName="NhanVienID" VisibleIndex="8">
                <PropertiesComboBox DataSourceID="dsNhanVien" TextField="HoTen" ValueField="ID">
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="Chức năng" Width="80px" VisibleIndex="18">
                 <DataItemTemplate>
                  
                    <dx:ASPxButton ToolTip="In phiếu" ID="btnInPhieu" runat="server"  Paddings-PaddingLeft="5px"  RenderMode="Link" OnInit="btnInPhieu_Init" AutoPostBack="false">
                        <Image IconID="print_print_16x16">
                        </Image>
                    </dx:ASPxButton>
                    
                </DataItemTemplate>
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
             </dx:GridViewDataTextColumn>
        </Columns>
       
        <Styles>
            <Header HorizontalAlign="Center">
            </Header>
            <GroupRow ForeColor="#009688">
            </GroupRow>
            <Cell>
                <Paddings PaddingBottom="3px" PaddingTop="3px" />
            </Cell>
            <GroupPanel>
                <Paddings Padding="0px" />
            </GroupPanel>
            <FilterCell>
                <Paddings Padding="0px" />
            </FilterCell>
            <SearchPanel>
                <Paddings PaddingBottom="5px" PaddingTop="5px" />
            </SearchPanel>
        </Styles>
        <Paddings Padding="0px" PaddingTop="0px" />
        <Border BorderWidth="0px" />
        <BorderBottom BorderWidth="1px" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsKho" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsKiemKe" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT * FROM [PhieuKiemKe]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsNhanVien" runat="server" 
        ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" 
        SelectCommand="SELECT [ID], [HoTen] FROM [NhanVien]"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	    UpdateControlHeight(gridDanhSach);
    }" ControlsInitialized="function(s, e) {
	    UpdateControlHeight(gridDanhSach);
    }" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxPopupControl ID="popupViewReport" ClientInstanceName="popupViewReport"
        runat="server" HeaderText="Phiếu kiểm kê" Width="1200px" Height="600px" 
    ScrollBars="Auto" PopupVerticalAlign="WindowCenter" ShowHeader="true" CloseAction="CloseButton" 
    PopupHorizontalAlign="WindowCenter" >
        <ClientSideEvents Closing="popupViewReport_Closing" />
        <HeaderStyle Font-Bold="True" BackColor="#009688" ForeColor="White" Font-Names="&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif" Font-Size="Large" />
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxCallbackPanel ID="cbpViewReport" ClientInstanceName="cbpViewReport" runat="server" Width="100%" 
                OnCallback="cbpViewReport_Callback">
                    <PanelCollection>
                        <dx:PanelContent>
                            <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server">
                            </dx:ASPxDocumentViewer>
                            <dx:ASPxHiddenField ID="hdfViewReport" ClientInstanceName="hdfViewReport" runat="server">
                            </dx:ASPxHiddenField>
                        </dx:PanelContent>
                    </PanelCollection>
                    <ClientSideEvents EndCallback="onEndCallBackViewRp" />
                </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
