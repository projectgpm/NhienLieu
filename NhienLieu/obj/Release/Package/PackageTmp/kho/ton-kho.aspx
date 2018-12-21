<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ton-kho.aspx.cs" Inherits="NhienLieu.kho.ton_kho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxGridView ID="gridTonKho" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTonKho" KeyFieldName="ID" OnCustomColumnDisplayText="gridTonKho_CustomColumnDisplayText" Width="100%">
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True" />
        <SettingsAdaptivity>
            <AdaptiveDetailLayoutProperties ColCount="1">
            </AdaptiveDetailLayoutProperties>
        </SettingsAdaptivity>
        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="gridTheKho" runat="server" AutoGenerateColumns="False" CssClass="mx-auto" DataSourceID="SqlDataSourceTheKho" KeyFieldName="ID" OnBeforePerformDataSelect="gridTheKho_BeforePerformDataSelect" Width="80%">
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="1">
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <SettingsPager Mode="EndlessPaging">
                    </SettingsPager>
                    <Settings ShowTitlePanel="True" />
                    <SettingsText EmptyDataRow="Chưa có dữ liệu" Title="THẺ KHO" />
                    <EditFormLayoutProperties ColCount="1">
                    </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" Visible="False" VisibleIndex="0">
                            <EditFormSettings Visible="False" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="Ngày" FieldName="NgayNhap" VisibleIndex="1">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Diễn giải" FieldName="DienGiai" VisibleIndex="2">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Nhập" FieldName="Nhap" VisibleIndex="3">
                            <PropertiesSpinEdit DisplayFormatString="g">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Xuất" FieldName="Xuat" VisibleIndex="4">
                            <PropertiesSpinEdit DisplayFormatString="g">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Tồn" FieldName="Ton" VisibleIndex="5">
                            <PropertiesSpinEdit DisplayFormatString="g">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSourceTheKho" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [NgayNhap], [DienGiai], [Nhap], [Xuat], [Ton], [NhienLieuID] FROM [Kho_TheKho] WHERE ([NhienLieuID] = @NhienLieuID) ORDER BY [ID] DESC">
                    <SelectParameters>
                        <asp:SessionParameter Name="NhienLieuID" SessionField="NhienLieuID" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>
        <Settings ShowFilterRow="True" ShowTitlePanel="True" />
        <SettingsSearchPanel Visible="True" />
        <SettingsText Title="TỒN KHO" EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Nhập dữ liệu cần tìm..." />
        <EditFormLayoutProperties ColCount="1">
        </EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" VisibleIndex="0" Width="5%">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MaNhienLieu" VisibleIndex="1" Caption="Ký hiệu">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tên - Quy cách vật tư" FieldName="TenNhienLieu" VisibleIndex="2" Width="25%">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Nhóm" FieldName="TenNhom" VisibleIndex="3">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="ĐVT" FieldName="TenDonViTinh" VisibleIndex="4">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tồn kho" FieldName="TonKho" VisibleIndex="5">
                <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Đơn giá" FieldName="DonGia" VisibleIndex="6">
                <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Giá bình quân" FieldName="GiaBinhQuan" VisibleIndex="7">
                <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataSpinEditColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSourceTonKho" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT * FROM [View_TonKho]"></asp:SqlDataSource>

</asp:Content>
