<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="quyet-toan-xi-nghiep.aspx.cs" Inherits="NhienLieu.nhap_lieu.quyet_toan_xi_nghiep" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function AdjustSize() {
            var hformThongTin = form_info.GetHeight();
            UpdateHeightControlInPage(gridQuyetToan, hformThongTin);
        }
        let LapBang = () => {
            if (cbb_Ben.GetSelectedIndex() == -1) {
                baoloi('Vui lòng chọn bến!');
                return;
            }
            cbp_BQT.PerformCallback('LapPhieu');
        }
        let EndCallBack = (s, e) => {
            if (s.cp_grid_null) {
                baoloi('Danh sách trống!');
                delete s.cp_grid_null;
            }
            if (s.cp_Error_Save) {
                baoloi('Thao tác không thành công, thử lại sau!');
                delete scp_Error_Save;
            }
            if (s.cp_Reset) {
                thongbao('Lưu phiếu thành công!');
                delete s.cp_Reset;
            }
        }

        let Refill_Date = () => cbpInfo.PerformCallback('Refill');

        let check_Save = () => {
            if (cbb_Ben.GetSelectedIndex() == -1) {
                baoloi('Vui lòng chọn bến!');
                return false;
            }
            if (cbThang.GetSelectedIndex() == -1) {
                baoloi('Vui lòng chọn tháng!');
                return false;
            }
            if (cbNam.GetSelectedIndex() == -1) {
                baoloi('Vui lòng chọn năm!');
                return false;
            }
            if (cbKy.GetSelectedIndex() == -1) {
                baoloi('Vui lòng chọn kỳ!');
                return false;
            }
            return true;
        }

        let btnPreviewClick = () => {
            if (check_Save())
                cbp_BQT.PerformCallback('Review');
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
                                cbp_BQT.PerformCallback('save');
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
        let onUnitReturnChanged = (s,e,key) => {
            console.log(s.name);
            let index = s.name.lastIndexOf('_'); // lấy index
            let sub = s.name.substr(index + 1, s.name.length - index); //cắt chuỗi
            cbp_BQT.PerformCallback(`UnitChange|${key}|${sub}`);
        }
    </script>
    <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <dx:ASPxFormLayout ID="form_info" ClientInstanceName="form_info" runat="server" ColCount="5" ColumnCount="5" Width="100%">
                    <Items>
                        <dx:LayoutItem Caption="Bến" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cbb_Ben" ClientInstanceName="cbb_Ben" runat="server" DataSourceID="dsBen" TextField="TenXiNghiep" ValueField="ID" Width="100%">
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="dsBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenXiNghiep] FROM [XiNghiep]"></asp:SqlDataSource>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Kỳ" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cbKy" ClientInstanceName="cbKy" runat="server" Width="100%">
                                        <Items>
                                            <dx:ListEditItem Text="Đầu kỳ (Từ ngày 01 -&gt; 10)" Value="0" />
                                            <dx:ListEditItem Text="Giữa kỳ (Từ ngày 11 -&gt; 20)" Value="1" />
                                            <dx:ListEditItem Text="Cuối kỳ (Còn lại)" Value="2" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Tháng" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cbThang" ClientInstanceName="cbThang" runat="server" Width="100%">
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Năm" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cbNam" ClientInstanceName="cbNam" runat="server" Width="100%">
                                        <ClientSideEvents  SelectedIndexChanged="Refill_Date" />
                                    </dx:ASPxComboBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="btnOK" ClientInstanceName="btnOK" runat="server" Text="LẬP BẢNG" AutoPostBack="false" Width="100%">
                                        <ClientSideEvents Click="LapBang" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
               </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents EndCallback="EndCallBack" />
    </dx:ASPxCallbackPanel>
                <dx:ASPxCallbackPanel ID="cbp_BQT" ClientInstanceName="cbp_BQT" runat="server" Width="100%" OnCallback="cbp_BQT_Callback">
        <PanelCollection>
            <dx:PanelContent runat="server">
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
                            <PropertiesSpinEdit DisplayFormatString="N2">
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
                    
                </dx:ASPxVerticalGrid>
                <asp:SqlDataSource ID="dsQuyetToan" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="pr_QuyetToanBen" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbpInfo$form_info$cbb_Ben" Name="BenID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
                    <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
                </dx:ASPxGlobalEvents>
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents EndCallback="EndCallBack" />
    </dx:ASPxCallbackPanel>
    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="1" Width="100%">
        <Items>
            <dx:LayoutItem Caption="" ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <div id="groupbtn" style="align-items: center; text-align: center; padding-top: 5px;">
                            <table style="margin: 0 auto;">
                                <tr>
                                    <td >
                                        <dx:ASPxButton ID="btnPrivew"  ClientInstanceName="btnPrivew" runat="server" Text="Xem trước" BackColor="#5cb85c"  AutoPostBack="false"  UseSubmitBehavior="false">
                                        <ClientSideEvents Click="btnPreviewClick" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td style="padding-left: 50px;">
                                        <dx:ASPxButton ID="btnLuuVaIn" runat="server" Text="Lưu phiếu" AutoPostBack="false" UseSubmitBehavior="false">
                                            <ClientSideEvents Click="onSaveClick" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td style="padding-left: 50px;">
                                        <dx:ASPxButton ID="btnTroVe"  ClientInstanceName="btnTroVe" runat="server" Text="Trở về" BackColor="#d9534f" AutoPostBack="false"  UseSubmitBehavior="false">
                                        <ClientSideEvents Click="btnTroVeClick" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
        </Items>
    </dx:ASPxFormLayout>

</asp:Content>
