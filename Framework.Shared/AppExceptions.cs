using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Framework.Shared
{
    public class IdenticalMethodException : ApplicationException
    {
        public IdenticalMethodException(string msg)
            : base(msg)
        {
        }
    }

    public class MethodNotUsedException : ApplicationException
    {
    }
}
