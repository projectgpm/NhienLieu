<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ben.aspx.cs" Inherits="NhienLieu.khai_bao.ben" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function AdjustSize(){
            //let hformThongTin = flThongTinBen.GetHeight();
            UpdateHeightControlInPage(gridBen, 1);
            //UpdateControlHeight(gridBen);
        }
    </script>
    
    <dx:ASPxGridView ID="gridBen" ClientInstanceName="gridBen" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceBen" KeyFieldName="ID" Width="100%">
        <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ShowDetailRow="True" />
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="gridDSPha" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridDSPha" CssClass="mx-auto" DataSourceID="dsPha" KeyFieldName="ID" OnBeforePerformDataSelect="gridDSPha_BeforePerformDataSelect" OnCustomColumnDisplayText="gridDSPha_CustomColumnDisplayText" Width="80%">
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="1">
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <SettingsPager Mode="EndlessPaging">
                    </SettingsPager>
                    <Settings ShowTitlePanel="True" />
                    <SettingsBehavior AllowEllipsisInText="True" AllowSelectByRowClick="True" />
                    <SettingsText EmptyDataRow="Chưa có dữ liệu" Title="DANH SÁCH PHÀ" />
                    <EditFormLayoutProperties ColCount="1">
                    </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" VisibleIndex="0" Width="5%">
                            <EditFormSettings Visible="False" />
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tên phà" FieldName="TenPha" VisibleIndex="1">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Số phà cũ" FieldName="SoPhaCu" VisibleIndex="2">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Số hiệu" FieldName="SoHieu" VisibleIndex="3">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Định mức (lít/tua)" FieldName="DinhMuc" VisibleIndex="4">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="BenID" Visible="False" VisibleIndex="5">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="DaXoa" VisibleIndex="6">
                            <PropertiesComboBox>
                                <Items>
                                    <dx:ListEditItem Text="Đang hoạt động" Value="0" />
                                    <dx:ListEditItem Text="Ngừng hoạt động" Value="1" />
                                </Items>
                            </PropertiesComboBox>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataComboBoxColumn>
                    </Columns>
                    <FormatConditions>
                        <dx:GridViewFormatConditionHighlight Expression="DaXoa = 0" FieldName="DaXoa" Format="GreenFillWithDarkGreenText">
                        </dx:GridViewFormatConditionHighlight>
                        <dx:GridViewFormatConditionHighlight Expression="DaXoa = 1" FieldName="DaXoa">
                        </dx:GridViewFormatConditionHighlight>
                    </FormatConditions>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsPha" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenPha], [SoPhaCu], [SoHieu], [DinhMuc], [BenID], [DaXoa] FROM [Pha] WHERE ([BenID] = @BenID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="BenID" SessionField="BenID" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <SettingsPager PageSize="30" AlwaysShowPager="True" >
            <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
            <PageSizeItemSettings Items="30, 50, 100" Caption="K&#237;ch thước trang" Visible="True"></PageSizeItemSettings>
        </SettingsPager>
        <Settings ShowFilterRow="True" ShowFooter="True" VerticalScrollableHeight="0" VerticalScrollBarMode="Visible" ShowTitlePanel="True" />
        <SettingsBehavior ConfirmDelete="True" AllowDragDrop="False" AllowEllipsisInText="True" AllowSelectByRowClick="True" />
        <SettingsText ConfirmDelete="Xác nhận xóa?" EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Nhập dữ liệu cần tìm..." Title="DANH SÁCH BẾN" />
        <SettingsResizing ColumnResizeMode="NextColumn" />
        <SettingsCommandButton>
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
        <SettingsSearchPanel Visible="True" />

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="8" Caption="#">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Width="5%">
                <EditFormSettings Visible="False" />
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tên bến" FieldName="TenBen" ShowInCustomizationForm="True" VisibleIndex="1">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Địa chỉ" FieldName="DiaChi" ShowInCustomizationForm="True" VisibleIndex="2">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" ShowInCustomizationForm="True" VisibleIndex="3">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn Caption="Ngày tạo" FieldName="NgayTao" ShowInCustomizationForm="True" VisibleIndex="6" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn Caption="Ngày thay đổi" FieldName="NgayThayDoi" ShowInCustomizationForm="True" VisibleIndex="7" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="DaXoa" ShowInCustomizationForm="True" VisibleIndex="5">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Text="Đang hoạt động" Value="0" />
                        <dx:ListEditItem Text="Ngừng hoạt động" Value="1" />
                    </Items>
                </PropertiesComboBox>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn Caption="Xí nghiệp" FieldName="XiNghiepID" VisibleIndex="4">
                <PropertiesComboBox DataSourceID="dsXiNghiep" TextField="TenXiNghiep" ValueField="ID">
                </PropertiesComboBox>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <TotalSummary>
            <dx:ASPxSummaryItem DisplayFormat="Tổng số dòng =  {0}" FieldName="TenBen" ShowInGroupFooterColumn="Tên bến" SummaryType="Count" />
        </TotalSummary>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight Expression="DaXoa = 0" FieldName="DaXoa" Format="GreenFillWithDarkGreenText">
            </dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionHighlight Expression="DaXoa = 1" FieldName="DaXoa">
            </dx:GridViewFormatConditionHighlight>
        </FormatConditions>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsXiNghiep" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenXiNghiep] FROM [XiNghiep]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" DeleteCommand="UPDATE [Ben] SET [NgayThayDoi] = getdate(), [DaXoa] = 1 WHERE [ID] = @ID" InsertCommand="INSERT INTO Ben(TenBen, DiaChi, DienThoai, NgayTao, NgayThayDoi, DaXoa, XiNghiepID) VALUES (@TenBen, @DiaChi, @DienThoai, GETDATE(), GETDATE(), 0, @XiNghiepID)" SelectCommand="SELECT * FROM [Ben]" UpdateCommand="UPDATE Ben SET TenBen = @TenBen, DiaChi = @DiaChi, DienThoai = @DienThoai, NgayThayDoi = GETDATE(), DaXoa = @DaXoa, XiNghiepID = @XiNghiepID WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TenBen" Type="String" />
            <asp:Parameter Name="DiaChi" Type="String" />
            <asp:Parameter Name="DienThoai" Type="String" />
            <asp:Parameter Name="XiNghiepID" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="TenBen" Type="String" />
            <asp:Parameter Name="DiaChi" Type="String" />
            <asp:Parameter Name="DienThoai" Type="String" />
            <asp:Parameter Name="DaXoa" Type="Int32" />
            <asp:Parameter Name="XiNghiepID" />
            <asp:Parameter Name="ID" Type="Int64" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <dx:ASPxGlobalEvents ID="globalEventGrid" runat="server">
        <ClientSideEvents BrowserWindowResized="function(s, e) { UpdateControlHeight(gridBen);}" ControlsInitialized="function(s, e) {
	        UpdateControlHeight(gridBen);}" />
    </dx:ASPxGlobalEvents>
    <dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server">
        <ClientSideEvents BrowserWindowResized="AdjustSize" ControlsInitialized="AdjustSize" />
    </dx:ASPxGlobalEvents>
</asp:Content>
