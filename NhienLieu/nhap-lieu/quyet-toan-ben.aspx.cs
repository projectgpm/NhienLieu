using DevExpress.Web;
using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.nhap_lieu
{
    public partial class quyet_toan_ben : System.Web.UI.Page
    {
        public List<OQuyetToanBen> listReceiptProducts
        {
            get
            {
                if (Session["listOQuyetToanBen"] == null)
                    Session["listOQuyetToanBen"] = new List<OQuyetToanBen>();
                return (List<OQuyetToanBen>)Session["listOQuyetToanBen"];
            }
            set
            {
                Session["listOQuyetToanBen"] = value;
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
                case "UnitChange": Unitchange(para[1], para[2]); BindGrid(); break;
                case "LapPhieu": Onload(); BindGrid(); break;
                default: break;
            }
        }
        private void Onload()
        {
            listReceiptProducts.Clear();
            int BenID = Convert.ToInt32(cbb_Ben.Value);
            DateTime TuNgay = fromDay.Date,
                     DenNgay = toDay.Date;
            var list_pha = DBProvider.DB.Phas.Where(p => p.BenID == BenID).ToList();
            
            foreach  (Pha pha in list_pha)
            {
                //var exist = listReceiptProducts.SingleOrDefault(q => q.ID == pha.ID);
                //if(exist == null)
                //{
                string newName = string.Format("{0} ({1}) \n ({2})",pha.TenPha, pha.SoPhaCu, pha.SoHieu);
                    OQuyetToanBen qt = new OQuyetToanBen(Convert.ToInt32(pha.ID), newName,
                    Convert.ToDouble(DBProvider.DB.ChamCongs.Where(q => q.PhaID == pha.ID && TuNgay <= q.NgayCham && q.NgayCham <= DenNgay).Sum(q => q.Ca1)),
                    Convert.ToDouble(DBProvider.DB.ChamCongs.Where(q => q.PhaID == pha.ID && TuNgay <= q.NgayCham && q.NgayCham <= DenNgay).Sum(q => q.Ca2)),
                    Convert.ToDouble(pha.DinhMuc), 0, 0, 0, 0, 0
                    );
                    listReceiptProducts.Add(qt);
                //}
                
            }
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
            double congtac = Convert.ToDouble(se_mayphat.Number);

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
    }
}