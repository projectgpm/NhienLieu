﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ton-kho.aspx.cs" Inherits="NhienLieu.kho.ton_kho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        let TonKhoCB = () => {
            if (cbbBen.GetSelectedIndex() == -1) {
                baoloi('Vui lòng chọn kho!');
                return;
            }
            gridTonKho.Refresh();
        }
        let EndCBTonKho = () => {
        }
    </script>
    <div class="mx-auto" style="font-size: 14pt; width:14%; padding: 5px;" >TỒN KHO</div>
    <dx:ASPxCallbackPanel ID="cbpTonkho" ClientInstanceName="cbpTonkho" runat="server" Width="100%" OnCallback="cbpTonkho_Callback">
        
        <PanelCollection>
        <dx:PanelContent runat="server">
                <dx:ASPxFormLayout ID="formkho" ClientInstanceName="formkho" runat="server" ColCount="2" ColumnCount="2" Width="50%" CssClass="mx-auto">
                    <Items>
                        <dx:LayoutItem Caption="Chọn kho" ColSpan="1" Width="70%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cbbBen" ClientInstanceName="cbbBen" runat="server" DataSourceID="dsBen" TextField="TenBen" ValueField="ID" Width="100%" NullText="-- Chọn kho --">
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="dsBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="" ColSpan="1" Width="30%">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="btnXem" runat="server" Text="Xem tồn kho" AutoPostBack="false" Width="100%">
                                        <ClientSideEvents Click="TonKhoCB" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
                    </dx:PanelContent>
        </PanelCollection>
        <ClientSideEvents EndCallback="EndCBTonKho" />
    </dx:ASPxCallbackPanel>
    <dx:ASPxGridView ID="gridTonKho" ClientInstanceName="gridTonKho" runat="server" AutoGenerateColumns="False" Width="100%" DataSourceID="dsTonKho" KeyFieldName="NhienLieuID" OnCustomColumnDisplayText="gridTonKho_CustomColumnDisplayText">
        <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ShowDetailRow="True" />
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>

        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="gridTheKho" ClientInstanceName="gridTheKho" runat="server" AutoGenerateColumns="False" CssClass="mx-auto" DataSourceID="dsTheKho" KeyFieldName="NhienLieuID; BenID" Width="70%" OnBeforePerformDataSelect="gridTheKho_BeforePerformDataSelect" OnCustomColumnDisplayText="gridTheKho_CustomColumnDisplayText">
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="1">
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <SettingsPager Mode="EndlessPaging">
                    </SettingsPager>
                    <Settings ShowTitlePanel="True" />
                    <SettingsBehavior AllowDragDrop="False" />
                    <SettingsText EmptyDataRow="Chưa có dữ liệu" Title="THẺ KHO" />
                    <EditFormLayoutProperties ColCount="1">
                    </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" VisibleIndex="0" Width="5%">
                            <EditFormSettings Visible="False" />
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataDateColumn Caption="Ngày" FieldName="NgayNhap" VisibleIndex="1">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataDateColumn>
                        <dx:GridViewDataTextColumn Caption="Diễn giải" FieldName="DienGiai" VisibleIndex="2">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Nhập" FieldName="Nhap" VisibleIndex="3">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Xuất" FieldName="Xuat" VisibleIndex="4">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Tồn" FieldName="Ton" VisibleIndex="5">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsTheKho" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT ID, NgayNhap, DienGiai, Nhap, Xuat, Ton, NhienLieuID, BenID FROM Kho_TheKho WHERE (NhienLieuID = @NhienLieuID) AND (BenID = @BenID) ORDER BY ID DESC">
                    <SelectParameters>
                        <asp:SessionParameter Name="NhienLieuID" SessionField="NhienLieuID" Type="Int64" />
                        <asp:ControlParameter Name="BenID" ControlID="cbpTonkho$formkho$cbbBen" PropertyName="Value" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </DetailRow>
        </Templates>

        <SettingsText EmptyDataRow="Chưa có dữ liệu" />

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
        <Columns>
            <dx:GridViewDataTextColumn Caption="STT" VisibleIndex="0" FieldName="ID">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Ký hiệu" VisibleIndex="1" FieldName="MaNhienLieu">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tên - Quy cách vật tư" VisibleIndex="2" FieldName="TenNhienLieu">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="ĐVT" VisibleIndex="3" FieldName="TenDonViTinh">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Nhóm" VisibleIndex="4" FieldName="TenNhom">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataSpinEditColumn Caption="Giá bình quân" FieldName="GiaBinhQuan" VisibleIndex="7">
                <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Đơn giá" FieldName="DonGia" VisibleIndex="6">
                <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Tồn kho" FieldName="TonKho" VisibleIndex="5">
                <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataSpinEditColumn Caption="Giá trị tồn kho" FieldName="GiaTriTonKho" ReadOnly="True" VisibleIndex="8">
                <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataTextColumn FieldName="NhienLieuID" Visible="False" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight Expression="TonKho &gt; 0" FieldName="TonKho" Format="GreenFillWithDarkGreenText">
            </dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionHighlight Expression="TonKho &lt;= 0" FieldName="TonKho">
            </dx:GridViewFormatConditionHighlight>
        </FormatConditions>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="dsTonKho" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="pr_TonKho" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cbpTonkho$formkho$cbbBen" Name="KhoID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
