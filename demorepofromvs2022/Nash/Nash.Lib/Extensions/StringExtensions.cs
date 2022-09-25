using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Nash.Lib.Extensions
{
    public static class StringExtensions
    {
        public static decimal ToDecimal(this string str)
        {
            return decimal.Parse(str);
        }
    }
}
