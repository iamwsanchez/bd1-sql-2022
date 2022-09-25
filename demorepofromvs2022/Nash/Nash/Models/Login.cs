using Nash.Lib.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Nash.Models
{
    public class Login
    {
        public Login()
        {

        }

        public bool IsLoggedIn { get; set; }
        public bool LogIn()
        {
            decimal number = "1,23".ToDecimal();
            return true;
        }
    }
}
