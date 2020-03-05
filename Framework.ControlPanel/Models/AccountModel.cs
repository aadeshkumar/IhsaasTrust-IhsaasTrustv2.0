using Framework.Shared.DataServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Framework.ControlPanel.Models
{
    public class RolesRightsModel
    {
        public List<Role> Roles { get; set; }
        public List<Right> Rights { get; set; }
        public List<Entity> Entities { get; set; }
        public short? RoleID { get; set; }
        public List<RoleRight> RolesRights { get; set; }

    }
}