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
    public partial class KiemKeControl : System.Web.UI.UserControl
    {
        public List<oImportProduct_KiemKeVatTu> listReceiptProducts
        {
            get
            {
                if (Session["sslistReceiptProducts_KiemKeVatTu"] == null)
                    Session["sslistReceiptProducts_KiemKeVatTu"] = new List<oImportProduct_KiemKeVatTu>();
                return (List<oImportProduct_KiemKeVatTu>)Session["sslistReceiptProducts_KiemKeVatTu"];
            }
            set
            {
                Session["sslistReceiptProducts_KiemKeVatTu"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Context.User.Identity.IsAuthenticated)
            {
                if (!IsPostBack)
                {
                    Reset();
                    Session["KhoID"] = 1;
                    hdfViewReport["view"] = 0;
                    if (listReceiptProducts.Count > 0)
                        BindGrid();
                    else
                        listReceiptProducts = new List<oImportProduct_KiemKeVatTu>();
                }

                if (hdfViewReport["view"].ToString() == "1")
                    reportViewer.Report = CreatReport();
                else
                    hdfViewReport["view"] = 0;

            }
            else

                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
        }
        #region report
        rpKiemKe CreatReport()
        {
            rpKiemKe rp = new rpKiemKe();
            rp.odsGiaoDich.DataSource = oCusExport;
            rp.CreateDocument();
            return rp;
        }

        private oReportKiemKeVatTu oCusExport
        {
            get
            {
                return (oReportKiemKeVatTu)Session["ocus_oReportKiemKeVatTu"];
            }
            set
            {
                Session["ocus_oReportKiemKeVatTu"] = value;
            }
        }
        #endregion
        protected void cbpInfoImport_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "xoahang": XoaHangChange(para[1]); BindGrid(); break;
                case "UnitChange": Unitchange(para[1]); BindGrid(); break;
                case "import": InsertIntoGrid(); BindGrid(); break;
                case "Save": Save(); break;
                case "Reset": Reset(); break;
                case "Review": CreateReportReview(); break;
                case "Review_Pro": Review_Pro(); break;
                case "redirect": DevExpress.Web.ASPxWebControl.RedirectOnCallback("~/Pages/LapPhieu/DanhSachMuaVatTu.aspx"); break;
                default: break;
            }
        }
        private void Review_Pro()
        {
            if (Session["KhoID"].ToString() != ccbKhoKiemKe.Value.ToString())
            {
                listReceiptProducts = new List<oImportProduct_KiemKeVatTu>();
                BindGrid();
                if (ccbKhoKiemKe.Text != "")
                {
                    Session["KhoID"] = ccbKhoKiemKe.Value.ToString();
                }
            }
        }
        private void CreateReportReview()
        {
            oCusExport = new oReportKiemKeVatTu();
            oCusExport.TieuDe = "BÁO CÁO KIỂM KHO ĐẾN NGÀY " + dateNgayKiemKe.Date.ToString("dd/MM/yyyy");
            oCusExport.TenKho = "KHO " +ccbKhoKiemKe.Text.ToUpper();
            oCusExport.CanCu = txtCanCu.Text;
            oCusExport.DiaDiem = txtDiaDiem.Text;
            oCusExport.ThanhPhanThamGia = HtmlThanhPhanThamGia.Html;
            oCusExport.HoiDongThongNhat = "Hội đồng thống nhất sử dụng số liệu báo cáo tồn kho đến " + Formats.ConvertToFullStringDate(dateTonCuoiNgay.Date) + " (Báo cáo Nhập  - Xuất - Tồn đến ngày " + dateTonCuoiNgay.Date.ToString("dd/MM/yyyy") + ") và các chứng từ cấp vật tư hết ngày " + dateNgayKiemKe.Date.AddDays(-1).ToString("dd/MM/yyyy") + " làm căn cứ số liệu cụ thể:";
            oCusExport.TieuDeTonDenCuoiNgay = "Tồn đến cuối ngày " + dateTonCuoiNgay.Date.ToString("dd/MM/yyyy");
            oCusExport.TieuDeNhapTuNgay = "Nhập từ ngày " + dateTonCuoiNgay.Date.AddDays(1).ToString("dd") + "÷" + dateNgayKiemKe.Date.AddDays(-1).ToString("dd") + dateNgayKiemKe.Date.ToString("/MM/yyyy");
            oCusExport.TieuDeKiemKeThucTe = "Kiểm kê thực tế " + dateNgayKiemKe.Date.ToString("dd/MM/yyyy");
            oCusExport.NgayThangNam = "TP Long Xuyên, " + Formats.ConvertToFullStringDate(dateNgayLapPhieu.Date);
            oCusExport.listProduct = new List<oProduct_KiemKe>();
            int i = 1;
            foreach (var Hang in listReceiptProducts)
            {
                oProduct_KiemKe pro = new oProduct_KiemKe();
                pro.STT = i++.ToString();
                pro.MaNhienLieu = Hang.MaNhienLieu;
                pro.TenNhienLieu = Hang.TenNhienLieu;
                pro.DVT = Hang.DVT;
                pro.SoLuongTonCuoi = Hang.SoLuongTonCuoi;
                pro.GiaTriTonCuoi = Hang.GiaTriTonCuoi;
                pro.SoLuongNhap = Hang.SoLuongNhap;
                pro.SoLuongThucTe = Hang.SoLuongThucTe;
                pro.GiaTriNhap = Hang.GiaTriNhap;
                pro.ChenhLechThua = Hang.ChenhLechThua;
                pro.TTChenhLechThua = Hang.TTChenhLechThua;
                pro.ChenhLechThieu = Hang.ChenhLechThieu;
                pro.TTChenhLechThieu = Hang.TTChenhLechThieu;
                pro.KyHieuNhomVatTu = Hang.KyHieuNhomVatTu;
                pro.TenNhomVatTu = Hang.TenNhomVatTu;
                oCusExport.listProduct.Add(pro);
            }
            cbpInfoImport.JSProperties["cp_rpView"] = true;
        }
        private void Reset()
        {
            listReceiptProducts = new List<oImportProduct_KiemKeVatTu>();
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
            ccbKhoKiemKe.SelectedIndex = 0;
            dateNgayKiemKe.Date = DateTime.Now;
            txtCanCu.Text = "Sự chỉ đạo của Ban Giám đốc Cty TNHH Một Thành Viên Phà An Giang.";
            txtDiaDiem.Text = "Kho ";
            HtmlThanhPhanThamGia.Html = "";
            dateTonCuoiNgay.Date = DateTime.Now.AddDays(-DateTime.Now.Day);
            dateNgayLapPhieu.Date = DateTime.Now;
            ccbVatTu.Text = "";
        }
        private void Save()
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    PhieuKiemKe _kiemke = new PhieuKiemKe();
                    _kiemke.NgayKiemKe = dateNgayKiemKe.Date;
                    _kiemke.CanCu = txtCanCu.Text;
                    _kiemke.DiaDiem = txtDiaDiem.Text;
                    _kiemke.ThanhPhanThamGia = HtmlThanhPhanThamGia.Html;
                    _kiemke.HoiDongThongNhat = "Hội đồng thống nhất sử dụng số liệu báo cáo tồn kho đến " + Formats.ConvertToFullStringDate(dateTonCuoiNgay.Date) + " (Báo cáo Nhập  - Xuất - Tồn đến ngày " + dateTonCuoiNgay.Date.ToString("dd/MM/yyyy") + ") và các chứng từ cấp vật tư hết ngày " + dateNgayKiemKe.Date.AddDays(-1).ToString("dd/MM/yyyy") + "làm căn cứ số liệu cụ thể:";
                    _kiemke.NgayLapPhieu = dateNgayLapPhieu.Date;
                    _kiemke.TonDenNgay = dateTonCuoiNgay.Date;
                    _kiemke.NgayLuuHeThong = DateTime.Now;
                    _kiemke.DaXoa = 0;
                    _kiemke.NhanVienID = Formats.IDUser();
                    _kiemke.KhoID = Convert.ToInt32(ccbKhoKiemKe.Value);
                    _kiemke.NgayText = dateTonCuoiNgay.Date.AddDays(1).ToString("dd") + "÷" + dateNgayKiemKe.Date.AddDays(-1).ToString("dd") + dateNgayKiemKe.Date.ToString("MM/yyyy");
                    DBProvider.DB.PhieuKiemKes.InsertOnSubmit(_kiemke);
                    DBProvider.DB.SubmitChanges();
                    long IDKiemKe = _kiemke.ID;
                    foreach (var prod in listReceiptProducts)
                    {
                        PhieuKiemKe_ChiTiet _chitiet = new PhieuKiemKe_ChiTiet();
                        _chitiet.PhieuKiemKeID = IDKiemKe;
                        _chitiet.NhienLieuID = prod.ID;
                        _chitiet.SoLuongTonCuoi = prod.SoLuongTonCuoi;
                        _chitiet.GiaTriTonCuoi = prod.GiaTriTonCuoi;
                        _chitiet.SoLuongNhap = prod.SoLuongNhap;
                        _chitiet.GiaTriNhap = prod.GiaTriNhap;
                        _chitiet.SoLuongThucTe = prod.SoLuongThucTe;
                        _chitiet.ChenhLechThua = prod.ChenhLechThua;
                        _chitiet.TTChenhLechThua = prod.TTChenhLechThua;
                        _chitiet.ChenhLechThieu = prod.ChenhLechThieu;
                        _chitiet.TTChenhLechThieu = prod.TTChenhLechThieu;
                        _chitiet.ChenhLech = prod.ChenhLech;
                        _chitiet.DonGiaNhapTrongKy = prod.DonGiaNhapTrongKy;
                        _chitiet.DonGiaTonCuoi = prod.DonGiaCuoiKy;
                        DBProvider.DB.PhieuKiemKe_ChiTiets.InsertOnSubmit(_chitiet);
                    }
                    DBProvider.DB.SubmitChanges();
                    scope.Complete();
                    cbpInfoImport.JSProperties["cp_Suss"] = true;
                }
                catch (Exception ex)
                {
                    scope.Dispose();
                    cbpInfoImport.JSProperties["cp_Err"] = true;
                    throw ex;
                }
            }
        }
        private void BindGrid()
        {
            gridImportPro.DataSource = listReceiptProducts;
            gridImportPro.DataBind();
            gridImportPro.ExpandAll();
        }
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            switch (e.Parameter)
            {

                case "Reset": Reset(); break;
                default: break;
            }
        }
        #region xóa hàng
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
        }
        #endregion
        protected void UpdateSTT()
        {
            speSoLuongThucTe.Number = 1;
            ccbVatTu.Value = "";
            ccbVatTu.Text = "";
            ccbVatTu.Focus();
            for (int i = 1; i <= listReceiptProducts.Count; i++)
            {
                listReceiptProducts[i - 1].STT = i;
            }
        }
        #region bind data vật tư theo kho 
        protected void ccbVatTu_Callback(object sender, CallbackEventArgsBase e)
        {
            ccbVatTu.DataBind();
        }
        protected void ccbVatTu_ItemRequestedByValue(object source, ListEditItemRequestedByValueEventArgs e)
        {
            long value = 0;
            if (e.Value == null || !Int64.TryParse(e.Value.ToString(), out value))
                return;
            ASPxComboBox comboBox = (ASPxComboBox)source;
            dsVatTu.SelectCommand = @"SELECT NhienLieu.ID, NhienLieu.MaNhienLieu, NhienLieu.TenNhienLieu
                                        FROM NhienLieu
                                        WHERE (NhienLieu.ID = @ID)";
            dsVatTu.SelectParameters.Clear();
            dsVatTu.SelectParameters.Add("ID", TypeCode.Int64, e.Value.ToString());
            comboBox.DataSource = dsVatTu;
            comboBox.DataBind();
        }

        protected void ccbVatTu_ItemsRequestedByFilterCondition(object source, ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            ASPxComboBox comboBox = (ASPxComboBox)source;
            dsVatTu.SelectCommand = @"SELECT [ID], [MaNhienLieu], [TenNhienLieu]
                                                    FROM (
	                                                    SELECT NhienLieu.ID, NhienLieu.MaNhienLieu, NhienLieu.TenNhienLieu,
	                                                    row_number()over(order by NhienLieu.MaNhienLieu) as [rn] 
	                                                    FROM NhienLieu 
	                                                    WHERE ((NhienLieu.MaNhienLieu LIKE @MaNhienLieu) OR NhienLieu.TenNhienLieu LIKE @TenNhienLieu) AND NhienLieu.DaXoa = 0 
	                                                    ) as st 
                                                    WHERE st.[rn] between @startIndex and @endIndex";
            dsVatTu.SelectParameters.Clear();
            dsVatTu.SelectParameters.Add("MaNhienLieu", TypeCode.String, string.Format("%{0}%", e.Filter));
            dsVatTu.SelectParameters.Add("TenNhienLieu", TypeCode.String, string.Format("%{0}%", e.Filter));
            dsVatTu.SelectParameters.Add("startIndex", TypeCode.Int64, (e.BeginIndex + 1).ToString());
            dsVatTu.SelectParameters.Add("endIndex", TypeCode.Int64, (e.EndIndex + 1).ToString());
            comboBox.DataSource = dsVatTu;
            comboBox.DataBind();
        }
        #endregion 

        #region InsertHang
        protected void InsertIntoGrid()
        {
            if (ccbVatTu.Value != null)
            {
                // idhanghoa

                var tbThongTin = DBProvider.DB.NhienLieus.Where(q=> q.ID == Convert.ToInt32(ccbVatTu.Value)).FirstOrDefault();
                if (tbThongTin != null)
                {

                    Insert_Hang(Convert.ToInt32(tbThongTin.ID));
                    return;
                }
                else
                {
                    ccbVatTu.Value = "";
                    ccbVatTu.Text = "";
                    ccbVatTu.Focus();
                    cbpInfoImport.JSProperties["cp_Error_MaHang"] = true;
                }
            }
            else if (ccbVatTu.Text != "")
            {
                /*var tbThongTin = DBDataProvider.DB.pr_InsertVatTu(ccbVatTu.Text.Trim()).FirstOrDefault();
                if (tbThongTin != null)
                {

                    Insert_Hang(Convert.ToInt32(tbThongTin.IDVatTu));
                    return;
                }
                else
                {
                    ccbVatTu.Value = "";
                    ccbVatTu.Text = "";
                    ccbVatTu.Focus();
                    cbpInfoImport.JSProperties["cp_Error_MaHang"] = true;
                }*/
            }
            else
            {
                ccbVatTu.Focus();
                cbpInfoImport.JSProperties["cp_ChonMaHang"] = true;
            }
        }
        public void Insert_Hang(int ID)
        {
            int tblVatTu_Count = DBProvider.DB.NhienLieus.Where(x => x.ID == ID && x.DaXoa == 0).Count();
            if (tblVatTu_Count > 0)
            {
                var tblVatTu = DBProvider.DB.NhienLieus.FirstOrDefault(x => x.ID == ID && x.DaXoa == 0);
                var exitProdInList = listReceiptProducts.SingleOrDefault(r => r.ID == ID);
                double SoLuongThucTe = Convert.ToDouble(speSoLuongThucTe.Number);
                if (exitProdInList == null)
                {
                    double SoLuongCuoiKy = 0, DonGiaCuoiKy = 0, GiaTriCuoiKy = 0, SoLuongNhapTrongKy = 0, DonGiaNhapTrongKy = 0, GiaTriNhapTrongKy = 0;
                    var _SoLuongCuoiKy = DBProvider.DB.pr_NhapXuatTon_TonCuoiNgay_IDNhienLieu(dateTonCuoiNgay.Date, dateTonCuoiNgay.Date, Convert.ToInt32(ccbKhoKiemKe.Value), Convert.ToInt32(tblVatTu.ID)).FirstOrDefault();
                    if (_SoLuongCuoiKy != null)
                        SoLuongCuoiKy = _SoLuongCuoiKy.SoLuongCuoiKy;

                    var _DonGiaCuoiKy = DBProvider.DB.pr_NhapXuatTon_TonCuoiNgay_IDNhienLieu(dateTonCuoiNgay.Date, dateTonCuoiNgay.Date, Convert.ToInt32(ccbKhoKiemKe.Value), Convert.ToInt32(tblVatTu.ID)).FirstOrDefault();
                    if (_DonGiaCuoiKy != null)
                        DonGiaCuoiKy = _DonGiaCuoiKy.DonGiaCuoiKy;

                    var _GiaTriCuoiKy = DBProvider.DB.pr_NhapXuatTon_TonCuoiNgay_IDNhienLieu(dateTonCuoiNgay.Date, dateTonCuoiNgay.Date, Convert.ToInt32(ccbKhoKiemKe.Value), Convert.ToInt32(tblVatTu.ID)).FirstOrDefault();
                    if (_GiaTriCuoiKy != null)
                        GiaTriCuoiKy = _GiaTriCuoiKy.ThanhTienCuoiKy;

                    var _SoLuongNhapTrongKy = DBProvider.DB.pr_NhapXuatTon_NhapTrongKy_IDNhienLieu(dateTonCuoiNgay.Date.AddDays(1), dateNgayKiemKe.Date.AddDays(-1), Convert.ToInt32(ccbKhoKiemKe.Value) , Convert.ToInt32(tblVatTu.ID)).FirstOrDefault();
                    if (_SoLuongNhapTrongKy != null)
                        SoLuongNhapTrongKy = _SoLuongNhapTrongKy.NhapTrongKy;

                    var _DonGiaNhapTrongKy = DBProvider.DB.pr_NhapXuatTon_NhapTrongKy_IDNhienLieu(dateTonCuoiNgay.Date.AddDays(1), dateNgayKiemKe.Date.AddDays(-1), Convert.ToInt32(ccbKhoKiemKe.Value), Convert.ToInt32(tblVatTu.ID)).FirstOrDefault();
                    if (_DonGiaNhapTrongKy != null)
                        DonGiaNhapTrongKy = _DonGiaNhapTrongKy.DonGiaNhapTrongKy;

                    var _GiaTriNhapTrongKy = DBProvider.DB.pr_NhapXuatTon_NhapTrongKy_IDNhienLieu(dateTonCuoiNgay.Date.AddDays(1), dateNgayKiemKe.Date.AddDays(-1), Convert.ToInt32(ccbKhoKiemKe.Value), Convert.ToInt32(tblVatTu.ID)).FirstOrDefault();
                    if (_GiaTriNhapTrongKy != null)
                        GiaTriNhapTrongKy = _GiaTriNhapTrongKy.ThanhTienNhapTrongKy;

                    double ChenhLech = (SoLuongCuoiKy + SoLuongNhapTrongKy) - (SoLuongThucTe);
                    double DonGiaChenhLech = 0;
                    if (SoLuongCuoiKy + SoLuongNhapTrongKy != 0)
                        DonGiaChenhLech = (DonGiaCuoiKy + DonGiaNhapTrongKy) / (SoLuongCuoiKy + SoLuongNhapTrongKy);

                    //var aa = listReceiptProducts.ToList();

                    oImportProduct_KiemKeVatTu newRecpPro = new oImportProduct_KiemKeVatTu(
                        Convert.ToInt32(tblVatTu.ID),
                        tblVatTu.MaNhienLieu,
                        tblVatTu.TenNhienLieu,
                        tblVatTu.DonViTinh.TenDonViTinh,
                        SoLuongCuoiKy,
                        GiaTriCuoiKy,
                        SoLuongNhapTrongKy,
                        GiaTriNhapTrongKy,
                        SoLuongThucTe,
                        ChenhLech > 0 ? ChenhLech : 0,
                        ChenhLech > 0 ? ChenhLech * DonGiaChenhLech : 0,
                        ChenhLech < 0 ? (-1) * ChenhLech : 0,
                        ChenhLech < 0 ? (-1) * ChenhLech * DonGiaChenhLech : 0,
                        tblVatTu.NhienLieu_Nhom.MaNhom,
                        tblVatTu.NhienLieu_Nhom.TenNhom, ChenhLech, DonGiaCuoiKy, DonGiaNhapTrongKy
                        );
                    listReceiptProducts.Add(newRecpPro);
                }
                else
                {
                    
                    exitProdInList.SoLuongThucTe += SoLuongThucTe;
                    double ChenhLech = (exitProdInList.SoLuongTonCuoi + exitProdInList.SoLuongNhap) - (exitProdInList.SoLuongThucTe);
                    double DonGiaChenhLech = (exitProdInList.DonGiaCuoiKy + exitProdInList.DonGiaNhapTrongKy) / (exitProdInList.SoLuongTonCuoi + exitProdInList.SoLuongNhap);
                    exitProdInList.ChenhLechThua = ChenhLech > 0 ? ChenhLech : 0;
                    exitProdInList.TTChenhLechThua = ChenhLech > 0 ? ChenhLech * DonGiaChenhLech : 0;
                    exitProdInList.ChenhLechThieu = ChenhLech < 0 ? (-1) * ChenhLech : 0;
                    exitProdInList.TTChenhLechThieu = ChenhLech < 0 ? (-1) * ChenhLech * DonGiaChenhLech : 0;
                    exitProdInList.ChenhLech = ChenhLech;
                }
                UpdateSTT();
            }
            else
            {
                ccbVatTu.Value = "";
                ccbVatTu.Text = "";
                ccbVatTu.Focus();
                cbpInfoImport.JSProperties["cp_Error_MaHang"] = true;
            }
        }
        #endregion

        #region cập nhật SL + DG 
        protected void speSpinEdit_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = String.Format("function(s, e) {{ onUnitReturnChanged({0}); }}", container.KeyValue);
        }
        private void Unitchange(string para)
        {
            int STT = Convert.ToInt32(para);
            //Lấy số lượng thực tế
            ASPxSpinEdit SpinEdit_SoLuongThucTe = gridImportPro.FindRowCellTemplateControlByKey(STT, (GridViewDataColumn)gridImportPro.Columns["Thực tế"], "speSoLuongThucTe") as ASPxSpinEdit;
            double SoLuongThucTe = Convert.ToDouble(SpinEdit_SoLuongThucTe.Number);

            // cập nhật
            var sourceRow = listReceiptProducts.Where(x => x.STT == STT).SingleOrDefault();
            sourceRow.SoLuongThucTe = SoLuongThucTe;
            double ChenhLech = (sourceRow.SoLuongTonCuoi + sourceRow.SoLuongNhap) - (sourceRow.SoLuongThucTe);
            double DonGiaChenhLech = (sourceRow.DonGiaCuoiKy + sourceRow.DonGiaNhapTrongKy) / (sourceRow.SoLuongTonCuoi + sourceRow.SoLuongNhap);
            sourceRow.ChenhLechThua = ChenhLech > 0 ? ChenhLech : 0;
            sourceRow.TTChenhLechThua = ChenhLech > 0 ? ChenhLech * DonGiaChenhLech : 0;
            sourceRow.ChenhLechThieu = ChenhLech < 0 ? (-1) * ChenhLech : 0;
            sourceRow.TTChenhLechThieu = ChenhLech < 0 ? (-1) * ChenhLech * DonGiaChenhLech : 0;
            sourceRow.ChenhLech = ChenhLech;
        }
        #endregion

    }
}