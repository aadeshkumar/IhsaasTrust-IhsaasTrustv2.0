using Framework.Shared.DataServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Framework.ControlPanel.Models
{
    public class SubscriptionModel
    {
        public int SubscriptionPackageID { get; set; }
        public string SubscriptionPackageName { get; set; }
        public int Amount { get; set; }
        public bool IsActive { get; set; }
    }
    public class DetailsModel
    {
        public List<SubscriptionPackage> SubscriptionPackages { get; set; }
    }

   

}