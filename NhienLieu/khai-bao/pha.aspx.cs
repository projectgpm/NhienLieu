using DevExpress.Web;
using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.khai_bao
{
    public partial class pha : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Context.User.Identity.IsAuthenticated)
                Response.Redirect("~/tai-khoan/DangNhap.aspx");

        }

        protected void gridPha_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            Formats.InitDisplayIndexColumn(e);
        }

        protected void cbpgridPha_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split('|');
            
            int idpha = int.Parse(cbbPha.Value.ToString());
            var Pha = DBProvider.DB.Phas.FirstOrDefault(q => q.ID == idpha);
            int idbenmoi = int.Parse(cbbBen.Value.ToString());
            if(idbenmoi == Pha.BenID)
            {
                cbpgridPha.JSProperties["cp_trungben"] = true;
                return;
            }
            DateTime ngay = deNgayDieuDong.Date;
            switch (para[0])
            {
                //case "Edit": DoiTrangThai(para[1]); break;
                case "Move": DieuDongPha(idpha, idbenmoi, ngay); cbpgridPha.JSProperties["cp_Susss"] = true; break;
                default: break;
            }
        }
        private void DieuDongPha(int IDPha, int BenMoi, DateTime NgayDieuDong)
        {
            var Pha = DBProvider.DB.Phas.FirstOrDefault(q => q.ID == IDPha);
            //ghi thẻ điều động
            var dieudong = new Pha_DieuDong();
            dieudong.PhaID = IDPha;
            dieudong.BenCuID = Pha.BenID;
            dieudong.BenMoiID = BenMoi;
            dieudong.NgayDieuDong = NgayDieuDong;
            dieudong.NgayTao = DateTime.Now;
            dieudong.NgayThayDoi = DateTime.Now;
            //cập nhật lại bến
            Pha.BenID = BenMoi;
            DBProvider.DB.Pha_DieuDongs.InsertOnSubmit(dieudong);
            DBProvider.DB.SubmitChanges();
        }

        protected void deNgayDieuDong_Init(object sender, EventArgs e)
        {
            deNgayDieuDong.Date = DateTime.Now;
        }

        protected void gridPha_BeforePerformDataSelect(object sender, EventArgs e)
        {
            Session["PhaID"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }
    }
}