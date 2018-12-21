using DevExpress.Export;
using DevExpress.XtraPrinting;
using KobePaint.libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KobePaint.Pages.TaiKhoan
{
    public partial class DanhSachTaiKhoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Pages/TaiKhoan/DangNhap.aspx");
            }
        }
        protected void gridKhachHang_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void btnXuatExcel_Click(object sender, EventArgs e)
        {
            exproter.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }

        protected void gridKhachHang_RowValidating(object sender, DevExpress.Web.Data.ASPxDataValidationEventArgs e)
        {
            if (e.IsNewRow) 
            {
                string tendangnhap = e.NewValues["TenDangNhap"].ToString();
                var ngdung = DBDataProvider.DB.nvNhanViens.Where(x => x.TenDangNhap == tendangnhap).FirstOrDefault();
                if (ngdung != null)
                {
                    e.RowError = "Tên đăng nhập đã tồn tại!!";
                }
            }
            else
            {
                string tendangnhap = e.NewValues["TenDangNhap"].ToString();
                int id = int.Parse(e.Keys["IDNhanVien"].ToString());
                var ngdung = DBDataProvider.DB.nvNhanViens.Where(x => x.TenDangNhap == tendangnhap && x.IDNhanVien != id).FirstOrDefault();
                if (ngdung != null)
                {
                    e.RowError = "Tên đăng nhập đã tồn tại!!";
                }
            }
        }

        protected void gridKhachHang_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            gridKhachHang.JSProperties["cpUpdate"] = true;

        }

        protected void gridKhachHang_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            gridKhachHang.JSProperties["cpInsert"] = true;
        }

        protected void gridKhachHang_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            gridKhachHang.JSProperties["cpDelete"] = true;
        }
    }
}