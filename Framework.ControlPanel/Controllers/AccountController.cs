using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Framework.ControlPanel.Models;
using Framework.Application.Services;
using System.Web.Security;
using Framework.Shared;
using Framework.Shared.DataServices;
using Framework.Shared.Enums;
using Framework.ControlPanel.CommonCode.Helpers;
namespace Framework.ControlPanel.Controllers
{
    public class AccountController : BaseController
    {
        //
        // GET: /Account/
        #region Updated Queries For Organization


        public ActionResult Index(int? pageNo)
        {
            return View();
        }
        public ActionResult RolesRights(short? roleID)
        {
            RolesRightsModel model = new RolesRightsModel();
            model.Entities = AccountServices.Instance.GetEntities();
            model.Roles = AccountServices.Instance.GetRoles();
            model.Rights = AccountServices.Instance.GetRights();
            model.RolesRights = AccountServices.Instance.GetRolesRights(roleID);
            model.RoleID = roleID;
            if (Request.IsAjaxRequest())
            {
                return PartialView("_RolesRightsPartial", model);
            }
            return View(model);
        }
        public JsonResult SaveRolesRights(List<RoleRight> RoleRight, short RoleID)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            int userID = Authentication.Instance.User.UserID;
            result.Data = AccountServices.Instance.SaveRoleRights(RoleRight, RoleID, userID);
            UserEntity user = new UserEntity();
            user = Authentication.Instance.User;
            user.RolesRights = AccountServices.Instance.GetUserRoleRights(user.UserID);
            Session["User"] = user;
            return result;
        }
    }
    #endregion
}
