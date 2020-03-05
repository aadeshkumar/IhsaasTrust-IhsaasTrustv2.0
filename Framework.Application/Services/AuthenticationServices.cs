using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Framework.Shared.DataServices;
using Framework.Shared.DataServices.CustomEntities;

namespace Framework.Application.Services
{
    public class AuthenticationServices
    {
        #region Define as Singleton
        private static AuthenticationServices _Instance;

        public static AuthenticationServices Instance
        {
            get
            {
                if (_Instance == null)
                {
                    _Instance = new AuthenticationServices();
                }

                return (_Instance);
            }
        }

        private AuthenticationServices()
        {
        }
        #endregion
        public UserEntity LoginUser(string emailAddres, string password)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"U.*, UR.RoleID")
                            .From("Users U").InnerJoin("UserRoles UR").On("UR.UserID=U.UserID")
                            .Where("U.Email = @0 AND U.Password = @1 AND U.StatusID = 1", emailAddres, password);

                return context.Fetch<UserEntity>(ppSql).FirstOrDefault();
            }
        }
        public List<UserOrganizationEntity> GetUserOrganizations(int userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"UO.UserID, O.*")
                            .From("UserOrganization UO").InnerJoin("Organizations O").On("UO.OrganizationID=O.OrganizationID")
                            .Where("UO.UserID=@0", userID);
                return context.Fetch<UserOrganizationEntity>(ppSql);
            }
        }
        public UserEntity LoginUser(int userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"U.*, UR.RoleID")
                            .From("Users U").InnerJoin("UserRoles UR").On("UR.UserID=U.UserID")
                            .Where("U.UserID = @0", userID);

                return context.Fetch<UserEntity>(ppSql).FirstOrDefault();
            }
        }
        public UserEntity LoginUser(string emailAddres)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"*, 2 As RecordStatusInt")
                            .From("Users")
                            .Where("Email = @0", emailAddres);

                return context.Fetch<UserEntity>(ppSql).FirstOrDefault();
            }
        }
        public UserEntity LoginUser(int userID, string md5Hash)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"*, 2 As RecordStatusInt")
                            .From("Users")
                            .Where("UserID = @0", userID);

                var user = context.Fetch<UserEntity>(ppSql).FirstOrDefault();
                if (user.MD5Hash == md5Hash)
                {
                    return user;
                }
                return null;
            }
        }

     

        public short GetLastRoleID()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Select("RoleID").From("Roles");
                return context.Fetch<short>(sql).LastOrDefault();
            }
        }
        public void NewRoleOrganization(Role role)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Insert(role);
            }
        }
        public void NewUserOrganization(User user)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Insert(user);
            }
        }

        public short GetNewOrganizationUserID(string fullName,string email,string password)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Select("UserID").From("Users").Where("FullName=@0 and Email=@1 and Password=@2",fullName,email,password);
                return context.Fetch<short>(sql).FirstOrDefault();
            }
        }
        public short GetNewOrganizationID(int subscriptionPackageID, string email)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Select("OrganizationID").From("Organizations").Where("SubscriptionPackageID=@0 and Email=@1", subscriptionPackageID, email);
                return context.Fetch<short>(sql).LastOrDefault();
            }
        }
        public void NewUserRoleOrganization(UserRole userRole)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Insert(userRole);
            }
        }

    }
}
