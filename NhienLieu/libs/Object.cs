using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhienLieu.libs
{
    
    [Serializable]
    public class oProductXuatKho
    {
        public oProductXuatKho()
        {
        }

        public oProductXuatKho(int sTT, int iD, string maNhienLieu, string tenNhienLieu, string tenPha, string dVT, double tonKho,double soLuong, double donGia)
        {
            STT = sTT;
            ID = iD;
            MaNhienLieu = maNhienLieu;
            TenNhienLieu = tenNhienLieu;
            TenPha = tenPha;
            DonViTinh = dVT;
            TonKho = tonKho;
            SoLuong = soLuong;
            DonGia = donGia;
            ThanhTien = soLuong * donGia;
        }

        public int STT { get; set; }
        public int ID { get; set; }
        public string MaNhienLieu { get; set; }
        public string TenNhienLieu { get; set; }
        public string TenPha { get; set; }
        public string DonViTinh { get; set; }
        public double TonKho { get; set; }
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