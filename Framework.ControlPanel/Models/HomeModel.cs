using Framework.Application.Services;
using Framework.Shared.DataServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Framework.ControlPanel.Models
{
    public class IndexPageModel
    {
        //public List<MenuNavigationGroup> MenuNavigationGroups { get; set; }
    }
    public class DashboardModel
    {
        public int totalNum { get; set; }
        public int NoOfApplications { get; set; }
        public int PendingInFinance { get; set; }
        public int InReviewOfCommittee { get; set; }
        public List<NoOfStreamEntity> NoOfStream { get; set; }
        public List<ApplicationStatusesEntity> ApplicationStatuses { get; set; }
        public List<NoOfApplicationsByUsersEntity> NoOfApplicationsByUsers { get; set; }
        public List<StatusCountEntity> StatusCount { get; set; }
        public List<AssignedFieldOfficerApplicationEntity> ApplicationAssignedToFieldOfficer { get; set; }
        public int Rejected { set; get; }
        public int Approved { set; get; }
        public int Submit { set; get; }
        public List<DashboardStatusEntity> DashboardStatus { get; set; }
        public List<StatisticsEntity> DashboardStatistics { get; set; }
        public List<StatisticsEntity> NoOfDelayedCases { get; set; }
        public List<StatisticsEntity> TotalAndConcludedApplications { get; set; }
        public List<Organization> ActiveOrganization { get; set; }


    }
}