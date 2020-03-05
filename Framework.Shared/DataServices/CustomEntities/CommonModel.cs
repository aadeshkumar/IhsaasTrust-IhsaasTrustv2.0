using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Framework.Shared.DataServices.CustomEntities
{
   public class CommonModel
    {
        public class OrganizationSubscriptions : OrganizationSubscription
        {
            [PetaPoco.Column]
            public string SubscriptionPackageName { get; set; } = string.Empty;

            [PetaPoco.Column]
            public string OrganizationName { get; set; } = string.Empty;

        }
    }
}
