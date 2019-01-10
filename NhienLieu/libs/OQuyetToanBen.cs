using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhienLieu.libs
{
    public class OQuyetToanBen
    {
        public OQuyetToanBen(int iD, string tenPha, double tuaNgay, double tuaDem, double dinhMuc, double bomNuoc, double mayPhat, double congTac, double chamMay, double thayMay)
        {
            ID = iD;
            TenPha = tenPha;
            TuaNgay = tuaNgay;
            TuaDem = tuaDem;
            TongTua = tuaNgay + tuaDem;
            DinhMuc = dinhMuc;
            VCNgay = tuaNgay * dinhMuc;
            VCDem = tuaDem * dinhMuc;
            VanChuyen = VCNgay + VCDem;
            BomNuoc = bomNuoc;
            MayPhat = mayPhat;
            CongTac = congTac;
            TongDau = VanChuyen + BomNuoc + MayPhat + CongTac;
            ChamMay = chamMay;
            ThayMay = thayMay;
            TongNhot = chamMay + thayMay;
        }
        public OQuyetToanBen() { }
        public int ID { get; set; }
        public string TenPha { get; set; }
        public double TuaNgay { get; set; }
        public double TuaDem { get; set; }
        public double TongTua { get; set; }
        public double DinhMuc { get; set; }
        public double VCNgay { get; set; }
        public double VCDem { get; set; }
        public double VanChuyen { get; set; }
        public double BomNuoc { get; set; }
        public double MayPhat { get; set; }
        public double CongTac { get; set; }
        public double TongDau { get; set; }
        public double ChamMay { get; set; }
        public double ThayMay { get; set; }
        public double TongNhot { get; set; }
    }
}