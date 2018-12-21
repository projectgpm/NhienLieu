<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="danh-sach-nhap-kho.aspx.cs" Inherits="NhienLieu.lap_phieu.danh_sach_nhap_kho" %>
<%@ Register assembly="DevExpress.XtraReports.v18.1.Web.WebForms, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        let onPrintClick = id => {
            pcViewReport.Show();
            cbpReport.PerformCallback('report|'+id);
        }
        let onDeleteClick = idPhieu => {
            $.confirm({
                title: '<strong>Thông báo:</strong>',
                content: 'Bạn muốn hủy phiếu nhập kho?',
                type: 'dak',
                boxWidth: '25%',
                theme: 'light',
                useBootstrap: false,
                animation: 'zoom',
                closeAnimation: 'scale',
                typeAnimated: true,
                buttons: {
                    tryAgain: {
                        text: 'Có',
                        btnClass: 'btn-blue',
                        keys: ['enter'],
                        action: function () {
                            cbpReport.PerformCallback('xoaphieu|' + idPhieu);
                        }
                    },
                    somethingElse: {
                        text: 'Không',
                        btnClass: 'btn-red',
                        keys: ['esc'],
                        action: function () {
                        }
                    },
                }
            });
        }
        let endCallBackGrid = (s, e) => {
            if (s.cp_Suc) {
                thongbao('Hủy phiếu thành công!');
                gridDSNhapKho.Refresh();
                delete s.cp_Suc;
            }
            if (s.cp_Err) {
                baoloi('Thao tác không thành công, thử lại sau!');
                delete s.cp_Err;
            }
        }
    </script>
    <dx:ASPxGridView ID="gridDSNhapKho" ClientInstanceName="gridDSNhapKho" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDSNhapKho" KeyFieldName="ID" OnCustomColumnDisplayText="gridDSNhapKho_CustomColumnDisplayText">
        <SettingsAdaptivity>
            <AdaptiveDetailLayoutProperties ColCount="1">
            </AdaptiveDetailLayoutProperties>
        </SettingsAdaptivity>
        <ClientSideEvents  RowDblClick="function(s, e) { s.StartEditRow(e.visibleIndex); }" />
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="gridChiTietNhapKho" runat="server" AutoGenerateColumns="False" DataSourceID="dsNhapKhoChiTiet" KeyFieldName="ID" OnBeforePerformDataSelect="gridChiTietNhapKho_BeforePerformDataSelect" Width="80%" CssClass="mx-auto">
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="1">
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <SettingsPager Mode="EndlessPaging">
                    </SettingsPager>
                    <Settings ShowTitlePanel="True" />
                    <SettingsText Title="Chi tiết nhập kho" />
                    <EditFormLayoutProperties ColCount="1">
                    </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Bến" FieldName="Ben" ShowInCustomizationForm="True" VisibleIndex="1">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="PhieuNhapID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="4">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Đơn giá" FieldName="GiaNhap" ShowInCustomizationForm="True" VisibleIndex="8">
                            <PropertiesTextEdit DisplayFormatString="N2">
                            </PropertiesTextEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Thành tiền" FieldName="ThanhTien" ShowInCustomizationForm="True" VisibleIndex="9">
                            <PropertiesTextEdit DisplayFormatString="N0">
                            </PropertiesTextEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tên - Quy cách vật tư" FieldName="TenNhienLieu" ShowInCustomizationForm="True" VisibleIndex="2">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="ĐVT" FieldName="TenDonViTinh" ShowInCustomizationForm="True" VisibleIndex="3">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewBandColumn Caption="Số lượng" ShowInCustomizationForm="True" VisibleIndex="5">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <Columns>
                                <dx:GridViewDataTextColumn Caption="Thực nhập" FieldName="SoLuong" ShowInCustomizationForm="True" VisibleIndex="1">
                                    <PropertiesTextEdit DisplayFormatString="N0">
                                    </PropertiesTextEdit>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Theo C.từ" FieldName="SoLuong" ShowInCustomizationForm="True" VisibleIndex="0">
                                    <PropertiesTextEdit DisplayFormatString="N0">
                                    </PropertiesTextEdit>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:GridViewDataTextColumn>
                            </Columns>
                        </dx:GridViewBandColumn>
                    </Columns>
                    <Styles>
                        <AdaptiveHeaderPanel Font-Bold="False" Font-Italic="False">
                        </AdaptiveHeaderPanel>
                        <TitlePanel Font-Bold="True" ForeColor="#99FF33">
                        </TitlePanel>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsNhapKhoChiTiet" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT * FROM [View_NhapKhoChiTiet] WHERE ([PhieuNhapID] = @PhieuNhapID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="PhieuNhapID" SessionField="PhieuNhapID" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <Settings ShowFilterRow="True" ShowTitlePanel="True" />
        <SettingsBehavior AllowDragDrop="False" />
        <SettingsCommandButton>
            <UpdateButton Text="Lưu lại">
                <Image IconID="save_save_32x32">
                </Image>
            </UpdateButton>
            <CancelButton Text="Hủy">
                <Image IconID="actions_cancel_32x32">
                </Image>
            </CancelButton>
        </SettingsCommandButton>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Nhập dữ liệu cần tìm..." Title="DANH SÁCH NHẬP KHO" />
        <EditFormLayoutProperties ColCount="1">
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" SortIndex="0" SortOrder="Descending" VisibleIndex="0" Width="5%">
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Số phiếu" FieldName="SoPhieu" ShowInCustomizationForm="True" VisibleIndex="1">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Hóa đơn số" FieldName="HoaDonSo" ShowInCustomizationForm="True" VisibleIndex="2">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Ngày nhập" FieldName="Ngay" ShowInCustomizationForm="True" VisibleIndex="3">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày lập phiếu" FieldName="NgayLapPhieu" ShowInCustomizationForm="True" VisibleIndex="4">
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn Caption="Thành tiền" FieldName="ThanhTien" ShowInCustomizationForm="True" VisibleIndex="5">
                <PropertiesTextEdit DisplayFormatString="N0">
                </PropertiesTextEdit>
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Nguồn nhập" FieldName="NguonNhap" ShowInCustomizationForm="True" Visible="False" VisibleIndex="6">
                <EditFormSettings Visible="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Chức năng" ShowInCustomizationForm="True" VisibleIndex="8">
                <HeaderStyle HorizontalAlign="Center" />
                <EditFormSettings Visible="False" />
                <DataItemTemplate>
                    <dx:ASPxButton ToolTip="In phiếu" ID="btnInPhieu" runat="server" RenderMode="Link" OnInit="btnInPhieu_Init" AutoPostBack="false">
                        <Image IconID="print_print_16x16">
                        </Image>
                    </dx:ASPxButton>
                    <dx:ASPxButton ToolTip="Xóa phiếu khỏi hệ thống" Paddings-PaddingLeft="5px" ID="btnXoaPhieu" runat="server" RenderMode="Link" OnInit="btnXoaPhieu_Init" AutoPostBack="false">
                        <Image IconID="actions_cancel_16x16">
                        </Image>
                    </dx:ASPxButton>
                </DataItemTemplate>
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="DaXoa" ShowInCustomizationForm="True" VisibleIndex="7">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="Hoàn tất" Value="0" />
                        <dx:ListEditItem Text="Phiếu hủy" Value="1" />
                    </Items>
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 0" Format="GreenFillWithDarkGreenText" />
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 1" Format="LightRedFillWithDarkRedText" />
        </FormatConditions>
        <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSourceDSNhapKho" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT ID, SoPhieu, HoaDonSo, Ngay, NgayLapPhieu, ThanhTien, NguonNhap, DaXoa FROM PhieuNhapKho" UpdateCommand="UPDATE PhieuNhapKho SET SoPhieu = @SoPhieu, HoaDonSo = @HoaDonSo, NguonNhap = @NguonNhap, Ngay = @Ngay, NgayLapPhieu = @NgayLapPhieu WHERE (ID = @ID)">

        <UpdateParameters>
            <asp:Parameter Name="SoPhieu" />
            <asp:Parameter Name="HoaDonSo" />
            <asp:Parameter Name="NguonNhap" />
            <asp:Parameter Name="Ngay" />
            <asp:Parameter Name="NgayLapPhieu" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <dx:ASPxPopupControl ID="pcViewReport" runat="server" Width="1200px" ClientInstanceName="pcViewReport"  
        HeaderText="Phiếu nhập kho" Height="600px" ScrollBars="Auto" 
PopupVerticalAlign="WindowCenter" ShowHeader="true" Modal="true" CloseAction="CloseButton" PopupHorizontalAlign="WindowCenter">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                <dx:ASPxCallbackPanel ID="cbpReport" ClientInstanceName="cbpReport" runat="server" Width="100%" OnCallback="cbpReport_Callback">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                        <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server">
                        </dx:ASPxDocumentViewer>
                        <dx:ASPxHiddenField ID="hdfViewReport" ClientInstanceName="hdfViewReport" runat="server">
                        </dx:ASPxHiddenField>
                        </dx:PanelContent>
                    </PanelCollection>
                <ClientSideEvents EndCallback="endCallBackGrid" />
                </dx:ASPxCallbackPanel>
            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>
</asp:Content>
