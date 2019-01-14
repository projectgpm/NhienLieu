using DevExpress.Web;
using NhienLieu.libs;
using NhienLieu.reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.nhap_lieu
{
    public partial class danh_sach_quyet_toan_ben : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            if (!IsPostBack)
            {
                hdfViewReport["view"] = 0;
                //gridDSNhapKho.DataBind();
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
        protected void gridDSNhapKho_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
        
        protected void btnXoaPhieu_Init(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btn.NamingContainer as GridViewDataRowTemplateContainer;
            var _phieu = DBProvider.DB.QuyetToan_Bens.FirstOrDefault(x => x.ID == Convert.ToInt32(container.KeyValue));
            btn.ClientSideEvents.Click = String.Format("function(s, e) {{ onDeleteClick({0}); }}", container.KeyValue);
            if (_phieu != null && _phieu.DaXoa == 1)
            {
                btn.Visible = false;
            }
        }
        protected void btnInPhieu_Init(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btn.NamingContainer as GridViewDataRowTemplateContainer;
            btn.ClientSideEvents.Click = String.Format("function(s, e) {{ onPrintClick({0}); }}", container.KeyValue);
            var _phieu = DBProvider.DB.QuyetToan_Bens.FirstOrDefault(x => x.ID == Convert.ToInt32(container.KeyValue));
            if (_phieu != null && _phieu.DaXoa == 1)
            {
                btn.Visible = false;
            }
        }

        protected void cbpReport_Callback(object sender, CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "report": ShowReport(Convert.ToInt32(para[1])); break;
                case "xoaphieu": XoaPhieu(Convert.ToInt32(para[1])); break;
                default: break;
            }
            
        }
        private void XoaPhieu(int id)
        {
            // hủy phiếu - tồn kho
            var _phieu = DBProvider.DB.PhieuNhapKhos.FirstOrDefault(q => q.ID == id);
            if(_phieu != null && _phieu.DaXoa == 0)
            {
                _phieu.DaXoa = 1;
                List<PhieuNhapKho_ChiTiet> list = DBProvider.DB.PhieuNhapKho_ChiTiets.Where(q => q.PhieuNhapID == id).ToList();
                foreach (var _chitiet in list)
                {
                    var _nhienlieu = DBProvider.DB.NhienLieus.FirstOrDefault( t => t.ID == _chitiet.NhienLieuID);
                    Kho_TheKho thekho = new Kho_TheKho();
                    thekho.DienGiai = "Hủy phiếu nhập kho #" +_phieu.SoPhieu;
                    thekho.NhienLieuID = _nhienlieu.ID;
                    thekho.NgayNhap = DateTime.Now;
                    thekho.Nhap = 0;
                    thekho.Xuat = _chitiet.SoLuong;
                    thekho.Ton -= _chitiet.SoLuong;
                    DBProvider.DB.Kho_TheKhos.InsertOnSubmit(thekho);
                }
                DBProvider.DB.SubmitChanges();
                cbpReport.JSProperties["cp_Suc"] = true;
            }
            else
                cbpReport.JSProperties["cp_Err"] = true;

        }
        private void ShowReport(int id)
        {
            var _Phieu = DBProvider.DB.PhieuNhapKhos.FirstOrDefault(x => x.ID == id);
            oCusExport = new oReportNhapKho();
            oCusExport.NguonNhap = _Phieu.NguonNhap;
            oCusExport.NgayThangNam = "Long Xuyên, " + Formats.ConvertToFullStringDate(DateTime.Parse(_Phieu.NgayLapPhieu.ToString()));
            oCusExport.DonViBanHang = _Phieu.DonVi.TenDonVi;
            oCusExport.DiaChi = _Phieu.DonVi.DiaChi;
            oCusExport.HoaDonSo = _Phieu.HoaDonSo;
            oCusExport.NgayHoaDon = _Phieu.Ngay.ToString();
            oCusExport.TenKho = "XN. Phà An Hòa";//_Phieu.kKho.TenKho;
            oCusExport.SoTT = _Phieu.SoPhieu;
            oCusExport.listProduct = new List<oProductNhapKho>();
            List<PhieuNhapKho_ChiTiet> ListHang = DBProvider.DB.PhieuNhapKho_ChiTiets.Where(x => x.PhieuNhapID == id).ToList();
            int i = 1;
            foreach (var Hang in ListHang)
            {
                oProductNhapKho pro = new oProductNhapKho();
                pro.ID = i++;
                pro.MaNhienLieu = Hang.NhienLieu.MaNhienLieu;
                pro.TenNhienLieu = Hang.NhienLieu.TenNhienLieu;
                pro.DonViTinh = Hang.NhienLieu.DonViTinh.TenDonViTinh;
                pro.SoLuongChungTu = Convert.ToDouble(Hang.SoLuong);
                pro.SoLuongThucNhap = Convert.ToDouble(Hang.SoLuong);
                pro.DonGia = Convert.ToDouble(Hang.GiaNhap);
                pro.TenBen = Hang.Ben;
                pro.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oCusExport.listProduct.Add(pro);
            }
            oCusExport.TongTien = Convert.ToDouble(_Phieu.ThanhTien);
            oCusExport.TienBangChu = Formats.replace_special_word((double)_Phieu.ThanhTien);
            hdfViewReport["view"] = 1;
        }

        protected void gridVerticalChiTiet_BeforePerformDataSelect(object sender, EventArgs e)
        {
            //Session["QuyetToanBenID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["QuyetToanBenID"] = ((sender as ASPxVerticalGrid).Parent as GridViewDetailRowTemplateContainer).KeyValue;
        }
    }
}