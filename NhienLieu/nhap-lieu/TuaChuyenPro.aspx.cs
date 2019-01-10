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
    public partial class TuaChuyenPro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            if (!IsPostBack)
            {
                khoitao();
            }
        }
        void khoitao()
        {
            //clear before create
            cbNam.Items.Clear();
            cbThang.Items.Clear();
            //create
            cbNam.Items.Add("Năm " + (DateTime.Now.Year-1), DateTime.Now.Year-1);
            cbNam.Items.Add("Năm " + DateTime.Now.Year, DateTime.Now.Year);
            cbNam.SelectedIndex = 1;
            CbNam_Change();
        }
        protected void cbpTua_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            int PhaID = Convert.ToInt32(cbPha.Value),
            Thang = Convert.ToInt32(cbThang.Value),
            Nam = Convert.ToInt32(cbNam.Value);
            KhoiTao_Data(PhaID, Thang, Nam);
        }
        void KhoiTao_Data(int PhaID, int Thang, int Nam)
        {
            using (var scope = new TransactionScope())
            {
                try
                {
                    int days = DateTime.DaysInMonth(Nam, Thang);
                    for (int i = 1; i <= days; i++)
                    {
                        var cc = DBProvider.DB.ChamCongs.FirstOrDefault(q => q.PhaID == PhaID && q.Nam == Nam && q.Thang == Thang && q.Ngay == i);
                        var pha = DBProvider.DB.Phas.SingleOrDefault(p=>p.ID == PhaID);
                        if (cc == null)
                        {
                            ChamCong phacc = new ChamCong();
                            phacc.Ngay = i;
                            phacc.Thang = Thang;
                            phacc.Nam = Nam;
                            phacc.Ca1 = 0;
                            phacc.Ca2 = 0;
                            phacc.TongCong = 0;
                            phacc.DaCham = 0;
                            phacc.PhaID = PhaID;
                            phacc.BenHienTai = pha.BenID;
                            phacc.XiNghiepHienTai = pha.Ben.XiNghiepID;
                            phacc.NguoiChamID = Formats.IDUser();
                            string d = i + "/" + Thang + "/" + Nam;
                            phacc.NgayCham = DateTime.Parse(d);
                            phacc.NgayTao = DateTime.Now;
                            phacc.NgayThayDoi = DateTime.Now;
                            DBProvider.DB.ChamCongs.InsertOnSubmit(phacc);
                        }
                    }
                    DBProvider.DB.SubmitChanges();
                    scope.Complete();
                }
                catch (Exception)
                {
                    cbpTua.JSProperties["cp_Error_Save"] = true;
                    scope.Dispose();
                    //throw ex;
                }
            }
            
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
                cbThang.Items.Add("Tháng "+i, i);
            }
            cbThang.SelectedIndex = thang;
        }

        protected void cbpInfo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            switch (para[0])
            {
                case "Refill": CbNam_Change(); break;
                case "LoadPha": cbPha_load(Convert.ToInt32(cbBen.Value)); break;
                default: break;
            }
        }
        private void cbPha_load(int BenID)
        {
            cbPha.Text = "";
            cbPha.DataSource = DBProvider.DB.Phas.Where(p => p.BenID == BenID).ToList();
            cbPha.ValueField = "ID";
            cbPha.TextField = "TenPha";
            cbPha.DataBind();
        }

        protected void gridNhienLieu_CustomGroupDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }
    }
}