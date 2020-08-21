using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Framework.Shared.DataServices;
using Framework.Shared;
using System.Reflection;
using Framework.Shared.Enums;
namespace Framework.Application.Services
{
    public class ApplicationServices
    {
        #region Define as Singleton
        private static ApplicationServices _Instance;
        public static ApplicationServices Instance
        {
            get
            {
                if (_Instance == null)
                {
                    _Instance = new ApplicationServices();
                }

                return (_Instance);
            }
        }
        private ApplicationServices()
        {
        }
        #endregion

        public string GetUserName(int ApprovalUserID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Append("Select FullName from Users where UserID = @0", ApprovalUserID);
                return context.Fetch<string>(ppSql).FirstOrDefault();
            }
        }
        //public string GetUserRoleName(int ApprovalUserID)
        //{
        //    using (var context = DataContextHelper.GetCPDataContext())
        //    {
        //        var ppSql = PetaPoco.Sql.Builder.Append("(Select RoleName from Roles where RoleID ="+ 
        //                                                "(Select UR.RoleID from UserRoles UR where UR.UserID = " +
        //                                                "(Select UserID from Users where UserID = @0)))", ApprovalUserID);
        //        return context.Fetch<string>(ppSql).FirstOrDefault();
        //    }
        //}
        public List<TemplateData> GetTemplate(int ID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Append(@"Select A.StatusID,A.UserID,A.CreatedOn,A.Reason,
                                    (Select RoleID from UserRoles where UserID=A.CreatedBy)CreatedBy,
	                                (Select [Data] From FieldValues Where ApplicationID = @0 AND FieldID = 105) FieldOfficerRecommendation,
	                                (Select [Data] From FieldValues Where ApplicationID = @0 AND FieldID = 90) SourceOfIncome,
	                                (Select [Data] From FieldValues Where ApplicationID = @0 AND FieldID = 108  AND FieldID = 108 AND [Data] != '') RSRecommendation,
	                                (Select [Data] From FieldValues Where ApplicationID = @0 AND FieldID = 117) FinanceAmount
                                     FROM Approvals A where A.RowID = @0 Order by CreatedOn", ID);
                return context.Fetch<TemplateData>(ppSql);
                //(Select[Data] From FieldValues Where ApplicationID = @0 AND FieldID = 105) CommitteeReason,
	               //                 (Select[Data] From FieldValues Where ApplicationID = @0 AND FieldID = 105) RSReason,
	               //                 (Select[Data] From FieldValues Where ApplicationID = @0 AND FieldID = 105) CEOReason,
	               //                 (Select[Data] From FieldValues Where ApplicationID = @0 AND FieldID = 105) FinanceReason,

            }
        }
        public int GetTotalNum(int userid)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Append("select count(*) from applications where  createdby = " + userid + " and applicationId not in (select RowID from approvals)");
                return context.Fetch<int>(ppSql).FirstOrDefault();
            }
        }
        public bool RejectionStatus(int ApplicationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                return Convert.ToInt32(context.Fetch<string>("SELECT StatusID  FROM Approvals where RowID=@0", ApplicationID).LastOrDefault()) == 7 ? true : false;
            }
        }
        public void UpdateFieldValues(string Data, int FieldID, int ApplicationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Execute("Update FieldValues Set Data = @0 Where ApplicationID = @1 and FieldID=@2", Data, ApplicationID, FieldID);
            }
        }
        public List<User> FindEmailsOfReportedTo(int UserID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                return context.Fetch<User>("Select Users.RecipientEmail, Users.FullName, Users.UserID FROM Users JOIN UserRoles ON Users.UserID = UserRoles.UserID Where RoleID = (select ReportedTo from ApprovalHierarchies  Where UserID=@0)", UserID);
            }
        }
        public string FindMobilesOfReportedTo(int UserID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                return string.Join(",", context.Fetch<User>("Select Users.Mobile FROM Users JOIN UserRoles ON Users.UserID = UserRoles.UserID Where RoleID = (select ReportedTo from ApprovalHierarchies  Where UserID=@0)", UserID));
            }
        }
        public string FindMobiles(int UserID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                return context.Fetch<string>("Select Mobile, FullName FROM Users Where UserID = @0", UserID).FirstOrDefault();
            }
        }
        public List<User> FindEmail(int UserID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                return context.Fetch<User>("Select RecipientEmail, UserID, FullName FROM Users Where UserID = @0", UserID);
            }
        }
        public string FindFullName(int OrgnaizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                return context.Fetch<string>("Select FullName FROM Users  Where OrgnaizationID = @0", OrgnaizationID).FirstOrDefault();
            }
        }
        public List<FieldType> GetFieldTypes()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"*")
                            .From("FieldTypes")
                            .Where("IsActive = 1");
                return context.Fetch<FieldType>(ppSql);
            }
        }
        public List<Field> GetFields(bool isAdmin,int OrganizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder.Select(@"*")
                            .From("Fields")
                            .Where("IsActive = 1 AND OrganizationID=@0 OR  OrganizationID=0", OrganizationID);
                if (isAdmin)
                    ppSql = ppSql.Where("AllowToAdmin = 1");
                return context.Fetch<Field>(ppSql);
            }
        }
        public List<FieldValue> GetFieldValues(int? applicationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                applicationID = applicationID ?? 0;
                var ppSql = PetaPoco.Sql.Builder.Select(@"*")
                            .From("FieldValues")
                            .Where("ApplicationID = @0", applicationID);
                return context.Fetch<FieldValue>(ppSql);
            }
        }
        public Shared.DataServices.Application GetApplication(int? applicationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                applicationID = applicationID ?? 0;
                var ppSql = PetaPoco.Sql.Builder.Select(@"*")
                            .From("Applications")
                            .Where("ApplicationID = @0", applicationID);
                return context.Fetch<Shared.DataServices.Application>(ppSql).FirstOrDefault();
            }
        }
        public List<ApplicationListEntity> GetApplication(string applicantName, string cnic, string contactNo, string whereClause, short? statusID, short? roleID, string enterprise, string date,int OrganizationID, int? pageNo, int? pageSize)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder
                        .Append(@";With FV 
                                AS
                                (
	                                Select ApplicationID, Data, FieldID From FieldValues Where FieldID IN (28,30,32,2155,1119,2119,2120)
                                ) Select * From (
                                Select 
	                                APP.ApplicationID,
	                                (Select [Data] From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 28) ApplicantName,
	                                (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 30) CNIC,
	                                (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 32) ContactNo,
                                    (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 2155) Latlng,
	                                (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 1119) Enterprise,
	                                (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 2119) IbrahimGoth,
	                                (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 2120) MehranTown,
	                                (Select Top 1 S.StatusName + ' (' + (Select Top 1 FullName From Users Where UserID = A.UserID) + ')' From Approvals A Inner Join Statuses S ON A.StatusID = S.StatusID Where A.RowID = APP.ApplicationID Order By A.CreatedOn Desc) [Status],
									(Select Top 1 S.StatusID From Approvals A Inner Join Statuses S ON A.StatusID = S.StatusID Where A.RowID = APP.ApplicationID Order By A.CreatedOn Desc) [StatusID],
									(Select Top 1 A.Reason From Approvals A Where A.RowID = APP.ApplicationID Order By A.CreatedOn Desc) Reason,
                                    (Select Top 1 A.UserID From Approvals A Where A.RowID = APP.ApplicationID Order By A.CreatedOn Desc) UserID,
	                                U.FullName CreatedBy,
	                                APP.Date,
									Count(0) Over() TotalItems
                                From Applications APP
                                Inner Join Users U
                                ON APP.CreatedBy = U.UserID " + whereClause + " Where APP.OrganizationID=@0 ) X", OrganizationID);
                //ppSql = ppSql.Where("");)
                if (!string.IsNullOrEmpty(applicantName)) { ppSql = ppSql.Where("X.ApplicantName = @0", applicantName); }
                if (!string.IsNullOrEmpty(cnic)) { ppSql = ppSql.Where("X.CNIC = @0", cnic); }
                if (!string.IsNullOrEmpty(contactNo)) { ppSql = ppSql.Where("X.ContactNo = @0", contactNo); }
                if (statusID.HasValue) { ppSql = ppSql.Where("X.StatusID = @0", statusID.Value); }
                if (roleID.HasValue) { ppSql = ppSql.Where("X.UserID IN (Select UserID From UserRoles Where RoleID = @0)", roleID.Value); }
                if (!string.IsNullOrEmpty(enterprise) && enterprise == "true") { ppSql = ppSql.Where("X.Enterprise = @0", enterprise); }
                if (!string.IsNullOrEmpty(date)) { ppSql = ppSql.Where("X.Date <= @0", date); }
                ppSql = ppSql.OrderBy("1 Desc");
                if (pageNo.HasValue && pageSize.HasValue) { ppSql = ppSql.Paginate(pageNo.Value, pageSize.Value); }
                return context.Fetch<ApplicationListEntity>(ppSql);
            }
        }
        public List<ApplicationListEntity> GetApplications(string applicantName, string cnic, string contactNo, string whereClause, short? statusID, short? roleID, string enterprise, string date, int OrganizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var ppSql = PetaPoco.Sql.Builder
                        .Append(@";With FV 
                                AS
                                (
	                                Select ApplicationID, Data, FieldID From FieldValues Where FieldID IN (28,30,32,95,1119)
                                ) Select * From (
                                Select 
	                                APP.ApplicationID,
	                                (Select [Data] From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 28) ApplicantName,
	                                (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 30) CNIC,
	                                (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 32) ContactNo,
                                    (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 95) Ration,
	                                (Select [Data] ApplicantName From FV Where FV.ApplicationID = APP.ApplicationID AND FV.FieldID = 1119) Enterprise,
	                                (Select Top 1 S.StatusName + ' (' + (Select Top 1 FullName From Users Where UserID = A.UserID) + ')' From Approvals A Inner Join Statuses S ON A.StatusID = S.StatusID Where A.RowID = APP.ApplicationID Order By A.CreatedOn Desc) [Status],
									(Select Top 1 S.StatusID From Approvals A Inner Join Statuses S ON A.StatusID = S.StatusID Where A.RowID = APP.ApplicationID Order By A.CreatedOn Desc) [StatusID],
									(Select Top 1 A.Reason From Approvals A Where A.RowID = APP.ApplicationID Order By A.CreatedOn Desc) Reason,
                                    (Select Top 1 A.UserID From Approvals A Where A.RowID = APP.ApplicationID Order By A.CreatedOn Desc) UserID,
	                                U.FullName CreatedBy,
	                                APP.Date
                                From Applications APP
                                Inner Join Users U
                                ON APP.CreatedBy = U.UserID " + whereClause + " Where APP.OrganizationID=@0) X", OrganizationID);
                //ppSql = ppSql.Where("");
                if (!string.IsNullOrEmpty(applicantName)) { ppSql = ppSql.Where("X.ApplicantName = @0", applicantName); }
                if (!string.IsNullOrEmpty(cnic)) { ppSql = ppSql.Where("X.CNIC = @0", cnic); }
                if (!string.IsNullOrEmpty(contactNo)) { ppSql = ppSql.Where("X.ContactNo = @0", contactNo); }
                if (statusID.HasValue) { ppSql = ppSql.Where("X.StatusID = @0", statusID.Value); }
                if (roleID.HasValue) { ppSql = ppSql.Where("X.UserID IN (Select UserID From UserRoles Where RoleID = @0)", roleID.Value); }
                if (!string.IsNullOrEmpty(enterprise) && enterprise == "true") { ppSql = ppSql.Where("X.Enterprise = @0", enterprise); }
                if (!string.IsNullOrEmpty(date)) { ppSql = ppSql.Where("X.Date <= @0", date); }
                return context.Fetch<ApplicationListEntity>(ppSql);
            }
        }

        public void ApplcationCreater(int applicationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Execute("Insert into FieldValues(ApplicationID,FieldID,Data,CreatedOn,CreatedBy) Values(@0,@1,@2,@3,@4)", applicationID);
            }
        }

        public Shared.DataServices.Application SaveUpdateApplication(Shared.DataServices.Application application, int userID, bool isAdmin, bool headOfFieldOfficer = false, bool IsDeleted = false, bool enterprise = false)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                if (application.ApplicationID == 0)
                {
                    context.Insert(application);
                }
                else
                {
                    if (!headOfFieldOfficer)
                        context.Execute("Update Applications Set ModifiedOn = @0, ModifiedBy = @1 Where ApplicationID = @2", application.ModifiedOn, application.ModifiedBy, application.ApplicationID);
                    else
                        context.Execute("Update Applications Set ModifiedOn = @0, ModifiedBy = @1, CreatedBy = @3 Where ApplicationID = @2", application.ModifiedOn, application.ModifiedBy, application.ApplicationID, application.CreatedBy);
                }
                if (!isAdmin)
                {
                    SaveApproval(userID, application.ApplicationID, (short)StatusesEnum.Submit, false, null, IsDeleted);
                }
                if(!enterprise)
                {
                    SaveApproval(userID, application.ApplicationID, (short)StatusesEnum.Submit, false, null, IsDeleted);
                }
                return application;
            }
        }
        public void InsertFieldValues(int userID, int applicationID, string data, int fieldID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Execute("Insert into FieldValues(ApplicationID,FieldID,Data,CreatedOn,CreatedBy) Values(@0,@1,@2,@3,@4)", applicationID, fieldID, data, DateTime.Now, userID);
            }
        }
        public void SaveApproval(int userID, int applicationID, short statusID, bool isEscalated, string reason, bool IsDeleted = false)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                if (IsDeleted)
                {
                    var aprrovals = context.Fetch<Approval>(string.Format("Select * From Approvals Where RowID = {0} and IsDeleted  IS NULL", applicationID));
                    foreach (var approve in aprrovals)
                    {
                        approve.ModifiedOn = DateTime.Now;
                        approve.IsDeleted = true;
                        context.Update(approve);
                    }

                    Approval approval = new Approval
                    {
                        UserID = userID,
                        EntityID = 4,
                        RowID = applicationID,
                        CreatedBy = userID,
                        CreatedOn = DateTime.Now,
                        StatusID = statusID,
                        Reason = reason,
                        IsEscalated = isEscalated
                    };
                    context.Insert(approval);
                }
                else
                {
                    var approvalCheck = context.Fetch<Approval>(string.Format("Select * From Approvals Where UserID = {0} AND RowID = {1} and IsDeleted  IS NULL", userID, applicationID)).LastOrDefault();
                    if (approvalCheck == null)
                    {
                        Approval approval = new Approval();
                        approval.UserID = userID;
                        approval.EntityID = 4;
                        approval.RowID = applicationID;
                        approval.CreatedBy = userID;
                        approval.CreatedOn = DateTime.Now;
                        approval.StatusID = statusID;
                        approval.Reason = reason;
                        approval.IsEscalated = isEscalated;
                        context.Insert(approval);
                    }
                    else
                    {
                        approvalCheck.ModifiedBy = userID;
                        approvalCheck.ModifiedOn = DateTime.Now;
                        context.Update(approvalCheck);
                    }

                }
            }
        }
        public DateTime IsApplicationUserExistCreatedOn(int fieldID, string fieldValue)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                // applicationID = applicationID ?? 0;
                var ppSql = PetaPoco.Sql.Builder.Select(@"CreatedOn")
                            .From("fieldvalues")
                            .Where("fieldid = @0 and Data = @1", fieldID, fieldValue);
                return context.Fetch<DateTime>(ppSql).FirstOrDefault();
            }
        }
        public bool IsApplicationUserExist(int fieldID, string fieldValue)
        {
            var exist = false;
            using (var context = DataContextHelper.GetCPDataContext())
            {
                // applicationID = applicationID ?? 0;
                var ppSql = PetaPoco.Sql.Builder.Select(@"*")
                            .From("fieldvalues")
                            .Where("fieldid = @0 and Data = @1", fieldID, fieldValue);
                var res = context.Fetch<Shared.DataServices.FieldValue>(ppSql).FirstOrDefault();

                exist = res != null ? true : false;
            }
            return exist;
        }
        //public void SaveFieldValues(List<FieldValue> fieldValue)
        //{
        //    using (var context = DataContextHelper.GetCPDataContext())
        //    {
        //        foreach (var fv in fieldValue)
        //        {
        //            context.Insert(fv);
        //        }
        //    }
        //}
        public List<FieldValue> SaveUpdateFieldValues(List<FieldValue> fieldValue, ref string message)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                foreach (var fv in fieldValue)
                {
                    if (fv.FieldValueID == 0)
                    {
                        context.Insert(fv);
                        message = "Application has been successfully created!";
                    }
                    else
                    {
                        //if (fv.IsDeleted.HasValue)
                        //{
                        //    context.Execute("Update FieldValues Set IsDeleted=@0 Where FieldValueID = @1", fv.IsDeleted, fv.FieldValueID);
                        //    message = "Application has been successfully updated!";
                        //}
                        //else
                        //{
                        context.Execute("Update FieldValues Set Data = @0, ModifiedOn = @1, ModifiedBy = @2 Where FieldValueID = @3", fv.Data, fv.ModifiedOn, fv.ModifiedBy, fv.FieldValueID);
                        message = "Application has been successfully updated!";
                        //}
                    }
                }
                if (fieldValue != null && fieldValue.Count != 0)
                {
                    context.Execute("Delete From FieldValues Where FieldID IN (108,117) AND Data='' Where ApplicationID=@0", fieldValue[0].ApplicationID);
                }
                return fieldValue;
            }
        }
        public void DeleteApplication(int applicationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Execute("Delete From FieldValues Where ApplicationID = @0", applicationID);
                context.Execute("Delete From Applications Where ApplicationID = @0", applicationID);
            }
        }
        //?
        //??
        //???
        //??
        //?
        public int GetNoOfApplicationss(short roleID, int userID,int organizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                if (roleID != (short)RolesEnum.Admin)
                {
                    sql = PetaPoco.Sql.Builder.Append(@"Select Count(*)                                                From Approvals A
                                                        Inner Join ApprovalHierarchies AH
                                                        ON A.UserID = AH.UserID
                                                        Inner Join Roles R
                                                        ON AH.ReportedTo = R.RoleID
                                                        Inner Join UserRoles UR
                                                        ON UR.RoleID = R.RoleID
                                                        Inner Join Statuses S
                                                        ON S.StatusID = A.StatusID
                                                        Inner Join Users U
                                                        ON U.UserID = A.UserID
                                                        Where UR.UserID = @0 AND A.RowID NOT IN (Select RowID From Approvals Where UserID = @0) AND A.StatusID NOT IN (7,9,10)", userID);
                }
                else
                {
                    sql = PetaPoco.Sql.Builder.Append("Select count(*) from Applications");

                }
                return context.Fetch<int>("select count(*) from Applications Where OrganizationID=@0", organizationID).FirstOrDefault();
            }
        }
        public List<ApplicationStatusesEntity> GetApplicationStatuses(short roleID, int userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                string whereClause = string.Empty;
                if (roleID != (short)RolesEnum.Admin)
                {
                    whereClause = string.Format("AND A.CreatedBy = {0}", userID);

                }
                var sql = PetaPoco.Sql.Builder.Append(@"Select Count(0) NoOfRecords, X.StatusID, S.StatusName From (
                                                        Select A.StatusID,
                                                        ROW_NUMBER() OVER(Partition By A.RowID Order By A.CreatedOn Desc) RankNo
                                                        From Approvals A
                                                        Where EntityID = 4 " + whereClause + @"
                                                        ) X 
                                                        Inner Join Statuses S ON S.StatusID = X.StatusID
                                                        Where X.RankNo = 1
                                                        Group By X.StatusID, S.StatusName");
                return context.Fetch<ApplicationStatusesEntity>(sql);
            }
        }
        public Notification GetNotification(int NotificationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                return context.Fetch<Notification>("Select * from Notifications where NotificationID = @0", NotificationID).FirstOrDefault();
            }
        }
        public List<ApprovalListEntity> GetApprovalApplications(int userID, int organizationID, bool isEscalated = false)
        {
            string whereClause = isEscalated ? "A.IsEscalated=1" : "UR.UserID = @0";
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Append(@"Select 
	                                                        A.ApprovalID, 
	                                                        A.RowID ApplicationID, 
                                                            (Select [Data] From FieldValues Where FieldID = 28 AND ApplicationID = A.RowID) ApplicantName,
	                                                            (Select [Data] From FieldValues Where FieldID = 30 AND ApplicationID = A.RowID) CNIC,
	                                                            (Select [Data] From FieldValues Where FieldID = 32 AND ApplicationID = A.RowID) ContactNo,
	                                                        A.StatusID, 
	                                                        A.CreatedOn,    
	                                                        A.Reason,
                                                            (select FullName from users where UserID=(select  top 1 UserID from Approvals where RowID=A.RowID order by CreatedOn)) InitiallyCreatedBy,
	                                                        A.CreatedBy,
	                                                        U.FullName + ' (' + (Select RoleName From Roles Where RoleID = (Select RoleID From UserRoles Where UserID = A.UserID)) + ')' CreatedBy,
	                                                        UR.UserID,
	                                                        S.StatusName Status
                                                        From Approvals A
                                                        Inner Join ApprovalHierarchies AH
                                                        ON A.UserID = AH.UserID
                                                        Inner Join Roles R
                                                        ON AH.ReportedTo = R.RoleID
                                                        Inner Join UserRoles UR
                                                        ON UR.RoleID = R.RoleID
                                                        Inner Join Statuses S
                                                        ON S.StatusID = A.StatusID
                                                        Inner Join Users U
                                                        ON U.UserID = A.UserID
                                                        Inner Join Applications APP
														On APP.ApplicationID = A.RowID
                                                        Where " + whereClause + " AND A.IsDeleted IS NULL AND A.RowID NOT IN (Select RowID From Approvals Where UserID = @0 and IsDeleted  IS NULL) AND A.StatusID NOT IN (7,9,10) AND APP.OrganizationID=@1", userID, organizationID);
                return context.Fetch<ApprovalListEntity>(sql);
            }
        }
        public List<Status> GetStatuses()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Append(@"Select * From Statuses Where IsActive = 1");
                return context.Fetch<Status>(sql);
            }
        }
        public List<User> GetCEO(int OrganizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Append(@"Select * From Users Where UserID IN (Select UserID From UserRoles Where RoleID = 6) AND StatusID = 1 and OrganizationID=@0", OrganizationID);
                return context.Fetch<User>(sql);
            }
        }

        public int GetNoOfApplicationss(string fromDate, string toDate, int organizationID, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Select(@"Count(0) NoOfApplications").From("Applications");
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    sql = sql.Where("CONVERT(date, CreatedON) BETWEEN @0 AND @1", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    sql = sql.Where("CreatedBy = @0", userID.Value);
                }
                sql = sql.Where("OrganizationID = @0", organizationID);
                return context.Fetch<int>(sql).FirstOrDefault();
            }
        }
        public List<NoOfApplicationsByUsersEntity> GetNoOfApplicationsByUserss(string fromDate, string toDate,int organizationID, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Select(@"Count(0) NoOfApplications, U.FullName, A.CreatedBy").From("Applications A")
                    .InnerJoin("Users U").On("U.UserID = A.CreatedBy").Where("A.OrganizationID=@0", organizationID);
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    sql = sql.Where("CONVERT(date, A.CreatedON) BETWEEN @0 AND @1", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    sql = sql.Where("A.CreatedBy = @0", userID.Value);
                }
                sql = sql.GroupBy("U.FullName, A.CreatedBy");
                return context.Fetch<NoOfApplicationsByUsersEntity>(sql);
            }
        }
        public List<StatusCountEntity> GetApplicationStatusess(string fromDate, string toDate,int organizationID, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                string whereClause = string.Empty;
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    whereClause = string.Format("and CONVERT(date, AP.CreatedON) BETWEEN '{0}' AND '{1}'", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    whereClause += string.Format("and AP.CreatedBy = {0}", userID.Value);
                }
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Append(@";With CTE AS (
                                                    Select Row_Number() Over(Partition By A.RowID Order By A.CreatedOn Desc) RankNo, 
                                                    S.StatusName
                                                    From Approvals A
                                                    Inner Join Applications AP ON AP.ApplicationID = A.RowID
                                                    Inner Join Statuses S
                                                    ON A.StatusID = S.StatusID where 1=1 AND AP.OrganizationID=@0
                                                    " + whereClause + @"
                                                  )
                                                  Select Count(0) StatusCount, StatusName From CTE Where RankNo = 1 Group By StatusName", organizationID);
                return context.Fetch<StatusCountEntity>(sql);
            }
        }
        public int PendingInFinances(string fromDate, string toDate,int organizationID, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                string whereClause = string.Format("AP.OrganizationID = {0} AND", organizationID);
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    whereClause = string.Format("CONVERT(date, AP.CreatedON) BETWEEN '{0}' AND '{1}' AND", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    whereClause += string.Format("AP.CreatedBy = {0} AND", userID.Value);
                }
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Append(@"Select Count(0) PendingInFinance From Approvals A Inner Join Applications AP ON A.RowID =
                                                        AP.ApplicationID Where " + whereClause + @"  A.UserID IN (
                                                        Select UserID From ApprovalHierarchies 
                                                        Where ReportedTo IN (
                                                        Select UR.RoleID From Users U
                                                        Inner Join UserRoles UR
                                                        ON U.UserID = UR.UserID
                                                        Inner Join Roles R
                                                        ON UR.RoleID = R.RoleID
                                                        Where UR.RoleID = @0)) AND StatusID = 8 AND RowID NOT IN (Select RowID From Approvals Where                  
                                                        UserID IN (Select UserID From UserRoles Where RoleID = @0))", (short)RolesEnum.Finance);
                return context.Fetch<int>(sql).FirstOrDefault();
            }
        }
        public int InReviewOfCommittees(string fromDate, string toDate,int organizationID, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                string whereClause = string.Format("AP.OrganizationID = {0} AND", organizationID);
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    whereClause = string.Format("CONVERT(date, AP.CreatedON) BETWEEN '{0}' AND '{1}' AND", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    whereClause += string.Format("AP.CreatedBy = {0} AND", userID.Value);
                }
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Append(@"Select Count(0) From Approvals A Inner Join Applications AP ON A.RowID = AP.ApplicationID
                                                    Where " + whereClause + @" A.UserID IN (
                                                    Select UserID From ApprovalHierarchies 
                                                    Where ReportedTo IN (
                                                    Select UR.RoleID From Users U
                                                    Inner Join UserRoles UR
                                                    ON U.UserID = UR.UserID
                                                    Inner Join Roles R
                                                    ON UR.RoleID = R.RoleID
                                                Where UR.RoleID = @0)) AND StatusID IN (8,4) AND RowID NOT IN (Select RowID From Approvals Where UserID IN (Select UserID From UserRoles Where RoleID = @0))", (short)RolesEnum.Committee);
                return context.Fetch<int>(sql).FirstOrDefault();
            }
        }
        public List<NoOfStreamEntity> GetNoOfStream(string fromDate, string toDate, int? userID, int organizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                string whereClause = string.Empty;
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    whereClause = string.Format("CONVERT(date, Fv.CreatedON) BETWEEN '{0}' AND '{1}' AND", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    whereClause += string.Format("AP.CreatedBy = {0} AND", userID.Value);
                }
                PetaPoco.Sql sql;
                if (organizationID != 1003)
                {
                    sql = PetaPoco.Sql.Builder.Append(@"Select Count(0) NoOfStream, FV.FieldID, F.FieldName
                                                    From FieldValues FV Inner Join Fields F ON F.FieldID = FV.FieldID
                                                    Where FV.FieldID IN (101,95,96,96,97) AND (FV.[Data] = 'true' OR FV.[Data] != '')
                                                    Group By FV.FieldID, F.FieldName");
                }
                else
                {
                    sql = PetaPoco.Sql.Builder.Append(@"Select Count(0) NoOfStream, FV.FieldID, F.FieldName
                                                    From FieldValues FV Inner Join Fields F ON F.FieldID = FV.FieldID
                                                    Where FV.FieldID IN (2119,2120) AND (FV.[Data] = 'true' OR FV.[Data] != '' AND F.OrganizationID = @0)
                                                    Group By FV.FieldID, F.FieldName", organizationID);
                }
                return context.Fetch<NoOfStreamEntity>(sql);
            }
        }

        public List<StatisticsEntity> GetNoOfDelayedCasess(int organizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder
                    .Append(@"Select Count(0) CountNo, 'Delayed by Committee' ColumnName
                                From Applications A
                                Inner Join Approvals AP
                                On A.ApplicationID = AP.RowID
                                Where A.CreatedOn <= GetDate() - 7 AND 
                                AP.UserID IN (Select UserID From UserRoles Where RoleID = 2)
                                AND AP.IsDeleted IS NULL AND AP.StatusID = 4
                                AND AP.RowID NOT IN (Select RowID From Approvals Where UserID IN (Select UserID From UserRoles Where RoleID = 3) AND StatusID = 8)
                                AND A.OrganizationID=@0
                                Union All
                                Select Count(0) CountNo, 'Delayed By RS' ColumnName
                                From (
                                Select Count(0) Count, RowID 
                                From Approvals
                                Where RowID IN (
	                                Select ApplicationID From Applications A
	                                Where A.CreatedOn <= GetDate() - 7 AND A.OrganizationID=@0
                                ) 
                                AND StatusID = 8 AND UserID IN (Select UserID From UserRoles Where RoleID = 3)
                                AND IsDeleted IS NULL
                                AND RowID NOT IN (Select RowID From Approvals Where UserID IN (Select UserID From UserRoles Where RoleID = 4) AND StatusID = 8)
                                Group By RowID
                                Having Count(0) > 1) X
                                Union All
                                Select Count(0) CountNo, 'Delayed by Finance' ColumnName
                                From Applications A
                                Inner Join Approvals AP
                                On A.ApplicationID = AP.RowID
                                Where A.CreatedOn <= GetDate() - 7 AND A.OrganizationID=@0 AND 
                                AP.UserID IN (Select UserID From UserRoles Where RoleID = 4)
                                AND AP.IsDeleted IS NULL AND AP.StatusID = 8
                                AND AP.RowID NOT IN (Select RowID From Approvals Where OrganizationID IN (Select UserID From UserRoles Where RoleID = 7) AND StatusID = 9)", organizationID);
                return context.Fetch<StatisticsEntity>(sql);
            }
        }
        public List<StatisticsEntity> GetTotalAndConcludedApplicationss(int organizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder
                    .Append(@"Select Count(0) CountNo, 'Total No. of Applications' ColumnName From Applications Where OrganizationID=@0
                                Union All
                                Select Count(0) CountNo, 'Concluded Applications' ColumnName From Approvals A Inner Join Applications APP On A.RowID = APP.ApplicationID
                                Where StatusID = 9 AND APP.OrganizationID=@0", organizationID);
                return context.Fetch<StatisticsEntity>(sql);
            }
        }
        public List<AssignedFieldOfficerApplicationEntity> ApplicationAssignedToFieldOfficer(int userID,int organizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Append(@"Select 
	                                                A.ApplicationID,
                                                    (Select [Data] From FieldValues Where FieldID = 28 AND ApplicationID = A.ApplicationID) ApplicantName,
	                                                (Select [Data] From FieldValues Where FieldID = 30 AND ApplicationID = A.ApplicationID) CNIC,
	                                                (Select [Data] From FieldValues Where FieldID = 32 AND ApplicationID = A.ApplicationID) ContactNo,
	                                                A.CreatedOn,
	                                                U.FullName AssignedBy
                                                From Applications A 
                                                Inner Join Users U ON A.AdminID = U.UserID
                                                Where A.CreatedBy = @0 AND A.AdminID IS NOT NULL AND A.ApplicationID NOT IN (Select RowID From Approvals) AND A.OrganizationID=@1", userID, organizationID);
                return context.Fetch<AssignedFieldOfficerApplicationEntity>(sql);
            }
        }
        public void InsertNotification(Notification n)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Execute("INSERT INTO [Notifications] ([ToUserID],[CreatedBy],[Body],[Subject],[IsRead],[OrganizationID]) VALUES (@0,@1,@2,@3,@4,@5)", n.ToUserID, n.CreatedBy, n.Body, n.Subject, n.IsRead, n.OrganizationID);
            }
        }
        public List<Notification> GetNotifications(int userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Append("Select * from Notifications where ToUserID = @0 and IsRead = 0", userID);
                return context.Fetch<Notification>(sql).ToList();
            }
        }
        public void ReadNotification(int NotificationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Select("*").From("Notifications").Where("NotificationID = @0", NotificationID);
                Notification myN = context.Fetch<Notification>(sql).FirstOrDefault();
                myN.IsRead = 1;
                context.Update(myN);
            }
        }
        public List<DashboardStatusEntity> DashboardStatuses(int userID,int organizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder
                    .Append(@"Select *, 
	                        (CASE 
		                          WHEN Y.RoleName = 'Committee' AND StatusName = 'Approved' THEN 'Pending in RS'
		                          WHEN Y.RoleName = 'RS' AND StatusName = 'Approved' THEN 'Pending in Finance'
		                          WHEN Y.RoleName = 'Field Officer' AND StatusName = 'Submit' THEN 'Pending in Committee'
		                          WHEN Y.RoleName = 'Committee' AND StatusName = 'Rejected' THEN 'Rejected by Committee'
		                          WHEN Y.RoleName = 'RS' AND StatusName = 'Rejected' THEN 'Rejected by RS'
		                          WHEN Y.RoleName = 'Finance' AND StatusName = 'Rejected' THEN 'Rejected by Finance'
		                          WHEN Y.RoleName = 'Finance' AND StatusName = 'Completed' THEN 'Approved by Finance'
		                          WHEN Y.RoleName = 'CEO' AND StatusName = 'Approved' THEN 'Approved by CEO'
                                  WHEN Y.RoleName = 'CEO' AND StatusName = 'Rejected' THEN 'Rejected by CEO'
                            END) Status
                        From (
	                        Select 
		                        Count(0) StatusCount,
		                        S.StatusName,
		                        R.RoleName
	                        From (
		                        Select
			                        (Select Top 1 StatusID From Approvals Where RowID = A.ApplicationID Order By CreatedOn Desc) StatusID,
			                        (Select RoleID From UserRoles Where UserID = (Select Top 1 UserID From Approvals Where RowID = A.ApplicationID Order By CreatedOn Desc)) RoleID
	                        From Applications A 
	                        Where A.CreatedBy = @0 AND A.OrganizationID=@1) X
	                        Inner Join Statuses S
	                        On X.StatusID = S.StatusID
	                        Inner Join Roles R
	                        On X.RoleID = R.RoleID
	                        Group By S.StatusName, R.RoleName) 
                        Y", userID, organizationID);
                return context.Fetch<DashboardStatusEntity>(sql).ToList();
            }
        }
        public List<StatisticsEntity> GetDashboardStatistics(int organizationID,int? userID)
        {
            string whereClause = userID.HasValue ? string.Format("Where A.CreatedBy = {0} AND A.OrganizationID = {1}", userID.Value, organizationID) : string.Format("Where A.OrganizationID = {0}",organizationID);
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder
                    .Append(@"  Select Count(0) CountNo, 'No. of Applications' ColumnName From Applications A " + whereClause + @"
                                Union All
                                Select Count(0) CountNo, X.StatusName ColumnName From (
                                Select ROW_NUMBER() OVER(Partition By AP.RowID Order By AP.CreatedOn Desc) RankNo, AP.StatusID, S.StatusName From Applications A Inner Join Approvals AP On A.ApplicationID = AP.RowID Inner Join Statuses S On S.StatusID = AP.StatusID " + whereClause + @") X Where X.RankNo = 1 Group By X.StatusName
                                Union All
                                Select Count(0) CountNo, (CASE 
									WHEN RoleName = 'CEO' THEN StatusName + ' by CEO'
									WHEN RoleName = 'Committee' THEN StatusName + ' by Committee'
									WHEN RoleName = 'Field Officer' THEN StatusName + ' by Field Officer'
									WHEN RoleName = 'Finance' THEN (CASE WHEN StatusName = 'Approved' THEN 'Escalated' ELSE StatusName END) + ' by Finance'
									WHEN RoleName = 'RS' THEN StatusName + ' by RS'
								END) ColumnName From (
                                Select ROW_NUMBER() OVER(Partition By AP.RowID Order By AP.CreatedOn Desc) RankNo, AP.UserID, R.RoleName, S.StatusName From Applications A Inner Join Approvals AP On A.ApplicationID = AP.RowID Inner Join UserRoles UR On UR.UserID = AP.UserID Inner Join Roles R On R.RoleID = UR.RoleID
                                  Inner Join Statuses S On S.StatusID = AP.StatusID  " + whereClause + ") X Where X.RankNo = 1 Group By X.RoleName, X.StatusName");
                return context.Fetch<StatisticsEntity>(sql).ToList();
            }
        }

        public int GetNoOfApplications(string fromDate, string toDate, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Select(@"Count(0) NoOfApplications").From("Applications");
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    sql = sql.Where("CONVERT(date, CreatedON) BETWEEN @0 AND @1", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    sql = sql.Where("CreatedBy = @0", userID.Value);
                }
                return context.Fetch<int>(sql).FirstOrDefault();
            }
        }
        public List<NoOfApplicationsByUsersEntity> GetNoOfApplicationsByUsers(string fromDate, string toDate, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Select(@"Count(0) NoOfApplications, U.FullName, A.CreatedBy").From("Applications A")
                    .InnerJoin("Users U").On("U.UserID = A.CreatedBy");
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    sql = sql.Where("CONVERT(date, A.CreatedON) BETWEEN @0 AND @1", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    sql = sql.Where("A.CreatedBy = @0", userID.Value);
                }
                sql = sql.GroupBy("U.FullName, A.CreatedBy");
                return context.Fetch<NoOfApplicationsByUsersEntity>(sql);
            }
        }
        public List<StatusCountEntity> GetApplicationStatuses(string fromDate, string toDate, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                string whereClause = string.Empty;
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    whereClause = string.Format("and CONVERT(date, AP.CreatedON) BETWEEN '{0}' AND '{1}'", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    whereClause += string.Format("and AP.CreatedBy = {0}", userID.Value);
                }
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Append(@";With CTE AS (
                                                    Select Row_Number() Over(Partition By A.RowID Order By A.CreatedOn Desc) RankNo, 
                                                    S.StatusName
                                                    From Approvals A
                                                    Inner Join Applications AP ON AP.ApplicationID = A.RowID
                                                    Inner Join Statuses S
                                                    ON A.StatusID = S.StatusID where 1=1
                                                    " + whereClause + @"
                                                  )
                                                  Select Count(0) StatusCount, StatusName From CTE Where RankNo = 1 Group By StatusName");
                return context.Fetch<StatusCountEntity>(sql);
            }
        }
        public int PendingInFinance(string fromDate, string toDate, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                string whereClause = string.Empty;
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    whereClause = string.Format("CONVERT(date, AP.CreatedON) BETWEEN '{0}' AND '{1}' AND", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    whereClause += string.Format("AP.CreatedBy = {0} AND", userID.Value);
                }
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Append(@"Select Count(0) PendingInFinance From Approvals A Inner Join Applications AP ON A.RowID =                                           
                                                        AP.ApplicationID Where " + whereClause + @"  A.UserID IN (
                                                        Select UserID From ApprovalHierarchies 
                                                        Where ReportedTo IN (
                                                        Select UR.RoleID From Users U
                                                        Inner Join UserRoles UR
                                                        ON U.UserID = UR.UserID
                                                        Inner Join Roles R
                                                        ON UR.RoleID = R.RoleID
                                                        Where UR.RoleID = @0)) AND StatusID = 8 AND RowID NOT IN (Select RowID From Approvals Where                  
                                                        UserID IN (Select UserID From UserRoles Where RoleID = @0))", (short)RolesEnum.Finance);
                return context.Fetch<int>(sql).FirstOrDefault();
            }
        }
        public int InReviewOfCommittee(string fromDate, string toDate, int? userID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                string whereClause = string.Empty;
                if (!string.IsNullOrEmpty(fromDate) && !string.IsNullOrEmpty(toDate))
                {
                    whereClause = string.Format("CONVERT(date, AP.CreatedON) BETWEEN '{0}' AND '{1}' AND", fromDate, toDate);
                }
                if (userID.HasValue && userID.Value != 0)
                {
                    whereClause += string.Format("AP.CreatedBy = {0} AND", userID.Value);
                }
                PetaPoco.Sql sql;
                sql = PetaPoco.Sql.Builder.Append(@"Select Count(0) From Approvals A Inner Join Applications AP ON A.RowID = AP.ApplicationID
                                                    Where " + whereClause + @" A.UserID IN (
                                                    Select UserID From ApprovalHierarchies 
                                                    Where ReportedTo IN (
                                                    Select UR.RoleID From Users U
                                                    Inner Join UserRoles UR
                                                    ON U.UserID = UR.UserID
                                                    Inner Join Roles R
                                                    ON UR.RoleID = R.RoleID
                                                Where UR.RoleID = @0)) AND StatusID IN (8,4) AND RowID NOT IN (Select RowID From Approvals Where UserID IN (Select UserID From UserRoles Where RoleID = @0))", (short)RolesEnum.Committee);
                return context.Fetch<int>(sql).FirstOrDefault();
            }
        }
        public List<StatisticsEntity> GetNoOfDelayedCases()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder
                    .Append(@"Select Count(0) CountNo, 'Delayed by Committee' ColumnName
                                From Applications A
                                Inner Join Approvals AP
                                On A.ApplicationID = AP.RowID
                                Where A.CreatedOn <= GetDate() - 7 AND 
                                AP.UserID IN (Select UserID From UserRoles Where RoleID = 2)
                                AND AP.IsDeleted IS NULL AND AP.StatusID = 4
                                AND AP.RowID NOT IN (Select RowID From Approvals Where UserID IN (Select UserID From UserRoles Where RoleID = 3) AND StatusID = 8)
                                Union All
                                Select Count(0) CountNo, 'Delayed By RS' ColumnName
                                From (
                                Select Count(0) Count, RowID 
                                From Approvals
                                Where RowID IN (
	                                Select ApplicationID From Applications A
	                                Where A.CreatedOn <= GetDate() - 7
                                ) 
                                AND StatusID = 8 AND UserID IN (Select UserID From UserRoles Where RoleID = 3)
                                AND IsDeleted IS NULL
                                AND RowID NOT IN (Select RowID From Approvals Where UserID IN (Select UserID From UserRoles Where RoleID = 4) AND StatusID = 8)
                                Group By RowID
                                Having Count(0) > 1) X
                                Union All
                                Select Count(0) CountNo, 'Delayed by Finance' ColumnName
                                From Applications A
                                Inner Join Approvals AP
                                On A.ApplicationID = AP.RowID
                                Where A.CreatedOn <= GetDate() - 7 AND 
                                AP.UserID IN (Select UserID From UserRoles Where RoleID = 4)
                                AND AP.IsDeleted IS NULL AND AP.StatusID = 8
                                AND AP.RowID NOT IN (Select RowID From Approvals Where UserID IN (Select UserID From UserRoles Where RoleID = 7) AND StatusID = 9)");
                return context.Fetch<StatisticsEntity>(sql);
            }
        }
        public List<StatisticsEntity> GetTotalAndConcludedApplications()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder
                    .Append(@"Select Count(0) CountNo, 'Total No. of Applications' ColumnName From Applications
                                Union All
                                Select Count(0) CountNo, 'Concluded Applications' ColumnName From Approvals A Inner Join Applications APP On A.RowID = APP.ApplicationID
                                Where StatusID = 9");
                return context.Fetch<StatisticsEntity>(sql);
            }
        }

        public List<Organization> GetActiveOrganizations()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Append("Select * from Organizations where IsActive = 'true'");
                return context.Fetch<Organization>(sql).ToList();
            }
        }
      

        public void ActiveOrganization(int OrganizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                Organization obj = new Organization();
                obj.OrganizationID = OrganizationID;
                context.Execute("update Organizations Set IsActive = 'True' where OrganizationID = @0", OrganizationID);
                context.Execute("UPDATE Users SET StatusID = 1 WHERE OrganizationID = @0", OrganizationID);
            }
        }
        public void DeActiveOrganization(int OrganizationID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                Organization obj = new Organization();
                obj.OrganizationID = OrganizationID;
                context.Execute("update Organizations Set IsActive = 'False' where OrganizationID = @0", OrganizationID);
                context.Execute("UPDATE Users SET StatusID = 2 WHERE OrganizationID = @0", OrganizationID);
            }
        }

        public string AddCNICVerifications(int applicationID, string CNIC)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                CNICVerification cnicVerification = new CNICVerification();
                cnicVerification.ApplicationID = applicationID;
                cnicVerification.CNIC = CNIC;
                cnicVerification.RequestedOn = DateTime.Now;
                cnicVerification.StatusID = 11;
                context.Insert(cnicVerification);
                return "Please wait...";
            }
        }

        public bool RequestInProgress()
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var data = context.Fetch<CNICVerification>("Select * From CNICVerifications Where StatusID = 11");
                if(data != null && data.Count != 0)
                {
                    return true;
                }
                return false;
            }
        }
        public CNICVerification GetCNICVerification(int applicationID, string CNIC)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                return context.Fetch<CNICVerification>(
                string.Format(@"
                    Select StatusID, ResponseText, UpdatedOn From CNICVerifications Where ApplicationID = {0} AND CNIC = {1}
                ", applicationID, CNIC)).FirstOrDefault();
            }
        }
        public List<CNICVerification> GetCNICVerifications(short? statusID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                var sql = PetaPoco.Sql.Builder.Append(@"Select * From CNICVerifications");
                if (statusID.HasValue)
                {
                    sql = sql.Where("StatusID = @0", statusID);
                }
                return context.Fetch<CNICVerification>(sql);
            }
        }
        public string UpdateCNICVerification(int applicationID, string CNIC, string responseText, short statusID)
        {
            using (var context = DataContextHelper.GetCPDataContext())
            {
                context.Execute("Update CNICVerifications Set ResponseText = @0, StatusID = @1, UpdatedOn = @2 Where ApplicationID = @3 AND CNIC = @4", responseText, statusID, DateTime.Now, applicationID, CNIC);
                return "Success";
            }
        }
    }
    public class NoOfStreamEntity
    {
        public int NoOfStream { get; set; }
        public int FieldID { get; set; }
        public string FieldName { get; set; }

    }

    public class StatusCountEntity
    {
        public int StatusCount { get; set; }
        public string StatusName { get; set; }

    }

    public class NoOfApplicationsByUsersEntity
    {
        public int NoOfApplications { get; set; }

        public string FullName { get; set; }
        public int CreatedBy { get; set; }
    }

    public class ApplicationStatusesEntity
    {
        public int NoOfRecords { get; set; }
        public int StatusID { get; set; }
        public string StatusName { get; set; }
    }

    public class ApprovalListEntity
    {
        public int ApprovalID { get; set; }
        public int ApplicationID { get; set; }
        public short StatusID { get; set; }
        public DateTime CreatedOn { get; set; }
        public string Reason { get; set; }
        public string CreatedBy { get; set; }
        public string InitiallyCreatedBy { get; set; }
        public int UserID { get; set; }
        public string Status { get; set; }
        public string ApplicantName { get; set; }
        public string ContactNo { get; set; }
        public string CNIC { get; set; }
    }
    public class TemplateData
    {
        public short StatusID { get; set; }
        public short CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public string Reason { get; set; }
        public int UserID { get; set; }
        public string FieldOfficerRecommendation { get; set; }
        public string SourceOfIncome { get; set; }
        public string RSRecommendation { get; set; }
        public string FinanceAmount { get; set; }
    }
    public class ApplicationListEntity
    {
        public int ApplicationID { get; set; }
        public string ApplicantName { get; set; }
        public string CNIC { get; set; }
        public string ContactNo { get; set; }
        public string Reason { get; set; }
        public string Status { get; set; }
        public short? StatusID { get; set; }
        public string CreatedBy { get; set; }
        public string Enterprise { get; set; }
        public string IbrahimGoth { get; set; }
        public string MehranTown { get; set; }
        public string Latlng { get; set; }
        public string Ration { get; set; }
        public DateTime Date { get; set; }
        public int TotalItems { get; set; }
    }


    public class AssignedFieldOfficerApplicationEntity
    {
        public int ApplicationID { get; set; }
        public string ApplicantName { get; set; }
        public string CNIC { get; set; }
        public string ContactNo { get; set; }
        public DateTime CreatedOn { get; set; }
        public string AssignedBy { get; set; }
    }

    public class DashboardStatusEntity
    {
        public int StatusCount { get; set; }
        public string StatusName { get; set; }
        public string RoleName { get; set; }
        public string Status { get; set; }
    }
    public class StatisticsEntity
    {
        public int CountNo { get; set; }
        public string ColumnName { get; set; }
    }
}