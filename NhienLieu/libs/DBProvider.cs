using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NhienLieu.libs
{
    public class DBProvider
    {
        const string DataContextKey = "NhienLieuDataContext";
        public static NhienLieuDataContext DB
        {
            get
            {
                if (HttpContext.Current.Items[DataContextKey] == null)
                    HttpContext.Current.Items[DataContextKey] = new NhienLieuDataContext();
                return (NhienLieuDataContext)HttpContext.Current.Items[DataContextKey];
            }
        }
    }
}