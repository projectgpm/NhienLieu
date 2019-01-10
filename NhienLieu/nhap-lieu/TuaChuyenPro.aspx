<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="TuaChuyenPro.aspx.cs" Inherits="NhienLieu.nhap_lieu.TuaChuyenPro" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">

        let Check = () => {
            if (cbBen.GetSelectedIndex == -1) {
                baoloi('Vui lòng chọn bến!');
                return false;
            }
            if (cbPha.GetSelectedIndex == -1) {
                baoloi('Vui lòng chọn phà!');
                return false;
            }
            return true;
        }
        let Change = () => {
            cbpInfo.PerformCallback('Refill');
        }
        let fillPha = () => {
            cbpBen.PerformCallback('LoadPha');
        }
        let OnCallBack = () => {
            if (Check())
                cbpTua.PerformCallback();
        }
        let AdjustSize = () => {
            let hInfoPanel = splImport.GetPaneByName('splpInfoImport').GetClientHeight();
            let hInfoLayout = formlayout2.GetHeight()*2;
            gridNhienLieu.SetHeight(hInfoPanel - hInfoLayout);
        }
        let endCallBackProduct = () => {

        }
        let endCallBackInfo = () => {

        }
    </script>
    <dx:ASPxPanel ID="panelImport" CssClass="gpm_content" runat="server" Width="100%" DefaultButton="btnImportToList">
        <PanelCollection>
            <dx:PanelContent ID="PanelContent3" runat="server">

                <div class="mx-auto" style="font-size: 14pt; width:14%; padding: 5px;" >
                    KHAI BÁO TUA CHUYẾN
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
                        <dx:ASPxCallbackPanel ID="cbpTua" ClientInstanceName="cbpTua" runat="server" Width="100%" OnCallback="cbpTua_Callback">
                             <PanelCollection>
                                <dx:PanelContent ID="PanelContent2" runat="server">
                            <dx:ASPxGridView ID="gridNhienLieu" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridNhienLieu" KeyFieldName="ID" Width="100%" DataSourceID="TuaChuyen" OnCustomGroupDisplayText="gridNhienLieu_CustomGroupDisplayText">
                           
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>

                                <SettingsPager>
                                    <Summary EmptyText="Không có dữ liệu" Text="Trang {0} / {1}" />
                                </SettingsPager>

                                <SettingsEditing Mode="Batch">
                                </SettingsEditing>
                                <SettingsCommandButton>
                                    <UpdateButton Text="Lưu lại">
                                        <Image IconID="save_save_32x32">
                                        </Image>
                                    </UpdateButton>
                                    <CancelButton Text="Hủy">
                                        <Image IconID="actions_cancel_32x32">
                                        </Image>
                                    </CancelButton>
                                </SettingsCommandButton>

                                <SettingsText EmptyDataRow="Không có dữ liệu" />

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
                           
                                <Columns>
                                    <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Visible="False">
                                        <EditFormSettings Visible="False" />
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Ca1" ShowInCustomizationForm="True" VisibleIndex="3" Caption="Ca 1">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Ca2" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Ca 2">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="TongCong" ShowInCustomizationForm="True" VisibleIndex="5" Caption="Tổng">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="NguoiChamID" ShowInCustomizationForm="True" VisibleIndex="8" Visible="False">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataComboBoxColumn FieldName="PhaID" ShowInCustomizationForm="True" VisibleIndex="2" Caption="Phà">
                                        <PropertiesComboBox DataSourceID="dsPha" TextField="TenPha" ValueField="ID">
                                        </PropertiesComboBox>
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataTextColumn FieldName="Ngay" ShowInCustomizationForm="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="1" Caption="Ngày">
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                        <CellStyle HorizontalAlign="Center">
                                        </CellStyle>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataComboBoxColumn Caption="Bến hiện tại" FieldName="BenHienTai" ShowInCustomizationForm="True" VisibleIndex="6">
                                        <PropertiesComboBox DataSourceID="ddsBen" TextField="TenBen" ValueField="ID">
                                        </PropertiesComboBox>
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataComboBoxColumn>
                                    <dx:GridViewDataComboBoxColumn Caption="Xí nghiệp hiện tại" FieldName="XiNghiepHienTai" ShowInCustomizationForm="True" VisibleIndex="7">
                                        <PropertiesComboBox DataSourceID="dsXiNghiep" TextField="TenXiNghiep" ValueField="ID">
                                        </PropertiesComboBox>
                                        <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                                    </dx:GridViewDataComboBoxColumn>
                                </Columns>
                           
                            </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="ddsBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="dsXiNghiep" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenXiNghiep] FROM [XiNghiep]"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="dsPha" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenPha] +' ('+ [SoPhaCu]+ ')' as TenPha FROM [Pha]"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="TuaChuyen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT * FROM [ChamCong] WHERE (([PhaID] = @PhaID) AND ([Nam] = @Nam) AND ([Thang] = @Thang)) ORDER BY [Ngay]" DeleteCommand="DELETE FROM [ChamCong] WHERE [ID] = @ID" InsertCommand="INSERT INTO [ChamCong] ([Ngay], [Thang], [Nam], [Ca1], [Ca2], [TongCong], [DaCham], [PhaID], [NguoiChamID], [NgayTao], [NgayThayDoi], [BenHienTai], [XiNghiepHienTai]) VALUES (@Ngay, @Thang, @Nam, @Ca1, @Ca2, @TongCong, @DaCham, @PhaID, @NguoiChamID, @NgayTao, @NgayThayDoi, @BenHienTai, @XiNghiepHienTai)" UpdateCommand="UPDATE [ChamCong] SET [Ca1] = @Ca1, [Ca2] = @Ca2, [TongCong]=@Ca1 + @Ca2 WHERE [ID] = @ID">
                                        <DeleteParameters>
                                            <asp:Parameter Name="ID" Type="Int64" />
                                        </DeleteParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="Ngay" Type="Int32" />
                                            <asp:Parameter Name="Thang" Type="Int32" />
                                            <asp:Parameter Name="Nam" Type="Int32" />
                                            <asp:Parameter Name="Ca1" Type="Double" />
                                            <asp:Parameter Name="Ca2" Type="Double" />
                                            <asp:Parameter Name="TongCong" Type="Double" />
                                            <asp:Parameter Name="DaCham" Type="Int32" />
                                            <asp:Parameter Name="PhaID" Type="Int64" />
                                            <asp:Parameter Name="NguoiChamID" Type="Int64" />
                                            <asp:Parameter Name="NgayTao" Type="DateTime" />
                                            <asp:Parameter Name="NgayThayDoi" Type="DateTime" />
                                            <asp:Parameter Name="BenHienTai" Type="Int64" />
                                            <asp:Parameter Name="XiNghiepHienTai" Type="Int64" />
                                        </InsertParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="cbpBen$formBen$cbPha" Name="PhaID" PropertyName="Value" Type="Int64" />
                                            <asp:ControlParameter ControlID="cbpInfo$formlayout2$cbNam" Name="Nam" PropertyName="Value" Type="Int32" />
                                            <asp:ControlParameter ControlID="cbpInfo$formlayout2$cbThang" Name="Thang" PropertyName="Value" Type="Int32" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="Ngay" Type="Int32" />
                                            <asp:Parameter Name="Thang" Type="Int32" />
                                            <asp:Parameter Name="Nam" Type="Int32" />
                                            <asp:Parameter Name="Ca1" Type="Double" />
                                            <asp:Parameter Name="Ca2" Type="Double" />
                                            <asp:Parameter Name="TongCong" Type="Double" />
                                            <asp:Parameter Name="DaCham" Type="Int32" />
                                            <asp:Parameter Name="PhaID" Type="Int64" />
                                            <asp:Parameter Name="NguoiChamID" Type="Int64" />
                                            <asp:Parameter Name="NgayTao" Type="DateTime" />
                                            <asp:Parameter Name="NgayThayDoi" Type="DateTime" />
                                            <asp:Parameter Name="BenHienTai" Type="Int64" />
                                            <asp:Parameter Name="XiNghiepHienTai" Type="Int64" />
                                            <asp:Parameter Name="ID" Type="Int64" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
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
                        <dx:ASPxCallbackPanel ID="cbpInfo" ClientInstanceName="cbpInfo" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
                             <PanelCollection>
                                <dx:PanelContent ID="PanelContent1" runat="server">
                        <dx:ASPxFormLayout ID="formlayout2" ClientInstanceName="formlayout2" runat="server" ColCount="1" Width="100%">
                            <Items>
                                <dx:LayoutItem Caption="Năm" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cbNam" runat="server" Width="100%" ClientInstanceName="cbNam">
                                                <ClientSideEvents  SelectedIndexChanged="Change" />
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Tháng" ColSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxComboBox ID="cbThang" runat="server" Width="100%" ClientInstanceName="cbThang">
                                                
                                            </dx:ASPxComboBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:ASPxFormLayout>
                        </dx:PanelContent>
                        </PanelCollection>
                        <ClientSideEvents EndCallback="endCallBackInfo" />
                    </dx:ASPxCallbackPanel>
                    <dx:ASPxCallbackPanel ID="cbpBen" ClientInstanceName="cbpBen" runat="server" Width="100%" OnCallback="cbpInfo_Callback">
                            <PanelCollection>
                            <dx:PanelContent ID="PanelContent4" runat="server">
                    <dx:ASPxFormLayout ID="formBen" ClientInstanceName="formBen" runat="server" ColCount="1" Width="100%">
                        <Items>
                            <dx:LayoutItem Caption="Bến" ColSpan="1">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="cbBen" ClientInstanceName="cbBen" runat="server" Width="100%" DataSourceID="dsBen" TextField="TenBen" ValueField="ID">
                                            <ClientSideEvents  SelectedIndexChanged="fillPha" />
                                        </dx:ASPxComboBox>
                                        <asp:SqlDataSource ID="dsBen" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenBen] FROM [Ben]"></asp:SqlDataSource>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="Phà" ColSpan="1">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxComboBox ID="cbPha" ClientInstanceName="cbPha" runat="server" Width="100%">
                                        </dx:ASPxComboBox>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                            <dx:LayoutItem Caption="" ColSpan="1">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        
                                            <dx:ASPxButton ID="btnNhapLieu" runat="server" Text="NHẬP LIỆU" AutoPostBack="false">
                                                <ClientSideEvents Click="OnCallBack" />
                                            </dx:ASPxButton>
                                        <span style="padding-left:15px;">
                                            <dx:ASPxButton ID="btnRS" runat="server" Text="LÀM LẠI" AutoPostBack="false" BackColor="#cc0000">
                                                <ClientSideEvents Click="function(s,e){ window.location.reload() }" />
                                            </dx:ASPxButton>
                                            </span>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:ASPxFormLayout>
                    </dx:PanelContent>
                    </PanelCollection>
                    <ClientSideEvents EndCallback="endCallBackInfo" />
                    </dx:ASPxCallbackPanel>
                    </dx:SplitterContentControl>
                </ContentCollection>
                </dx:SplitterPane>
            </Panes>
<ContentCollection>
<dx:SplitterContentControl runat="server"></dx:SplitterContentControl>
</ContentCollection>
            </dx:SplitterPane>
            <%--<dx:SplitterPane Name="splpProcess" MaxSize="100px" Size="70px">
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
            </dx:SplitterPane>--%>
        </Panes>
    </dx:ASPxSplitter>
                </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxPanel>
</asp:Content>
