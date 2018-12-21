<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="don-vi-ban-hang.aspx.cs" Inherits="NhienLieu.khai_bao.don_vi_ban_hang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxGridView ID="gridDonVi" ClientInstanceName="gridDonVi" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceDonVi" KeyFieldName="ID" OnCustomColumnDisplayText="gridDonVi_CustomColumnDisplayText" Width="100%">
<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>

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
            <EditButton ButtonType="Image" RenderMode="Image">
                <Image IconID="edit_edit_16x16" ToolTip="Sửa">
                </Image>
            </EditButton>
            <DeleteButton ButtonType="Image" RenderMode="Image">
                <Image IconID="spreadsheet_removepivotfield_16x16" ToolTip="Xóa">
                </Image>
            </DeleteButton>
        </SettingsCommandButton>
        <SettingsSearchPanel Visible="True" />

        <SettingsText EmptyDataRow="Không có dữ liệu" SearchPanelEditorNullText="Nhập dữ liệu cần tìm..." Title="DANH SÁCH ĐƠN VỊ BÁN HÀNG" />

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="5">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn Caption="STT" FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Width="5%">
                <EditFormSettings Visible="False" />
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                <CellStyle HorizontalAlign="Center">
                </CellStyle>
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Tên đơn vị" FieldName="TenDonVi" ShowInCustomizationForm="True" VisibleIndex="1">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Địa chỉ" FieldName="DiaChi" ShowInCustomizationForm="True" VisibleIndex="2">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Điện thoại" FieldName="SDT" ShowInCustomizationForm="True" VisibleIndex="3">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn Caption="Ghi chú" FieldName="GhiChu" ShowInCustomizationForm="True" VisibleIndex="4">
                <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SqlDataSourceDonVi" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" DeleteCommand="DELETE FROM DonVi WHERE (ID = @ID)" InsertCommand="INSERT INTO DonVi(TenDonVi, DiaChi, SDT, GhiChu, NgayTao, NgayThayDoi) VALUES (@TenDonVi, @DiaChi, @SDT, @GhiChu, GETDATE(), GETDATE())" SelectCommand="SELECT [ID], [TenDonVi], [DiaChi], [SDT], [GhiChu] FROM [DonVi]" UpdateCommand="UPDATE DonVi SET TenDonVi = @TenDonVi, DiaChi = @DiaChi, SDT = @SDT, GhiChu = @GhiChu, NgayThayDoi = GETDATE()"></asp:SqlDataSource>
</asp:Content>
