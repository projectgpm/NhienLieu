<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="nhien-lieu.aspx.cs" Inherits="NhienLieu.khai_bao.nhien_lieu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
    let donvitinh = () => {
        pcDonViTinh.Show();
        }
    let nhomvattu = () => {
        pcNhomVatTu.Show();
    }
    </script>
    <dx:ASPxGridView ID="gridNhienLieu" ClientInstanceName="gridNhienLieu" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceNhienLieu" KeyFieldName="ID" Width="100%" OnCustomColumnDisplayText="ASPxGridView1_CustomColumnDisplayText">
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>

        <SettingsEditing Mode="EditForm">
        </SettingsEditing>

        <Settings ShowFilterRow="True" ShowTitlePanel="True" />
        <SettingsBehavior ConfirmDelete="True" />
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
        <SettingsPopup>
            <EditForm HorizontalAlign="Center" Modal="True" AllowResize="True">
            </EditForm>
        </SettingsPopup>
        <SettingsSearchPanel Visible="True" />

        <SettingsText SearchPanelEditorNullText="Nhập thông tin cần tìm..." PopupEditFormCaption="Cập nhật" Title="DANH SÁCH VẬT TƯ" />

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="8">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Caption="STT" Width="5%" ShowInCustomizationForm="True">
                <EditFormSettings Visible="False" />
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Ký hiệu" FieldName="MaNhienLieu" VisibleIndex="1" ShowInCustomizationForm="True">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tên - Quy cách vật tư" FieldName="TenNhienLieu" VisibleIndex="2" ShowInCustomizationForm="True" Width="30%">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn Caption="Đơn vị tính" FieldName="DonViTinhID" ShowInCustomizationForm="True" VisibleIndex="4">
                <PropertiesComboBox DataSourceID="SqlDataSourceDonViTinh" TextField="TenDonViTinh" ValueField="ID">
                    <ClientSideEvents ButtonClick="function(s, e) {donvitinh()}" ></ClientSideEvents>
                    <DropDownButton Visible="False">
                    </DropDownButton>
                    <Buttons>
                        <dx:EditButton>
                            <Image IconID="actions_add_16x16">
                            </Image>
                        </dx:EditButton>
                    </Buttons>
                </PropertiesComboBox>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataSpinEditColumn Caption="Đơn giá" FieldName="DonGia" VisibleIndex="3">
                <PropertiesSpinEdit DisplayFormatString="N2" NumberFormat="Custom">
                </PropertiesSpinEdit>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataSpinEditColumn>
            <dx:GridViewDataComboBoxColumn Caption="Nhóm" FieldName="NhomID" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="SqlDataSourceNhom" TextField="TenNhom" ValueField="ID">
                    <ClientSideEvents ButtonClick="function(s, e) {nhomvattu()}" ></ClientSideEvents>
                    <DropDownButton Visible="False">
                    </DropDownButton>
                    <Buttons>
                        <dx:EditButton>
                            <Image IconID="actions_add_16x16">
                            </Image>
                        </dx:EditButton>
                    </Buttons>
                </PropertiesComboBox>
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataComboBoxColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSourceNhom" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenNhom] FROM [NhienLieu_Nhom]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDonViTinh" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" SelectCommand="SELECT [ID], [TenDonViTinh] FROM [DonViTinh]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceNhienLieu" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" DeleteCommand="UPDATE NhienLieu SET DaXoa = 1 WHERE (ID = @ID)" InsertCommand="INSERT INTO NhienLieu(MaNhienLieu, TenNhienLieu, TonKho, DonGia, GiaBinhQuan, KhoID, DonViTinhID, NhomID, NgayTao, NgayThayDoi, DaXoa) VALUES (@MaNhienLieu, @TenNhienLieu, @TonKho, @DonGia, @DonGia, 1, @DonViTinhID, @NhomID, GETDATE(), GETDATE(), 0)" SelectCommand="SELECT ID, MaNhienLieu, TenNhienLieu, TonKho, DonGia, GiaBinhQuan, DonViTinhID, NhomID, DaXoa FROM NhienLieu WHERE (DaXoa = 0)" UpdateCommand="UPDATE NhienLieu SET MaNhienLieu = @MaNhienLieu, TenNhienLieu = @TenNhienLieu, DonViTinhID = @DonViTinhID, NhomID = @NhomID, NgayThayDoi = GETDATE() WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MaNhienLieu" Type="String" />
            <asp:Parameter Name="TenNhienLieu" Type="String" />
            <asp:Parameter Name="TonKho" Type="Double" />
            <asp:Parameter Name="DonGia" Type="Double" />
            <asp:Parameter Name="DonViTinhID" Type="Int64" />
            <asp:Parameter Name="NhomID" Type="Int64" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="MaNhienLieu" Type="String" />
            <asp:Parameter Name="TenNhienLieu" Type="String" />
            <asp:Parameter Name="DonViTinhID" Type="Int64" />
            <asp:Parameter Name="NhomID" Type="Int64" />
            <asp:Parameter Name="ID" Type="Int64" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <dx:ASPxPopupControl 
        ID="pcDonViTinh" ClientInstanceName="pcDonViTinh" runat="server"
        CloseAction="CloseButton" Modal="true"
        PopupVerticalAlign="WindowCenter"
        PopupHorizontalAlign="WindowCenter" HeaderText="THÊM ĐƠN VỊ TÍNH" Width="800px" >
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl" runat="server">
                <dx:ASPxGridView ID="gridDonViTinh" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceThemDonViTinh" KeyFieldName="ID" OnCustomColumnDisplayText="gridDonViTinh_CustomColumnDisplayText" Width="100%">
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>

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

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="3">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                            <EditFormSettings Visible="False" />
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Mã đơn vị tính" FieldName="MaDonViTinh" ShowInCustomizationForm="True" VisibleIndex="1">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tên đơn vị tính" FieldName="TenDonViTinh" ShowInCustomizationForm="True" VisibleIndex="2">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSourceThemDonViTinh" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" DeleteCommand="DELETE FROM DonViTinh WHERE (ID = @ID)" InsertCommand="INSERT INTO DonViTinh(MaDonViTinh, TenDonViTinh, NgayTao, NgayThayDoi) VALUES (@MaDonViTinh, @TenDonViTinh, GETDATE(), GETDATE())" SelectCommand="SELECT ID, MaDonViTinh, TenDonViTinh FROM DonViTinh ORDER BY TenDonViTinh" UpdateCommand="UPDATE DonViTinh SET MaDonViTinh = @MaDonViTinh, TenDonViTinh = @TenDonViTinh, NgayThayDoi = GETDATE() WHERE (ID = @ID)"></asp:SqlDataSource>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents CloseUp="function(s, e) { gridNhienLieu.Refresh(); }" />
    </dx:ASPxPopupControl>
    <dx:ASPxPopupControl 
        ID="pcNhomVatTu" ClientInstanceName="pcNhomVatTu" runat="server"
        CloseAction="CloseButton" Modal="true"
        PopupVerticalAlign="WindowCenter"
        PopupHorizontalAlign="WindowCenter" HeaderText="THÊM NHÓM VẬT TƯ" Width="800px" >
        <ContentCollection>
            <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceThemNhomVatTu" KeyFieldName="ID" OnCustomColumnDisplayText="gridDonViTinh_CustomColumnDisplayText" Width="100%">
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>

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

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
                    <Columns>
                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="3">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                            <EditFormSettings Visible="False" />
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Tên nhóm" FieldName="TenNhom" ShowInCustomizationForm="True" VisibleIndex="2">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Mã nhóm" FieldName="MaNhom" ShowInCustomizationForm="True" VisibleIndex="1">
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                        </dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="SqlDataSourceThemNhomVatTu" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" DeleteCommand="DELETE FROM [NhienLieu_Nhom] WHERE [ID] = @ID" InsertCommand="INSERT INTO [NhienLieu_Nhom] ([TenNhom], [MaNhom]) VALUES (@TenNhom, @MaNhom)" SelectCommand="SELECT [ID], [TenNhom], [MaNhom] FROM [NhienLieu_Nhom] ORDER BY [TenNhom]" UpdateCommand="UPDATE [NhienLieu_Nhom] SET [TenNhom] = @TenNhom, [MaNhom] = @MaNhom WHERE [ID] = @ID">
                    <DeleteParameters>
                        <asp:Parameter Name="ID" Type="Int64" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="TenNhom" Type="String" />
                        <asp:Parameter Name="MaNhom" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TenNhom" Type="String" />
                        <asp:Parameter Name="MaNhom" Type="String" />
                        <asp:Parameter Name="ID" Type="Int64" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents CloseUp="function(s, e) { gridNhienLieu.Refresh(); }" />
    </dx:ASPxPopupControl>
</asp:Content>
