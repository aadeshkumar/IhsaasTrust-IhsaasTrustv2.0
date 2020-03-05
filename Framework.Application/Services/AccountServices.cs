using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Framework.Shared.DataServices;

namespace Framework.Application.Services
{
    public class AccountServices
    {
        #region Define as Singleton
        private static AccountServices _Instance;

        public static AccountServices Instance
        {
            get
            {
                if (_Instance == null)
                {
                    _Instance = new AccountServices();
                }

                return (_Instance);
            }
        }

        private AccountServices()
        {
        }
        #endregion
        public List<Role> GetRoles()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"*").From("Roles").Where("IsActive=1");
                return context.Fetch<Role>(ppSql);
            }
        }
        public List<Right> GetRights()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"*").From("Rights").Where("IsActive=1");
                return context.Fetch<Right>(ppSql);
            }
        }
        public List<Entity> GetEntities()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"*").From("Entities").Where("IsActive=1");
                return context.Fetch<Entity>(ppSql);
            }
        }
        public List<RoleRight> GetRolesRights(short roleID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"*").From("RoleRights").Where("RoleID=@0", roleID);
                return context.Fetch<RoleRight>(ppSql);
            }
        }
        public string SaveRoleRights(List<RoleRight> roleRights, short roleID, int userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                try
                {
                    string result = "Rights have been deleted";
                    context.BeginTransaction();
                    context.Execute("Delete From RoleRights Where RoleID = @0", roleID);
                    if (roleRights != null && roleRights.Count != 0)
                    {
                        foreach (var roleRight in roleRights)
                        {
                            roleRight.CreatedOn = DateTime.Now;
                            roleRight.ModifiedOn = DateTime.Now;
                            roleRight.CreatedBy = userID;
                            roleRight.ModifiedBy = userID;
                            context.Save(roleRight);
                        }
                        result = roleRights.Count.ToString() + " rights have been saved for the selected role.";
                    }
                    context.CompleteTransaction();
                    return result;
                }
                catch (Exception ex)
                {
                    return ex.Message;
                }

            }
        }
        public List<UserRoleRightsEntity> GetUserRoleRights(int userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Select("RoleID").From("UserRoles").Where("UserID = @0", userID);
                short roleID = context.Fetch<short>(sql).FirstOrDefault();
                var cpSql = PetaPoco.Sql.Builder.Select("UR.RoleID, UR.RightID, UR.EntityID, E.NameEn EntityName").From("RoleRights UR").InnerJoin("Entities E").On("E.EntityID = UR.EntityID").Where("UR.RoleID = @0", roleID);
                return context.Fetch<UserRoleRightsEntity>(cpSql);
            }
        }
        public List<User> GetFieldWorkers(int OrganizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Select("U.UserID, U.FullName")
                    .From("Users U").InnerJoin("UserRoles UR").On("U.UserID = UR.UserID AND U.StatusID = 1").Where("UR.RoleID IN (2,5) AND U.OrganizationID=@0", OrganizationID);
                return context.Fetch<User>(sql);
            }
        }
    }
}
