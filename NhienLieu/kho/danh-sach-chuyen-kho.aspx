﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="danh-sach-chuyen-kho.aspx.cs" Inherits="NhienLieu.kho.danh_sach_chuyen_kho" %>
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
                content: 'Bạn muốn hủy phiếu chuyển kho?',
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
                gridDSXuatKho.Refresh();
                delete s.cp_Suc;
            }
            if (s.cp_Err) {
                baoloi('Thao tác không thành công, thử lại sau!');
                delete s.cp_Err;
            }
        }
    </script>
    <dx:ASPxGridView ID="gridDSChuyenKho" ClientInstanceName="gridDSChuyenKho" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="DSChuyenKho" KeyFieldName="ID" OnCustomColumnDisplayText="gridDSChuyenKho_CustomColumnDisplayText">
        <SettingsAdaptivity>
            <AdaptiveDetailLayoutProperties ColCount="1">
            </AdaptiveDetailLayoutProperties>
        </SettingsAdaptivity>
        <ClientSideEvents  RowDblClick="function(s, e) { s.StartEditRow(e.visibleIndex); }" />
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="gridChiTietChuyenKho" runat="server" AutoGenerateColumns="False" DataSourceID="dsChuyenKhoChiTiet" KeyFieldName="ID" Width="80%" CssClass="mx-auto" OnBeforePerformDataSelect="gridChiTietChuyenKho_BeforePerformDataSelect" OnCustomColumnDisplayText="gridChiTietChuyenKho_CustomColumnDisplayText">
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="1">
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <SettingsPager Mode="EndlessPaging">
                    </SettingsPager>
                    <Settings ShowTitlePanel="True" />
                    <SettingsText Title="Chi tiết xuất kho" />
                    <EditFormLayoutProperties ColCount="1">
                    </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Caption="STT">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tên - Quy cách vật tư" FieldName="TenNhienLieu" ShowInCustomizationForm="True" VisibleIndex="2">
                            <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="TenDonViTinh" ShowInCustomizationForm="True" VisibleIndex="3" Caption="ĐVT">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Ký hiệu" FieldName="MaNhienLieu" ShowInCustomizationForm="True" VisibleIndex="1">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="ThanhTien" VisibleIndex="7">
                            <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Đơn giá" FieldName="GiaXuat" VisibleIndex="6">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Số lượng xuất" FieldName="SoLuongChuyen" VisibleIndex="5">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                    </Columns>
                    <Styles>
                        <AdaptiveHeaderPanel Font-Bold="False" Font-Italic="False">
                        </AdaptiveHeaderPanel>
                        <TitlePanel Font-Bold="True" ForeColor="#99FF33">
                        </TitlePanel>
                    </Styles>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsChuyenKhoChiTiet" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT * FROM [View_ChuyenKhoChiTiet] WHERE ([PhieuChuyenID] = @PhieuChuyenID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="PhieuChuyenID" SessionField="PhieuChuyenID" />
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
        <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Nhập dữ liệu cần tìm..." Title="DANH SÁCH CHUYỂN KHO" />
        <EditFormLayoutProperties ColCount="1">
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" SortIndex="0" SortOrder="Descending" VisibleIndex="0" Width="5%">
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Chức năng" ShowInCustomizationForm="True" VisibleIndex="11">
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
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
            <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="DaXoa" ShowInCustomizationForm="True" VisibleIndex="10">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="Hoàn tất" Value="0" />
                        <dx:ListEditItem Text="Phiếu hủy" Value="1" />
                    </Items>
                </PropertiesComboBox>
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="Số phiếu" FieldName="SoPhieu" ShowInCustomizationForm="True" VisibleIndex="1">
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Căn cứ" FieldName="CanCu" ShowInCustomizationForm="True" VisibleIndex="2">
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Đối tượng xuất" FieldName="DoiTuongXuat" ShowInCustomizationForm="True" VisibleIndex="3">
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Thời hạn xuất" FieldName="ThoiHanXuat" ShowInCustomizationForm="True" VisibleIndex="4">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Ngày" FieldName="Ngay" VisibleIndex="8">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày lập phiếu" FieldName="NgayLapPhieu" ShowInCustomizationForm="True" VisibleIndex="5">
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="ThanhTien" VisibleIndex="9">
                <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <EditFormSettings Visible="False" />
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="Xuất tại kho" FieldName="BenChuyenID" VisibleIndex="6">
                <PropertiesComboBox DataSourceID="SqlDataSourceBen" TextField="TenBen" ValueField="ID">
                </PropertiesComboBox>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="Kho nhận" FieldName="BenNhanID" VisibleIndex="7">
                <PropertiesComboBox DataSourceID="SqlDataSourceBen" TextField="TenBen" ValueField="ID">
                </PropertiesComboBox>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 0" Format="GreenFillWithDarkGreenText" />
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 1" Format="LightRedFillWithDarkRedText" />
        </FormatConditions>
        <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSourceBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSChuyenKho" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT ID, SoPhieu, CanCu, DoiTuongXuat, ThoiHanXuat, BenChuyenID, BenNhanID, Ngay, NgayLapPhieu, ThanhTien, DaXoa, NhanVienID FROM PhieuChuyenKho" UpdateCommand="UPDATE PhieuXuatKho SET SoPhieu = @SoPhieu, CanCu = @CanCu, DoiTuongXuat = @DoiTuongXuat, ThoiHanXuat = @ThoiHanXuat, BenXuatID = @BenXuatID, Ngay = @Ngay, NgayLapPhieu = @NgayLapPhieu WHERE (ID = @ID)">
        <UpdateParameters>
            <asp:Parameter Name="SoPhieu" />
            <asp:Parameter Name="CanCu" />
            <asp:Parameter Name="DoiTuongXuat" />
            <asp:Parameter Name="ThoiHanXuat" />
            <asp:Parameter Name="BenXuatID" />
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
