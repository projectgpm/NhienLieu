using DevExpress.Web;
using DevExpress.Web.ASPxHtmlEditor;
using NhienLieu.libs;
using NhienLieu.reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.kho
{
    public partial class danh_sach_kiem_ke : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    hdfViewReport["view"] = 0;
                }
            }
            if (hdfViewReport["view"].ToString() == "1")
                reportViewer.Report = CreatReport();
            else
                hdfViewReport["view"] = 0;
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
        protected void gridDanhSach_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
        protected void gridDanhSach_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            gridDanhSach.JSProperties["cpDelete"] = true;
        }

        protected void gridDanhSach_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            gridDanhSach.JSProperties["cpInsert"] = true;
        }

        protected void gridDanhSach_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {

            int ID = int.Parse(e.Keys[0].ToString());
            var _phieu = DBProvider.DB.PhieuKiemKes.FirstOrDefault(x => x.ID == ID);
            _phieu.CanCu = e.NewValues["CanCu"] == null ? "" : e.NewValues["CanCu"].ToString();
            _phieu.DiaDiem = e.NewValues["DiaDiem"] == null ? "" : e.NewValues["DiaDiem"].ToString();
            GridViewDataTextColumn ht = ((ASPxGridView)sender).Columns["ThanhPhanThamGia"] as GridViewDataTextColumn;
            ASPxHtmlEditor gvht = ((ASPxGridView)sender).FindEditRowCellTemplateControl(ht, "ThanhPhanThamGia") as ASPxHtmlEditor;
            _phieu.ThanhPhanThamGia = gvht.Html;
            _phieu.NgayLapPhieu = DateTime.Parse(e.NewValues["NgayLapPhieu"].ToString());
            DBProvider.DB.SubmitChanges();
            e.Cancel = true;
            gridDanhSach.CancelEdit();
            gridDanhSach.JSProperties["cpUpdate"] = true;
        }

        protected void btnInPhieu_Init(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btn.NamingContainer as GridViewDataRowTemplateContainer;
            btn.ClientSideEvents.Click = String.Format("function(s, e) {{ onPrintClick({0}); }}", container.KeyValue);
        }

        protected void cbpViewReport_Callback(object sender, CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "report": ShowReport(Convert.ToInt32(para[1])); break;
                default: break;
            }
        }

        private void ShowReport(int IDPhieu)
        {
            var _Phieu = DBProvider.DB.PhieuKiemKes.FirstOrDefault(x => x.ID == IDPhieu);
            oCusExport = new oReportKiemKeVatTu();
            oCusExport.TieuDe = "BÁO CÁO KIỂM KHO ĐẾN NGÀY " + DateTime.Parse(_Phieu.NgayKiemKe.ToString()).ToString("dd/MM/yyyy");
            oCusExport.TenKho = _Phieu.Ben.TenBen.ToUpper();
            oCusExport.CanCu = _Phieu.CanCu;
            oCusExport.DiaDiem = _Phieu.DiaDiem;
            oCusExport.ThanhPhanThamGia = _Phieu.ThanhPhanThamGia;
            oCusExport.HoiDongThongNhat = "Hội đồng thống nhất sử dụng số liệu báo cáo tồn kho đến " + Formats.ConvertToFullStringDate(DateTime.Parse(_Phieu.TonDenNgay.ToString())) + " (Báo cáo Nhập  - Xuất - Tồn đến ngày " + DateTime.Parse(_Phieu.TonDenNgay.ToString()).Date.ToString("dd/MM/yyyy") + ") và các chứng từ cấp vật tư hết ngày " + DateTime.Parse(_Phieu.NgayKiemKe.ToString()).Date.AddDays(-1).ToString("dd/MM/yyyy") + " làm căn cứ số liệu cụ thể:";
            oCusExport.TieuDeTonDenCuoiNgay = "Tồn đến cuối ngày " + DateTime.Parse(_Phieu.TonDenNgay.ToString()).Date.ToString("dd/MM/yyyy");
            oCusExport.TieuDeNhapTuNgay = "Nhập từ ngày " + _Phieu.NgayText;
            oCusExport.TieuDeKiemKeThucTe = "Kiểm kê thực tế " + DateTime.Parse(_Phieu.NgayKiemKe.ToString()).Date.ToString("dd/MM/yyyy");
            oCusExport.NgayThangNam = "TP Long Xuyên, " + Formats.ConvertToFullStringDate((DateTime)_Phieu.NgayLapPhieu);
            oCusExport.listProduct = new List<oProduct_KiemKe>();
            List<PhieuKiemKe_ChiTiet> ListHang = DBProvider.DB.PhieuKiemKe_ChiTiets.Where(x => x.PhieuKiemKeID == IDPhieu).ToList();
            int i = 1;
            foreach (var Hang in ListHang)
            {
                oProduct_KiemKe pro = new oProduct_KiemKe();
                pro.STT = i++.ToString();
                pro.MaNhienLieu = Hang.NhienLieu.MaNhienLieu ;
                pro.TenNhienLieu = Hang.NhienLieu.TenNhienLieu;
                pro.DVT = Hang.NhienLieu.DonViTinh.TenDonViTinh;
                pro.SoLuongTonCuoi = (double)Hang.SoLuongTonCuoi;
                pro.GiaTriTonCuoi = (double)Hang.GiaTriTonCuoi;
                pro.SoLuongNhap = (double)Hang.SoLuongNhap;
                pro.SoLuongThucTe = (double)Hang.SoLuongThucTe;
                pro.GiaTriNhap = (double)Hang.GiaTriNhap;
                pro.ChenhLechThua = (double)Hang.ChenhLechThua;
                pro.TTChenhLechThua = (double)Hang.TTChenhLechThua;
                pro.ChenhLechThieu = (double)Hang.ChenhLechThieu;
                pro.TTChenhLechThieu = (double)Hang.TTChenhLechThieu;
                pro.KyHieuNhomVatTu = Hang.NhienLieu.NhienLieu_Nhom.MaNhom;
                pro.TenNhomVatTu = Hang.NhienLieu.NhienLieu_Nhom.TenNhom;
                oCusExport.listProduct.Add(pro);
            }
            hdfViewReport["view"] = 1;
        }

        protected void gridChiTiet_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["KiemKeID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void gridChiTiet_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
    }
}