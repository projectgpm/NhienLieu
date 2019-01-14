<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="danh-sach-quyet-toan-xi-nghiep.aspx.cs" Inherits="NhienLieu.nhap_lieu.danh_sach_quyet_toan_xi_nghiep" %>
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
        <Templates>
            <DetailRow>
                <dx:ASPxVerticalGrid ID="gridVerticalChiTiet" runat="server" Width="100%" AutoGenerateRows="False" ClientInstanceName="gridVerticalChiTiet" DataSourceID="dsChiTiet" KeyFieldName="ID" OnBeforePerformDataSelect="gridVerticalChiTiet_BeforePerformDataSelect">
                    <Rows>
                        <dx:VerticalGridTextRow FieldName="ID" Visible="False" VisibleIndex="0">
                        </dx:VerticalGridTextRow>
                        <dx:VerticalGridTextRow FieldName="QuyetToanBenID" Visible="False" VisibleIndex="1">
                        </dx:VerticalGridTextRow>
                        <dx:VerticalGridSpinEditRow Caption="Định mức" FieldName="DinhMuc" VisibleIndex="3">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Italic="True" HorizontalAlign="Center" />
                            <RecordStyle Font-Italic="True" HorizontalAlign="Right">
                            </RecordStyle>
                        </dx:VerticalGridSpinEditRow>
                        <dx:VerticalGridSpinEditRow Caption="I. TUA" FieldName="TongTua" VisibleIndex="4">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <Rows>
                                <dx:VerticalGridSpinEditRow Caption="1. Tua ngày" FieldName="TuaNgay" VisibleIndex="0">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:VerticalGridSpinEditRow>
                                <dx:VerticalGridSpinEditRow Caption="2. Tua đêm" FieldName="TuaDem" VisibleIndex="1">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:VerticalGridSpinEditRow>
                            </Rows>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <RecordStyle Font-Bold="True">
                            </RecordStyle>
                        </dx:VerticalGridSpinEditRow>
                        <dx:VerticalGridSpinEditRow Caption="II. Dầu D.O (Lít)" FieldName="TongDau" VisibleIndex="12">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <Rows>
                                <dx:VerticalGridSpinEditRow Caption="4. Công tác" FieldName="CongTac" VisibleIndex="3">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:VerticalGridSpinEditRow>
                                <dx:VerticalGridSpinEditRow Caption="3. Máy phát trên phà" FieldName="MayPhat" VisibleIndex="2">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:VerticalGridSpinEditRow>
                                <dx:VerticalGridSpinEditRow Caption="2. Bơm nước vệ sinh phà" FieldName="BomNuoc" VisibleIndex="1">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:VerticalGridSpinEditRow>
                                <dx:VerticalGridSpinEditRow Caption="1. Vận chuyển" FieldName="VanChuyen" VisibleIndex="0">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <Rows>
                                        <dx:VerticalGridSpinEditRow Caption="- Ngày" FieldName="VCNgay" VisibleIndex="0">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:VerticalGridSpinEditRow>
                                        <dx:VerticalGridSpinEditRow Caption="- Đêm" FieldName="VCDem" VisibleIndex="1">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:VerticalGridSpinEditRow>
                                    </Rows>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:VerticalGridSpinEditRow>
                            </Rows>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <RecordStyle Font-Bold="True">
                            </RecordStyle>
                        </dx:VerticalGridSpinEditRow>
                        <dx:VerticalGridSpinEditRow Caption="III. Nhớt (Lít)" FieldName="TongNhot" VisibleIndex="13">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <Rows>
                                <dx:VerticalGridSpinEditRow Caption="1. Châm máy" FieldName="ChamMay" VisibleIndex="0">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:VerticalGridSpinEditRow>
                                <dx:VerticalGridSpinEditRow Caption="2. Thay máy" FieldName="ThayMay" VisibleIndex="1">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <HeaderStyle HorizontalAlign="Center" />
                                </dx:VerticalGridSpinEditRow>
                            </Rows>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <RecordStyle Font-Bold="True">
                            </RecordStyle>
                        </dx:VerticalGridSpinEditRow>
                        <dx:VerticalGridTextRow Caption="Chỉ tiêu" FieldName="TenPha" ReadOnly="True" VisibleIndex="2">
                            <PropertiesTextEdit DisplayFormatString="g">
                            </PropertiesTextEdit>
                            <HeaderStyle HorizontalAlign="Center" />
                            <RecordStyle HorizontalAlign="Center">
                            </RecordStyle>
                        </dx:VerticalGridTextRow>
                    </Rows>
                    <SettingsPager Mode="ShowAllRecords">
                    </SettingsPager>
                </dx:ASPxVerticalGrid>
                <asp:SqlDataSource ID="dsChiTiet" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT QuyetToan_Ben_ChiTiet.ID, QuyetToan_Ben_ChiTiet.QuyetToanBenID, Pha.TenPha + ' (' + Pha.SoPhaCu + ') (' + Pha.SoHieu + ')' AS TenPha, QuyetToan_Ben_ChiTiet.DinhMuc, QuyetToan_Ben_ChiTiet.TongTua, QuyetToan_Ben_ChiTiet.TuaNgay, QuyetToan_Ben_ChiTiet.TuaDem, QuyetToan_Ben_ChiTiet.TongDau, QuyetToan_Ben_ChiTiet.VanChuyen, QuyetToan_Ben_ChiTiet.VCNgay, QuyetToan_Ben_ChiTiet.VCDem, QuyetToan_Ben_ChiTiet.BomNuoc, QuyetToan_Ben_ChiTiet.MayPhat, QuyetToan_Ben_ChiTiet.CongTac, QuyetToan_Ben_ChiTiet.TongNhot, QuyetToan_Ben_ChiTiet.ChamMay, QuyetToan_Ben_ChiTiet.ThayMay FROM QuyetToan_Ben_ChiTiet INNER JOIN Pha ON QuyetToan_Ben_ChiTiet.PhaID = Pha.ID WHERE (QuyetToan_Ben_ChiTiet.QuyetToanBenID = @QuyetToanBenID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="QuyetToanBenID" SessionField="QuyetToanBenID" />
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
        <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Nhập dữ liệu cần tìm..." Title="BẢNG QUYẾT TOÁN BẾN" />
        <EditFormLayoutProperties ColCount="1">
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" SortIndex="0" SortOrder="Descending" VisibleIndex="0" Width="5%">
                <EditFormSettings Visible="False" />
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Chức năng" ShowInCustomizationForm="True" VisibleIndex="8">
                <EditFormSettings Visible="False" />
                <DataItemTemplate>
                    <dx:ASPxButton ID="btnInPhieu" runat="server" AutoPostBack="false" OnInit="btnInPhieu_Init" RenderMode="Link" ToolTip="In phiếu">
                        <Image IconID="print_print_16x16">
                        </Image>
                    </dx:ASPxButton>
                    <dx:ASPxButton ID="btnXoaPhieu" runat="server" AutoPostBack="false" OnInit="btnXoaPhieu_Init" Paddings-PaddingLeft="5px" RenderMode="Link" ToolTip="Xóa phiếu khỏi hệ thống">
                        <Image IconID="actions_cancel_16x16">
                        </Image>
                    </dx:ASPxButton>
                </DataItemTemplate>
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
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
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn Caption="Bến" FieldName="TenBen" ShowInCustomizationForm="True" VisibleIndex="4">
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Thời gian quyết toán" FieldName="ThoiGian" ShowInCustomizationForm="True" VisibleIndex="5">
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày lập bảng" FieldName="NgayLap" ShowInCustomizationForm="True" VisibleIndex="6">
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True" />
            </dx:GridViewDataDateColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 0" Format="GreenFillWithDarkGreenText" />
            <dx:GridViewFormatConditionHighlight FieldName="DaXoa" Expression="[DaXoa] = 1" Format="LightRedFillWithDarkRedText" />
        </FormatConditions>
        <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="True" />
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSourceDSNhapKho" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT QuyenToan_Ben.ID, Ben.TenBen, QuyenToan_Ben.ThoiGian, QuyenToan_Ben.NgayLap, QuyenToan_Ben.DaXoa FROM QuyenToan_Ben INNER JOIN Ben ON QuyenToan_Ben.BenID = Ben.ID" UpdateCommand="UPDATE PhieuNhapKho SET SoPhieu = @SoPhieu, HoaDonSo = @HoaDonSo, NguonNhap = @NguonNhap, Ngay = @Ngay, NgayLapPhieu = @NgayLapPhieu WHERE (ID = @ID)">

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
