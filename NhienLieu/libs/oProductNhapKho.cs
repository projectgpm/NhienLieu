using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhienLieu.libs
{
    #region report nhập kho
    [Serializable]
    public class oReportNhapKho
    {
        public string SoTT { get; set; }
        public string NguonNhap { get; set; }
        public string DonViBanHang { get; set; }
        public string DiaChi { get; set; }
        public string HoaDonSo { get; set; }
        public string NgayHoaDon { get; set; }
        public string NgayThangNam { get; set; }
        public double TongTien { get; set; }
        public string TienBangChu { get; set; }
        public string TenKho { get; set; }
        public List<oProductNhapKho> listProduct { get; set; }
    }
    [Serializable]
    public class oProductNhapKho
    {
        public int ID { get; set; }
        public int IDNhienLieu { get; set; }
        public string MaNhienLieu { get; set; }
        public string TenNhienLieu { get; set; }
        public string DonViTinh { get; set; }
        public double SoLuongChungTu { get; set; }
        public double SoLuongThucNhap { get; set; }
        public double DonGia { get; set; }
        public double ThanhTien { get; set; }
        public int IDBenPha { get; set; }
        public string TenBen { get; set; }
        public oProductNhapKho(int iDNhienLieu, string kyhieu, string tenNhienLieu, string dvt, double slchungtu, double sltn, double dongia, int iDBenPha, string benPha)
        {
            // TODO: Complete member initialization
            this.IDNhienLieu = iDNhienLieu;
            this.MaNhienLieu = kyhieu;
            this.TenNhienLieu = tenNhienLieu;
            this.DonViTinh = dvt;
            this.SoLuongChungTu = slchungtu;
            this.SoLuongThucNhap = sltn;
            this.DonGia = dongia;
            this.IDBenPha = iDBenPha;
            this.TenBen = benPha;
            this.ThanhTien = sltn * dongia;
        }
        public oProductNhapKho()
        {
            // TODO: Complete member initialization
        }
        public oProductNhapKho(oProductNhapKho x)
        {
            // TODO: Complete member initialization
            this.ID = x.ID;
            this.MaNhienLieu = x.MaNhienLieu;
            this.TenNhienLieu = x.TenNhienLieu;
            this.DonViTinh = x.DonViTinh;
            this.SoLuongChungTu = x.SoLuongChungTu;
            this.SoLuongThucNhap = x.SoLuongThucNhap;
            this.DonGia = x.DonGia;
            this.ThanhTien = x.ThanhTien;
            this.TenBen = x.TenBen;
            this.IDNhienLieu = x.IDNhienLieu;
            this.IDBenPha = x.IDBenPha;
        }
    }
    #endregion
}