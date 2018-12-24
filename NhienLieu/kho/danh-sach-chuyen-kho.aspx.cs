using DevExpress.Web;
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
    public partial class danh_sach_chuyen_kho : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            if (!IsPostBack)
            {
                hdfViewReport["view"] = 0;
                gridDSChuyenKho.DataBind();
            }
            if (hdfViewReport["view"].ToString() == "1")
                reportViewer.Report = CreatReport();
            else
                hdfViewReport["view"] = 0;
        }
        rpChuyenKho CreatReport()
        {
            rpChuyenKho rp = new rpChuyenKho();
            rp.odsGiaoDich.DataSource = oCusExport;
            rp.CreateDocument();
            return rp;
        }
        private oReportChuyenKho oCusExport
        {
            get
            {
                return (oReportChuyenKho)Session["ocus_oReportChuyenKho"];
            }
            set
            {
                Session["ocus_oReportChuyenKho"] = value;
            }
        }
        protected void gridDSChuyenKho_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridChiTietChuyenKho_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PhieuChuyenID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }
        protected void btnXoaPhieu_Init(object sender, EventArgs e)
        {
            ASPxButton btn = sender as ASPxButton;
            GridViewDataRowTemplateContainer container = btn.NamingContainer as GridViewDataRowTemplateContainer;
            var _phieu = DBProvider.DB.PhieuChuyenKhos.FirstOrDefault(x => x.ID == Convert.ToInt32(container.KeyValue));
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
            var _phieu = DBProvider.DB.PhieuChuyenKhos.FirstOrDefault(x => x.ID == Convert.ToInt32(container.KeyValue));
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
            // hủy phiếu - trừ tồn kho
            var _phieu = DBProvider.DB.PhieuXuatKhos.FirstOrDefault(q => q.ID == id);
            if(_phieu != null && _phieu.DaXoa == 0)
            {
                _phieu.DaXoa = 1;
                List<PhieuChuyenKho_ChiTiet> list = DBProvider.DB.PhieuChuyenKho_ChiTiets.Where(q => q.PhieuChuyenID == id).ToList();
                foreach (var _chitiet in list)
                {/*
                    var tonkho = DBProvider.DB.Kho_TonKhos.FirstOrDefault(k=>k.BenID == _phieu.BenXuatID && k.NhienLieuID == _chitiet.NhienLieuID);
                    Kho_TheKho thekho = new Kho_TheKho();
                    thekho.NhienLieuID = _chitiet.NhienLieuID;
                    thekho.BenID = _phieu.BenXuatID;
                    thekho.NgayNhap = DateTime.Now;
                    thekho.DienGiai = "Hủy phiếu xuất #"+_phieu.SoPhieu;
                    thekho.Nhap = _chitiet.SoLuong; //sl hủy
                    thekho.Xuat = 0;
                    thekho.Ton = tonkho.TonKho + _chitiet.SoLuong;
                    thekho.GiaThoiDiem = _chitiet.GiaXuat;
                    thekho.NhanVienID = Formats.IDUser();
                    DBProvider.DB.Kho_TheKhos.InsertOnSubmit(thekho);

                    //cập nhật lại tồn kho
                    tonkho.TonKho += _chitiet.SoLuong;*/
                }
                DBProvider.DB.SubmitChanges();
                cbpReport.JSProperties["cp_Suc"] = true;
            }
            else
                cbpReport.JSProperties["cp_Err"] = true;

        }
        private void ShowReport(int id)
        {
            var _Phieu = DBProvider.DB.PhieuChuyenKhos.FirstOrDefault(x => x.ID == id);
            oCusExport = new oReportChuyenKho();
            oCusExport.CanCu = _Phieu.CanCu;
            oCusExport.DoiTuongXuat = _Phieu.DoiTuongXuat;
            oCusExport.ThoiHanXuat = _Phieu.ThoiHanXuat;
            oCusExport.KhoXuat = DBProvider.DB.Bens.FirstOrDefault(b => b.ID == _Phieu.BenChuyenID).TenBen;
            oCusExport.DiaChi = "";
            oCusExport.NgayThangNam = "Long Xuyên, " + Formats.ConvertToFullStringDate(DateTime.Parse(_Phieu.NgayLapPhieu.ToString()));
            oCusExport.Ngay = _Phieu.Ngay.ToString();
            oCusExport.SoPhieu = _Phieu.SoPhieu;
            oCusExport.listProduct = new List<oProductChuyenKho>();
            List<PhieuChuyenKho_ChiTiet> ListHang = DBProvider.DB.PhieuChuyenKho_ChiTiets.Where(x => x.PhieuChuyenID == id).ToList();
            int i = 1;
            foreach (var Hang in ListHang)
            {
                oProductChuyenKho pro = new oProductChuyenKho();
                pro.STT = i++;
                pro.MaNhienLieu = Hang.NhienLieu.MaNhienLieu;
                pro.TenNhienLieu = Hang.NhienLieu.TenNhienLieu;
                pro.DonViTinh = Hang.NhienLieu.DonViTinh.TenDonViTinh;
                pro.SoLuong = Convert.ToDouble(Hang.SoLuongChuyen);
                pro.DonGia = Convert.ToDouble(Hang.GiaXuat);
                pro.ThanhTien = Convert.ToDouble(Hang.ThanhTien);
                oCusExport.listProduct.Add(pro);
            }
            oCusExport.TongTien = Convert.ToDouble(_Phieu.ThanhTien);
            oCusExport.TienBangChu = Formats.replace_special_word((double)_Phieu.ThanhTien);
            hdfViewReport["view"] = 1;
        }

        protected void gridChiTietChuyenKho_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
    }
}