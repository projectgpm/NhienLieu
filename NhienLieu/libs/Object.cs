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
        public string MaNhienLieu { get; set; }
        public string TenNhienLieu { get; set; }
        public string DonViTinh { get; set; }
        public double SoLuongChungTu { get; set; }
        public double SoLuongThucNhap { get; set; }
        public double DonGia { get; set; }
        public double ThanhTien { get; set; }
        public string Ben { get; set; }
        public oProductNhapKho(string kyhieu, string tenNhienLieu, string dvt, double slchungtu, double sltn, double dongia, string benPha)
        {
            // TODO: Complete member initialization
            this.MaNhienLieu = kyhieu;
            this.TenNhienLieu = tenNhienLieu;
            this.DonViTinh = dvt;
            this.SoLuongChungTu = slchungtu;
            this.SoLuongThucNhap = sltn;
            this.DonGia = dongia;
            this.Ben = benPha;
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
            this.Ben = x.Ben;
        }
    }
    #endregion
    [Serializable]
    public class oProductXuatKho
    {
        public oProductXuatKho()
        {
        }

        public oProductXuatKho(int sTT, string kyHieu, string tenNhienLieu, string dVT, double soLuong, double donGia)
        {
            STT = sTT;
            KyHieu = kyHieu;
            TenNhienLieu = tenNhienLieu;
            DVT = dVT;
            SoLuong = soLuong;
            DonGia = donGia;
            ThanhTien = soLuong * donGia;
        }

        public int STT { get; set; }
        public string KyHieu { get; set; }
        public string TenNhienLieu { get; set; }
        public string DVT { get; set; }
        public double SoLuong { get; set; }
        public double DonGia { get; set; }
        public double ThanhTien { get; set; }
    }
    [Serializable]
    public class oReportXuatKho
    {
        public string SoPhieu { get; set; }
        public string CanCu { get; set; }
        public string DoiTuongXuat { get; set; }
        public string ThoiHanXuat { get; set; }
        public string KhoXuat { get; set; }
        public string DiaChi { get; set; }
        public string Ngay { get; set; }
        public string NgayThangNam { get; set; }
        public double TongTien { get; set; }
        public string TienBangChu { get; set; }
        public string TenKho { get; set; }
        public List<oProductXuatKho> listProduct { get; set; }
    }
}