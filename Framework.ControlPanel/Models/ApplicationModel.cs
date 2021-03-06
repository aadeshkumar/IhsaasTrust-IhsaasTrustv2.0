﻿using Framework.Application.Services;
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
        public int PageNo { get; set; }
        public int PageSize { get; set; }
        public int OrganizationID { get; set; }
    }
    public class MyArray
    {
        public string ApplicationID { get; set; }
        public string ApplicantName { get; set; }
        public string CNIC { get; set; }
        public string ContactNo { get; set; }
        public int TotalItems { get; set; }
        public string Enterprise { get; set; }
        public string Status { get; set; }
        public int StatusID { get; set; }
        public string Reason { get; set; }
        public string Timeline { get; set; }
        public string CreatedBy { get; set; }
        public string Date { get; set; }
        public string Edit { get; set; }
        public string Delete { get; set; }
    }

    public class Root
    {
        public List<MyArray> MyArray { get; set; }
    }
}