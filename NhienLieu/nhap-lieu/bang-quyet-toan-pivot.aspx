<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="bang-quyet-toan-pivot.aspx.cs" Inherits="NhienLieu.nhap_lieu.bang_quyet_toan_pivot" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v18.1, Version=18.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
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
                <dx:ASPxPivotGrid ID="ASPxPivotGrid1" runat="server" DataSourceID="dsBangQuyetToan" Width="100%">
                    <Fields>
                        <dx:PivotGridField ID="fieldTenPha" AreaIndex="0" FieldName="TenPha" Name="fieldTenPha" Options-ShowInFilter="True">
                        </dx:PivotGridField>
                        <dx:PivotGridField ID="fieldTuaNgay" Area="ColumnArea" AreaIndex="0" FieldName="TuaNgay" Name="fieldTuaNgay" Options-ShowInFilter="True">
                        </dx:PivotGridField>
                        <dx:PivotGridField ID="fieldTuaDem" Area="ColumnArea" AreaIndex="1" FieldName="TuaDem" Name="fieldTuaDem" Options-ShowInFilter="True">
                        </dx:PivotGridField>
                        <dx:PivotGridField ID="fieldTongTua" Area="ColumnArea" AreaIndex="2" FieldName="TongTua" Name="fieldTongTua" Options-ShowInFilter="True">
                        </dx:PivotGridField>
                        <dx:PivotGridField ID="fieldDinhMuc" Area="ColumnArea" AreaIndex="3" FieldName="DinhMuc" Name="fieldDinhMuc" Options-ShowInFilter="True">
                        </dx:PivotGridField>
                        <dx:PivotGridField ID="fieldVCNgay" Area="ColumnArea" AreaIndex="4" FieldName="VCNgay" Name="fieldVCNgay" Options-ShowInFilter="True">
                        </dx:PivotGridField>
                        <dx:PivotGridField ID="fieldVCDem" Area="ColumnArea" AreaIndex="5" FieldName="VCDem" Name="fieldVCDem" Options-ShowInFilter="True">
                        </dx:PivotGridField>
                    </Fields>
                </dx:ASPxPivotGrid>
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
