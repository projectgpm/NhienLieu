using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhienLieu.libs
{
    #region kiểm kê vật tư
    [Serializable]
    public class oImportProduct_KiemKeVatTu
    {
        public int STT { get; set; }
        public int ID { get; set; }
        public string MaNhienLieu { get; set; }
        public string TenNhienLieu { get; set; }
        public string DVT { get; set; }
        public double SoLuongTonCuoi { get; set; }
        public double GiaTriTonCuoi { get; set; }
        public double SoLuongNhap { get; set; }
        public double GiaTriNhap { get; set; }
        public double SoLuongThucTe { get; set; }
        public double ChenhLechThua { get; set; }
        public double TTChenhLechThua { get; set; }
        public double ChenhLechThieu { get; set; }
        public double TTChenhLechThieu { get; set; }
        public string KyHieuNhomVatTu { get; set; }
        public string TenNhomVatTu { get; set; }
        public double ChenhLech { get; set; }
        public double DonGiaCuoiKy { get; set; }
        public double DonGiaNhapTrongKy { get; set; }
        public oImportProduct_KiemKeVatTu(int iDVatTu, string kyHieu, string tenVatTu, string dVT, double soLuongTonCuoi, double giaTriTonCuoi, double soLuongNhap, double giaTriNhap, double soLuongThucTe, double chenhLechThua, double tTChenhLechThua, double chenhLechThieu, double tTChenhLechThieu, string kyHieuNhomVatTu, string tenNhomVatTu, double chenhLech, double donGiaCuoiKy, double donGiaNhapTrongKy)
        {
            // TODO: Complete member initialization
            this.ID = iDVatTu;
            this.MaNhienLieu = kyHieu;
            this.TenNhienLieu = tenVatTu;
            this.DVT = dVT;
            this.SoLuongTonCuoi = soLuongTonCuoi;
            this.GiaTriTonCuoi = giaTriTonCuoi;
            this.SoLuongNhap = soLuongNhap;
            this.SoLuongThucTe = soLuongThucTe;
            this.GiaTriNhap = giaTriNhap;
            this.ChenhLechThua = chenhLechThua;
            this.TTChenhLechThua = tTChenhLechThua;
            this.ChenhLechThieu = chenhLechThieu;
            this.TTChenhLechThieu = tTChenhLechThieu;
            this.KyHieuNhomVatTu = kyHieuNhomVatTu;
            this.TenNhomVatTu = tenNhomVatTu;
            this.ChenhLech = chenhLech;
            this.DonGiaCuoiKy = donGiaCuoiKy;
            this.DonGiaNhapTrongKy = donGiaNhapTrongKy;
        }
    }
    #endregion
    #region report kiểm kê vật tư
    [Serializable]
    public class oReportKiemKeVatTu
    {
        public string TieuDe { get; set; }
        public string TenKho { get; set; }
        public string CanCu { get; set; }
        public string DiaDiem { get; set; }
        public string ThanhPhanThamGia { get; set; }
        public string HoiDongThongNhat { get; set; }
        public string TieuDeTonDenCuoiNgay { get; set; }
        public string TieuDeNhapTuNgay { get; set; }
        public string TieuDeKiemKeThucTe { get; set; }
        public string NgayThangNam { get; set; }
        public List<oProduct_KiemKe> listProduct { get; set; }
    }
    [Serializable]
    public class oProduct_KiemKe
    {
        public string STT { get; set; }
        public string MaNhienLieu { get; set; }
        public string TenNhienLieu { get; set; }
        public string DVT { get; set; }
        public double SoLuongTonCuoi { get; set; }
        public double GiaTriTonCuoi { get; set; }
        public double SoLuongNhap { get; set; }
        public double GiaTriNhap { get; set; }
        public double SoLuongThucTe { get; set; }
        public double ChenhLechThua { get; set; }
        public double TTChenhLechThua { get; set; }
        public double ChenhLechThieu { get; set; }
        public double TTChenhLechThieu { get; set; }
        public string KyHieuNhomVatTu { get; set; }
        public string TenNhomVatTu { get; set; }
        public oProduct_KiemKe(string sTT, string kyHieu, string tenVatTu, string dVT, double soLuongTonCuoi, double giaTriTonCuoi, double soLuongNhap, double giaTriNhap, double soLuongThucTe, double chenhLechThua, double tTChenhLechThua, double chenhLechThieu, double tTChenhLechThieu, string kyHieuNhomVatTu, string tenNhomVatTu)
        {
            // TODO: Complete member initialization
            this.STT = sTT;
            this.MaNhienLieu = kyHieu;
            this.TenNhienLieu = tenVatTu;
            this.DVT = dVT;
            this.SoLuongTonCuoi = soLuongTonCuoi;
            this.GiaTriTonCuoi = giaTriTonCuoi;
            this.SoLuongNhap = soLuongNhap;
            this.SoLuongThucTe = soLuongThucTe;
            this.GiaTriNhap = giaTriNhap;
            this.ChenhLechThua = chenhLechThua;
            this.TTChenhLechThua = tTChenhLechThua;
            this.ChenhLechThieu = chenhLechThieu;
            this.TTChenhLechThieu = tTChenhLechThieu;
            this.KyHieuNhomVatTu = kyHieuNhomVatTu;
            this.TenNhomVatTu = tenNhomVatTu;
        }
        public oProduct_KiemKe()
        {
            // TODO: Complete member initialization
        }
        public oProduct_KiemKe(oProduct_KiemKe x)
        {
            // TODO: Complete member initialization
            this.STT = x.STT;
            this.MaNhienLieu = x.MaNhienLieu;
            this.TenNhienLieu = x.TenNhienLieu;
            this.DVT = x.DVT;
            this.SoLuongTonCuoi = x.SoLuongTonCuoi;
            this.GiaTriTonCuoi = x.GiaTriTonCuoi;
            this.SoLuongNhap = x.SoLuongNhap;
            this.SoLuongThucTe = x.SoLuongThucTe;
            this.GiaTriNhap = x.GiaTriNhap;
            this.ChenhLechThua = x.ChenhLechThua;
            this.TTChenhLechThua = x.TTChenhLechThua;
            this.ChenhLechThieu = x.ChenhLechThieu;
            this.TTChenhLechThieu = x.TTChenhLechThieu;
            this.KyHieuNhomVatTu = x.KyHieuNhomVatTu;
            this.TenNhomVatTu = x.TenNhomVatTu;
        }
    }
    #endregion
}