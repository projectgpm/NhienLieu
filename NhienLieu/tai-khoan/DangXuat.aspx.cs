using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.tai_khoan
{
    public partial class DangXuat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          //  Backup();
            FormsAuthentication.SignOut();
            Response.Redirect("~/tai-khoan/DangNhap.aspx");
        }
        public void Backup()
        {
            /*var _CH = DBProvider.DB.chChiNhanhs.Where(x => x.IDChiNhanh == 1).FirstOrDefault();
            if (_CH != null)
            {
                SqlConnection connect;
                string con = WebConfigurationManager.ConnectionStrings["BanHangVietConnectionString"].ConnectionString;
                connect = new SqlConnection(con);
                connect.Open();
                string URL = _CH.UrlBackup + @"\";
                string strFileName = @"" + URL + DateTime.Now.ToString("dd-MM-yy-H-mm") + ".bak";
                string strFileName2 = @"" + Server.MapPath("~/Backup/") + DateTime.Now.ToString("dd-MM-yy-H-mm") + ".bak";
                SqlCommand command = new SqlCommand(@"BACKUP DATABASE [" + Server.MapPath("~/App_Data/") + @"BanHangViet.mdf]" + " to disk ='" + strFileName + "'", connect);
                SqlCommand command2 = new SqlCommand(@"BACKUP DATABASE [" + Server.MapPath("~/App_Data/") + @"BanHangViet.mdf]" + " to disk ='" + strFileName2 + "'", connect);
                command.ExecuteNonQuery();
                command2.ExecuteNonQuery();
                connect.Close();
            }*/
        }
    }
}