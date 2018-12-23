using DevExpress.Web;
using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.lap_phieu
{
    public partial class xuat_kho : System.Web.UI.Page
    {
        public List<oProductXuatKho> listReceiptProducts
        {
            get
            {
                if (Session["listReceiptProducts"] == null)
                    Session["listReceiptProducts"] = new List<oProductXuatKho>();
                return (List<oProductXuatKho>)Session["listReceiptProducts"];
            }
            set
            {
                Session["listReceiptProducts"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            if (!IsPostBack)
            {
               /* if (listReceiptProducts.Count > 0)
                    BindGrid();
                else*/
                    listReceiptProducts = new List<oProductXuatKho>();
            }
        }

        protected void cbb_NhienLieu_ItemsRequestedByFilterCondition(object source, DevExpress.Web.ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            ASPxComboBox comboBox = (ASPxComboBox)source;
            SqlDataSourceNhienLieu.SelectCommand = @"SELECT [ID], [MaNhienLieu], [TenNhienLieu]
                                                    FROM (
	                                                    SELECT NhienLieu.ID, NhienLieu.MaNhienLieu, NhienLieu.TenNhienLieu,
	                                                    row_number()over(order by NhienLieu.MaNhienLieu) as [rn] 
	                                                    FROM NhienLieu 
	                                                    WHERE ((NhienLieu.MaNhienLieu LIKE @MaNhienLieu) OR NhienLieu.TenNhienLieu LIKE @TenNhienLieu) AND NhienLieu.DaXoa = 0
	                                                    ) as st 
                                                    WHERE st.[rn] between @startIndex and @endIndex";
            SqlDataSourceNhienLieu.SelectParameters.Clear();
            SqlDataSourceNhienLieu.SelectParameters.Add("MaNhienLieu", TypeCode.String, string.Format("%{0}%", e.Filter));
            SqlDataSourceNhienLieu.SelectParameters.Add("TenNhienLieu", TypeCode.String, string.Format("%{0}%", e.Filter));
            SqlDataSourceNhienLieu.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString());
            SqlDataSourceNhienLieu.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString());
            comboBox.DataSource = SqlDataSourceNhienLieu;
            comboBox.DataBind();
        }

        protected void cbb_NhienLieu_ItemRequestedByValue(object source, DevExpress.Web.ListEditItemRequestedByValueEventArgs e)
        {
            long value = 0;
            if (e.Value == null || !Int64.TryParse(e.Value.ToString(), out value))
                return;
            ASPxComboBox comboBox = (ASPxComboBox)source;
            SqlDataSourceNhienLieu.SelectCommand = @"SELECT NhienLieu.ID, NhienLieu.MaNhienLieu, NhienLieu.TenNhienLieu
                                        FROM NhienLieu
                                        WHERE (NhienLieu.ID = @ID)";
            SqlDataSourceNhienLieu.SelectParameters.Clear();
            SqlDataSourceNhienLieu.SelectParameters.Add("ID", TypeCode.Int64, e.Value.ToString());
            comboBox.DataSource = SqlDataSourceNhienLieu;
            comboBox.DataBind();
        }

        protected void cbpNhienLieu_Callback(object sender, CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                /*case "price": GetPrice(); break;
                case "UnitChange": Unitchange(para[1]); BindGrid(); break;
                case "Save": Save(); CreateReportReview_Save(Convert.ToInt32(hiddenFields["IDPhieuMoi"].ToString())); break;
                case "Review": CreateReportReview(); break;
                case "importexcel": BindGrid(); cbpInfoImport.JSProperties["cp_LoadInFo"] = true; break;
                case "xoahang": XoaHangChange(para[1]); break;
                case "lammoi": DeleteListProducts(); break;
                case "UnitChange_GiamGia": Unitchange_GiamGia(para[1]); BindGrid(); break;*/
                case "save": Save(); BindGrid(); break;
                case "xoahang": XoaHangChange(para[1]); break;
                case "UnitChange": Unitchange(para[1]); BindGrid(); break;
                case "import": Insert_NL(int.Parse(cbb_NhienLieu.Value.ToString())); BindGrid(); break;
                default: break;
            }
            
        }
        private void Unitchange(string para)
        {
            int IDProduct = Convert.ToInt32(para);

            //Số lượng
            ASPxSpinEdit SpinEdit = gridNhienLieu.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridNhienLieu.Columns["Số lượng"], "spChungTu") as ASPxSpinEdit;
            Double UnitProductNew = Convert.ToDouble(SpinEdit.Number);

            //Đơn giá nhập
            ASPxSpinEdit SpinEdit_GiaVon = gridNhienLieu.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridNhienLieu.Columns["Đơn giá"], "spDonGia") as ASPxSpinEdit;
            Double PriceProduct_GiaVon = Double.Parse(SpinEdit_GiaVon.Number.ToString());

            // cập nhật
            var sourceRow = listReceiptProducts.Where(x => x.STT == IDProduct).SingleOrDefault();
            sourceRow.SoLuong = UnitProductNew;
            sourceRow.DonGia = PriceProduct_GiaVon;
            sourceRow.ThanhTien = UnitProductNew * PriceProduct_GiaVon;
            gridNhienLieu.JSProperties["cp_LoadInFo"] = true;
            //BindGrid();
        }
        protected void Save()
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    if (gridNhienLieu.VisibleRowCount > 0)
                    {
                        //lấy số phiếu
                        var max_phieu = DBProvider.DB.SettingSoPhieus.SingleOrDefault(q => q.NamHienTai == DateTime.Now.Year);
                        //nếu hết năm hoặc k tồn tại thì tạo mới
                        if (max_phieu == null)
                        {
                            var setting = new SettingSoPhieu();
                            setting.NamHienTai = DateTime.Now.Year;
                            setting.SoPhieuNhap = 0;
                            setting.SoPhieuXuat = 0;
                            DBProvider.DB.SettingSoPhieus.InsertOnSubmit(setting);
                            DBProvider.DB.SubmitChanges();
                            max_phieu = setting;
                        }
                        PhieuXuatKho _phieuxuat = new PhieuXuatKho();
                        _phieuxuat.SoPhieu = max_phieu.SoPhieuXuat + 1 + "/" + DateTime.Now.ToString("MM/yyyy");
                        _phieuxuat.CanCu = txt_cancu.Text;
                        _phieuxuat.DoiTuongXuat = txt_doituongxuat.Text;
                        _phieuxuat.ThoiHanXuat = txt_thoihanxuat.Text;
                        _phieuxuat.Ngay = txt_ngayxuat.Text;
                        _phieuxuat.BenXuatID = long.Parse(cbb_benxuat.Value.ToString());
                        _phieuxuat.ThanhTien = 0;
                        _phieuxuat.DaXoa = 0;
                        _phieuxuat.DiaChi = DBProvider.DB.Bens.FirstOrDefault(q=> q.ID == long.Parse(cbb_benxuat.Value.ToString())).DiaChi;
                        _phieuxuat.NhanVienID = Formats.IDUser();
                        if (deNgayLapPhieu.Value != null)
                           _phieuxuat.NgayLapPhieu = deNgayLapPhieu.Date;
                        DBProvider.DB.PhieuXuatKhos.InsertOnSubmit(_phieuxuat);
                        DBProvider.DB.SubmitChanges();
                        foreach (var prod in listReceiptProducts)
                        {
                            //thêm chi tiết xuất
                            var nhienlieu = DBProvider.DB.NhienLieus.SingleOrDefault(q => q.ID == prod.ID);
                            var tonkho = DBProvider.DB.Kho_TonKhos.FirstOrDefault(p => p.NhienLieuID == nhienlieu.ID && p.BenID == Convert.ToInt32(cbb_benxuat.Value));
                            PhieuXuatKho_ChiTiet ct = new PhieuXuatKho_ChiTiet();
                            ct.NhienLieuID = nhienlieu.ID;
                            ct.PhieuXuatID = _phieuxuat.ID;
                            ct.TonTruoc = tonkho.TonKho;
                            ct.SoLuong = prod.SoLuong;
                            ct.GiaXuat = prod.DonGia;
                            ct.ThanhTien = ct.SoLuong * ct.GiaXuat;
                            DBProvider.DB.PhieuXuatKho_ChiTiets.InsertOnSubmit(ct);
                            //cập nhật thành tiền
                            _phieuxuat.ThanhTien += ct.ThanhTien;
                            //ghi thẻ kho -- trigger

                        }
                        max_phieu.SoPhieuXuat++;
                        DBProvider.DB.SubmitChanges();
                        scope.Complete();
                        cbpNhienLieu.JSProperties["cp_Reset"] = true;
                    }
                }
                catch (Exception ex)
                {
                    scope.Dispose();
                    throw ex;
                }
            }
        }

        public void Insert_NL(int ID)
        {
            int nhienlieu_count = DBProvider.DB.NhienLieus.Where(x => x.ID == ID).Count();
            if (nhienlieu_count > 0)
            {
                var vNhienLieu = DBProvider.DB.NhienLieus.Where(x => x.ID == ID).FirstOrDefault();
                var tonkho = DBProvider.DB.Kho_TonKhos.FirstOrDefault(q => q.BenID == Convert.ToInt32(cbb_benxuat.Value) && q.NhienLieuID == vNhienLieu.ID);
                var existProdInList = listReceiptProducts.SingleOrDefault(q => q.STT == ID);
                if (existProdInList == null)
                {
                    oProductXuatKho nhienlieu = new oProductXuatKho(Convert.ToInt32(vNhienLieu.ID), Convert.ToInt32(vNhienLieu.ID),
                        vNhienLieu.MaNhienLieu,
                        vNhienLieu.TenNhienLieu,
                        vNhienLieu.DonViTinh.TenDonViTinh, Convert.ToDouble(tonkho.TonKho),
                        0, Convert.ToDouble(vNhienLieu.GiaBinhQuan));
                    listReceiptProducts.Add(nhienlieu);
                }
                else
                {
                    //exitProdInList.SoLuong += SoLuong;
                    //exitProdInList.ThanhTien = exitProdInList.SoLuong * exitProdInList.GiaBan;
                }
                cbb_NhienLieu.Value = "";
                cbb_NhienLieu.Text = "";
                cbb_NhienLieu.Focus();
                UpdateSTT();
            }
            else
            {
                cbb_NhienLieu.Value = "";
                cbb_NhienLieu.Text = "";
                cbb_NhienLieu.Focus();
                cbpNhienLieu.JSProperties["cp_Error_MaHang"] = true;
            }
        }
        
        protected void cbpDonVi_Callback(object sender, CallbackEventArgsBase e)
        {
            /*
            int idDonVi = int.Parse(cbbDonViBH.Value.ToString());
            var donvi = DBProvider.DB.DonVis.SingleOrDefault(q => q.ID == idDonVi);
            if (donvi != null)
            {
                txt_diachi.Text = donvi.DiaChi;
            }
            else
            {
                txt_diachi.Text = "";
            }*/
        }
        private void BindGrid()
        {
            gridNhienLieu.DataSource = listReceiptProducts;
            gridNhienLieu.DataBind();
        }
        protected void spChungTu_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        protected void btnXoaHang_Init(object sender, EventArgs e)
        {
            ASPxButton btnButton = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btnButton.NamingContainer as GridViewDataRowTemplateContainer;
            btnButton.ClientSideEvents.Click = String.Format("function(s, e) {{ onXoaHangChanged({0}); }}", container.KeyValue);
        }
        private void XoaHangChange(string para)
        {
            int STT = Convert.ToInt32(para);
            var itemToRemove = listReceiptProducts.SingleOrDefault(r => r.STT == STT);
            if (itemToRemove != null)
            {
                listReceiptProducts.Remove(itemToRemove);
                UpdateSTT();
            }
            BindGrid();
            cbpNhienLieu.JSProperties["cp_LoadInFo"] = true;
        }
        protected void gridNhienLieu_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            int stt = int.Parse(e.Keys["STT"].ToString());
            var itemToRemove = listReceiptProducts.SingleOrDefault(r => r.STT == stt);
            if (itemToRemove != null)
            {
                listReceiptProducts.Remove(itemToRemove);
                UpdateSTT();
            }
            e.Cancel = true;
            BindGrid();
            cbpNhienLieu.JSProperties["cp_LoadInFo"] = true;
        }
        protected void UpdateSTT()
        {
            for (int i = 1; i <= listReceiptProducts.Count; i++)
            {
                listReceiptProducts[i - 1].STT = i;
            }
        }

        protected void deNgayLapPhieu_Init(object sender, EventArgs e)
        {
            deNgayLapPhieu.Date = DateTime.Now;
        }
    }
}