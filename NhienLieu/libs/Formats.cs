using DevExpress.Web;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NhienLieu.libs
{
    public static class Formats
    {
        public static IFormatProvider culture = new CultureInfo("vi-VN", true);

        public static string ConvertToVNDateString(string date)
        {
            return DateTime.Parse(date, culture, DateTimeStyles.NoCurrentDateDefault).ToString("dd/MM/yyyy");
        }
        /// <summary>
        /// covert yyyy-MM-dd
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static string ConvertToShortDateString(string date)
        {
            return DateTime.Parse(date, culture, DateTimeStyles.NoCurrentDateDefault).ToString("yyyy-MM-dd");
        }
        /// <summary>
        /// covert yyyy-MM-dd HH:mm:ss
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static string ConvertToDateTimeString(string date)
        {
            return DateTime.Parse(date, culture, DateTimeStyles.NoCurrentDateDefault).ToString("yyyy-MM-dd HH:mm:ss");
        }
        public static DateTime ConvertToDateTime(string date)
        {
            return DateTime.Parse(date, culture, DateTimeStyles.NoCurrentDateDefault);
        }
        /// <summary>
        /// Convert ngày 12 tháng 3 năm 1995
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static string ConvertToFullStringDate(DateTime date)
        {
            string ngay = date.Day.ToString();
            string thang = date.Month.ToString();
            string nam = date.Year.ToString();
            return "ngày " + ngay + " tháng " + thang + " năm " + nam;
        }
        public static string ConvertToFullStringDate_ToUp(DateTime date)
        {
            string ngay = date.Day.ToString();
            string thang = date.Month.ToString();
            string nam = date.Year.ToString();
            return "Ngày " + ngay + " Tháng " + thang + " Năm " + nam;
        }
        public static void InitDateEditControl(object sender, EventArgs e)
        {
            ASPxDateEdit dateEdit = sender as ASPxDateEdit;
            dateEdit.CalendarProperties.FirstDayOfWeek = FirstDayOfWeek.Monday;
            dateEdit.CalendarProperties.ShowClearButton = false;
            dateEdit.CalendarProperties.ShowTodayButton = false;
            dateEdit.CalendarProperties.ShowWeekNumbers = false;
            dateEdit.CalendarProperties.FastNavProperties.Enabled = false;
            dateEdit.EditFormat = EditFormat.Custom;
            dateEdit.DisplayFormatString = "dd/MM/yyyy";
            dateEdit.EditFormatString = "dd/MM/yyyy";
            dateEdit.PopupHorizontalAlign = PopupHorizontalAlign.NotSet;
            dateEdit.PopupVerticalAlign = PopupVerticalAlign.NotSet;
            dateEdit.Date = DateTime.Now;
        }
        public static void InitDateEditControl_AddDay(object sender, EventArgs e,int Ngay)
        {
            ASPxDateEdit dateEdit = sender as ASPxDateEdit;
            dateEdit.CalendarProperties.FirstDayOfWeek = FirstDayOfWeek.Monday;
            dateEdit.CalendarProperties.ShowClearButton = false;
            dateEdit.CalendarProperties.ShowTodayButton = false;
            dateEdit.CalendarProperties.ShowWeekNumbers = false;
            dateEdit.CalendarProperties.FastNavProperties.Enabled = false;
            dateEdit.EditFormat = EditFormat.Custom;
            dateEdit.DisplayFormatString = "dd/MM/yyyy";
            dateEdit.EditFormatString = "dd/MM/yyyy";
            dateEdit.PopupHorizontalAlign = PopupHorizontalAlign.NotSet;
            dateEdit.PopupVerticalAlign = PopupVerticalAlign.NotSet;
            dateEdit.Date = DateTime.Now.AddDays(Ngay);
        }
        public static void InitDateEditControlNoValue(object sender, EventArgs e)
        {
            ASPxDateEdit dateEdit = sender as ASPxDateEdit;
            dateEdit.CalendarProperties.FirstDayOfWeek = FirstDayOfWeek.Monday;
            dateEdit.CalendarProperties.ShowClearButton = false;
            dateEdit.CalendarProperties.ShowTodayButton = false;
            dateEdit.CalendarProperties.ShowWeekNumbers = false;
            dateEdit.CalendarProperties.FastNavProperties.Enabled = false;
            dateEdit.EditFormat = EditFormat.Custom;
            dateEdit.DisplayFormatString = "dd/MM/yyyy";
            dateEdit.EditFormatString = "dd/MM/yyyy";
            dateEdit.PopupHorizontalAlign = PopupHorizontalAlign.NotSet;
            dateEdit.PopupVerticalAlign = PopupVerticalAlign.NotSet;
            dateEdit.Value = string.Empty;
        }

        public static int[] ConvertArrStringToArrInt(string[] arrString)
        {
            int[] numbers = new int[arrString.Length];
            for (int i = 0; i < arrString.Length; i++)
            {
                try
                {
                    numbers[i] = int.Parse(arrString[i]);
                }
                catch 
                {
                    numbers[i] = -1;
                }
            }
            return numbers;
        }

        public static void InitDisplayIndexColumn(ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.Caption == "STT")
            {
                e.DisplayText = (e.VisibleIndex + 1).ToString();
            }
        }
        static private List<int> groupIndexes = new List<int>();
        static private int rowInGroupNumber = 1;
        static private bool isFirstDisplayedRow = true;
        private static bool IsGridUngrouped { get { return groupIndexes.Count == 0; } }
        private static void CollectGroupIndexes(ASPxGridView g)
        {
            groupIndexes.Clear();
            for (int i = 0; i < g.VisibleRowCount; i++)
            {
                if (g.IsGroupRow(i))
                    groupIndexes.Add(i);
            }
        }
        private static int GetParentGroupIndex(int index)
        {
            return groupIndexes.FindLast(delegate(int i) { return i < index; });
        }

        private static bool IsRowIsFirstGroup(int index, ASPxGridView g)
        {
            return g.IsGroupRow(index - 1);
        }
        /// <summary>
        /// chuyển đổi không dấu In hoa
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static string convert_KhongDau(string s)
        {
            Regex regex = new Regex("\\p{IsCombiningDiacriticalMarks}+");
            string temp = s.Normalize(NormalizationForm.FormD);
            return regex.Replace(temp, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D').ToUpper();
        } 
        public static void InitDisplayIndexGroupColumn(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.Caption != "STT")
                return;
            ASPxGridView g = sender as ASPxGridView;
            CollectGroupIndexes(g);
            if (IsGridUngrouped)
                rowInGroupNumber = e.VisibleIndex + 1;
            else
            {
                if (isFirstDisplayedRow)
                {
                    rowInGroupNumber = e.VisibleIndex - GetParentGroupIndex(e.VisibleIndex);
                    isFirstDisplayedRow = false;
                }
                else
                {
                    if (IsRowIsFirstGroup(e.VisibleIndex, g))
                        rowInGroupNumber = 1;
                    else
                        rowInGroupNumber++;
                }
            }
            //e.Value = rowInGroupNumber;
            e.DisplayText = rowInGroupNumber.ToString();
        }
        /// <summary>
        /// ID User
        /// </summary>
        /// <returns></returns>
        public static int IDUser()
        {
            return Convert.ToInt32(HttpContext.Current.User.Identity.Name.Split('-')[0]);
        }
     
        /// <summary>
        /// Ho tên User
        /// </summary>
        /// <returns></returns>
        public static string NameUser()
        {
            return HttpContext.Current.User.Identity.Name.Split('-')[1];
        }

        public static int PermissionUser()
        {
            return Convert.ToInt32(HttpContext.Current.User.Identity.Name.Split('-')[2]);
        }
        /// <summary>
        /// IDchiNhanh
        /// </summary>
        /// <returns></returns>
        public static int IDChiNhanh()
        {
            return Convert.ToInt32(HttpContext.Current.User.Identity.Name.Split('-')[3]);
        }

        //Thông báo mess
      
        public static void Show_ThongBao(string Message)
        {
            string cleanMessage = Message.Replace("'", "\'");
            Page page = HttpContext.Current.CurrentHandler as Page;
            string script = string.Format("alert('{0}');", cleanMessage);
            if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
            {
                page.ClientScript.RegisterClientScriptBlock(page.GetType(), "alert", script, true /* addScriptTags */);
            } 
        }
        public static string replace_special_word(double total)
        {
            try
            {
                string rs = "";
                total = Math.Round(total, 0);
                string[] ch = { "không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín" };
                string[] rch = { "lẻ", "mốt", "", "", "", "lăm" };
                string[] u = { "", "mươi", "trăm", "ngàn", "", "", "triệu", "", "", "tỷ", "", "", "ngàn", "", "", "triệu" };
                string nstr = total.ToString();

                int[] n = new int[nstr.Length];
                int len = n.Length;
                for (int i = 0; i < len; i++)
                {
                    n[len - 1 - i] = Convert.ToInt32(nstr.Substring(i, 1));
                }

                for (int i = len - 1; i >= 0; i--)
                {
                    if (i % 3 == 2)// số 0 ở hàng trăm
                    {
                        if (n[i] == 0 && n[i - 1] == 0 && n[i - 2] == 0) continue;//nếu cả 3 số là 0 thì bỏ qua không đọc
                    }
                    else if (i % 3 == 1) // số ở hàng chục
                    {
                        if (n[i] == 0)
                        {
                            if (n[i - 1] == 0) { continue; }// nếu hàng chục và hàng đơn vị đều là 0 thì bỏ qua.
                            else
                            {
                                rs += " " + rch[n[i]]; continue;// hàng chục là 0 thì bỏ qua, đọc số hàng đơn vị
                            }
                        }
                        if (n[i] == 1)//nếu số hàng chục là 1 thì đọc là mười
                        {
                            rs += " mười"; continue;
                        }
                    }
                    else if (i != len - 1)// số ở hàng đơn vị (không phải là số đầu tiên)
                    {
                        if (n[i] == 0)// số hàng đơn vị là 0 thì chỉ đọc đơn vị
                        {
                            if (i + 2 <= len - 1 && n[i + 2] == 0 && n[i + 1] == 0) continue;
                            rs += " " + (i % 3 == 0 ? u[i] : u[i % 3]);
                            continue;
                        }
                        if (n[i] == 1)// nếu là 1 thì tùy vào số hàng chục mà đọc: 0,1: một / còn lại: mốt
                        {
                            rs += " " + ((n[i + 1] == 1 || n[i + 1] == 0) ? ch[n[i]] : rch[n[i]]);
                            rs += " " + (i % 3 == 0 ? u[i] : u[i % 3]);
                            continue;
                        }
                        if (n[i] == 5) // cách đọc số 5
                        {
                            if (n[i + 1] != 0) //nếu số hàng chục khác 0 thì đọc số 5 là lăm
                            {
                                rs += " " + rch[n[i]];// đọc số 
                                rs += " " + (i % 3 == 0 ? u[i] : u[i % 3]);// đọc đơn vị
                                continue;
                            }
                        }
                    }

                    rs += (rs == "" ? " " : ", ") + ch[n[i]];// đọc số
                    rs += " " + (i % 3 == 0 ? u[i] : u[i % 3]);// đọc đơn vị
                }
                if (rs[rs.Length - 1] != ' ')
                    rs += " đồng";
                else
                    rs += "đồng";

                if (rs.Length > 2)
                {
                    string rs1 = rs.Substring(0, 2);
                    rs1 = rs1.ToUpper();
                    rs = rs.Substring(2);
                    rs = rs1 + rs;
                }
                return rs.Trim().Replace("lẻ,", "lẻ").Replace("mươi,", "mươi").Replace("trăm,", "trăm").Replace("mười,", "mười") + ".";
            }
            catch
            {
                return "";
            }

        }
    }
}