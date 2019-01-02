<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KiemKeControl.ascx.cs" Inherits="NhienLieu.lap_phieu.KiemKeControl" %>
<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v18.1.Web.WebForms, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxRichEdit.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxRichEdit" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxSpellChecker.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxSpellChecker" tagprefix="dx" %>
<style>
    .dxflGroupCell_Material {
        padding: 0 5px;
    }

    .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > tbody > tr:first-child > .dxflGroupCell_Material > .dxflItem_Material, .dxflHeadingLineGroupBoxSys.dxflGroupBox_Material > .dxflGroup_Material > .dxflChildInFirstRowSys > .dxflGroupCell_Material > .dxflItem_Material {
        padding-top: 1px;
    }
    .gpm_content {
        margin-top: -5px;
    }
</style>
<script>
    function AdjustSize() {
        var hInfoPanel = splImport.GetPaneByName('splpInfoImport').GetClientHeight();
        var hInfoLayout = flayoutInfosImport.GetHeight();
        gridImportPro.SetHeight(hInfoPanel - hInfoLayout);

    }
    function onXoaHangChanged(key) {
        cbpInfoImport.PerformCallback('xoahang|' + key);
    }
    function onUnitReturnChanged(key) {
        cbpInfoImport.PerformCallback('UnitChange|' + key);
    }
    function ImportProduct() {
        cbpInfoImport.PerformCallback("import");
    }
    function endCallBackProduct(s, e) {
        if (s.cp_Suss) {
            delete s.cp_Suss;
            cbpInfoImport.PerformCallback('Reset');
             cbpInfo.PerformCallback('Reset');
            thongbao('Lưu phiếu thành công.');
        }
        if (s.cp_Err) {
            delete s.cp_Err;
            baoloi('Đã có lỗi xảy ra? Vui lòng liên hệ công ty cung cấp phần mềm?')
        }
        if (s.cp_rpView) {
            hdfViewReport.Set('view', '1');
            popupViewReport.Show();
            reportViewer.GetViewer().Refresh();
            delete (s.cp_rpView);
        }
        if (s.cp_Error_MaHang) {
            delete s.cp_Error_MaHang;
            baoloi('Vật tư không tồn tại?');
        }
        if (s.cp_ChonMaHang) {
            delete s.cp_ChonMaHang;
            baoloi('Vui lòng chọn vật tư?');
        }
    }
    function checkInput() {
        if (txtCanCu.GetText() == "") {
            txtCanCu.Focus();
            baoloi('Vui lòng nhập thông tin?');
            return false;
        }
        if (txtDiaDiem.GetText() == "") {
            txtDiaDiem.Focus();
            baoloi('Vui lòng nhập thông tin?');
            return false;
        }
        if (HtmlThanhPhanThamGia.GetHtml() == "") {
            HtmlThanhPhanThamGia.Focus();
            baoloi('Vui lòng nhập thông tin?');
            return false;
        }
        if (gridImportPro.GetVisibleRowsOnPage() < 1) {
            ccbVatTu.Focus();
            baoloi('Danh sách vật tư trống?');
            return false;
        }
        return true;
    }
    function onSaveClick() {
        if (checkInput()) {
            $.confirm({
                title: '<strong>Thông báo:</strong>',
                content: 'Xác nhận lập phiếu kiểm kê vật tư?',
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
                            cbpInfoImport.PerformCallback('Save');
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
    function btnTroVeClick() {
        $.confirm({
            title: '<strong>Thông báo:</strong>',
            content: 'Quay lại trang danh sách kiểm kê vật tư?',
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
                        cbpInfoImport.PerformCallback('redirect');
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
    function onReviewClick() {
        if (checkInput())
            cbpInfoImport.PerformCallback('Review');
    }
    function ccbKhoKiemKeSelected() {
        cbpInfoImport.PerformCallback('Review_Pro');
        ccbVatTu.PerformCallback();
    }
</script>
<dx:ASPxPanel ID="panelImport" CssClass="gpm_content" runat="server" Width="100%" DefaultButton="btnImportToList">
    <PanelCollection>
        <dx:PanelContent ID="PanelContent1" runat="server">
            <dx:ASPxSplitter ID="splImport" runat="server" ClientInstanceName="splImport" FullscreenMode="True" Height="100%" SeparatorVisible="False" Width="100%" Orientation="Vertical">
                <Styles>
                    <Pane>
                        <Paddings Padding="0px" />
                    </Pane>
                </Styles>
                <Panes>
                    <dx:SplitterPane Name="splpInfo">
                        <Panes>
                            <dx:SplitterPane Name="splpInfoImport">
                                <ContentCollection>
                                    <dx:SplitterContentControl ID="SplitterContentControl2" runat="server">
                                        <dx:ASPxCallbackPanel ID="cbpInfoImport" ClientInstanceName="cbpInfoImport" runat="server" Width="100%" OnCallback="cbpInfoImport_Callback">
                                            <PanelCollection>
                                                <dx:PanelContent ID="PanelContent2" runat="server">
                                                    <dx:ASPxFormLayout ID="flayoutInfosImport" ClientInstanceName="flayoutInfosImport" runat="server" Width="100%">
                                                        <Items>
                                                            <dx:LayoutGroup Caption="Nội dung kiểm kê" ColCount="7" GroupBoxDecoration="HeadingLine">
                                                                <Items>
                                                                    <dx:LayoutItem Caption="" ColSpan="4" ShowCaption="False" Width="100%" ColumnSpan="4">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer8" runat="server">
                                                                                <dx:ASPxComboBox ID="ccbVatTu" runat="server" 
                                                                                    ValueType="System.String"
                                                                                    ClientInstanceName="ccbVatTu"
                                                                                    DropDownWidth="600" DropDownStyle="DropDown"
                                                                                    ValueField="ID"
                                                                                    NullText="Nhập ký hiệu hoặc tên vật tư" Width="100%" 
                                                                                    TextFormatString="{0} - {1}"
                                                                                    EnableCallbackMode="true" CallbackPageSize="20"
                                                                                    OnItemsRequestedByFilterCondition="ccbVatTu_ItemsRequestedByFilterCondition"
                                                                                    OnItemRequestedByValue="ccbVatTu_ItemRequestedByValue" OnCallback="ccbVatTu_Callback"
                                                                                    >
                                                                                    <Columns>
                                                                                        <dx:ListBoxColumn FieldName="MaNhienLieu" Width="50px" Caption="Ký hiệu" />
                                                                                        <dx:ListBoxColumn FieldName="TenNhienLieu" Width="250px" Caption="Tên nhiên liệu" />
                                                                                    </Columns>
                                                                                    <DropDownButton Visible="False">
                                                                                    </DropDownButton>
                                                                                </dx:ASPxComboBox>
                                                                                <asp:SqlDataSource ID="dsVatTu" runat="server" 
                                                                                    ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [MaNhienLieu], [TenNhienLieu] FROM [NhienLieu]">
                                                                                </asp:SqlDataSource>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Số lượng">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                                <dx:ASPxSpinEdit ID="speSoLuongThucTe" AllowNull="false" ClientInstanceName="speSoLuongThucTe"
                                                                                    MinValue="1" DisplayFormatString="N2" MaxValue="100000000000000000" Number="1"
                                                                                    Font-Bold="true" HorizontalAlign="Right" runat="server">
                                                                                </dx:ASPxSpinEdit>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings Location="Left" />
                                                                        <CaptionStyle Font-Bold="True">
                                                                        </CaptionStyle>
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="" ShowCaption="False">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer9" runat="server">
                                                                                <dx:ASPxButton ID="btnImportToList" runat="server" Text="Đưa vào DS" AutoPostBack="False">
                                                                                    <ClientSideEvents Click="ImportProduct" />
                                                                                </dx:ASPxButton>
                                                                                <dx:ASPxHiddenField ID="hiddenFields" runat="server"></dx:ASPxHiddenField>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                    </dx:LayoutItem>
                                                                </Items>
                                                            </dx:LayoutGroup>
                                                        </Items>
                                                        <SettingsItemCaptions Location="Top" />
                                                    </dx:ASPxFormLayout>

                                                    <dx:ASPxGridView ID="gridImportPro" ClientInstanceName="gridImportPro" runat="server" Width="100%" AutoGenerateColumns="False" KeyFieldName="STT">
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
                                                            <dx:GridViewDataTextColumn Caption="STT" FieldName="STT" ShowInCustomizationForm="True" VisibleIndex="0" Width="50px">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Tên vật tư" FieldName="TenNhienLieu" ShowInCustomizationForm="True" VisibleIndex="2">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Ký hiệu" FieldName="MaNhienLieu" ShowInCustomizationForm="True" VisibleIndex="1">
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
                                                            <dx:GridViewDataTextColumn Caption="ĐVT" FieldName="DVT" ShowInCustomizationForm="True" VisibleIndex="3" Width="100px">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataSpinEditColumn Caption="Tồn cuối" FieldName="SoLuongTonCuoi" ShowInCustomizationForm="True" VisibleIndex="4" Width="110px" ToolTip="Tồn cuối đến ngày">
                                                                <PropertiesSpinEdit DisplayFormatString="N2" DisplayFormatInEditMode="True" NumberFormat="Custom"></PropertiesSpinEdit>
                                                            </dx:GridViewDataSpinEditColumn>
                                                            <dx:GridViewDataSpinEditColumn Caption="SL nhập" FieldName="SoLuongNhap"
                                                                ShowInCustomizationForm="True" VisibleIndex="5" Width="100px" ToolTip="Số lượng nhập từ ngày">
                                                                <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom" 
                                                                    DisplayFormatInEditMode="True">
                                                                </PropertiesSpinEdit>
                                                            </dx:GridViewDataSpinEditColumn>
                                                            <dx:GridViewDataSpinEditColumn Caption="Chênh lệch" FieldName="ChenhLech" ShowInCustomizationForm="True" VisibleIndex="8" Width="110px">
                                                                <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N2" NumberFormat="Custom">
                                                                </PropertiesSpinEdit>
                                                            </dx:GridViewDataSpinEditColumn>
                                                            <dx:GridViewDataSpinEditColumn Caption="Thực tế" FieldName="SoLuongThucTe" ShowInCustomizationForm="True" VisibleIndex="6" Width="100px">
                                                                <PropertiesSpinEdit DisplayFormatInEditMode="True" DisplayFormatString="N2" NumberFormat="Custom">
                                                                </PropertiesSpinEdit>
                                                                <DataItemTemplate>
                                                                    <dx:ASPxSpinEdit ID="speSoLuongThucTe" AllowNull="false" 
                                                                        MinValue="0" MaxValue="10000000000000000000000000"
                                                                        runat="server" Number='<%# Convert.ToDouble(Eval("SoLuongThucTe")) %>' 
                                                                        DisplayFormatString="N2" Width="100%" NumberType="Float" 
                                                                        OnInit="speSpinEdit_Init" Increment="5000" HorizontalAlign="Right">
                                                                        <SpinButtons ShowIncrementButtons="false"></SpinButtons>
                                                                    </dx:ASPxSpinEdit>
                                                                </DataItemTemplate>
                                                                <CellStyle>
                                                                    <Paddings Padding="2px" />
                                                                </CellStyle>
                                                            </dx:GridViewDataSpinEditColumn>
                                                        </Columns>
                                                        <FormatConditions>
                                                            <dx:GridViewFormatConditionHighlight FieldName="ChenhLech" Expression="[ChenhLech] &lt; 1" Format="LightRedFillWithDarkRedText" />
                                                            <dx:GridViewFormatConditionHighlight FieldName="ChenhLech" Expression="[ChenhLech] &gt; 0" Format="GreenFillWithDarkGreenText" />
                                                        </FormatConditions>
                                                        <TotalSummary>
                                                            <dx:ASPxSummaryItem DisplayFormat="Tổng mặt hàng: {0:N0}" FieldName="KyHieu" ShowInColumn="Ký hiệu" SummaryType="Count" />
                                                        </TotalSummary>
                                                        <Styles>
                                                            <Footer Font-Bold="True">
                                                            </Footer>
                                                        </Styles>
                                                    </dx:ASPxGridView>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                            <ClientSideEvents EndCallback="endCallBackProduct" />
                                        </dx:ASPxCallbackPanel>
                                    </dx:SplitterContentControl>
                                </ContentCollection>
                            </dx:SplitterPane>
                                <dx:SplitterPane MaxSize="350px" Name="splpInfoNCC"  >
                                <ContentCollection>
                                    <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                                            <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
                                            <PanelCollection>
                                                <dx:PanelContent ID="PanelContent3" runat="server">
                                                    <dx:ASPxFormLayout ID="flayoutInfoNCC" runat="server" Width="100%" Height="100%">
                                                        <Items>
                                                            <dx:LayoutGroup Caption="Thông tin kiểm kê" GroupBoxDecoration="HeadingLine">
                                                                <CellStyle>
                                                                    <Paddings Padding="0px" />
                                                                </CellStyle>
                                                                <ParentContainerStyle>
                                                                    <Paddings Padding="0px" />
                                                                </ParentContainerStyle>
                                                                <Items>
                                                                    <dx:LayoutItem Caption="Kho kiểm kê">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer2" runat="server">
                                                                                <dx:ASPxComboBox ID="ccbKhoKiemKe" AllowNull="false" SelectedIndex="0"  ClientInstanceName="ccbKhoKiemKe" Width="100%" runat="server" DataSourceID="dsKho" TextField="TenBen" ValueField="ID">
                                                                                    <ClientSideEvents SelectedIndexChanged="ccbKhoKiemKeSelected" />
                                                                                </dx:ASPxComboBox>
                                                                                <asp:SqlDataSource ID="dsKho" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings Location="Left" />
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Ngày kiểm kê" ShowCaption="True">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer3" runat="server">
                                                                                <dx:ASPxDateEdit ID="dateNgayKiemKe" Width="100%" ClientInstanceName="dateNgayKiemKe" DisplayFormatString="dd/MM/yyyy" AllowNull="false" runat="server">
                                                                                    <ClientSideEvents Init="function(s,e){s.SetDate(new Date());}" />
                                                                                </dx:ASPxDateEdit>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings Location="Left" />
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Căn cứ">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer4" runat="server">
                                                                                <dx:ASPxTextBox ID="txtCanCu" ClientInstanceName="txtCanCu" Width="100%" runat="server">
                                                                                </dx:ASPxTextBox>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings Location="Top" />
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Địa điểm">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer5" runat="server">
                                                                                <dx:ASPxTextBox ID="txtDiaDiem" ClientInstanceName="txtDiaDiem" Width="100%" runat="server">
                                                                                </dx:ASPxTextBox>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings Location="Top" />
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Tồn đến cuối ngày" ColSpan="1">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                                <dx:ASPxDateEdit ID="dateTonCuoiNgay" ClientInstanceName="dateTonCuoiNgay" AllowNull="false" Width="100%" runat="server">
                                                                                    <%--<ClientSideEvents Init="function(s,e){
                                                                                        s.SetDate(new Date());
                                                                                        }" />--%>
                                                                                </dx:ASPxDateEdit>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings Location="Left" />
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Ngày lập phiếu" ColSpan="1">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                                <dx:ASPxDateEdit ID="dateNgayLapPhieu" ClientInstanceName="dateNgayLapPhieu" AllowNull="false" Width="100%" runat="server">
                                                                                    <ClientSideEvents Init="function(s,e){s.SetDate(new Date());}" />
                                                                                </dx:ASPxDateEdit>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings Location="Left" />
                                                                    </dx:LayoutItem>
                                                                    <dx:LayoutItem Caption="Thành phần tham gia" ColSpan="1" ShowCaption="True">
                                                                        <LayoutItemNestedControlCollection>
                                                                            <dx:LayoutItemNestedControlContainer runat="server">
                                                                                <dx:ASPxHtmlEditor ID="HtmlThanhPhanThamGia" runat="server" ClientInstanceName="HtmlThanhPhanThamGia" Font-Size="Smaller" Height="100px" ToolbarMode="None" Width="100%">
                                                                                    <Settings AllowDesignView="False" AllowHtmlView="False" AllowPreview="False">
                                                                                    </Settings>
                                                                                    <SettingsHtmlEditing EnterMode="BR">
                                                                                    </SettingsHtmlEditing>
                                                                                </dx:ASPxHtmlEditor>
                                                                            </dx:LayoutItemNestedControlContainer>
                                                                        </LayoutItemNestedControlCollection>
                                                                        <CaptionSettings Location="Top" />
                                                                    </dx:LayoutItem>
                                                                </Items>
                                                            </dx:LayoutGroup>
                                                        </Items>
                                                        <SettingsItemCaptions Location="Top" />
                                                    </dx:ASPxFormLayout>
                                                </dx:PanelContent>
                                            </PanelCollection>
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
                    <dx:SplitterPane Name="splpProcess" MaxSize="100px" Size="46px">
                        <ContentCollection>
                            <dx:SplitterContentControl ID="SplitterContentControl4" runat="server">
                                <div style="align-items: center; text-align: center; padding-top: 5px;">
                                    <table style="margin: 0 auto;">
                                        <tr>
                                            <td>
                                                <dx:ASPxButton ID="btnXemTruoc" runat="server" Text="Xem trước"  BackColor="#5cb85c" AutoPostBack="false" UseSubmitBehavior="false">
                                                    <ClientSideEvents Click="onReviewClick" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="padding-left: 10px;">
                                                <dx:ASPxButton ID="btnLuu" runat="server" Text="Lưu phiếu" AutoPostBack="false" UseSubmitBehavior="false">
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
<dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
    <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
</dx:ASPxGlobalEvents>
<%--===============================================================================--%>
<script>
    function popupViewReportClose() {
        hdfViewReport.Set('view', '0');
    }
</script>
<dx:ASPxPopupControl ID="popupViewReport"
    HeaderImage-Height="50px" CloseAction="CloseButton"
    ClientInstanceName="popupViewReport" runat="server"
    HeaderText="Phiếu kiểm kê" Width="1200px" 
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
