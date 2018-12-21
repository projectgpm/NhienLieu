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
                                <dx:ASPxGridView ID="gridKhachHang" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridKhachHang" DataSourceID="dsNhanVien" KeyFieldName="IDNhanVien" Width="100%" OnCustomColumnDisplayText="gridKhachHang_CustomColumnDisplayText" OnRowValidating="gridKhachHang_RowValidating" OnRowDeleting="gridKhachHang_RowDeleting" OnRowInserting="gridKhachHang_RowInserting" OnRowUpdating="gridKhachHang_RowUpdating">
                                   <ClientSideEvents EndCallback="message" />
                                    <Settings ShowFilterRowMenu="True" ShowFooter="True" ShowHeaderFilterButton="true" ShowGroupedColumns="True"/>
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
                                        <dx:GridViewDataTextColumn FieldName="IDNhanVien" Caption="STT" ReadOnly="True" VisibleIndex="0" Width="50px">
                                            <Settings AllowAutoFilter="False" AllowHeaderFilter="False"></Settings>
                                            <EditFormSettings Visible="False" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="TenDangNhap" Caption="Tên đăng nhập" VisibleIndex="7" Settings-AllowAutoFilterTextInputTimer="False" >
                                            <PropertiesTextEdit>
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                                    <RequiredField ErrorText="Chưa nhập thông tin" IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                            <Settings AllowAutoFilter="true" AllowHeaderFilter="true"></Settings>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="MatKhau" Caption="Mật khẩu" VisibleIndex="8" Settings-AllowAutoFilterTextInputTimer="False">
                                            <PropertiesTextEdit Password="false" >
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                                    <RequiredField ErrorText="Chưa nhập thông tin" IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                            <Settings AllowAutoFilter="true" AllowHeaderFilter="true"></Settings>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="HoTen" Caption="Họ tên" VisibleIndex="1">
                                            <PropertiesTextEdit>
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                                    <RequiredField ErrorText="Chưa nhập thông tin" IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DienThoai" Caption="Điện thoại" VisibleIndex="2">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DiaChi" Caption="Địa chỉ" VisibleIndex="3" Width="200px">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="GhiChu" Caption="Thông tin khác" VisibleIndex="4" Width="200px">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataCheckColumn Caption="Trạng thái" FieldName="DaXoa" ShowInCustomizationForm="True" VisibleIndex="6">
                                            <PropertiesCheckEdit DisplayTextChecked="Đã khóa" DisplayTextUnchecked="Đang sử dụng">
                                                <DisplayImageChecked IconID="businessobjects_bopermission_16x16" ToolTip="Đã khóa">
                                                </DisplayImageChecked>
                                                <DisplayImageUnchecked IconID="actions_apply_16x16" ToolTip="Đang sử dụng">
                                                </DisplayImageUnchecked>
                                            </PropertiesCheckEdit>
                                        </dx:GridViewDataCheckColumn>
                                        <dx:GridViewDataComboBoxColumn Caption="Nhóm" FieldName="NhomID" GroupIndex="0" ShowInCustomizationForm="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="5">
                                            <PropertiesComboBox DataSourceID="dsNhom" TextField="TenNhom" ValueField="IDNhom">
                                                <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom" SetFocusOnError="True">
                                                    <RequiredField ErrorText="Chưa chọn nhóm" IsRequired="True" />
                                                </ValidationSettings>
                                            </PropertiesComboBox>
                                        </dx:GridViewDataComboBoxColumn>
                                    </Columns>
                                    <TotalSummary>
                                        <dx:ASPxSummaryItem DisplayFormat="N0" FieldName="TongCongNo" ShowInColumn="Tổng công nợ" SummaryType="Sum" />
                                        <dx:ASPxSummaryItem DisplayFormat="N0" FieldName="DaThanhToan" ShowInColumn="Đã thanh toán" SummaryType="Sum" />
                                        <dx:ASPxSummaryItem DisplayFormat="N0" FieldName="TienTTConLai" ShowInColumn="Công nợ hiện tại" SummaryType="Sum" />
                                    </TotalSummary>
                                    <Styles>
                                        <Header Wrap="True">
                                        </Header>
                                    </Styles>
                                </dx:ASPxGridView>
                                <asp:SqlDataSource ID="dsNhanVien" runat="server" ConnectionString="<%$ ConnectionStrings:BanHangVietConnectionString %>" 
                                    SelectCommand="SELECT [IDNhanVien], [TenDangNhap], [MatKhau], [HoTen], [DienThoai], [DiaChi], [GhiChu], [NhomID], [DaXoa], [NgayTao] FROM [nvNhanVien] WHERE IDNhanVien != 1" 
                                    DeleteCommand="UPDATE [nvNhanVien] SET DaXoa = 1 WHERE [IDNhanVien] = @IDNhanVien" 
                                    InsertCommand="INSERT INTO [nvNhanVien] ([TenDangNhap], [MatKhau], [HoTen], [DienThoai], [DiaChi], [GhiChu], [NhomID], [DaXoa], [NgayTao]) VALUES (@TenDangNhap, @MatKhau, @HoTen, @DienThoai, @DiaChi, @GhiChu, @NhomID, 0, GetDate())" 
                                    UpdateCommand="UPDATE [nvNhanVien] SET [TenDangNhap] = @TenDangNhap, [MatKhau] = @MatKhau, [HoTen] = @HoTen, [DienThoai] = @DienThoai, [DiaChi] = @DiaChi, [GhiChu] = @GhiChu, [NhomID] = @NhomID, [DaXoa] = @DaXoa WHERE [IDNhanVien] = @IDNhanVien">
                                  
                                    <DeleteParameters>
                                        <asp:Parameter Name="IDNhanVien" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="TenDangNhap" Type="String" />
                                        <asp:Parameter Name="MatKhau" Type="String" />
                                        <asp:Parameter Name="HoTen" Type="String" />
                                        <asp:Parameter Name="DienThoai" Type="String" />
                                        <asp:Parameter Name="DiaChi" Type="String" />
                                        <asp:Parameter Name="GhiChu" Type="String" />
                                        <asp:Parameter Name="NhomID" Type="Int32" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="TenDangNhap" Type="String" />
                                        <asp:Parameter Name="MatKhau" Type="String" />
                                        <asp:Parameter Name="HoTen" Type="String" />
                                        <asp:Parameter Name="DienThoai" Type="String" />
                                        <asp:Parameter Name="DiaChi" Type="String" />
                                        <asp:Parameter Name="GhiChu" Type="String" />
                                        <asp:Parameter Name="NhomID" Type="Int32" />
                                        <asp:Parameter Name="DaXoa" Type="Boolean" />
                                        <asp:Parameter Name="IDNhanVien" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="dsNhom" runat="server" ConnectionString="<%$ ConnectionStrings:BanHangVietConnectionString %>" SelectCommand="SELECT [IDNhom], [TenNhom] FROM [nvNhom]"></asp:SqlDataSource>
                               
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
