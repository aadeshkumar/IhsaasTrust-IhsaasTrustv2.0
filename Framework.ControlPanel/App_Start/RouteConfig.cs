using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Framework.ControlPanel
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.MapRoute(
               name: "LoginRoute", //Don't change this name it is used for Authorize Attributes
               url: "login",
               defaults: new { controller = "Authentication", action = "Login" }
           );
            routes.MapRoute(
               name: "MainPage", //Don't change this name it is used for Authorize Attributes
               url: "",
               defaults: new { controller = "Authentication", action = "Login" }
           );
            routes.MapRoute(
               name: "Organizations",  //Don't change this name it is used for Authorize Attributes
               url: "portal/home/organizations/list",
               defaults: new { controller = "Home", action = "Organizations" }
           );
            routes.MapRoute(
             name: "SelectedOrganizations",  //Don't change this name it is used for Authorize Attributes
             url: "portal/home/organizations/selected",
             defaults: new { controller = "Home", action = "SelectedOrganization" }
         );
            routes.MapRoute(
               name: "HomePage",  //Don't change this name it is used for Authorize Attributes
               url: "portal/home/dashboard",
               defaults: new { controller = "Home", action = "Index", fromDate = UrlParameter.Optional, toDate= UrlParameter.Optional, userID=UrlParameter.Optional }
           );
            routes.MapRoute(
               name: "Approval",  //Don't change this name it is used for Authorize Attributes
               url: "portal/application/approval",
               defaults: new { controller = "Application", action = "Approval" }
           );
            routes.MapRoute(
               name: "Application",  //Don't change this name it is used for Authorize Attributes
               url: "portal/application/create",
               defaults: new { controller = "Application", action = "Index" }
           );
            routes.MapRoute(
               name: "ApplicationList",  //Don't change this name it is used for Authorize Attributes
               url: "portal/application/list",
               defaults: new { controller = "Application", action = "List" }
           );

            routes.MapRoute(
               name: "RationApplication",  //Don't change this name it is used for Authorize Attributes
               url: "portal/application/Rationlist",
               defaults: new { controller = "Application", action = "RationList" }
           );
            routes.MapRoute(
              name: "RolesRights",  //Don't change this name it is used for Authorize Attributes
              url: "portal/roles-rights/",
              defaults: new { controller = "Account", action = "RolesRights" }
          );
            routes.MapRoute(
               name: "DynamicSetupScreen",  //Don't change this name it is used for Authorize Attributes
               url: "portal/{tableName}/{screenID}/",
               defaults: new { controller = "Configuration", action = "DynamicSetupScreen", screenID = UrlParameter.Optional }
           );
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
            routes.MapRoute(
              name: "Register",
              url: "Home/SubscriptionRequest/",
              defaults: new { controller = "Home", action = "SubscriptionRequest", id = UrlParameter.Optional }
          );
        }
    }
}