using DevExpress.Web;
using NhienLieu.libs;
using NhienLieu.reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.lap_phieu
{
    public partial class nhap_kho : System.Web.UI.Page
    {
        public List<oProductNhapKho> listReceiptProducts
        {
            get
            {
                if (Session["listoProductNhapKho"] == null)
                    Session["listoProductNhapKho"] = new List<oProductNhapKho>();
                return (List<oProductNhapKho>)Session["listoProductNhapKho"];
            }
            set
            {
                Session["listoProductNhapKho"] = value;
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
                hdfViewReport["view"] = 0;
                listReceiptProducts = new List<oProductNhapKho>();
            }
            if (hdfViewReport["view"].ToString() == "1")
                reportViewer.Report = CreatReport();
            else
                hdfViewReport["view"] = 0;
        }
        rpNhapKho CreatReport()
        {
            rpNhapKho rp = new rpNhapKho();
            rp.odsGiaoDich.DataSource = oCusExport;
            rp.CreateDocument();
            return rp;
        }
        private oReportNhapKho oCusExport
        {
            get
            {
                return (oReportNhapKho)Session["ocus_oReportNhapKho"];
            }
            set
            {
                Session["ocus_oReportNhapKho"] = value;
            }
        }
        #region bind nhiên liệu
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
        #endregion

        protected void cbpNhienLieu_Callback(object sender, CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "Reset": DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/lap-phieu/danh-sach-nhap-kho.aspx"); break;
                case "save": Save(); BindGrid(); break;
                case "xoahang": XoaHangChange(para[1]); break;
                case "Review": Review(); break;
                case "UnitChange": Unitchange(para[1]); BindGrid(); break;
                case "import": Insert_NL(int.Parse(cbb_NhienLieu.Value.ToString())); BindGrid(); break;
                default: break;
            }
            
        }

        private void Review()
        {
            oCusExport = new oReportNhapKho();
            oCusExport.NguonNhap = txt_nguonnhap.Text;
            oCusExport.NgayThangNam = "Long Xuyên, " + Formats.ConvertToFullStringDate(DateTime.Parse(deNgayLapPhieu.Text));
            oCusExport.DonViBanHang = cbbDonViBH.Text;
            oCusExport.DiaChi = txt_diachi.Text;
            oCusExport.HoaDonSo = txt_hoadonso.Text;
            oCusExport.NgayHoaDon = txt_ngaynhap.Text;
            oCusExport.TenKho = "XN. Phà An Hòa";//_Phieu.kKho.TenKho;
            oCusExport.SoTT = "Xem trước";
            oCusExport.listProduct = new List<oProductNhapKho>();
            double TongTien = 0;
            int i = 1;
            foreach (var Hang in listReceiptProducts)
            {
                TongTien += Hang.ThanhTien;
                oProductNhapKho pro = new oProductNhapKho();
                pro.ID = i++;
                pro.MaNhienLieu = Hang.MaNhienLieu;
                pro.TenNhienLieu = Hang.TenNhienLieu;
                pro.DonViTinh = Hang.DonViTinh;
                pro.SoLuongChungTu = Hang.SoLuongChungTu;
                pro.SoLuongThucNhap = Hang.SoLuongThucNhap;
                pro.DonGia = Hang.DonGia;
                pro.TenBen = Hang.TenBen;
                pro.ThanhTien = Hang.ThanhTien;
                oCusExport.listProduct.Add(pro);
            }
            oCusExport.TongTien = Convert.ToDouble(TongTien);
            oCusExport.TienBangChu = Formats.replace_special_word((double)TongTien);
            cbpNhienLieu.JSProperties["cp_rpView"] = true;
        }
        private void Unitchange(string para)
        {
            int IDProduct = Convert.ToInt32(para);

            //Số lượng
            ASPxSpinEdit SpinEdit = gridNhienLieu.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridNhienLieu.Columns["Theo C.từ"], "spChungTu") as ASPxSpinEdit;
            int UnitProductNew = Convert.ToInt32(SpinEdit.Number);

            //Đơn giá nhập
            ASPxSpinEdit SpinEdit_GiaVon = gridNhienLieu.FindRowCellTemplateControlByKey(IDProduct, (GridViewDataColumn)gridNhienLieu.Columns["Đơn giá"], "spDonGia") as ASPxSpinEdit;
            Double PriceProduct_GiaVon = Double.Parse(SpinEdit_GiaVon.Number.ToString());

            // cập nhật
            var sourceRow = listReceiptProducts.Where(x => x.ID == IDProduct).SingleOrDefault();
            sourceRow.SoLuongChungTu = UnitProductNew;
            sourceRow.SoLuongThucNhap = sourceRow.SoLuongChungTu;
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
                        //lập phiếu nhập
                        var phieunhap = new PhieuNhapKho();
                        phieunhap.SoPhieu = max_phieu.SoPhieuNhap+1 +"/"+ DateTime.Now.ToString("MM/yyyy");
                        phieunhap.NguonNhap = txt_nguonnhap.Text;
                        phieunhap.DonViID = long.Parse(cbbDonViBH.Value.ToString());
                        phieunhap.HoaDonSo = txt_hoadonso.Text;
                        phieunhap.Ngay = txt_ngaynhap.Text;
                        phieunhap.NhanVienID = Formats.IDUser();
                        phieunhap.DaXoa = 0;
                        if (deNgayLapPhieu.Value != null)
                            phieunhap.NgayLapPhieu = deNgayLapPhieu.Date;
                        else phieunhap.NgayLapPhieu = DateTime.Now;
                        DBProvider.DB.PhieuNhapKhos.InsertOnSubmit(phieunhap);
                        DBProvider.DB.SubmitChanges();
                        phieunhap.ThanhTien = 0;
                        //thêm chi tiết
                        foreach (var prod in listReceiptProducts)
                        {
                            PhieuNhapKho_ChiTiet ct = new PhieuNhapKho_ChiTiet();
                            ct.PhieuNhapID = phieunhap.ID;
                            ct.NhienLieuID = prod.IDNhienLieu;
                            ct.GiaNhap = prod.DonGia;
                            ct.SoLuong = prod.SoLuongChungTu;
                            ct.ThanhTien = ct.GiaNhap * ct.SoLuong;
                            ct.Ben = prod.TenBen;
                            ct.BenNhapID = prod.IDBenPha;
                            DBProvider.DB.PhieuNhapKho_ChiTiets.InsertOnSubmit(ct);
                            DBProvider.DB.SubmitChanges();
                            phieunhap.ThanhTien += (ct.GiaNhap * ct.SoLuong);
                        }
                        max_phieu.SoPhieuNhap++;
                        DBProvider.DB.SubmitChanges();
                        scope.Complete();
                        cbpNhienLieu.JSProperties["cp_Reset"] = true;
                    }
                }
                catch (Exception )
                {
                    cbpNhienLieu.JSProperties["cp_Error_Save"] = true;
                    scope.Dispose();
                    //throw ex;
                }
            }
        }

        public void Insert_NL(int ID)
        {
            int nhienlieu_count = DBProvider.DB.NhienLieus.Where(x => x.ID == ID).Count();
            if (nhienlieu_count > 0)
            {
                var vNhienLieu = DBProvider.DB.NhienLieus.FirstOrDefault(x => x.ID == ID);
                int IDBen = Convert.ToInt32(cbbBen.Value.ToString());
                var existProdInList = listReceiptProducts.SingleOrDefault(x=>x.IDNhienLieu == vNhienLieu.ID && x.IDBenPha == IDBen);
                if (existProdInList == null)
                {
                    oProductNhapKho nhienlieu = new oProductNhapKho(
                        ID,
                        vNhienLieu.MaNhienLieu,
                        vNhienLieu.TenNhienLieu,
                        vNhienLieu.DonViTinh.TenDonViTinh,
                        1,
                        1,
                        Convert.ToDouble(vNhienLieu.DonGia),
                        IDBen,
                        cbbBen.Text
                        );
                    listReceiptProducts.Add(nhienlieu);
                }
                else
                {
                    cbpNhienLieu.JSProperties["cp_Error_TonTai"] = true;
                    
                }
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
            int idDonVi = int.Parse(cbbDonViBH.Value.ToString());
            var donvi = DBProvider.DB.DonVis.SingleOrDefault(q => q.ID == idDonVi);
            if (donvi != null)
            {
                txt_diachi.Text = donvi.DiaChi;
            }
            else
            {
                txt_diachi.Text = "";
            }
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
            SpinEdit.ClientSideEvents.NumberChanged = string.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        protected void btnXoaHang_Init(object sender, EventArgs e)
        {
            ASPxButton btnButton = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btnButton.NamingContainer as GridViewDataRowTemplateContainer;
            btnButton.ClientSideEvents.Click = string.Format("function(s, e) {{ onXoaHangChanged({0}); }}", container.KeyValue);
        }
        private void XoaHangChange(string para)
        {
            int STT = Convert.ToInt32(para);
            var itemToRemove = listReceiptProducts.SingleOrDefault(r => r.ID == STT);
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
            var itemToRemove = listReceiptProducts.SingleOrDefault(r => r.ID == stt);
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
                listReceiptProducts[i - 1].ID = i;
            }
        }

        protected void deNgayLapPhieu_Init(object sender, EventArgs e)
        {
            deNgayLapPhieu.Date = DateTime.Now;
        }
    }
}