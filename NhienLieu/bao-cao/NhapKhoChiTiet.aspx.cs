using DevExpress.Export;
using DevExpress.XtraPrinting;
using NhienLieu.libs;
using NhienLieu.reports;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.bao_cao
{
    public partial class NhapKhoChiTiet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hdfViewReport["view"] = 0;
            }
            if (hdfViewReport["view"].ToString() == "1")
                reportViewer.Report = CreatReport();
            else
                hdfViewReport["view"] = 0;
        }
        rpBangKeNhap CreatReport()
        {
            rpBangKeNhap rp = new rpBangKeNhap();
            //rp.odsGiaoDich.DataSource = oCusExport;
            rp.Parameters["TuNgay"].Visible = false;
            rp.Parameters["TuNgay"].Value = fromDay.Date;
            rp.Parameters["DenNgay"].Visible = false;
            rp.Parameters["DenNgay"].Value = toDay.Date;
            rp.Parameters["NgayThangNam"].Visible = false;
            rp.Parameters["NgayThangNam"].Value = "TP Long Xuyên, " + Formats.ConvertToFullStringDate(DateTime.Now);
            rp.Parameters["TuNgayDenNgay"].Visible = false;
            rp.Parameters["TuNgayDenNgay"].Value = "Từ ngày " + fromDay.Date.ToString("dd/MM/yyyy") + " đến ngày " + toDay.Date.ToString("dd/MM/yyyy");
            rp.CreateDocument();
            return rp;
        }
        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter == "Review")
                cbpInfo.JSProperties["cp_rpView"] = true;
        }
        protected void dateEditControl_Init(object sender, EventArgs e)
        {
            Formats.InitDateEditControl(sender, e);
        }

        protected void gridChiTietNhapKho_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void btnXuatExcel_Click(object sender, EventArgs e)
        {
            exporterGrid.FileName = "Bao_Cao_Nhap_Kho" + "_" + DateTime.Now.ToString("yy-MM-dd");
            exporterGrid.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
    }
}