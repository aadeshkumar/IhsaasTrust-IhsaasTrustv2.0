using Framework.Application.Services;
using Framework.ControlPanel.Models;
using Framework.Shared.DataServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Framework.ControlPanel.Controllers
{
    public class ConfigurationController : BaseController
    {
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult UserTypes()
        {
            return View();
        }
        public ActionResult DynamicSetupScreen(int screenID)
        {
            DynamicSetupScreen dynamicSetupScreen = new DynamicSetupScreen();
            dynamicSetupScreen = CommonServices.Instance.GetDynamicSetupScreen(screenID);
            return View(dynamicSetupScreen);
        }
        public ActionResult EntityDetails()
        {
            return View();
        }
        public ActionResult Entities()
        {
            return View();
        }
        public ActionResult EntityDetailsDropDown(int entityID)
        {
            var list = CommonServices.Instance.GetAllEntityDetails(entityID);
            return PartialView("_EntityDetailsDropDown", list);
        }       
        public ActionResult ApiConfigurations()
        {
            return View();
        }        
        public ActionResult GetDropDownList(string tableName, string columns, string controlID, string key, string value)
        {
            DropDownListModel model = new DropDownListModel();
            model.Data = CommonServices.Instance.GetTableListingData(tableName, columns, string.Empty, string.Empty);
            model.ControlID = controlID;
            model.Key = key;
            model.Value = value;
            model.TableName = tableName;
            return PartialView("_GetDropDownList", model);
        }

        [HttpGet]
        public ActionResult Organization()
        {
            var package = CommonServices.Instance.GetOrganizations();
            return View(package);
        }


        [HttpGet]
        public ActionResult SubscriptionRequest()
        {
            
            return View();
        }
        [HttpPost]
        public ActionResult SubscriptionRequest(SubscriptionRequest SubscriptionRequest)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            string message = string.Empty;
            Organization org = new Organization();
            try
            {

                if (SubscriptionRequest != null)
                {
                    Organization a = new Organization();
                    a.OrganizationName = SubscriptionRequest.RequestOrganizationName;
                    a.SubscriptionPackageID = SubscriptionRequest.SubscriptionPackageID;
                    a.Email = SubscriptionRequest.RequestEmail;
                    a.PhoneNo = SubscriptionRequest.RequestPhoneNo;
                    a.MobileNo = SubscriptionRequest.RequestMobileNo;
                    a.Address = SubscriptionRequest.RequestAddress;
                    a.NoOfBranches = SubscriptionRequest.RequestNoOfBranches;
                    a.Logo = SubscriptionRequest.Logo;
                    a.IsActive = true;
                    CommonServices.Instance.Save(a.OrganizationName, a.Email, a.PhoneNo, a.MobileNo, a.Address, a.NoOfBranches, a.IsActive);
                    //Role role = new Role();
                    //role.CreatedBy = 1;
                    //role.CreatedOn = DateTime.Now;
                    //role.IsActive = true;
                    //role.OrganizationID = AuthenticationServices.Instance.GetNewOrganizationID(a.SubscriptionPackageID, a.Email);
                    //role.RoleName = "Admin";
                    //role.RoleID = 1;
                    User user = new User();
                    user.OrganizationID = AuthenticationServices.Instance.GetNewOrganizationID(a.SubscriptionPackageID, a.Email);
                    user.FullName = a.OrganizationName;
                    user.DisplayName = a.OrganizationName;
                    user.PictureURL = SubscriptionRequest.Logo;
                    user.OrganizationName = SubscriptionRequest.RequestOrganizationName;
                    user.Email = a.Email;
                    user.Password = "BP0qaZXHfNc=";
                    user.CreatedBy = 1;
                    user.StatusID = 1;

                    AuthenticationServices.Instance.NewUserOrganization(user);
                    //AuthenticationServices.Instance.NewRoleOrganization(role);
                    UserRole userRole = new UserRole();
                    userRole.RoleID = 1;
                    userRole.OrganizationID = user.OrganizationID;
                    userRole.CreatedBy = 1;
                    userRole.CreatedOn = DateTime.Now;
                    userRole.UserID = AuthenticationServices.Instance.GetNewOrganizationUserID(user.FullName, user.Email, user.Password);
                    AuthenticationServices.Instance.NewUserRoleOrganization(userRole);
                    message = "Saved";


                }
                else
                {
                    message = "model is empty";
                }
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            result.Data = message;
            return View();
        }
    }
}
