using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Adoofy;
using Framework.Application.Services;
using Framework.ControlPanel.CommonCode;
using Framework.ControlPanel.CommonCode.Helpers;
using Framework.ControlPanel.Models;
using Framework.Shared.DataServices;
using Framework.Shared.Enums;

namespace Framework.ControlPanel.Controllers
{
    public class HomeController : BaseController
    {
        #region Updated Queries For Organization



        public JsonResult GetNotification(int NotificationID)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            Notification noti = ApplicationServices.Instance.GetNotification(NotificationID);
            result.Data = noti.Body;
            ApplicationServices.Instance.ReadNotification(NotificationID);
            return result;

        }
        public ActionResult GetCharts(string fromDate, string toDate)
        {
            DashboardModel model = new DashboardModel();
            int organizationID = Authentication.Instance.User.OrganizationID;
            model.NoOfApplications = ApplicationServices.Instance.GetNoOfApplicationss(fromDate, toDate, organizationID, null);
            model.NoOfApplicationsByUsers = ApplicationServices.Instance.GetNoOfApplicationsByUserss(fromDate, toDate, organizationID, null);
            model.StatusCount = ApplicationServices.Instance.GetApplicationStatusess(fromDate, toDate, organizationID, null);
            model.PendingInFinance = ApplicationServices.Instance.PendingInFinances(fromDate, toDate, organizationID, null);
            model.InReviewOfCommittee = ApplicationServices.Instance.InReviewOfCommittees(fromDate, toDate, organizationID, null);
            model.NoOfStream = ApplicationServices.Instance.GetNoOfStream(fromDate, toDate, null);

            return PartialView("_ChartsPartialView", model);
        }
        public ActionResult Index(string fromDate, string toDate, int? userID, int? OrganizationID)
        {
            int organizationID = Authentication.Instance.User.OrganizationID;
            DashboardModel model = new DashboardModel();
            if (Authentication.Instance.IsLoggedIn && Authentication.Instance.User.RolesRights != null && Authentication.Instance.User.RolesRights.Count != 0)
            {
                int useriD = Authentication.Instance.User.UserID;
                short roleID = Authentication.Instance.User.RoleID;
                model.NoOfApplications = ApplicationServices.Instance.GetNoOfApplicationss(roleID, useriD, organizationID);
                model.ApplicationStatuses = ApplicationServices.Instance.GetApplicationStatuses(roleID, useriD);
            }
            else
            {
                model.NoOfApplications = 0;
            }

            if (OrganizationID.HasValue || (Authentication.Instance.User.RoleID == (short)RolesEnum.CEO || Authentication.Instance.User.RoleID == (short)RolesEnum.HeadFieldWorker))
            {
                organizationID = OrganizationID.HasValue ? OrganizationID.Value : organizationID;
                userID = OrganizationID.HasValue ? null : userID;
                model.NoOfApplications = ApplicationServices.Instance.GetNoOfApplicationss(fromDate, toDate, organizationID, userID);
                model.NoOfApplicationsByUsers = ApplicationServices.Instance.GetNoOfApplicationsByUserss(fromDate, toDate, organizationID, userID);
                model.StatusCount = ApplicationServices.Instance.GetApplicationStatusess(fromDate, toDate, organizationID, userID);
                model.PendingInFinance = ApplicationServices.Instance.PendingInFinances(fromDate, toDate, organizationID, userID);
                model.InReviewOfCommittee = ApplicationServices.Instance.InReviewOfCommittees(fromDate, toDate, organizationID, userID);
                model.NoOfStream = ApplicationServices.Instance.GetNoOfStream(fromDate, toDate, userID);
                model.NoOfDelayedCases = ApplicationServices.Instance.GetNoOfDelayedCasess(organizationID);
                model.TotalAndConcludedApplications = ApplicationServices.Instance.GetTotalAndConcludedApplicationss(organizationID);
                model.ActiveOrganization = ApplicationServices.Instance.GetActiveOrganizations();
            }
            else if (Authentication.Instance.User.RoleID == (short)RolesEnum.SuperAdmin)
            {
                model.NoOfApplications = ApplicationServices.Instance.GetNoOfApplications(fromDate, toDate, userID);
                model.NoOfApplicationsByUsers = ApplicationServices.Instance.GetNoOfApplicationsByUsers(fromDate, toDate, userID);
                model.StatusCount = ApplicationServices.Instance.GetApplicationStatuses(fromDate, toDate, userID);
                model.PendingInFinance = ApplicationServices.Instance.PendingInFinance(fromDate, toDate, userID);
                model.InReviewOfCommittee = ApplicationServices.Instance.InReviewOfCommittee(fromDate, toDate, userID);
                model.NoOfStream = ApplicationServices.Instance.GetNoOfStream(fromDate, toDate, userID);
                model.NoOfDelayedCases = ApplicationServices.Instance.GetNoOfDelayedCases();
                model.TotalAndConcludedApplications = ApplicationServices.Instance.GetTotalAndConcludedApplications();
                model.ActiveOrganization = ApplicationServices.Instance.GetActiveOrganizations();


            }

            if (Authentication.Instance.User.RoleID == (short)RolesEnum.FieldWorker || Authentication.Instance.User.RoleID == (short)RolesEnum.HeadFieldWorker)
            {
                model.ApplicationAssignedToFieldOfficer = ApplicationServices.Instance.ApplicationAssignedToFieldOfficer(Authentication.Instance.User.UserID, organizationID);
            }
            if (Authentication.Instance.User.RoleID == (short)RolesEnum.Committee || Authentication.Instance.User.RoleID == (short)RolesEnum.RS || Authentication.Instance.User.RoleID == (short)RolesEnum.Finance)
            {
                var apps = ApplicationServices.Instance.GetApprovalApplications(Authentication.Instance.User.UserID, organizationID);
                model.Rejected = apps.UniqueBy(x => x.ApplicationID).Where(x => x.StatusID == (short)StatusesEnum.Rejected).Count();
                model.Submit = apps.UniqueBy(x => x.ApplicationID).Where(x => x.StatusID == (short)StatusesEnum.Submit).Count();
                model.Approved = apps.UniqueBy(x => x.ApplicationID).Where(x => x.StatusID == (short)StatusesEnum.Approved).Count();
            }
            if (Authentication.Instance.User.RoleID == (short)RolesEnum.FieldWorker)
            {
                model.DashboardStatus = ApplicationServices.Instance.DashboardStatuses(Authentication.Instance.User.UserID, organizationID);
                model.DashboardStatistics = ApplicationServices.Instance.GetDashboardStatistics(organizationID, (int?)Authentication.Instance.User.UserID);
            }
            else
            {
                model.DashboardStatistics = ApplicationServices.Instance.GetDashboardStatistics(organizationID, (int?)null);
            }
            model.totalNum = ApplicationServices.Instance.GetTotalNum(Authentication.Instance.User.UserID);

            return View(model);
        }
        public ActionResult Template(string ApplicationID)
        {
            List<Application.Services.TemplateData> model = new List<Application.Services.TemplateData>();
            model = ApplicationServices.Instance.GetTemplate(int.Parse(ApplicationID));
            return View(model);
        }
        public ActionResult Menus()
        {
            short roleID = Authentication.Instance.User.RoleID;
            var menus = CommonServices.Instance.GetMenus(roleID);
            return PartialView("_LeftMenus", menus);
        }


        #endregion

        public ActionResult Organizations()
        {
            return View();
        }
        public ActionResult SelectedOrganization(int organizationID)
        {

            Authentication.Instance.User.OrganizationID = organizationID;
            return Redirect("/portal/home/dashboard");
        }
    }
}
