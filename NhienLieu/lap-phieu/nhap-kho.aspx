﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="nhap-kho.aspx.cs" Inherits="NhienLieu.lap_phieu.nhap_kho" %>
<%@ Register Assembly="DevExpress.XtraReports.v18.1.Web.WebForms, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<asp:Content ID="nhapkho" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        let ThemNhienLieu = () => {
            if(CheckInput())
            cbpNhienLieu.PerformCallback('import');
        }
        let btnTroVeClick = () => {
            $.confirm({
                title: '<strong>Thông báo:</strong>',
                content: 'Bạn muốn rời khỏi trang này?',
                type: 'dak',
                boxWidth: '25%',
                theme: 'light',
                autoClose: 'somethingElse',
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
                            window.history.back();
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
        function check_Save() {
            //if (ccbNhapKho.GetSelectedIndex() == -1) {
            //    baoloi('Vui lòng chọn kho nhập!');
            //    ccbNhapKho.Focus();
            //    return false;
            //}
            if (txt_ngaynhap.GetValue() == null) {
                txt_ngaynhap.Focus();
                baoloi('Chưa chọn ngày!');
                return false;
            }
            if (cbbDonViBH.GetSelectedIndex() == -1) {
                baoloi('Chưa chọn Đơn vị bán hàng!');
                cbbDonViBH.Focus();
                return false;
            }
            if (gridNhienLieu.GetVisibleRowsOnPage() < 1) {
                baoloi('Danh sách nhiên liệu trống!');
                cbb_NhienLieu.Focus();
                return false;
            }
            return true;
        }
        function btnPreviewClick() {
            if (check_Save())
                cbpNhienLieu.PerformCallback('Review');
        }
        let onSaveClick = () => {
            if (check_Save()) {
                $.confirm({
                    title: '<strong>Thông báo:</strong>',
                    content: 'Xác nhận lưu phiếu?',
                    type: 'dak',
                    boxWidth: '25%',
                    theme: 'light',
                    autoClose: 'somethingElse',
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
                                cbpNhienLieu.PerformCallback('save');
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
        }
        let CheckInput = () => {
            if (cbb_NhienLieu.GetSelectedIndex() == -1) {
                cbb_NhienLieu.Focus();
                baoloi('Chưa chọn Nhiên liệu!');
                return false;
            }
            if (cbbBen.GetSelectedIndex() == -1) {
                cbbBen.Focus();
                baoloi('Chưa chọn Bến!');
                return false;
            }
            
            return true;
        }
        let onDVSelect = () => {
            cbpDonVi.PerformCallback();
        }
        let onXoaHangChanged = key => {
            cbpNhienLieu.PerformCallback('xoahang|' + key);
        }
        function onUnitReturnChanged(key) {
            cbpNhienLieu.PerformCallback('UnitChange|' + key);
        }
        let endCallBackProduct = (s, e) => {
            if (s.cp_Reset) {
                delete (s.cp_Reset);
                thongbao('Nhập kho thành công!');
                $('#groupbtn').hide();
                
            }
            if (s.cp_Error_TonTai) {
                delete s.cp_Error_TonTai;
                baoloi('Nhiên liệu đã tồn tại ở bến này?');
                //cbb_NhienLieu.SetValue("");
                //cbb_NhienLieu.SetText("");
                cbb_NhienLieu.Focus();
            }
            if (s.cp_Error_Save) {
                delete s.cp_Error_Save;
                baoloi('Đã có lỗi thêm dữ liệu. Vui lòng liên hệ nhà cung cấp phần mềm?');
            }
            if (s.cp_rpView) {
                hdfViewReport.Set('view', '1');
                popupViewReport.Show();
                reportViewer.GetViewer().Refresh();
                delete (s.cp_rpView);
            }
        }

        let endCallBackDonVi = (s, e) => {

        }
        function AdjustSize() {
            var hInfoPanel = splImport.GetPaneByName('splpInfoImport').GetClientHeight();
            var hInfoLayout = formThongtin.GetHeight();
            gridNhienLieu.SetHeight(hInfoPanel - hInfoLayout);
        }
    </script>
    <dx:ASPxPanel ID="panelImport" CssClass="gpm_content" runat="server" Width="100%" DefaultButton="btnImportToList">
        <PanelCollection>
            <dx:PanelContent ID="PanelContent3" runat="server">

                <div class="mx-auto" style="font-size: 14pt; width:14%; padding: 5px;" >
                    PHIẾU NHẬP KHO
                </div>
    <dx:ASPxSplitter ID="splImport" runat="server" ClientInstanceName="splImport" FullscreenMode="True" Height="100%" SeparatorVisible="False" Width="100%" Orientation="Vertical">
        <Styles>
            <Pane>
                <Paddings Padding="0px" />
            </Pane>
        </Styles>
        <Panes>
            <dx:SplitterPane Name="splpInfo">
            <Panes>
            <dx:SplitterPane  Name="splpInfoImport" >
                <ContentCollection>
                    <dx:SplitterContentControl runat="server">
                        <dx:ASPxCallbackPanel ID="cbpNhienLieu" ClientInstanceName="cbpNhienLieu" runat="server" Width="100%" OnCallback="cbpNhienLieu_Callback">
                             <PanelCollection>
                                <dx:PanelContent ID="PanelContent2" runat="server">
                                    <dx:ASPxFormLayout ID="formThongtin"  ClientInstanceName="formThongtin" runat="server" ColCount="6" ColumnCount="6" Width="100%">

                                        <Items>
                                            <dx:LayoutItem ColSpan="4" Caption="Nhiên liệu" ColumnSpan="4" Width="60%">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxComboBox ID="cbb_NhienLieu" runat="server" ClientInstanceName="cbb_NhienLieu" DropDownStyle="DropDown" DropDownWidth="600px" 
	                                                        EnableCallbackMode="True" TextFormatString="{0} - {1}" Width="100%" 
	                                                        OnItemRequestedByValue="cbb_NhienLieu_ItemRequestedByValue" OnItemsRequestedByFilterCondition="cbb_NhienLieu_ItemsRequestedByFilterCondition" ValueField="ID">
	                                                        <Columns>
		                                                        <dx:ListBoxColumn Caption="Mã nhiên liệu" FieldName="MaNhienLieu" Width="30%">
		                                                        </dx:ListBoxColumn>
		                                                        <dx:ListBoxColumn Caption="Nhiên liệu" FieldName="TenNhienLieu" Width="70%">
		                                                        </dx:ListBoxColumn>
	                                                        </Columns>
	                                                        <DropDownButton Visible="False">
	                                                        </DropDownButton>
                                                        </dx:ASPxComboBox>
                                                        <asp:SqlDataSource ID="SqlDataSourceNhienLieu" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [MaNhienLieu], [TenNhienLieu] FROM [NhienLieu]"></asp:SqlDataSource>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" Caption="Bến" Width="30%">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxComboBox ID="cbbBen" ClientInstanceName="cbbBen" runat="server" DataSourceID="SqlDataSourceBen" TextField="TenBen" ValueField="ID" Width="100%">
                                                        </dx:ASPxComboBox>
                                                        <asp:SqlDataSource ID="SqlDataSourceBen" runat="server" 
                                                            ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" 
                                                            SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem ColSpan="1" Caption="" Width="10%">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">
                                                        <dx:ASPxButton ID="btnDuaVaoDS" runat="server" Text="ĐƯA VÀO DS" AutoPostBack="False">
                                                            <ClientSideEvents Click="ThemNhienLieu" />
                                                        </dx:ASPxButton>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>

                                    </dx:ASPxFormLayout>
                            <dx:ASPxGridView ID="gridNhienLieu" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridNhienLieu" KeyFieldName="ID" Width="100%" OnRowDeleting="gridNhienLieu_RowDeleting">
                            <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowFooter="True" />
                                <SettingsAdaptivity>
                                <AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
                                </SettingsAdaptivity>

                                <SettingsPager Mode="ShowAllRecords">
                                </SettingsPager>
                                <SettingsBehavior AllowSort="False" />
                                <SettingsCommandButton>
                                    <ShowAdaptiveDetailButton ButtonType="Image">
                                    </ShowAdaptiveDetailButton>
                                    <HideAdaptiveDetailButton ButtonType="Image">
                                    </HideAdaptiveDetailButton>
                                    <DeleteButton ButtonType="Image" RenderMode="Image">
                                        <Image IconID="actions_cancel_16x16">
                                        </Image>
                                    </DeleteButton>
                                </SettingsCommandButton>
                                <SettingsText EmptyDataRow="Chưa có dữ liệu" />

                                <EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
                                <Columns>
                                    <dx:GridViewDataTextColumn Caption="Bến" FieldName="TenBen" ShowInCustomizationForm="True" VisibleIndex="2" Width="100px">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Ký hiệu" FieldName="MaNhienLieu" ShowInCustomizationForm="True" VisibleIndex="1" Width="100px">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataButtonEditColumn Caption="Xóa" ShowInCustomizationForm="True" VisibleIndex="9" Width="50px">
                                            <DataItemTemplate>
                                            <dx:ASPxButton AutoPostBack="false" ID="BtnXoaHang" ClientInstanceName="BtnXoaHang" runat="server" 
                                                    RenderMode="Link" OnInit="btnXoaHang_Init">
                                                <Image IconID="actions_cancel_16x16">
                                                </Image>
                                            </dx:ASPxButton>
                                        </DataItemTemplate>
                                        <CellStyle HorizontalAlign="Center">
                                        </CellStyle>
                                    </dx:GridViewDataButtonEditColumn>
                                    <dx:GridViewDataTextColumn Caption="Tên - Quy cách vật tư" FieldName="TenNhienLieu" ShowInCustomizationForm="True" VisibleIndex="3">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataSpinEditColumn Caption="Thành tiền" FieldName="ThanhTien" ShowInCustomizationForm="True" VisibleIndex="8">
                                        <PropertiesSpinEdit DisplayFormatString="N0" NumberFormat="Custom">
                                        </PropertiesSpinEdit>
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataSpinEditColumn>
                                    <dx:GridViewDataSpinEditColumn Caption="Đơn giá" FieldName="DonGia" ShowInCustomizationForm="True" VisibleIndex="7">
                                                                   
                                    <PropertiesSpinEdit DisplayFormatString="N2"></PropertiesSpinEdit>
                                        <DataItemTemplate>
                                            <dx:ASPxSpinEdit ID="spDonGia" AllowNull="false" MinValue="0" MaxValue="10000000000000000000000000" runat="server" Number='<%# Convert.ToDouble(Eval("DonGia")) %>' DisplayFormatString="N2" Width="100%" NumberType="Float" OnInit="spChungTu_Init" Increment="5000" HorizontalAlign="Right">
                                                <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                            </dx:ASPxSpinEdit>
                                        </DataItemTemplate>
                                        <CellStyle>
                                            <Paddings Padding="2px" />
                                        </CellStyle>
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                                                   
                                    </dx:GridViewDataSpinEditColumn>
                                    <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ShowInCustomizationForm="True" VisibleIndex="0" Width="5%">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewBandColumn Caption="Số lượng" ShowInCustomizationForm="True" VisibleIndex="5">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                        <Columns>
                                            <dx:GridViewDataSpinEditColumn Caption="Theo C.từ" FieldName="SoLuongChungTu" ShowInCustomizationForm="True" VisibleIndex="0" Width="8%">
                                                <PropertiesSpinEdit DisplayFormatString="g">
                                                </PropertiesSpinEdit>
                                                <DataItemTemplate>
                                                    <dx:ASPxSpinEdit ID="spChungTu" runat="server" AllowNull="false" MinValue="0" MaxValue="100000000" Number='<%# Convert.ToDouble(Eval("SoLuongChungTu")) %>' Width="100%" DisplayFormatString="N2" NumberType="Float" OnInit="spChungTu_Init" Increment="5000" HorizontalAlign="Right">
                                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                    </dx:ASPxSpinEdit>
                                                </DataItemTemplate>
                                                <CellStyle>
                                                    <Paddings Padding="2px" />
                                                </CellStyle>
                                            </dx:GridViewDataSpinEditColumn>
                                            <dx:GridViewDataSpinEditColumn Caption="Thực nhập" FieldName="SoLuongThucNhap" ShowInCustomizationForm="True" VisibleIndex="1" Width="8%">
                                                <PropertiesSpinEdit DisplayFormatString="N0">
                                                </PropertiesSpinEdit>
                                            </dx:GridViewDataSpinEditColumn>
                                        </Columns>
                                    </dx:GridViewBandColumn>
                                    <dx:GridViewDataTextColumn Caption="ĐVT" FieldName="DonViTinh" ShowInCustomizationForm="True" VisibleIndex="4" Width="75px">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <TotalSummary>
                                    <dx:ASPxSummaryItem DisplayFormat="Tổng mặt hàng: {0:N0}" FieldName="MaHang" ShowInColumn="Mã HH" SummaryType="Count" />
                                    <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="ThanhTien" ShowInColumn="Thành tiền" SummaryType="Sum" />
                                    <dx:ASPxSummaryItem DisplayFormat="{0:N0}" FieldName="SoLuongChungTu" ShowInColumn="Số lượng" SummaryType="Sum" />
                                </TotalSummary>
                                <Styles>
                                    <Footer Font-Bold="True">
                                    </Footer>
                                </Styles>
                                    </dx:ASPxGridView>
                                    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
                                        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
                                    </dx:ASPxGlobalEvents>
                            </dx:PanelContent>
                        </PanelCollection>
                        <ClientSideEvents EndCallback="endCallBackProduct" />
                    </dx:ASPxCallbackPanel>
                    </dx:SplitterContentControl>
                </ContentCollection>
            </dx:SplitterPane>
            <dx:SplitterPane MaxSize="350px">
                <ContentCollection>
                    <dx:SplitterContentControl runat="server">
                        <dx:ASPxCallbackPanel ID="cbpDonVi" ClientInstanceName="cbpDonVi" runat="server" Width="100%" OnCallback="cbpDonVi_Callback">
                             <PanelCollection>
                                <dx:PanelContent ID="PanelContent1" runat="server">
                        <dx:ASPxFormLayout ID="formlayout2" runat="server" ColCount="1" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="Nguồn nhập" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txt_nguonnhap" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Đơn vị bán hàng" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cbbDonViBH" ClientInstanceName="cbbDonViBH" runat="server" Width="100%" DataSourceID="SqlDataSourceDonViBH" TextField="TenDonVi" ValueField="ID">
                                            <ClientSideEvents SelectedIndexChanged="onDVSelect"></ClientSideEvents>
                                            </dx:ASPxComboBox>
                                            <asp:SqlDataSource ID="SqlDataSourceDonViBH" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenDonVi] FROM [DonVi]"></asp:SqlDataSource>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Địa chỉ" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txt_diachi" runat="server" Width="100%" ReadOnly="True">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Hóa đơn số" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txt_hoadonso" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Ngày" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="txt_ngaynhap" ClientInstanceName="txt_ngaynhap" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Ngày lập phiếu" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxDateEdit ID="deNgayLapPhieu" runat="server" Width="100%" OnInit="deNgayLapPhieu_Init">
                                            </dx:ASPxDateEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                        </dx:PanelContent>
                        </PanelCollection>
                        <ClientSideEvents EndCallback="endCallBackDonVi" />
                    </dx:ASPxCallbackPanel>
                    </dx:SplitterContentControl>
                </ContentCollection>
                </dx:SplitterPane>
            </Panes>
            <ContentCollection>
                <dx:SplitterContentControl ID="SplitterContentControl3" runat="server">
                </dx:SplitterContentControl>
            </ContentCollection>
            </dx:SplitterPane>
            <dx:SplitterPane Name="splpProcess" MaxSize="100px" Size="70px">
                <ContentCollection>
                    <dx:SplitterContentControl ID="SplitterContentControl4" runat="server">
                        <div id="groupbtn" style="align-items: center; text-align: center; padding-top: 5px;">
                            <table style="margin: 0 auto;">
                                <tr>
                                    <td >
                                        <dx:ASPxButton ID="btnPrivew"  ClientInstanceName="btnPrivew" runat="server" Text="Xem trước" BackColor="#5cb85c"  AutoPostBack="false"  UseSubmitBehavior="false">
                                        <ClientSideEvents Click="btnPreviewClick" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td style="padding-left: 10px;">
                                        <dx:ASPxButton ID="btnLuuVaIn" runat="server" Text="Nhập kho" AutoPostBack="false" UseSubmitBehavior="false">
                                            <ClientSideEvents Click="onSaveClick" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td style="padding-left: 10px;">
                                        <dx:ASPxButton ID="btnTroVe"  ClientInstanceName="btnTroVe" runat="server" Text="Trở về" BackColor="#d9534f" AutoPostBack="false"  UseSubmitBehavior="false">
                                        <ClientSideEvents Click="btnTroVeClick" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dx:SplitterContentControl>
                </ContentCollection>
            </dx:SplitterPane>
        </Panes>
    </dx:ASPxSplitter>
                </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxPanel>
<script>
    function popupViewReportClose() {
        hdfViewReport.Set('view', '0');
    }
</script>
<dx:ASPxPopupControl ID="popupViewReport"
    HeaderImage-Height="50px" CloseAction="CloseButton"
    ClientInstanceName="popupViewReport" runat="server"
    HeaderText="Phiếu nhập kho" Width="850px" 
    Height="600px" ScrollBars="Auto" PopupHorizontalAlign="WindowCenter" 
    PopupVerticalAlign="WindowCenter" ShowHeader="true" Modal="True">
    <HeaderStyle  Font-Bold="True"  Font-Names="&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif" Font-Size="Large" />
    <ClientSideEvents CloseButtonClick="popupViewReportClose" />
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl4" runat="server">
            <dx:ASPxHiddenField ID="hdfViewReport" ClientInstanceName="hdfViewReport" runat="server">
            </dx:ASPxHiddenField>
            <dx:ASPxDocumentViewer ID="reportViewer" ClientInstanceName="reportViewer" runat="server">
            </dx:ASPxDocumentViewer>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>
</asp:Content>
