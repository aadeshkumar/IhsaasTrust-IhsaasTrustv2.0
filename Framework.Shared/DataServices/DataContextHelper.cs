
using Framework.Shared.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Framework.Shared.DataServices
{
    public static class DataContextHelper
    {
        public static FrameworkRepository GetExceptionLoggingDataContext(bool enableAutoSelect = false)
        {
            return (GetNewDataContext("ELConnectionString", enableAutoSelect));
        }

        public static FrameworkRepository GetBackgroundProcessDataContext(bool enableAutoSelect = false)
        {
            //return (GetNewDataContext("BGSConnectionString", enableAutoSelect));
            return (GetNewDataContext("CPConnectionString", enableAutoSelect));
        }

        public static FrameworkRepository GetPPDataContext(bool enableAutoSelect = true)
        {
            return (GetNewDataContext("PPConnectionString", enableAutoSelect));
        }

        public static FrameworkRepository GetCPDataContext(bool enableAutoSelect = true)
        {
            return (GetNewDataContext("CPConnectionString", enableAutoSelect));
        }

        private static FrameworkRepository GetNewDataContext(string connectionStringName, bool enableAutoSelect)
        {
            FrameworkRepository repository = new FrameworkRepository(connectionStringName);
            repository.EnableAutoSelect = enableAutoSelect;
            return (repository);
        }
    }
}
