using DevExpress.Web;
using NhienLieu.libs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.nhap_lieu.tua_chuyen
{
    public partial class index : System.Web.UI.Page
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
            for (int i = 1; i <= 12; i++)
            {
                cbThang.Items.Add("Tháng " + i, i);
            }
            for (int i = DateTime.Now.Year-2; i <= DateTime.Now.Year; i++)
            {
                cbNam.Items.Add("Năm " + i, i);
            }
            cbNam.SelectedIndex = 2;
            cbThang.SelectedIndex = DateTime.Now.Month-1;
            if (DateTime.Now.Day >= 20)
                cbKy.SelectedIndex = 2;
            else if (DateTime.Now.Day >= 10 && DateTime.Now.Day < 20)
                cbKy.SelectedIndex = 1;
            else cbKy.SelectedIndex = 0;
        }

        protected void gridChamCong_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            string ss = e.Keys[0].ToString();
            int ngay = Convert.ToInt32(ss.Substring(5));
            int thang = Convert.ToInt32(cbThang.Value);
            int nam = Convert.ToInt32(cbNam.Value);
            for (int i = 0; i < e.NewValues.Count; i++)
            {
                if (e.NewValues[i].ToString() != e.OldValues[i].ToString())
                {
                    string s = e.NewValues.Keys.OfType<string>().Skip(i).First();
                    string[] arr = s.Split('-');
                    var cc = DBProvider.DB.ChamCongs.FirstOrDefault(q => q.Ngay == ngay && q.Thang == thang && q.Nam == nam && q.PhaID == long.Parse(arr[1]));
                    if(cc is null)
                    {
                        ChamCong newCC = new ChamCong();
                        newCC.NgayTao = DateTime.Now;
                        newCC.NgayThayDoi = DateTime.Now;
                        newCC.Ngay = ngay;
                        newCC.Thang = thang;
                        newCC.Nam = nam;
                        newCC.PhaID = long.Parse(arr[1]);
                        newCC.Ca1 = 0;
                        newCC.Ca2 = 0;
                        newCC.DaCham = 0;
                        if (arr[0] == "ca1")
                            newCC.Ca1 = double.Parse(e.NewValues[s].ToString());
                        if (arr[0] == "ca2")
                            newCC.Ca2 = double.Parse(e.NewValues[s].ToString());
                        newCC.TongCong = newCC.Ca1 + newCC.Ca2;
                        DBProvider.DB.ChamCongs.InsertOnSubmit(newCC);
                        
                    }
                    else
                    {
                        if(cc.DaCham == 0)
                        {
                            cc.NgayThayDoi = DateTime.Now;
                            if (arr[0] == "ca1")
                                cc.Ca1 = double.Parse(e.NewValues[s].ToString());
                            if (arr[0] == "ca2")
                                cc.Ca2 = double.Parse(e.NewValues[s].ToString());
                            cc.TongCong = cc.Ca1 + cc.Ca2;
                        }
                    }
                }
            }
            DBProvider.DB.SubmitChanges();
            e.Cancel = true;
            gridChamCong.CancelEdit();
            //gridChamCong.UpdateEdit();
        }
        public void TuaChuyen(int BenID, int thang, int nam, int ky)
        {
            //int thang = Convert.ToInt32(cbThang.Value);
            //int nam = Convert.ToInt32(cbNam.Value);
            gridChamCong.Columns.Clear();
            GridViewDataColumn coltt = new GridViewDataColumn();
            coltt.FieldName = "TT";
            coltt.Caption = "TT";
            coltt.Visible = true;
            coltt.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
            coltt.ReadOnly = true;
            coltt.Settings.AllowSort = DevExpress.Utils.DefaultBoolean.False;
            gridChamCong.Columns.Add(coltt);
            //long BenID = 1;
            //if (cbBen.Value != null)
            //    BenID = Convert.ToInt32(cbBen.Value);
            var listPha = DBProvider.DB.Phas.Where(q => q.BenID == BenID && q.DaXoa == 0);
            DataTable dt = new DataTable();
            dt.Columns.Add("TT", Type.GetType("System.String"));

            foreach (var pha in listPha)
            {
                GridViewBandColumn coltenpha = new GridViewBandColumn();
                coltenpha.Caption = pha.TenPha + " (" + pha.SoPhaCu + ")";
                coltenpha.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GridViewDataSpinEditColumn colca1 = new GridViewDataSpinEditColumn();
                colca1.Caption = "Ca 1";
                colca1.Settings.AllowSort = DevExpress.Utils.DefaultBoolean.False;
                colca1.FieldName = "ca1-" + pha.ID;
                colca1.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                GridViewDataSpinEditColumn colca2 = new GridViewDataSpinEditColumn();
                colca2.Caption = "Ca 2";
                colca2.Settings.AllowSort = DevExpress.Utils.DefaultBoolean.False;
                colca2.FieldName = "ca2-" + pha.ID;
                colca2.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                coltenpha.Columns.Add(colca1);
                coltenpha.Columns.Add(colca2);
                gridChamCong.Columns.Add(coltenpha);
                dt.Columns.Add("ca1-" + pha.ID, Type.GetType("System.Double"));
                dt.Columns.Add("ca2-" + pha.ID, Type.GetType("System.Double"));
            }
            GridViewDataTextColumn colid = new GridViewDataTextColumn();
            colid.FieldName = "ID";
            colid.Visible = false;
            gridChamCong.Columns.Add(colid);
            dt.Columns.Add("ID", Type.GetType("System.String"));
            //int ky = cbKy.SelectedIndex;
            switch (ky)
            {
                case 0:
                    for (int ky1 = 1; ky1 < 11; ky1++)
                    {
                        DataRow r = dt.NewRow();
                        r["TT"] = "Ngày " + ky1.ToString();
                        r["ID"] = ky1;

                        foreach (var pha in listPha)
                        {
                            var cc = DBProvider.DB.ChamCongs.FirstOrDefault(q => q.PhaID == pha.ID && q.Ngay == ky1 && q.Thang == thang && q.Nam == nam);
                            if (cc is null)
                            {
                                r["ca1-" + pha.ID] = "0";
                                r["ca2-" + pha.ID] = "0";
                                //k tồn tại thì tạo 0-0
                                /*ChamCong newCC = new ChamCong();
                                newCC.NgayTao = DateTime.Now;
                                newCC.NgayThayDoi = DateTime.Now;
                                newCC.Ngay = ky1;
                                newCC.Thang = int.Parse(cbThang.Value.ToString());
                                newCC.Nam = DateTime.Now.Year;
                                newCC.PhaID = pha.ID;
                                newCC.Ca1 = 0;
                                newCC.Ca2 = 0;
                                DBProvider.DB.ChamCongs.InsertOnSubmit(newCC);*/
                            }
                            // ca1ID3
                            else
                            {
                                r["ca1-" + pha.ID] = cc.Ca1;
                                r["ca2-" + pha.ID] = cc.Ca2;
                            }
                        }
                        dt.Rows.Add(r);
                    }
                    break;
                case 1:
                    for (int ky2 = 11; ky2 < 21; ky2++)
                    {
                        DataRow r = dt.NewRow();
                        r["TT"] = "Ngày " + ky2.ToString();
                        r["ID"] = ky2;

                        foreach (var pha in listPha)
                        {
                            var cc = DBProvider.DB.ChamCongs.FirstOrDefault(q => q.PhaID == pha.ID && q.Ngay == ky2 && q.Thang == thang && q.Nam == nam);
                            if (cc is null)
                            {
                                r["ca1-" + pha.ID] = "0";
                                r["ca2-" + pha.ID] = "0";
                            }
                            // ca1ID3
                            else
                            {
                                r["ca1-" + pha.ID] = cc.Ca1;
                                r["ca2-" + pha.ID] = cc.Ca2;
                            }
                        }
                        dt.Rows.Add(r);
                    }
                    break;
                case 2:
                    int ngay = DateTime.DaysInMonth(nam, thang);
                    for (int ky3 = 21; ky3 <= ngay; ky3++)
                    {
                        DataRow r = dt.NewRow();
                        r["TT"] = "Ngày " + ky3.ToString();
                        r["ID"] = ky3;

                        foreach (var pha in listPha)
                        {
                            var cc = DBProvider.DB.ChamCongs.FirstOrDefault(q => q.PhaID == pha.ID && q.Ngay == ky3 && q.Thang == thang && q.Nam == nam);
                            if (cc is null)
                            {
                                r["ca1-" + pha.ID] = "0";
                                r["ca2-" + pha.ID] = "0";
                            }
                            // ca1ID3
                            else
                            {
                                r["ca1-" + pha.ID] = cc.Ca1;
                                r["ca2-" + pha.ID] = cc.Ca2;
                            }
                        }
                        dt.Rows.Add(r);
                    }
                    break;
                default: break;
            }
            gridChamCong.DataSource = dt;
            gridChamCong.DataBind();
        }
        protected void cbpBtn_Callback(object sender, CallbackEventArgsBase e)
        {
            int thang = Convert.ToInt32(cbThang.Value);
            int nam = Convert.ToInt32(cbNam.Value);
            int ky = cbKy.SelectedIndex;
            int BenID = Convert.ToInt32(cbBen.Value);
            TuaChuyen(BenID, thang, nam, ky);
        }

        protected void gridChamCong_Init(object sender, EventArgs e)
        {
            //int ky = 0;
            //if (DateTime.Now.Day > 10)
            //    ky = 1;
            //if (DateTime.Now.Day > 20)
            //    ky = 2;
            //TuaChuyen(1, DateTime.Now.Month, DateTime.Now.Year, ky);
        }
    }
}