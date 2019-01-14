using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.tai_khoan
{
    public partial class ThongTinTaiKhoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TKDataSource.SelectParameters["ID"].DefaultValue = Formats.IDUser().ToString();
            formLayout.DataBind();
        }
        protected void btOK_Click(object sender, EventArgs e)
        {
            var _user = DBProvider.DB.NhanViens.Where(n => n.TaiKhoan == lblTenDangNhap.Text).SingleOrDefault();
            if (_user != null)
            {
                _user.DiaChi = tbDiaChi.Text;
                _user.MatKhau = tbPass1.Text;
                _user.DienThoai = tbPhone.Text;
            }
            DBProvider.DB.SubmitChanges();
            pcLogin.ShowOnPageLoad = false;
        }
    }
}