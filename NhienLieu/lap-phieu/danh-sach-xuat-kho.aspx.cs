using DevExpress.Web;
using NhienLieu.libs;
using NhienLieu.reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.lap_phieu
{
    public partial class danh_sach_xuat_kho : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            if (!IsPostBack)
            {
                hdfViewReport["view"] = 0;
                gridDSXuatKho.DataBind();
            }
            if (hdfViewReport["view"].ToString() == "1")
                reportViewer.Report = CreatReport();
            else
                hdfViewReport["view"] = 0;
        }
        rpXuatKho CreatReport()
        {
            rpXuatKho rp = new rpXuatKho();
            rp.odsGiaoDich.DataSource = oCusExport;
            rp.CreateDocument();
            return rp;
        }
        private oReportXuatKho oCusExport
        {
            get
            {
                return (oReportXuatKho)Session["ocus_oReportXuatKho"];
            }
            set
            {
                Session["ocus_oReportXuatKho"] = value;
            }
        }
        protected void gridDSXuatKho_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridChiTietXuatKho_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PhieuXuatID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }
        protected void btnXoaPhieu_Init(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btn.NamingContainer as GridViewDataRowTemplateContainer;
            var _phieu = DBProvider.DB.PhieuXuatKhos.FirstOrDefault(x => x.ID == Convert.ToInt32(container.KeyValue));
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
            var _phieu = DBProvider.DB.PhieuXuatKhos.FirstOrDefault(x => x.ID == Convert.ToInt32(container.KeyValue));
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
            var _phieu = DBProvider.DB.PhieuXuatKhos.FirstOrDefault(q => q.ID == id);
            if(_phieu != null && _phieu.DaXoa == 0)
            {
                _phieu.DaXoa = 1;
                List<PhieuXuatKho_ChiTiet> list = DBProvider.DB.PhieuXuatKho_ChiTiets.Where(q => q.PhieuXuatID == id).ToList();
                foreach (var _chitiet in list)
                {
                    var _nhienlieu = DBProvider.DB.NhienLieus.FirstOrDefault( t => t.ID == _chitiet.NhienLieuID);
                    Kho_TheKho thekho = new Kho_TheKho();
                    thekho.DienGiai = "Hủy phiếu xuất kho #" +_phieu.SoPhieu;
                    thekho.NhienLieuID = _nhienlieu.ID;
                    thekho.NgayNhap = DateTime.Now;
                    thekho.Xuat = 0;
                    thekho.Nhap = _chitiet.SoLuong;
                    thekho.Ton = 0;// _nhienlieu.TonKho += _chitiet.SoLuong;
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
            var _Phieu = DBProvider.DB.PhieuXuatKhos.FirstOrDefault(x => x.ID == id);
            oCusExport = new oReportXuatKho();
            oCusExport.CanCu = _Phieu.CanCu;
            oCusExport.DoiTuongXuat = _Phieu.DoiTuongXuat;
            oCusExport.ThoiHanXuat = _Phieu.ThoiHanXuat;
            oCusExport.KhoXuat = _Phieu.Ben.TenBen;
            oCusExport.DiaChi = "";
            oCusExport.NgayThangNam = "Long Xuyên, " + Formats.ConvertToFullStringDate(DateTime.Parse(_Phieu.NgayLapPhieu.ToString()));
            oCusExport.Ngay = _Phieu.Ngay.ToString();
            oCusExport.SoPhieu = _Phieu.SoPhieu;
            oCusExport.listProduct = new List<oProductXuatKho>();
            List<PhieuXuatKho_ChiTiet> ListHang = DBProvider.DB.PhieuXuatKho_ChiTiets.Where(x => x.PhieuXuatID == id).ToList();
            int i = 1;
            foreach (var Hang in ListHang)
            {
                oProductXuatKho pro = new oProductXuatKho();
                pro.STT = i++;
                pro.KyHieu = Hang.NhienLieu.MaNhienLieu;
                pro.TenNhienLieu = Hang.NhienLieu.TenNhienLieu;
                pro.DVT = Hang.NhienLieu.DonViTinh.TenDonViTinh;
                pro.SoLuong = Convert.ToDouble(Hang.SoLuong);
                pro.DonGia = Convert.ToDouble(Hang.GiaXuat);
                pro.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oCusExport.listProduct.Add(pro);
            }
            oCusExport.TongTien = Convert.ToDouble(_Phieu.ThanhTien);
            oCusExport.TienBangChu = Formats.replace_special_word((double)_Phieu.ThanhTien);
            hdfViewReport["view"] = 1;
        }
    }
}