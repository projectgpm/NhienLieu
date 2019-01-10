using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.nhap_lieu
{
    public partial class KhaiBaoTuaChuyen : System.Web.UI.Page
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
            cbThang.Items.Clear();
            for (int i = 1; i <= DateTime.Now.Month; i++)
            {
                cbThang.Items.Add("Tháng " + i, i);
            }
            cbThang.SelectedIndex = DateTime.Now.Month;
            if (DateTime.Now.Day >= 20)
                cbKy.SelectedIndex = 2;
            else if (DateTime.Now.Day >= 10 && DateTime.Now.Day < 20)
                cbKy.SelectedIndex = 1;
            else cbKy.SelectedIndex = 0;
        }

        protected void cbpTuaChuyen_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            KB_TuaChuyen();
        }
        void KB_TuaChuyen()
        {
            SqlDataSourceChamCong.SelectParameters["BenID"].DefaultValue = cbBen.Value.ToString();
        }
    }
}