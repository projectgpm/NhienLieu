using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhienLieu.libs
{
    public class oProductChuyenKho
    {
        public oProductChuyenKho()
        {
        }

        public oProductChuyenKho(int sTT, int iD, string maNhienLieu, string tenNhienLieu, string donViTinh, double tonKho, double soLuong, double donGia)
        {
            STT = sTT;
            ID = iD;
            MaNhienLieu = maNhienLieu;
            TenNhienLieu = tenNhienLieu;
            DonViTinh = donViTinh;
            TonKho = tonKho;
            SoLuong = soLuong;
            DonGia = donGia;
            ThanhTien = soLuong * donGia;
        }

        public int STT { get; set; }
        public int ID { get; set; }
        public string MaNhienLieu { get; set; }
        public string TenNhienLieu { get; set; }
        public string DonViTinh { get; set; }
        public double TonKho { get; set; }
        public double SoLuong { get; set; }
        public double DonGia { get; set; }
        public double ThanhTien { get; set; }

    }
    public class oReportChuyenKho
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
        public string KhoNhan { get; set; }
        public List<oProductChuyenKho> listProduct { get; set; }
    }
}