using DevExpress.Web;
using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.nhap_lieu
{
    public partial class quyet_toan_xi_nghiep : System.Web.UI.Page
    {
        public List<OQuyetToanBen> listReceiptProducts
        {
            get
            {
                if (Session["listOQuyetToanXiNghiep"] == null)
                    Session["listOQuyetToanXiNghiep"] = new List<OQuyetToanBen>();
                return (List<OQuyetToanBen>)Session["listOQuyetToanXiNghiep"];
            }
            set
            {
                Session["listOQuyetToanXiNghiep"] = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            
            if (!IsPostBack)
            {
                listReceiptProducts = new List<OQuyetToanBen>();
                //BindGrid();
                khoitao();
            }
            //else BindGrid();
        }
        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }

        protected void cbp_BQT_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "Review": /*Review();*/ break;
                case "save": Save(); BindGrid(); break;
                case "UnitChange": Unitchange(para[1], para[2]); BindGrid(); break;
                case "LapPhieu": Onload(); BindGrid(); break;
                default: break;
            }
        }
        /*rpNhapKho CreatReport()
        {
            rpNhapKho rp = new rpNhapKho();
            rp.odsGiaoDich.DataSource = oCusExport;
            rp.CreateDocument();
            return rp;
        }*/
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
        /*private void Review()
        {
            oCusExport = new oReportNhapKho();
            oCusExport.NguonNhap = txt_nguonnhap.Text;
            oCusExport.NgayThangNam = "Long Xuyên, " + Formats.ConvertToFullStringDate(DateTime.Parse(deNgayLapPhieu.Text));
            oCusExport.DonViBanHang = cbbDonViBH.Text;
            oCusExport.DiaChi = txt_diachi.Text;
            oCusExport.HoaDonSo = txt_hoadonso.Text;
            oCusExport.NgayHoaDon = txt_ngaynhap.Text;
            oCusExport.TenKho = "XN. Phà An Hòa";//_Phieu.kKho.TenKho;
            oCusExport.SoTT = "Xem trước";
            oCusExport.listProduct = new List<oProductNhapKho>();
            double TongTien = 0;
            int i = 1;
            foreach (var Hang in listReceiptProducts)
            {
                TongTien += Hang.ThanhTien;
                oProductNhapKho pro = new oProductNhapKho();
                pro.ID = i++;
                pro.MaNhienLieu = Hang.MaNhienLieu;
                pro.TenNhienLieu = Hang.TenNhienLieu;
                pro.DonViTinh = Hang.DonViTinh;
                pro.SoLuongChungTu = Hang.SoLuongChungTu;
                pro.SoLuongThucNhap = Hang.SoLuongThucNhap;
                pro.DonGia = Hang.DonGia;
                pro.TenBen = Hang.TenBen;
                pro.ThanhTien = Hang.ThanhTien;
                oCusExport.listProduct.Add(pro);
            }
            oCusExport.TongTien = Convert.ToDouble(TongTien);
            oCusExport.TienBangChu = Formats.replace_special_word((double)TongTien);
            cbpNhienLieu.JSProperties["cp_rpView"] = true;
        }*/
        private void Onload()
        {
            listReceiptProducts.Clear();
            int BenID = Convert.ToInt32(cbb_Ben.Value);
            int Thang = Convert.ToInt32(cbThang.Value);
            int Nam = Convert.ToInt32(cbNam.Value);
            int ky = Convert.ToInt32(cbKy.Value);
            int tungay = 1, denngay = 31;
            switch(ky)
            {
                case 0:
                    denngay = 11;
                    break;
                case 1:
                    tungay = 11;
                    denngay = 20;
                    break;
                case 2:
                    tungay = 21;
                    break;
                default: break;
            }
            var list_pha = DBProvider.DB.Phas.Where(p => p.BenID == BenID).ToList();
            
            foreach  (Pha pha in list_pha)
            {
                //var exist = listReceiptProducts.SingleOrDefault(q => q.ID == pha.ID);
                //if(exist == null)
                //{
                string newName = string.Format("{0} ({1}) \n ({2})",pha.TenPha, pha.SoPhaCu, pha.SoHieu);
                    OQuyetToanBen qt = new OQuyetToanBen(Convert.ToInt32(pha.ID), newName,
                    Convert.ToDouble(DBProvider.DB.ChamCongs.Where(q => q.PhaID == pha.ID && q.Nam == Nam && q.Thang == Thang && tungay <= q.Ngay && q.Ngay <= denngay).Sum(q => q.Ca1)),
                    Convert.ToDouble(DBProvider.DB.ChamCongs.Where(q => q.PhaID == pha.ID && q.Nam == Nam && q.Thang == Thang && tungay <= q.Ngay && q.Ngay <= denngay).Sum(q => q.Ca2)),
                    Convert.ToDouble(pha.DinhMuc), 0, 0, 0, 0, 0
                    );
                    listReceiptProducts.Add(qt);
                //}
                
            }

            OQuyetToanBen TongCong = new OQuyetToanBen(-1, "Tổng cộng",
            Convert.ToDouble(listReceiptProducts.Sum(q=>q.TuaNgay)) ,
            Convert.ToDouble(listReceiptProducts.Sum(q => q.TuaDem)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.TongTua)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.DinhMuc)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.VCNgay)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.VCDem)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.VanChuyen)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.BomNuoc)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.MayPhat)), 
            Convert.ToDouble(listReceiptProducts.Sum(q => q.CongTac)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.TongDau)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.ChamMay)), 
            Convert.ToDouble(listReceiptProducts.Sum(q => q.ThayMay)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.TongNhot))
            );
            listReceiptProducts.Add(TongCong);
        }
        private void BindGrid()
        {
            gridQuyetToan.DataSource = listReceiptProducts;
            gridQuyetToan.DataBind();
        }
        private void Unitchange(string para, string sub_index)
        {
            int index = Convert.ToInt32(para);
            int sub_in = Convert.ToInt32(sub_index);

            ASPxSpinEdit se_bomnuoc = gridQuyetToan.FindRowCellTemplateControl(sub_in, (VerticalGridDataRow)gridQuyetToan.Rows["BomNuoc"], "se_bomnuoc") as ASPxSpinEdit;
            double bomnuoc = Convert.ToDouble(se_bomnuoc.Number);
            
            ASPxSpinEdit se_mayphat = gridQuyetToan.FindRowCellTemplateControl(sub_in, (VerticalGridDataRow)gridQuyetToan.Rows["MayPhat"], "se_mayphat") as ASPxSpinEdit;
            double mayphat = Convert.ToDouble(se_mayphat.Number);

            ASPxSpinEdit se_congtac = gridQuyetToan.FindRowCellTemplateControl(sub_in, (VerticalGridDataRow)gridQuyetToan.Rows["CongTac"], "se_congtac") as ASPxSpinEdit;
            double congtac = Convert.ToDouble(se_congtac.Number);

            ASPxSpinEdit se_chammay = gridQuyetToan.FindRowCellTemplateControl(sub_in, (VerticalGridDataRow)gridQuyetToan.Rows["ChamMay"], "se_chammay") as ASPxSpinEdit;
            double chammay = Convert.ToDouble(se_chammay.Number);

            ASPxSpinEdit se_thaymay = gridQuyetToan.FindRowCellTemplateControl(sub_in, (VerticalGridDataRow)gridQuyetToan.Rows["ThayMay"], "se_thaymay") as ASPxSpinEdit;
            double thaymay = Convert.ToDouble(se_thaymay.Number);
            // cập nhật

            var sourceRow = listReceiptProducts.Where(x => x.ID == index).SingleOrDefault();
            sourceRow.MayPhat = mayphat;
            sourceRow.BomNuoc = bomnuoc;
            sourceRow.ChamMay = chammay;
            sourceRow.CongTac = congtac;
            sourceRow.ThayMay = thaymay;

            sourceRow.TongDau = sourceRow.VanChuyen + sourceRow.BomNuoc + sourceRow.MayPhat + sourceRow.CongTac;
            sourceRow.TongNhot = sourceRow.ChamMay + sourceRow.ThayMay;

            
            listReceiptProducts.RemoveAt(listReceiptProducts.Count-1);
            OQuyetToanBen TongCong = new OQuyetToanBen(-1, "Tổng cộng",
            Convert.ToDouble(listReceiptProducts.Sum(q => q.TuaNgay)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.TuaDem)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.TongTua)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.DinhMuc)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.VCNgay)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.VCDem)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.VanChuyen)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.BomNuoc)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.MayPhat)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.CongTac)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.TongDau)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.ChamMay)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.ThayMay)),
            Convert.ToDouble(listReceiptProducts.Sum(q => q.TongNhot))
            );
            listReceiptProducts.Add(TongCong);
            //sourceRow.DonGia = PriceProduct_GiaVon;
            //sourceRow.ThanhTien = UnitProductNew * PriceProduct_GiaVon;
            //gridNhienLieu.JSProperties["cp_LoadInFo"] = true;

            //BindGrid();
        }
        protected void sp_Init(object sender, EventArgs e)
        {
            ASPxSpinEdit SpinEdit = sender as ASPxSpinEdit;
            //GridViewDataRowTemplateContainer container = SpinEdit.NamingContainer as GridViewDataRowTemplateContainer;
            VerticalGridDataItemTemplateContainer container = SpinEdit.NamingContainer as VerticalGridDataItemTemplateContainer;
            SpinEdit.ClientSideEvents.NumberChanged = string.Format("function(s, e) {{ onUnitReturnChanged(s,e,{0}); }}", container.KeyValue);
            
        }
        void khoitao()
        {
            cbb_Ben.SelectedIndex = 0;
            int day = DateTime.Now.Day;
            cbKy.SelectedIndex = 0;
            if (day >= 11) cbKy.SelectedIndex = 1;
            if (day >= 21) cbKy.SelectedIndex = 2;
            //clear before create
            cbNam.Items.Clear();
            cbThang.Items.Clear();
            //create
            cbNam.Items.Add("Năm " + (DateTime.Now.Year - 1), DateTime.Now.Year - 1);
            cbNam.Items.Add("Năm " + DateTime.Now.Year, DateTime.Now.Year);
            cbNam.SelectedIndex = 1;
            CbNam_Change();
        }
        private void CbNam_Change()
        {
            int namht = DateTime.Now.Year;
            int thang = 12;
            if (namht == Convert.ToInt32(cbNam.Value))
                thang = DateTime.Now.Month;
            cbThang.Items.Clear();
            for (int i = 1; i <= thang; i++)
            {
                cbThang.Items.Add("Tháng " + i, i);
            }
            cbThang.SelectedIndex = thang;
        }

        protected void cbpInfo_Callback(object sender, CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "Refill": CbNam_Change(); break;
                default: break;
            }
        }
        private void Save()
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    if (gridQuyetToan.VisibleRecordCount > 0)
                    {
                        QuyetToan_Ben qt = new QuyetToan_Ben();
                        qt.BenID = Convert.ToInt32(cbb_Ben.Value);
                        qt.NgayLap = DateTime.Now;
                        int Thang = Convert.ToInt32(cbThang.Value);
                        int Nam = Convert.ToInt32(cbNam.Value);
                        int ky = Convert.ToInt32(cbKy.Value);
                        switch (ky)
                        {
                            case 0:
                                qt.ThoiGian = string.Format("Từ ngày 1/{0}/{1} đến ngày 10/{2}/{3}", Thang, Nam, Thang, Nam);
                                break;
                            case 1:
                                qt.ThoiGian = string.Format("Từ ngày 11/{0}/{1} đến ngày 20/{2}/{3}", Thang, Nam, Thang, Nam);
                                break;
                            case 2:
                                int day = DateTime.DaysInMonth(Nam, Thang);
                                qt.ThoiGian = string.Format("Từ ngày 21/{0}/{1} đến ngày {2}/{3}/{4}", Thang, Nam, day, Thang, Nam);
                                break;
                            default: break;
                        }
                        qt.DaXoa = 0;
                        qt.Ky = ky;
                        qt.Thang = Thang;
                        qt.Nam = Nam;
                        DBProvider.DB.QuyetToan_Bens.InsertOnSubmit(qt);
                        DBProvider.DB.SubmitChanges();
                        List<OQuyetToanBen> tmp = listReceiptProducts.ToList();
                        tmp.RemoveAt(listReceiptProducts.Count - 1);
                        foreach (OQuyetToanBen qtb in tmp)
                        {
                            QuyetToan_Ben_ChiTiet ct = new QuyetToan_Ben_ChiTiet();
                            ct.QuyetToanBenID = qt.ID;
                            ct.PhaID = qtb.ID;
                            ct.DinhMuc = qtb.DinhMuc;
                            ct.TongTua = qtb.TongTua;
                            ct.TuaNgay = qtb.TuaNgay;
                            ct.TuaDem = qtb.TuaDem;
                            ct.TongDau = qtb.TongDau;
                            ct.VanChuyen = qtb.VanChuyen;
                            ct.VCNgay = qtb.VCNgay;
                            ct.VCDem = qtb.VCDem;
                            ct.BomNuoc = qtb.BomNuoc;
                            ct.MayPhat = qtb.MayPhat;
                            ct.CongTac = qtb.CongTac;
                            ct.TongNhot = qtb.TongNhot;
                            ct.ChamMay = qtb.ChamMay;
                            ct.ThayMay = qtb.ThayMay;
                            DBProvider.DB.QuyetToan_Ben_ChiTiets.InsertOnSubmit(ct);
                            DBProvider.DB.SubmitChanges();
                        }
                        qt.TongTua = Convert.ToDouble(listReceiptProducts.Sum(q => q.TongTua));
                        qt.TuaNgay = Convert.ToDouble(listReceiptProducts.Sum(q => q.TuaNgay));
                        qt.TuaDem = Convert.ToDouble(listReceiptProducts.Sum(q => q.TuaDem));
                        qt.TongDau = Convert.ToDouble(listReceiptProducts.Sum(q => q.TongDau));
                        qt.VanChuyen = Convert.ToDouble(listReceiptProducts.Sum(q => q.VanChuyen));
                        qt.VCNgay = Convert.ToDouble(listReceiptProducts.Sum(q => q.VCNgay));
                        qt.VCDem = Convert.ToDouble(listReceiptProducts.Sum(q => q.VCDem));
                        qt.BomNuoc = Convert.ToDouble(listReceiptProducts.Sum(q => q.BomNuoc));
                        qt.MayPhat = Convert.ToDouble(listReceiptProducts.Sum(q => q.MayPhat));
                        qt.CongTac = Convert.ToDouble(listReceiptProducts.Sum(q => q.CongTac));
                        qt.TongNhot = Convert.ToDouble(listReceiptProducts.Sum(q => q.TongNhot));
                        qt.ChamMay = Convert.ToDouble(listReceiptProducts.Sum(q => q.ChamMay));
                        qt.ThayMay = Convert.ToDouble(listReceiptProducts.Sum(q => q.ThayMay));
                        DBProvider.DB.SubmitChanges();
                        scope.Complete();
                        cbp_BQT.JSProperties["cp_Reset"] = true;
                    }
                    else
                        cbp_BQT.JSProperties["cp_grid_null"] = true;
                }
                catch (Exception ex)
                {
                    cbp_BQT.JSProperties["cp_Error_Save"] = true;
                    scope.Dispose();
                    throw ex;
                }
            }
        }
    }
}