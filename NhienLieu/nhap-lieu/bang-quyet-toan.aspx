<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="bang-quyet-toan.aspx.cs" Inherits="NhienLieu.nhap_lieu.bang_quyet_toan" %>
<asp:Content ID="BangQuyetToan" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxCallbackPanel ID="cbp_BQT" ClientInstanceName="cbp_BQT" runat="server" Width="100%">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <dx:ASPxFormLayout ID="form_BQT" ClientInstanceName="form_BQT" runat="server" ColCount="4" ColumnCount="4" Width="100%">
                    <Items>
                        <dx:LayoutItem Caption="Bến" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxComboBox ID="cbb_Ben" runat="server" DataSourceID="dsBen" TextField="TenBen" ValueField="ID" Width="100%">
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="dsBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Từ ngày" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="fromDay" runat="server" AllowNull="False" ClientInstanceName="fromDay" OnInit="dateEditControl_Init">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="đến ngày" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="toDay" runat="server" AllowNull="False" ClientInstanceName="toDay" OnInit="dateEditControl_Init">
                                        <DateRangeSettings StartDateEditID="fromDay" />
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="" ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="btnOK" ClientInstanceName="btnOK" runat="server" Text="LẬP BẢNG">
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
                <dx:ASPxGridView ID="gridBangQuyetToan" runat="server" Width="100%" AutoGenerateColumns="False" ClientInstanceName="gridBangQuyetToan" DataSourceID="dsBangQuyetToan">
                    <SettingsAdaptivity>
                        <AdaptiveDetailLayoutProperties ColCount="1">
                        </AdaptiveDetailLayoutProperties>
                    </SettingsAdaptivity>
                    <EditFormLayoutProperties ColCount="1">
                    </EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewDataTextColumn Caption="Tên phà" FieldName="TenPha" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewBandColumn Caption="TUA" ShowInCustomizationForm="True" VisibleIndex="8">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <Columns>
                                <dx:GridViewDataSpinEditColumn Caption="Tua ngày" FieldName="TuaNgay" ShowInCustomizationForm="True" VisibleIndex="0">
                                    <PropertiesSpinEdit DisplayFormatString="g">
                                    </PropertiesSpinEdit>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Tua đêm" FieldName="TuaDem" ShowInCustomizationForm="True" VisibleIndex="1">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                </dx:GridViewDataSpinEditColumn>
                            </Columns>
                        </dx:GridViewBandColumn>
                        <dx:GridViewBandColumn Caption="Dầu D.O (Lít)" ShowInCustomizationForm="True" VisibleIndex="10">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <Columns>
                                <dx:GridViewBandColumn Caption="Vận chuyển" ShowInCustomizationForm="True" VisibleIndex="0">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <dx:GridViewDataSpinEditColumn Caption="Đêm" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="VCDem">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                        </dx:GridViewDataSpinEditColumn>
                                        <dx:GridViewDataSpinEditColumn Caption="Ngày" ShowInCustomizationForm="True" VisibleIndex="0" FieldName="VCNgay">
                                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                            </PropertiesSpinEdit>
                                            <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                        </dx:GridViewDataSpinEditColumn>
                                    </Columns>
                                </dx:GridViewBandColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Bơm nước vệ sinh phà" ShowInCustomizationForm="True" VisibleIndex="1">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="speBomNuoc" runat="server" Width="170px" Number="0" DisplayFormatString="N2">
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Máy phát trên phà" ShowInCustomizationForm="True" VisibleIndex="2">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="speMayPhat" runat="server" Width="170px" Number="0" DisplayFormatString="N2">
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Công tác" ShowInCustomizationForm="True" VisibleIndex="3">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="speCongTac" runat="server" Width="170px" Number="0" DisplayFormatString="N2">
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:GridViewDataSpinEditColumn>
                            </Columns>
                        </dx:GridViewBandColumn>
                        <dx:GridViewBandColumn Caption="Nhớt (Lít)" ShowInCustomizationForm="True" VisibleIndex="12">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <Columns>
                                <dx:GridViewDataSpinEditColumn Caption="Châm máy" ShowInCustomizationForm="True" VisibleIndex="0">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="speChamMay" runat="server" Width="170px" Number="0" DisplayFormatString="N2">
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Thay máy" ShowInCustomizationForm="True" VisibleIndex="1">
                                    <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                                    </PropertiesSpinEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxSpinEdit ID="speThayMay" runat="server" Width="170px" Number="0" DisplayFormatString="N2">
                                        </dx:ASPxSpinEdit>
                                    </DataItemTemplate>
                                </dx:GridViewDataSpinEditColumn>
                            </Columns>
                        </dx:GridViewBandColumn>
                        <dx:GridViewDataSpinEditColumn Caption="Định mức" FieldName="DinhMuc" ShowInCustomizationForm="True" VisibleIndex="7">
                            <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                            </PropertiesSpinEdit>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataSpinEditColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="dsBangQuyetToan" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="pr_BangQuyetToan" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cbp_BQT$form_BQT$fromDay" Name="TuNgay" PropertyName="Value" Type="DateTime" />
                        <asp:ControlParameter ControlID="cbp_BQT$form_BQT$toDay" Name="DenNgay" PropertyName="Value" Type="DateTime" />
                        <asp:ControlParameter ControlID="cbp_BQT$form_BQT$cbb_Ben" Name="BenID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>

</asp:Content>
