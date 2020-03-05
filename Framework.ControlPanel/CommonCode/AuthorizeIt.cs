using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Mvc;
using Framework.Application.Services;
using Framework.ControlPanel.CommonCode.Helpers;
namespace Framework.ControlPanel.CommonCode
{
    public class AuthorizeIt : System.Web.Mvc.AuthorizeAttribute
    {
        protected override bool AuthorizeCore(System.Web.HttpContextBase httpContext)
        {
            if (Authentication.Instance.IsLoggedIn)
            {
                if (Authentication.Instance.User.RolesRights == null || Authentication.Instance.User.RolesRights.Count == 0)
                {
                    Authentication.Instance.User.RolesRights = AccountServices.Instance.GetUserRoleRights(Authentication.Instance.User.UserID);
                    Authentication.Instance.User.RoleID = (Authentication.Instance.User.RolesRights != null && Authentication.Instance.User.RolesRights.Count != 0) ? Authentication.Instance.User.RolesRights.FirstOrDefault().RoleID : (short)0;
                }
                return true;
            }
            return base.AuthorizeCore(httpContext);
        }

         protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
         {

             RedirectToRouteResult result = null;
             if (Authentication.Instance.IsLoggedIn)
             {
                 Authentication.Instance.LastSecurityError = "Role is not assigned to the user";
                 result = new RedirectToRouteResult("HomePage", new System.Web.Routing.RouteValueDictionary(), true);
             }
             else
             {
                result = new RedirectToRouteResult("LoginRoute", new System.Web.Routing.RouteValueDictionary(), true);
             }
             filterContext.Result = result;
         }
    }
}