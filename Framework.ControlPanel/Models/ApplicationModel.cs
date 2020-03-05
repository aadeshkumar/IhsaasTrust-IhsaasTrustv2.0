using Framework.Application.Services;
using Framework.Shared.DataServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Framework.ControlPanel.Models
{
    public class ApplicationModel
    {
        public List<FieldType> FieldTypes { get; set; }
        public List<Field> Fields { get; set; }
        public Framework.Shared.DataServices.Application Application { get; set; }
        public List<FieldValue> FieldValues { get; set; }
        public int? ApplicationID { get; set; }
        public List<User> FieldWorkers { get; set; }
        public bool IsAdmin { get; set; }
        public bool ReadOnly { get; set; }
    }

    public class ApprovalModel
    {
        public List<ApprovalListEntity> ApprovalList { set; get; }
        public List<Status> Statuses { get; set; }
        public List<User> CEO { get; set; }
        public List<CNICVerification> CNICVerifications { get; set; }
    }

    public class ApplicationListModel
    {
        public List<ApplicationListEntity> Applications { get; set; }
        public string ApplicantName { get; set; }
        public string CNIC { get; set; }
        public string ContactNo { get; set; }
        public string Enterprise { get; set; }
        public string Ration { get; set; }
        public string Latlng { get; set; }

    }
}