<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="pha.aspx.cs" Inherits="NhienLieu.khai_bao.pha" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        let AdjustSize = () => {
            let hformThongTin = flThongTin.GetHeight();
            UpdateHeightControlInPage(gridPha, hformThongTin);
        }
        let btnDieuDongPhaClick = () => {
            if (cbbPha.lastSuccessValue == null) {
                baoloi('Chưa chọn phà điều động!');
                return;
            }
            if (cbbBen.lastSuccessValue == null) {
                baoloi('Chưa chọn bến chuyển đến!');
                return;
            }
            if (deNgayDieuDong.date == null) {
                baoloi('Chưa chọn ngày điều động!');
                return;
            }
            cbpgridPha.PerformCallback('Move|');
            gridPha.Refresh();
        }
        let endCallBackPha = (s, e) => {
            if (s.cp_Susss) {
                delete (s.cp_Susss);
                thongbao('Điều động thành công!');
                pcDieuDong.Hide();
                gridPha.Refresh();

            }
            if (s.cp_Error) {
                delete (s.cp_Error);
                baoloi('Không thể điều động, hãy thử lại!');
            }
            if (s.cp_trungben) {
                delete (s.cp_trungben);
                baoloi('Không thể điều động trùng bến!');
            }

        }
    </script>
     <dx:ASPxFormLayout ID="flThongTin" runat="server" ClientInstanceName="flThongTin" ColCount="2">
        <Items>
            <dx:LayoutItem ShowCaption="False">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer ID="LayoutItemNestedControlContainer1" runat="server">
                        <table>
                            <tr>
                                <td><dx:ASPxButton ID="btnDieuDong" ClientInstanceName="btnDieuDong" runat="server"  Text="ĐIỀU ĐỘNG PHÀ" CssClass="ml-3" AutoPostBack="False" >
                                    <ClientSideEvents Click="function(s, e) {
	pcDieuDong.Show();
}" />
       </dx:ASPxButton></td>
                            </tr>
                        </table>
                        
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            
        </Items>
    </dx:ASPxFormLayout>
    <dx:ASPxCallbackPanel ID="cbpgridPha" ClientInstanceName="cbpgridPha" runat="server" Width="100%" OnCallback="cbpgridPha_Callback">
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxGridView ID="gridPha" ClientInstanceName="gridPha" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePha" KeyFieldName="ID" Width="100%" OnCustomColumnDisplayText="gridPha_CustomColumnDisplayText">
                             <SettingsPager PageSizeItemSettings-Caption="Kích thước trang">
<Summary EmptyText="Kh&#244;ng c&#243; dữ liệu" Text="Trang {0}/{1}"></Summary>

                                <PageSizeItemSettings Visible="true" Items="30, 50, 100"/>
                          </SettingsPager>

                        <Settings ShowFilterRow="True" ShowTitlePanel="True" />
                        <SettingsDetail ShowDetailRow="true" />
                <SettingsAdaptivity>
                <AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
                </SettingsAdaptivity>
                        <Templates>
                        <DetailRow>
                            <div style="width: 100%; text-align:center;">
                                <div style="display:inline-block;">
                                    <dx:ASPxGridView ID="gridThePha" ClientInstanceName="gridThePha" runat="server" Width="800px" AutoGenerateColumns="False" DataSourceID="SqlDataSourceThePha" KeyFieldName="ID"  OnBeforePerformDataSelect="gridPha_BeforePerformDataSelect">

                                        <SettingsAdaptivity>
                                            <AdaptiveDetailLayoutProperties ColCount="1">
                                            </AdaptiveDetailLayoutProperties>
                                        </SettingsAdaptivity>
                                        <EditFormLayoutProperties ColCount="1">
                                        </EditFormLayoutProperties>
                                        <SettingsText Title="LỊCH SỬ ĐIỀU ĐỘNG" EmptyDataRow="Không có dữ liệu" />
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" Visible="False" VisibleIndex="0" SortIndex="0" SortOrder="Descending">
                                                <EditFormSettings Visible="False" />
                                                <HeaderStyle HorizontalAlign="Center" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Ngày điều động" FieldName="NgayDieuDong" VisibleIndex="4">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <CellStyle HorizontalAlign="Center">
                                                </CellStyle>
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="Bến điều động" FieldName="BenCuID" VisibleIndex="2">
                                                <PropertiesComboBox DataSourceID="SqlDataSourceBen" TextField="TenBen" ValueField="ID">
                                                </PropertiesComboBox>
                                                <HeaderStyle HorizontalAlign="Center" />
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="Bến chuyển đến" FieldName="BenMoiID" VisibleIndex="3">
                                                <PropertiesComboBox DataSourceID="SqlDataSourceBen" TextField="TenBen" ValueField="ID">
                                                </PropertiesComboBox>
                                                <HeaderStyle HorizontalAlign="Center" />
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="Phà" FieldName="PhaID" ShowInCustomizationForm="True" VisibleIndex="1">
                                                <PropertiesComboBox DataSourceID="SqlDataSourcePha" TextField="TenPha" ValueField="ID">
                                                </PropertiesComboBox>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <CellStyle HorizontalAlign="Center">
                                                </CellStyle>
                                            </dx:GridViewDataComboBoxColumn>
                                        </Columns>

                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="SqlDataSourceThePha" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT ID, PhaID, BenCuID, BenMoiID, NgayDieuDong FROM Pha_DieuDong WHERE (PhaID = @PhaID)">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="PhaID" SessionField="PhaID" Type="String"/>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                        </DetailRow>
                        </Templates>
                        <SettingsPager PageSize="30" AlwaysShowPager="True" >
                            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />

                <PageSizeItemSettings Items="30, 50, 100" Caption="K&#237;ch thước trang" Visible="True"></PageSizeItemSettings>
                        </SettingsPager>

                        <SettingsEditing Mode="PopupEditForm">
                        </SettingsEditing>

                        <Settings VerticalScrollBarMode="Visible" VerticalScrollableHeight="0" ShowTitlePanel="false" ShowFooter="True"/>
                        <SettingsBehavior ConfirmDelete="True" AllowHeaderFilter="False" />
                        <SettingsCommandButton>
                            <ClearFilterButton Text="Hủy lọc">
                            </ClearFilterButton>
                            <NewButton Text="Thêm mới">
                                <Image IconID="actions_add_16x16">
                                </Image>
                            </NewButton>
                            <UpdateButton Text="Lưu lại">
                                <Image IconID="save_save_32x32">
                                </Image>
                            </UpdateButton>
                            <CancelButton Text="Hủy">
                                <Image IconID="actions_cancel_32x32">
                                </Image>
                            </CancelButton>
                            <EditButton ButtonType="Image" RenderMode="Image">
                                <Image IconID="edit_edit_16x16" ToolTip="Sửa">
                                </Image>
                            </EditButton>
                            <DeleteButton ButtonType="Image" RenderMode="Image">
                                <Image IconID="edit_delete_16x16" ToolTip="Xóa">
                                </Image>
                            </DeleteButton>
                        </SettingsCommandButton>
                        <SettingsDataSecurity AllowDelete="False" />
                        <SettingsPopup>
                            <EditForm HorizontalAlign="WindowCenter" Modal="True" ShowHeader="False" VerticalAlign="WindowCenter" Width="800px">
                            </EditForm>
                        </SettingsPopup>
                        <SettingsSearchPanel Visible="True" />

                        <SettingsText ConfirmDelete="Xác nhận xóa?" EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Nhập dữ liệu cần tìm..." Title="DANH SÁCH PHÀ" />
                        
                        <EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
                        <Columns>
                            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="7" ShowClearFilterButton="True">
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            </dx:GridViewCommandColumn>
                            <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" VisibleIndex="0" Width="5%">
                                <EditFormSettings Visible="False" />
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                <CellStyle HorizontalAlign="Center">
                                </CellStyle>
                                <ExportCellStyle Font-Bold="True" HorizontalAlign="Center">
                                </ExportCellStyle>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="Tên phà" FieldName="TenPha" VisibleIndex="1">
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                <ExportCellStyle Font-Bold="True" HorizontalAlign="Center">
                                </ExportCellStyle>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="Số phà cũ" FieldName="SoPhaCu" VisibleIndex="2">
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                <ExportCellStyle Font-Bold="True" HorizontalAlign="Center">
                                </ExportCellStyle>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn Caption="Số hiệu" FieldName="SoHieu" VisibleIndex="3">
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                <ExportCellStyle Font-Bold="True" HorizontalAlign="Center">
                                </ExportCellStyle>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataComboBoxColumn Caption="Bến" FieldName="BenID" VisibleIndex="5">
                                <PropertiesComboBox DataSourceID="SqlDataSourceBen" TextField="TenBen" ValueField="ID">
                                </PropertiesComboBox>
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                <ExportCellStyle Font-Bold="True" HorizontalAlign="Center">
                                </ExportCellStyle>
                            </dx:GridViewDataComboBoxColumn>
                            <dx:GridViewDataSpinEditColumn Caption="Định mức (lít/tua)" FieldName="DinhMuc" VisibleIndex="4">
                                <PropertiesSpinEdit DisplayFormatString="N1" NumberFormat="Custom">
                                </PropertiesSpinEdit>
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                <ExportCellStyle Font-Bold="True" HorizontalAlign="Center">
                                </ExportCellStyle>
                            </dx:GridViewDataSpinEditColumn>
                            <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="DaXoa" ShowInCustomizationForm="True" VisibleIndex="6">
                                <PropertiesComboBox>
                                    <Items>
                                        <dx:ListEditItem Text="Đang hoạt động" Value="0" />
                                        <dx:ListEditItem Text="Ngừng hoạt động" Value="1" />
                                    </Items>
                                </PropertiesComboBox>
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            </dx:GridViewDataComboBoxColumn>
                        </Columns>
                        <TotalSummary>
                            <dx:ASPxSummaryItem DisplayFormat="Tổng số dòng = {0}" FieldName="TenPha" ShowInGroupFooterColumn="Tên phà" SummaryType="Count" />
                        </TotalSummary>
                             <FormatConditions>
                                 <dx:GridViewFormatConditionHighlight Expression="[DaXoa] = 0" FieldName="DaXoa" Format="GreenFillWithDarkGreenText">
                                 </dx:GridViewFormatConditionHighlight>
                                 <dx:GridViewFormatConditionHighlight Expression="[DaXoa] = 1" FieldName="DaXoa">
                                 </dx:GridViewFormatConditionHighlight>
                             </FormatConditions>
                    </dx:ASPxGridView>
            </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents EndCallback="endCallBackPha" />
    </dx:ASPxCallbackPanel>
    
    <asp:SqlDataSource ID="SqlDataSourcePha" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT * FROM [Pha]" UpdateCommand="UPDATE Pha SET TenPha = @TenPha, SoPhaCu = @SoPhaCu, SoHieu = @SoHieu, DinhMuc = @DinhMuc, BenID = @BenID, DaXoa = @DaXoa WHERE (ID = @ID)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) {
	        UpdateControlHeight(gridPha);
        }" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridPha);
        }" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxPopupControl ID="pcDieuDong" ClientInstanceName="pcDieuDong" runat="server" ShowFooter="True"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px" CloseAction="CloseButton" HeaderText="ĐIỀU ĐỘNG PHÀ" Modal="True" PopupAnimationType="Fade">
       <HeaderStyle BackColor="#009688" Font-Bold="True" ForeColor="White" Font-Names="&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif" Font-Size="Large" />
        <ContentCollection>

<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td>
                <dx:ASPxComboBox ID="cbbPha" ClientInstanceName="cbbPha" runat="server" ValueType="System.String" DataSourceID="pcPha" TextField="TenPha" ValueField="ID" NullText="--Chọn phà điều động--" Caption="Chọn phà" Width="100%"></dx:ASPxComboBox>
                <asp:SqlDataSource ID="pcPha" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenPha] FROM [Pha]"></asp:SqlDataSource>
            </td>
            <td>
                <dx:ASPxComboBox ID="cbbBen" ClientInstanceName="cbbBen" runat="server" ValueType="System.String" DataSourceID="pcBen" TextField="TenBen" ValueField="ID" NullText="--Chọn bến chuyển đến--" Caption="Bến chuyển đến" Width="100%"></dx:ASPxComboBox>
                <asp:SqlDataSource ID="pcBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxDateEdit ID="deNgayDieuDong" ClientInstanceName="deNgayDieuDong" runat="server" NullText="--Ngày điều động--" Caption="Ngày điều động" MaxDate="2999-12-31" MinDate="2010-01-01" Width="100%" OnInit="deNgayDieuDong_Init"></dx:ASPxDateEdit>
            </td>
        </tr>
    </table>

</dx:PopupControlContentControl>
</ContentCollection>
        <FooterTemplate>
            <div style="margin-left: 350px;">
                <dx:ASPxButton ID="btnDieuDongPha" runat="server" Text="ĐIỀU ĐỘNG PHÀ" AutoPostBack="false">
                    <ClientSideEvents Click="btnDieuDongPhaClick" />
                </dx:ASPxButton>
            </div>
        </FooterTemplate>
    </dx:ASPxPopupControl>
</asp:Content>
