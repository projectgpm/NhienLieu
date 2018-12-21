using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhienLieu.libs
{
    public class NhienLieuXuat
    {
        public NhienLieuXuat(int iD, string maNhienLieu, string tenNhienLieu, string donViTinh, double tonKho, double soLuong, double donGia)
        {
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
}