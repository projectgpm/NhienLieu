using DevExpress.Web;
using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.nhap_lieu
{
    public partial class lap_bang_quyet_toan : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            
            if (!IsPostBack)
            {
                //dt = new DataTable();
            }
            else BindGrid();
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
                case "LapPhieu": LapPhieu(Convert.ToInt32(cbb_Ben.Value)); BindGrid(); break;
                default: break;
            }
        }
        
        void LapPhieu(int BenID)
        {

            // gridBangQuyetToan.Columns.Clear();
            List<Pha> List_Pha = DBProvider.DB.Phas.Where(q => q.BenID == BenID).ToList();
            GridViewDataColumn col_ID = new GridViewDataColumn();
            col_ID.FieldName = "ID";
            col_ID.Caption = "ID";
            col_ID.Visible = false;
            dt.Columns.Add("ID", Type.GetType("System.String"));
            gridBangQuyetToan.Columns.Add(col_ID);
            GridViewDataColumn coltt = new GridViewDataColumn();
            coltt.FieldName = "STT";
            coltt.Caption = "STT";
            coltt.Visible = true;
            coltt.HeaderStyle.Font.Bold = true;
            coltt.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            coltt.CellStyle.HorizontalAlign = HorizontalAlign.Center;
            coltt.Settings.AllowSort = DevExpress.Utils.DefaultBoolean.False;
            dt.Columns.Add("STT", Type.GetType("System.String"));
            gridBangQuyetToan.Columns.Add(coltt);
            GridViewDataColumn col_chitieu = new GridViewDataColumn();
            col_chitieu.FieldName = "ChiTieu";
            col_chitieu.Caption = "Chỉ tiêu";
            col_chitieu.Visible = true;
            col_chitieu.HeaderStyle.Font.Bold = true;
            col_chitieu.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            col_chitieu.ReadOnly = true;
            dt.Columns.Add("ChiTieu", Type.GetType("System.String"));
            gridBangQuyetToan.Columns.Add(col_chitieu);
            //col band
            GridViewBandColumn col_tenpha = new GridViewBandColumn();
            col_tenpha.Caption = "Tên phà";
            col_tenpha.HeaderStyle.Font.Bold = true;
            col_tenpha.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            
            //add cột phà
            foreach (Pha pha in List_Pha)
            {
                GridViewDataColumn col_pha = new GridViewDataColumn();
                col_pha.FieldName = "Pha"+pha.ID;
                col_pha.Caption = pha.TenPha + "(" + pha.SoPhaCu + ")" + "\n("+pha.SoHieu+")";
                col_pha.Visible = true;
                col_pha.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                dt.Columns.Add("Pha" + pha.ID, Type.GetType("System.String"));
                col_tenpha.Columns.Add(col_pha);
            }
            gridBangQuyetToan.Columns.Add(col_tenpha);
            //cột Số đề nghị quyết toán
            GridViewDataSpinEditColumn col_quyettoan = new GridViewDataSpinEditColumn();
            col_quyettoan.FieldName = "SoQuyetToan";
            col_quyettoan.Caption = "Số đề nghị quyết toán";
            col_quyettoan.Visible = true;
            col_quyettoan.PropertiesSpinEdit.DisplayFormatString = "N2";
            col_quyettoan.HeaderStyle.Font.Bold = true;
            col_quyettoan.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            dt.Columns.Add("SoQuyetToan", Type.GetType("System.String"));
            gridBangQuyetToan.Columns.Add(col_quyettoan);

            GridViewDataSpinEditColumn col_sokiemtra = new GridViewDataSpinEditColumn();
            col_sokiemtra.FieldName = "SoKiemTra";
            col_sokiemtra.Caption = "Số kiểm tra";
            col_sokiemtra.Visible = true;
            col_sokiemtra.PropertiesSpinEdit.DisplayFormatString = "N2";
            col_sokiemtra.HeaderStyle.Font.Bold = true;
            col_sokiemtra.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            dt.Columns.Add("SoKiemTra", Type.GetType("System.String"));
            gridBangQuyetToan.Columns.Add(col_sokiemtra);
            string[] arr0 = new string[] {
                "",
                "I","1","2",
                "II","1","-","-","2","3","4",
                "III","1","2"
            };
            string[] arr1 = new string[] {
                "Định mức",
                "TUA","Tua ngày","Tua đêm",
                "Dầu D.O (Lít)","Vận chuyển","Ngày","Đêm","Bơm nước vệ sinh phà","Máy phát trên phà","Công tác, điều động,...",
                "Nhớt (Lít)","Châm máy","Thay máy"
            };

            for (int i = 0; i < 14; i++)
            {
                DataRow r = dt.NewRow();
                r[0] = i;
                r[1] = arr0[i];
                r[2] = arr1[i];

                dt.Rows.Add(r);
            }
        }
        void BindGrid()
        {
            gridBangQuyetToan.DataSource = dt;
            gridBangQuyetToan.DataBind();
        }
    }
}