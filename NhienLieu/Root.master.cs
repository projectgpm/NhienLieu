using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;

namespace NhienLieu {
    public partial class RootMaster : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {
            if (Context.User.Identity.IsAuthenticated)
            {
                string[] infoUser = Context.User.Identity.Name.Split('-');

                if (!IsPostBack)
                {
                    /*switch (infoUser[2])
                    {
                        case "1": XmlDataSourceHeader.DataFile = "~/App_Data/MenuQuanTri.xml"; break;
                        case "2": XmlDataSourceHeader.DataFile = "~/App_Data/MenuVanPhong.xml"; break;
                        case "3": XmlDataSourceHeader.DataFile = "~/App_Data/MenuBanHang.xml"; break;
                        default: XmlDataSourceHeader.DataFile = "~/App_Data/MenuToanQuyen.xml"; break;
                    }*/
                }
            }
            else
            {
                Response.Redirect("~/tai-khoan/DangNhap.aspx");
            }
        }

        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/tai-khoan/DangNhap.aspx");
        }
    }
}