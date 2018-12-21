using DevExpress.Web;
using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.kho
{
    public partial class ton_kho : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            if(!IsPostBack)
            {
                //gridTonKho.SettingsDetail.AllowOnlyOneMasterRowExpanded = true;

            }
        }

        protected void gridTonKho_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void gridTheKho_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["NhienLieuID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }
        protected void cbpTonkho_Callback(object sender, CallbackEventArgsBase e)
        {
            
        }
    }
}