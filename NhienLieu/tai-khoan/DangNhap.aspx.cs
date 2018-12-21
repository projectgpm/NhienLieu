using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management;
using System.Net;
using System.Net.NetworkInformation;
using System.Runtime.InteropServices;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.tai_khoan
{
    public partial class DangNhap : System.Web.UI.Page
    {
        private static Random random = new Random();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        public void CheckDangNhap()
        {
            var user = from p in DBProvider.DB.NhanViens
                       where p.TaiKhoan == tbLogin.Text.Trim() && p.MatKhau == tbPassword.Text.Trim() && p.DaXoa == 0
                       select new
                       {
                           userID = p.ID,
                           TenNguoiDung = p.HoTen,
                           /*Quyen = p.NhomID,
                           IDChiNhanh = p.IDChiNhanh*/
                       };
            if (user.Any())
            {
                FormsAuthentication.RedirectFromLoginPage(user.First().userID + "-" + user.First().TenNguoiDung /*+ "-" + user.First().Quyen + "-" + user.First().IDBen*/, chbRemember.Checked);
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                lblError.Text = "Tài khoản hoặc mật khẩu không đúng ?";
            }
        }

        [DllImport("wininet.dll")]
        private extern static bool InternetGetConnectedState(out int description, int reservedValue);
        public bool IsConnectedToInternet()
        {
            int desc;
            return InternetGetConnectedState(out desc, 0);
        }

        //Đăng nhập
        protected void btOK_Click(object sender, EventArgs e) // đăng nhập
        {
            CheckDangNhap();
        }

        //MD5
        public static string CreateMD5(string input)
        {
            // Use input string to calculate MD5 hash
            using (System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create())
            {
                byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

                // Convert the byte array to hexadecimal string
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < hashBytes.Length; i++)
                {
                    sb.Append(hashBytes[i].ToString("X2"));
                }
                return sb.ToString();
            }
        }
        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }

    }
}