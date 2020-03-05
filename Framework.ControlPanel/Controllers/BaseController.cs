using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Framework.ControlPanel.CommonCode;
using Framework.ControlPanel.Models;
using Framework.Application.Services;
using Framework.Application;
using Framework.ControlPanel.CommonCode.Helpers;

namespace Framework.ControlPanel.Controllers
{
    [AuthorizeIt]
    public class BaseController : Controller
    {
        /// <summary>
        /// Called before the action method is invoked.
        /// </summary>
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            filterContext.HttpContext.Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));
            filterContext.HttpContext.Response.Cache.SetValidUntilExpires(false);
            filterContext.HttpContext.Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
            filterContext.HttpContext.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            filterContext.HttpContext.Response.Cache.SetNoStore();
            if (Authentication.Instance.IsLoggedIn)
            {
                if (Authentication.Instance.User.RolesRights == null || Authentication.Instance.User.RolesRights.Count == 0)
                {
                    Authentication.Instance.User.RolesRights = AccountServices.Instance.GetUserRoleRights(Authentication.Instance.User.UserID);
                    Authentication.Instance.User.RoleID = (Authentication.Instance.User.RolesRights != null && Authentication.Instance.User.RolesRights.Count != 0) ? Authentication.Instance.User.RolesRights.FirstOrDefault().RoleID : (short)0;
                }
            }
            base.OnActionExecuting(filterContext);
        }
    }
}
