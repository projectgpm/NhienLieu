<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="xi-nghiep.aspx.cs" Inherits="NhienLieu.khai_bao.xi_nghiep" %>
<asp:Content ID="contentXiNghiep" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxGridView ID="gridXiNghiep" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridXiNghiep" DataSourceID="dsXiNghiep" KeyFieldName="ID" OnCustomColumnDisplayText="gridXiNghiep_CustomColumnDisplayText" Width="100%">
        <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ShowDetailRow="True" />
        <SettingsAdaptivity>
            <AdaptiveDetailLayoutProperties ColCount="1">
            </AdaptiveDetailLayoutProperties>
        </SettingsAdaptivity>
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="griddsBen" runat="server" AutoGenerateColumns="False" ClientInstanceName="griddsBen" CssClass="mx-auto" DataSourceID="dsBen" KeyFieldName="ID" OnBeforePerformDataSelect="griddsBen_BeforePerformDataSelect" OnCustomColumnDisplayText="griddsBen_CustomColumnDisplayText" Width="80%">
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="1">
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <SettingsPager Mode="EndlessPaging">
                    </SettingsPager>
                    <Settings ShowTitlePanel="True" />
                    <SettingsBehavior AllowEllipsisInText="True" AllowSelectByRowClick="True" />
                    <SettingsText EmptyDataRow="Chưa có dữ liệu" Title="DANH SÁCH BẾN" />
                    <EditFormLayoutProperties ColCount="1">
                    </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Width="5%">
                            <EditFormSettings Visible="False" />
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tên bến" FieldName="TenBen" ShowInCustomizationForm="True" VisibleIndex="1">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="DienThoai" ShowInCustomizationForm="True" VisibleIndex="2">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Địa chỉ" FieldName="DiaChi" ShowInCustomizationForm="True" VisibleIndex="3">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="XiNghiepID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="5">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="DaXoa" VisibleIndex="4">
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
                <asp:SqlDataSource ID="dsBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen], [DienThoai], [DiaChi], [DaXoa], [XiNghiepID] FROM [Ben] WHERE ([XiNghiepID] = @XiNghiepID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="XiNghiepID" SessionField="XiNghiepID" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <Settings ShowFilterRow="True" ShowTitlePanel="True" />
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
            <EditButton Text="Sửa">
                <Image IconID="edit_edit_16x16" ToolTip="Sửa">
                </Image>
            </EditButton>
        </SettingsCommandButton>
        <SettingsSearchPanel Visible="True" />
        <SettingsText EmptyDataRow="Chưa có dữ liệu" SearchPanelEditorNullText="Nhập dữ liệu cần tìm..." Title="DANH SÁCH XÍ NGHIỆP PHÀ" />
        <EditFormLayoutProperties ColCount="1">
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowEditButton="True" ShowInCustomizationForm="True" VisibleIndex="7">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Width="5%">
                <EditFormSettings Visible="False" />
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tên xí nghiệp" FieldName="TenXiNghiep" ShowInCustomizationForm="True" VisibleIndex="1">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Địa chỉ" FieldName="DiaChi" ShowInCustomizationForm="True" VisibleIndex="2">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="SĐT" FieldName="SDT" ShowInCustomizationForm="True" VisibleIndex="3">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MST" ShowInCustomizationForm="True" VisibleIndex="4">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Ghi chú" FieldName="GhiChu" ShowInCustomizationForm="True" VisibleIndex="5">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Trạng thái" FieldName="DaXoa" ShowInCustomizationForm="True" VisibleIndex="6">
                <PropertiesComboBox>
                    <Items>
                        <dx:ListEditItem Selected="True" Text="Đang hoạt động" Value="0" />
                        <dx:ListEditItem Text="Ngừng hoạt động" Value="1" />
                    </Items>
                </PropertiesComboBox>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight Expression="DaXoa = 0" FieldName="DaXoa" Format="GreenFillWithDarkGreenText">
            </dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionHighlight Expression="DaXoa =1" FieldName="DaXoa">
            </dx:GridViewFormatConditionHighlight>
        </FormatConditions>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsXiNghiep" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" DeleteCommand="DELETE FROM [XiNghiep] WHERE [ID] = @ID" InsertCommand="INSERT INTO [XiNghiep] ([TenXiNghiep], [DiaChi], [SDT], [MST], [GhiChu], [DaXoa]) VALUES (@TenXiNghiep, @DiaChi, @SDT, @MST, @GhiChu, @DaXoa)" SelectCommand="SELECT * FROM [XiNghiep]" UpdateCommand="UPDATE [XiNghiep] SET [TenXiNghiep] = @TenXiNghiep, [DiaChi] = @DiaChi, [SDT] = @SDT, [MST] = @MST, [GhiChu] = @GhiChu, [DaXoa] = @DaXoa WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TenXiNghiep" Type="String" />
            <asp:Parameter Name="DiaChi" Type="String" />
            <asp:Parameter Name="SDT" Type="String" />
            <asp:Parameter Name="MST" Type="String" />
            <asp:Parameter Name="GhiChu" Type="String" />
            <asp:Parameter Name="DaXoa" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="TenXiNghiep" Type="String" />
            <asp:Parameter Name="DiaChi" Type="String" />
            <asp:Parameter Name="SDT" Type="String" />
            <asp:Parameter Name="MST" Type="String" />
            <asp:Parameter Name="GhiChu" Type="String" />
            <asp:Parameter Name="DaXoa" Type="Int32" />
            <asp:Parameter Name="ID" Type="Int64" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
