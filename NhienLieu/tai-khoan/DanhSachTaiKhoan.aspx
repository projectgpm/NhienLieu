<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="DanhSachTaiKhoan.aspx.cs" Inherits="NhienLieu.tai_khoan.DanhSachTaiKhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxFormLayout ID="formThongTin" ClientInstanceName="formThongTin" runat="server" Width="100%">
        <Items>
            <dx:LayoutGroup Caption="Danh sách tài khoản" Width="100%" GroupBoxDecoration="HeadingLine">
                <Items>
                    <dx:LayoutItem HorizontalAlign="Right" ShowCaption="False" Width="100%">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnXuatExcel" runat="server" OnClick="btnXuatExcel_Click" Text="Xuất Excel">
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Nhóm khách hàng" ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxGridViewExporter ID="exproter" runat="server" ExportedRowType="All" GridViewID="gridKhachHang">
                                </dx:ASPxGridViewExporter>
                                <dx:ASPxGridView ID="gridKhachHang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridKhachHang" DataSourceID="dsNhanVien" KeyFieldName="ID" Width="100%" OnCustomColumnDisplayText="gridKhachHang_CustomColumnDisplayText" OnRowValidating="gridKhachHang_RowValidating" OnRowDeleting="gridKhachHang_RowDeleting" OnRowInserting="gridKhachHang_RowInserting" OnRowUpdating="gridKhachHang_RowUpdating">
                                   <ClientSideEvents EndCallback="message" />
                                    <Settings ShowFooter="True"/>
                                    <SettingsBehavior ColumnResizeMode="Control" AutoExpandAllGroups="True" ConfirmDelete="True" />
                                    <SettingsCommandButton>
                                        <ShowAdaptiveDetailButton ButtonType="Image">
                                        </ShowAdaptiveDetailButton>
                                        <HideAdaptiveDetailButton ButtonType="Image">
                                        </HideAdaptiveDetailButton>
                                        <NewButton ButtonType="Image" RenderMode="Image" Text="Thêm">
                                            <Image IconID="actions_newemployee_32x32devav" ToolTip="Thêm tài khoản mới">
                                            </Image>
                                        </NewButton>
                                        <UpdateButton ButtonType="Image" RenderMode="Image">
                                            <Image IconID="save_save_32x32" ToolTip="Lưu lại tất cả thay đổi">
                                            </Image>
                                        </UpdateButton>
                                        <CancelButton ButtonType="Image" RenderMode="Image" Text="Hủy">
                                            <Image IconID="actions_cancel_32x32">
                                            </Image>
                                        </CancelButton>
                                        <EditButton ButtonType="Image" RenderMode="Image" Text="Sửa">
                                            <Image IconID="actions_edit_16x16devav" ToolTip="Sửa">
                                            </Image>
                                        </EditButton>
                                        <DeleteButton ButtonType="Image" RenderMode="Image" Text="Xóa">
                                            <Image IconID="actions_close_16x16" ToolTip="Xóa">
                                            </Image>
                                        </DeleteButton>
                                    </SettingsCommandButton>
                                    <SettingsSearchPanel Visible="True" />
                                    <SettingsText HeaderFilterCancelButton="Hủy" SearchPanelEditorNullText="Nhập thông tin cần tìm..." CommandBatchEditCancel="Hủy bỏ" CommandBatchEditUpdate="Lưu" PopupEditFormCaption="Cập nhật nhân viên"  EmptyDataRow="Không có dữ liệu" CommandCancel="Hủy" ConfirmDelete="Bạn có chắc chắn muốn xóa?" HeaderFilterFrom="Từ" HeaderFilterLastMonth="Tháng trước" HeaderFilterLastWeek="Tuần trước" HeaderFilterLastYear="Năm trước" HeaderFilterNextMonth="Tháng sau" HeaderFilterNextWeek="Tuần sau" HeaderFilterNextYear="Năm sau" HeaderFilterOkButton="Lọc" HeaderFilterSelectAll="Chọn tất cả" HeaderFilterShowAll="Tất cả" HeaderFilterShowBlanks="Trống" HeaderFilterShowNonBlanks="Không trống" HeaderFilterThisMonth="Tháng này" HeaderFilterThisWeek="Tuần này" HeaderFilterThisYear="Năm nay" HeaderFilterTo="Đến" HeaderFilterToday="Hôm nay" HeaderFilterTomorrow="Ngày mai" HeaderFilterYesterday="Ngày hôm qua" CommandDelete="Xóa dữ liệu ??" />

<SettingsAdaptivity>
<AdaptiveDetailLayoutProperties ColCount="1"></AdaptiveDetailLayoutProperties>
</SettingsAdaptivity>

                                    <SettingsPager PageSize="20">
                                        <Summary EmptyText="Không có dữ liệu" Text="Trang {0}/{1}" />
                                    </SettingsPager>

<EditFormLayoutProperties ColCount="1"></EditFormLayoutProperties>
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="9">
                                        </dx:GridViewCommandColumn>
                                        <dx:GridViewDataTextColumn FieldName="ID" Caption="STT" ReadOnly="True" VisibleIndex="0" Width="50px">
                                            <Settings AllowAutoFilter="False" AllowHeaderFilter="False"></Settings>
                                            <EditFormSettings Visible="False" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="TaiKhoan" Caption="Tên đăng nhập" VisibleIndex="7" Settings-AllowAutoFilterTextInputTimer="False" >
                                            <PropertiesTextEdit>
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                                    <RequiredField ErrorText="Chưa nhập thông tin" IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                            <Settings AllowAutoFilter="true" AllowHeaderFilter="true"></Settings>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="MatKhau" Caption="Mật khẩu" VisibleIndex="8" Settings-AllowAutoFilterTextInputTimer="False">
                                            <PropertiesTextEdit Password="false" >
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                                    <RequiredField ErrorText="Chưa nhập thông tin" IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                            <Settings AllowAutoFilter="true" AllowHeaderFilter="true"></Settings>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="HoTen" Caption="Họ tên" VisibleIndex="1">
                                            <PropertiesTextEdit>
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                                    <RequiredField ErrorText="Chưa nhập thông tin" IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DienThoai" Caption="Điện thoại" VisibleIndex="2">
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DiaChi" Caption="Địa chỉ" VisibleIndex="3" Width="200px">
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="GhiChu" Caption="Thông tin khác" VisibleIndex="4" Width="200px">
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataCheckColumn Caption="Trạng thái" FieldName="DaXoa" ShowInCustomizationForm="True" VisibleIndex="6">
                                            <PropertiesCheckEdit DisplayTextChecked="Đã khóa" DisplayTextUnchecked="Đang sử dụng">
                                                <DisplayImageChecked IconID="businessobjects_bopermission_16x16" ToolTip="Đã khóa">
                                                </DisplayImageChecked>
                                                <DisplayImageUnchecked IconID="actions_apply_16x16" ToolTip="Đang sử dụng">
                                                </DisplayImageUnchecked>
                                            </PropertiesCheckEdit>
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </dx:GridViewDataCheckColumn>
                                    </Columns>
                                    <Styles>
                                        <Header Wrap="True">
                                        </Header>
                                    </Styles>
                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:NhienLieuConnectionString %>" 
                                    SelectCommand="SELECT * FROM [NhanVien] WHERE TaiKhoan != 'admin'" 
                                    DeleteCommand="UPDATE [NhanVien] SET [DaXoa] = 1 WHERE [ID] = @ID" 
                                    InsertCommand="INSERT INTO [NhanVien] ([HoTen], [DienThoai], [DiaChi], [GhiChu], [NgayTao], [DaXoa], [TaiKhoan], [MatKhau]) VALUES (@HoTen, @DienThoai, @DiaChi, @GhiChu, getdate(), 0, @TaiKhoan, @MatKhau)" 
                                    UpdateCommand="UPDATE [NhanVien] SET [HoTen] = @HoTen, [DienThoai] = @DienThoai, [DiaChi] = @DiaChi, [GhiChu] = @GhiChu, [DaXoa] = @DaXoa, [TaiKhoan] = @TaiKhoan, [MatKhau] = @MatKhau WHERE [ID] = @ID">
                                  
                                    <DeleteParameters>
                                        <asp:Parameter Name="ID" Type="Int64" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="HoTen" Type="String" />
                                        <asp:Parameter Name="DienThoai" Type="String" />
                                        <asp:Parameter Name="DiaChi" Type="String" />
                                        <asp:Parameter Name="GhiChu" Type="String" />
                                        <asp:Parameter Name="NgayTao" Type="String" />
                                        <asp:Parameter Name="DaXoa" Type="Int32" />
                                        <asp:Parameter Name="TaiKhoan" Type="String" />
                                        <asp:Parameter Name="MatKhau" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="HoTen" Type="String" />
                                        <asp:Parameter Name="DienThoai" Type="String" />
                                        <asp:Parameter Name="DiaChi" Type="String" />
                                        <asp:Parameter Name="GhiChu" Type="String" />
                                        <asp:Parameter Name="NgayTao" Type="String" />
                                        <asp:Parameter Name="DaXoa" Type="Int32" />
                                        <asp:Parameter Name="TaiKhoan" Type="String" />
                                        <asp:Parameter Name="MatKhau" Type="String" />
                                        <asp:Parameter Name="ID" Type="Int64" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                               
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
                <SettingsItemCaptions Location="Left" />
            </dx:LayoutGroup>
        </Items>
        <Styles>
            <LayoutItem>
                <Paddings PaddingTop="0px" />
            </LayoutItem>
        </Styles>
    </dx:ASPxFormLayout>
</asp:Content>
