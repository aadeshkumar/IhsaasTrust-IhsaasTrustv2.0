using System;
using System.Collections.Generic;
using System.IO;
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
using System.Net.Mail;
using System.Threading.Tasks;
using System.Net;
using System.Net.Http;

namespace Framework.ControlPanel.Controllers
{
    public class ApplicationController : BaseController
    {
        #region Updated Queries For Organization

        //public async Task SendSMSs(string mobileno, string message)
        //{
        //    //var values = new Dictionary<string, string>
        //    //{
        //    // { "username", "923343380614" },
        //    // { "password", "5294" },
        //    // { "sender", "IhssasTrust" },
        //    // { "mobile", mobileno },
        //    // { "message", message }
        //    //};
        //    //var content = new FormUrlEncodedContent(values);
        //    //var response = await client.PostAsync("https://sendpk.com/api/sms.php", content);
        //    //var responseString = await response.Content.ReadAsStringAsync();
        //    var responseString = await client.GetStringAsync("https://sendpk.com/api/sms.php?username=923343380614&password=5294&sender=IhssasTrust&mobile='"+ mobileno + "&message=" + message);
        //}
        public async Task SendEmails(int FromUserID, string UserID, string Subject, string FieldOfficer, string ApplicantName, string CNIC, string ContactNo, int ApplicationID, short roleID, string Reason, int? EmailUserID, int? approvalRequest)
        {
            MailMessage mailMessage = new MailMessage();
            //int OrganizationID = Authentication.Instance.User.OrganizationID;
            //if (EmailUserID.HasValue)
            //{
            //    mailMessage.To.Add(string.Join(",", ApplicationServices.Instance.FindEmail(Convert.ToInt32(EmailUserID))));
            //    mailMessage.CC.Add("shahzeb.irshad@ihsaas.pk");
            //    mailMessage.From = new MailAddress("ihsaastrust@gmail.com");
            //    mailMessage.Subject = Subject;
            //    mailMessage.Body = ApplicationEmailBody(string.Empty, FieldOfficer, ApplicantName, CNIC, ContactNo, ApplicationID);
            //    mailMessage.IsBodyHtml = true;

            //    using (var smtpClient = new SmtpClient())
            //    {
            //        smtpClient.Host = "smtp.gmail.com";
            //        smtpClient.Port = 587;
            //        smtpClient.EnableSsl = true;
            //        smtpClient.Credentials = new System.Net.NetworkCredential("ihsaastrust@gmail.com", "ihsaas123@");
            //        await smtpClient.SendMailAsync(mailMessage);
            //    }
            //}
            //else
            {
                List<User> recipientUsers = new List<User>();
                if (EmailUserID.HasValue)
                {
                    recipientUsers = ApplicationServices.Instance.FindEmail(Convert.ToInt32(EmailUserID));
                }
                else
                {
                    if (approvalRequest.HasValue && approvalRequest.Value == 2)
                    {
                        var application = ApplicationServices.Instance.GetApplication(ApplicationID);
                        recipientUsers = ApplicationServices.Instance.FindEmail(application.CreatedBy.Value);
                    }
                    else if(approvalRequest.HasValue && approvalRequest.Value == 3)
                    {
                        recipientUsers.Add(new User() {
                            FullName = "Shahzeb Irshad", RecipientEmail = "shahzeb.irshad@ihsaas.pk", UserID = 39
                        });
                    }
                    else
                    {
                        recipientUsers = ApplicationServices.Instance.FindEmailsOfReportedTo(Convert.ToInt32(UserID));
                    }
                }
                foreach (var ru in recipientUsers)
                {
                    mailMessage.Subject = Subject;
                    mailMessage.Body = ApplicationEmailBody(ru.FullName, FieldOfficer, ApplicantName, CNIC, ContactNo, ApplicationID, roleID, Subject, Reason, approvalRequest);
                    Notification noti = new Notification();
                    noti.IsRead = 0;
                    noti.ToUserID = Convert.ToInt32(ru.UserID);
                    //noti.OrganizationID = Authentication.Instance.User.OrganizationID;
                    noti.Body = mailMessage.Body;
                    noti.Subject = mailMessage.Subject;
                    noti.CreatedBy = FromUserID;
                    ApplicationServices.Instance.InsertNotification(noti);
                    //mailMessage.To.Add(ru.RecipientEmail);
                    ////mailMessage.CC.Add("shahzeb.irshad@ihsaas.pk");
                    //mailMessage.From = new MailAddress("ihsaastrust@gmail.com");
                    
                   
                    //mailMessage.IsBodyHtml = true;
                   

                    
                    //using (var smtpClient = new SmtpClient())
                    //{
                    //    smtpClient.Host = "smtp.gmail.com";
                    //    smtpClient.Port = 587;
                    //    smtpClient.EnableSsl = true;
                    //    smtpClient.Credentials = new System.Net.NetworkCredential("ihsaastrust@gmail.com", "ihsaas123@");
                    //    await smtpClient.SendMailAsync(mailMessage);
                    //}
                }
            }
        }
        public JsonResult SendMail(string UserID, string Subject, string FieldOfficer, string ApplicantName, string CNIC, string ContactNo, int ApplicationID, short roleID, string Reason, int? EmailUserID, int? approvalRequest)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            try
            {
                int id = Authentication.Instance.User.UserID;
                var task = Task.Run(async () => await SendEmails(id,UserID, Subject, FieldOfficer, ApplicantName, CNIC, ContactNo, ApplicationID, roleID, Reason, EmailUserID, approvalRequest));
                result.Data = "success";
                
            }
            catch (Exception ex)
            {
                result.Data = new { Success = false, Message = ex.Message };
            }

            return result;
        }
        private static readonly HttpClient client = new HttpClient();
        public JsonResult SendSMS(string MessageText, string UserID, int? MobileUserID)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            try
            {
                SendSMSs(MessageText, UserID, MobileUserID);
            }
            catch (Exception ex)
            {
                result.Data = new { Success = false, Message = ex.Message };
            }

            return result;
        }
        public static string SendSMSs( string MessageText, string UserID, int? MobileUserID)
        {
            //var toNumber = ;
            ////if (MobileUserID.HasValue)
            ////{
            ////    toNumber = ApplicationServices.Instance.FindMobilesOfReportedTo(Convert.ToInt32(MobileUserID));
            ////}
            ////else
            ////{
            ////    toNumber = ApplicationServices.Instance.FindMobiles(Convert.ToInt32(UserID));
            ////}

            //String URI = "http://sendpk.com" +
            //"/api/sms.php?" +
            //"username=" +  +
            //"&password=" +  +
            //"&sender=" + "IhssasTrust" +
            //"&mobile=" + toNumber +
            //"&message=" + Uri.UnescapeDataString(MessageText); // Visual Studio 10-15 
            //try
            //{
            //    WebRequest req = WebRequest.Create(URI);
            //    WebResponse resp = req.GetResponse();
            //    var sr = new System.IO.StreamReader(resp.GetResponseStream());
            //    return sr.ReadToEnd().Trim();
            //}
            //catch (WebException ex)
            //{
            //    var httpWebResponse = ex.Response as HttpWebResponse;
            //    if (httpWebResponse != null)
            //    {
            //        switch (httpWebResponse.StatusCode)
            //        {
            //            case HttpStatusCode.NotFound:
            //                return "404:URL not found :" + URI;
            //                break;
            //            case HttpStatusCode.BadRequest:
            //                return "400:Bad Request";
            //                break;
            //            default:
            //                return httpWebResponse.StatusCode.ToString();
            //        }
            //    }
            //}
            return null;
        }
        public JsonResult UploadImage()
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            try
            {
                var imageURL = string.Empty;
                for (int i = 0; i < Request.Files.Count; i++)
                {
                    var file = Request.Files[i];
                    var fileName = Guid.NewGuid() + Path.GetExtension(file.FileName);
                    var path = Path.Combine(Server.MapPath("~/Content/images/"), fileName);
                    file.SaveAs(path);

                    imageURL += string.Format("/content/images/{0}", fileName) + "|-|";
                }
                result.Data = new { Success = true, ImageURL = imageURL };
            }
            catch (Exception ex)
            {
                result.Data = new { Success = false, Message = ex.Message };
            }
            return result;
        }
        public ActionResult Index(int? applicationID, bool edit = false)
        {
            int organizationID = Authentication.Instance.User.OrganizationID;
           
            ApplicationModel model = new ApplicationModel();
        
            if ((Request.UrlReferrer != null && Request.UrlReferrer.AbsolutePath.ToLower().Contains("application/approval")
                || Request.UrlReferrer != null && Request.UrlReferrer.AbsolutePath.ToLower().Contains("application/list"))
                && !(Authentication.Instance.User.RoleID == (short)RolesEnum.FieldWorker) && applicationID.HasValue)
            {
                model.ReadOnly = true;
            }

            bool isAdmin = Authentication.Instance.User.RoleID == (short)RolesEnum.Admin || ((Authentication.Instance.User.RoleID == (short)RolesEnum.CEO && !model.ReadOnly) || (Authentication.Instance.User.RoleID == (short)RolesEnum.HeadFieldWorker && !model.ReadOnly)) ? true : false;

            model.IsAdmin = isAdmin;
            model.ApplicationID = applicationID;
            model.Application = ApplicationServices.Instance.GetApplication(applicationID);
            model.FieldTypes = ApplicationServices.Instance.GetFieldTypes();
            model.Fields = ApplicationServices.Instance.GetFields(isAdmin, organizationID);
            model.FieldValues = ApplicationServices.Instance.GetFieldValues(applicationID);
            if (isAdmin || Authentication.Instance.User.RoleID == (short)RolesEnum.CEO || Authentication.Instance.User.RoleID == (short)RolesEnum.HeadFieldWorker)
            {
                model.FieldWorkers = AccountServices.Instance.GetFieldWorkers(organizationID);
            }

            return View("Index", model);
            
        }
        public JsonResult UpdateApplication(string Data, int FieldID, int ApplicationID)
        {
            JsonResult result = new JsonResult();
            string message = string.Empty;
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            Shared.DataServices.Application application = new Shared.DataServices.Application();

            try
            {
                ApplicationServices.Instance.UpdateFieldValues(Data, FieldID, ApplicationID);
            }
            catch (Exception ex)
            {
                message = string.Format("Unable to create fields value, reason: {0}", ex.Message);
            }
            result.Data = message;
            return result;
        }
        public JsonResult SaveUpdateApplication(FormCollection form)
        {
            JsonResult result = new JsonResult();
            int organizationID = Authentication.Instance.User.OrganizationID;
            string message = string.Empty;
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            Shared.DataServices.Application application = new Shared.DataServices.Application();
            int userID = Authentication.Instance.User.UserID;
            int? fieldWorkerID = form["FieldWorkerID"] != null ? (int?)int.Parse(form["FieldWorkerID"]) : (int?)null;
            int? adminID = (int?)null;
            bool enterprise = !string.IsNullOrEmpty(form["fv0_fid1119"]) ? bool.Parse(form["fv0_fid1119"]) : false;
            if (fieldWorkerID.HasValue)
            {
                userID = fieldWorkerID.Value;
                adminID = Authentication.Instance.User.UserID;
            }
            List<FieldValue> fieldValues = new List<FieldValue>();
            List<FieldValue> newfieldValues = new List<FieldValue>();
            int applicationID = 0;
            try
            {
                var cnicExist = false;
                var contactNoExist = false;
                var EndDate = DateTime.Now;
                int cnicDays=0,contactDays=0;
                string cnic = form["fv0_fid30"] != null ? form["fv0_fid30"] : string.Empty;
                if (!string.IsNullOrEmpty(cnic))
                {
                    cnicExist = ApplicationServices.Instance.IsApplicationUserExist(30, cnic);
                    cnicDays = (EndDate.Date - ApplicationServices.Instance.IsApplicationUserExistCreatedOn(30, cnic).Date).Days;
                }

                string contactNo = form["fv0_fid32"] != null ? form["fv0_fid32"] : string.Empty;
                if (!string.IsNullOrEmpty(contactNo))
                {
                    contactNoExist = ApplicationServices.Instance.IsApplicationUserExist(32, contactNo);
                    contactDays = (EndDate.Date - ApplicationServices.Instance.IsApplicationUserExistCreatedOn(32, contactNo).Date).Days;
                }
                if (Authentication.Instance.User.RoleID != (short)RolesEnum.CEO)
                {
                    if ((cnicExist || contactNoExist) && (cnicDays < 91 || contactDays < 91))
                    {
                        result.Data = new { Message = "Unable to create application, reason: CNIC/Contact No. already exist", Failed = true };
                        return result;
                    }
                }

                bool IsDeleted=false;
                foreach (var key in form.Keys)
                {
                    if (key.ToString() == "ApplicationID")
                    {
                        applicationID = int.Parse(form[key.ToString()]);
                        if (applicationID == 0)
                        {
                            application.OrganizationID = organizationID;
                            application.CreatedBy = userID;
                            application.CreatedOn = DateTime.Now;
                            application.ApplicationCode = "AppCode-" + DateTime.Now.ToString("yyyyMMddhhmmss");
                            application.Date = DateTime.Now;
                            application.AdminID = adminID;
                            application.IsActive = true;
                        }
                        else
                        {
                            if (ApplicationServices.Instance.RejectionStatus(applicationID) && Authentication.Instance.User.RoleID==2)
                            {
                                IsDeleted = true;
                            }
                            if (Authentication.Instance.User.RoleID == (short)RolesEnum.HeadFieldWorker)
                            {
                                application.CreatedBy = userID;
                            }
                            application.ApplicationID = applicationID;
                            application.ModifiedBy = userID;
                            application.CreatedBy = userID;
                            application.ModifiedOn = DateTime.Now;
                        }
                        ApplicationServices.Instance.SaveUpdateApplication(application, userID, adminID.HasValue ? true : false, (application.CreatedBy.HasValue && application.CreatedBy.Value != 0) ? true : false, IsDeleted, enterprise);
                        applicationID = application.ApplicationID;
                    }
                }
            }
            catch (Exception ex)
            {
                message = string.Format("Unable to create application, reason: {0}", ex.Message);
                result.Data = new { Message = message, Failed = true };
                return result;
            }
            try
            {
                foreach (var key in form.Keys)
                {
                    if (key.ToString().Contains("fv") && key.ToString().Contains("fid") && !key.ToString().Contains("fid108"))
                    {
                        string[] fv = key.ToString().Replace("fv", "").Replace("fid", "").Split('_');
                        int fieldValueID = int.Parse(fv[0]);
                        int fieldID = int.Parse(fv[1]);
                        string data = form[key.ToString()];
                        if (fieldValueID == 0)
                        {
                            fieldValues.Add(new FieldValue
                            {
                                ApplicationID = applicationID,
                                Data = data,
                                FieldValueID = fieldValueID,
                                FieldID = fieldID,
                                CreatedBy = userID,
                                CreatedOn = DateTime.Now
                            });
                        }
                        else
                        {
                            //if (ApplicationServices.Instance.RejectionStatus(applicationID))
                            //{
                            //    fieldValues.Add(new FieldValue
                            //    {
                            //        FieldValueID = fieldValueID,
                            //        IsDeleted = true
                            //    });


                            //    newfieldValues.Add(new FieldValue
                            //    {
                            //        ApplicationID = applicationID,
                            //        Data = data,
                            //        FieldValueID = fieldValueID,
                            //        FieldID = fieldID,
                            //        CreatedBy = userID,
                            //        CreatedOn = DateTime.Now
                            //    });
                            //}
                            //else
                            //{
                                fieldValues.Add(new FieldValue
                                {
                                    ApplicationID = applicationID,
                                    Data = data,
                                    FieldValueID = fieldValueID,
                                    FieldID = fieldID,
                                    ModifiedBy = userID,
                                    ModifiedOn = DateTime.Now
                                });
                            //}
                        }
                    }
                }
                
                ApplicationServices.Instance.SaveUpdateFieldValues(fieldValues, ref message);
                //ApplicationServices.Instance.SaveFieldValues(newfieldValues);
            }
            
            catch (Exception ex)
            {
                //message = string.Format("Unable to create fields value, reason: {0}", ex.Message);
                //result.Data = new { Message = message, Failed = true };
                //return result;
            }
            result.Data = new { ApplicationID = applicationID, Message = message };
            return result;
        }
        public JsonResult DeleteApplication(int applicationID)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            try
            {
                ApplicationServices.Instance.DeleteApplication(applicationID);
            }
            catch (Exception ex)
            {
                result.Data = string.Format("Unable to delete application, reason: {0}", ex.Message);
            }
            result.Data = "Success";
            return result;
        }
        public ActionResult List(string applicantName, string cnic, string contactNo, string Latlng, string enterprise, string date, short? statusID, short? searchRoleID, int? pageNo, int? pageSize)
        {
            ApplicationListModel model = new ApplicationListModel();
            int userID = Authentication.Instance.User.UserID;
            int roleID = Authentication.Instance.User.RoleID;
            int organizationID = Authentication.Instance.User.OrganizationID;
            string whereClause = string.Empty;
            if (roleID == (short)RolesEnum.FieldWorker)
            {
                whereClause = " AND APP.CreatedBy = " + userID;
            }
            model.ApplicantName = applicantName;
            model.CNIC = cnic;
            model.ContactNo = contactNo;
            model.Enterprise = enterprise;
            model.Latlng = Latlng;
            pageNo = pageNo ?? 1;
            pageSize = pageSize ?? 10;
            model.PageNo = pageNo.Value;
            model.PageSize = pageSize.Value;
            model.OrganizationID = organizationID;
            model.Applications = ApplicationServices.Instance.GetApplication(applicantName, cnic, contactNo, whereClause, statusID, searchRoleID, enterprise, date, organizationID, pageNo, pageSize);
            if (Request.IsAjaxRequest())
            {
                return PartialView("_List", model);
            }
            return View("List", model);
        }

        public ActionResult RationList(string applicantName, string cnic, string contactNo, string enterprise, string Ration,string date, short? statusID, short? searchRoleID)
        {
            ApplicationListModel model = new ApplicationListModel();
            int userID = Authentication.Instance.User.UserID;
            int roleID = Authentication.Instance.User.RoleID;
            int organizationID = Authentication.Instance.User.OrganizationID;
            string whereClause = string.Empty;
            if (roleID == (short)RolesEnum.FieldWorker)
            {
                whereClause = " AND APP.CreatedBy = " + userID;
            }
            model.ApplicantName = applicantName;
            model.CNIC = cnic;
            model.ContactNo = contactNo;
            model.Ration = Ration;
            model.Enterprise = enterprise;
            
            model.Applications = ApplicationServices.Instance.GetApplications(applicantName, cnic, contactNo, whereClause, statusID, searchRoleID, enterprise, date, organizationID);
            if (Request.IsAjaxRequest())
            {
                return PartialView("_RationList", model);
            }
            return View("RationList", model);
        }


        public ActionResult Approval()
        {
            ApprovalModel model = new ApprovalModel();
            int userID = Authentication.Instance.User.UserID;
            int organizationID = Authentication.Instance.User.OrganizationID;
            bool isEscalated = Authentication.Instance.User.RoleID == (short)RolesEnum.CEO ? true : false;
            model.ApprovalList = ApplicationServices.Instance.GetApprovalApplications(userID, organizationID, isEscalated);
            model.Statuses = ApplicationServices.Instance.GetStatuses();
            model.CEO = ApplicationServices.Instance.GetCEO(organizationID);
            //model.CNICVerifications = ApplicationServices.Instance.GetCNICVerifications((short?)null);
            return View("Approval", model);
        }
        #endregion

        public JsonResult GetRecommendedRation(int noOfPersons)
        {
            List<string> names = new List<string>();
            names.Add("Amount");
            Dictionary<string, object> search = new Dictionary<string, object>();
            search.Add("NoOfPerson", noOfPersons);
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            try
            {
                result.Data = CommonServices.Instance.GetTableSingleRecord("RationAmounts", names, search)["Amount"];
            }
            catch (Exception e)
            {
                result.Data = 0;
            }
            return result;
        }

        #region Updated Queries For Organization
        public JsonResult ApprovalStatus(int applicationID, short statusID, string reason, int? escalateTo, int? amount, string recommendation)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            string message = string.Empty;
            bool isEscalated = escalateTo.HasValue ? true : false;

            bool Amount = amount.HasValue ? true : false;

            int userID = Authentication.Instance.User.UserID;
            try
            {
                if (Amount)
                {
                    ApplicationServices.Instance.InsertFieldValues(userID, applicationID, amount.ToString(), 117);
                }
                ApplicationServices.Instance.SaveApproval(userID, applicationID, statusID, isEscalated, reason);
                if (recommendation != null)
                {
                    ApplicationServices.Instance.InsertFieldValues(userID, applicationID, recommendation, 108);
                }
                //if(escalateTo.HasValue)
                //{
                //    ApplicationServices.Instance.SaveApproval(escalateTo.Value, applicationID, statusID, isEscalated, reason);
                //}
                message = "success";
            }
            catch (Exception ex)
            {
                message = "Unable to approve application due to " + ex.Message;
            }
            result.Data = message;
            return result;
        }
        [HttpPost]
        public JsonResult UploadFile(HttpPostedFileBase file)
        {
            
            var abc = Authentication.Instance.User.OrganizationID;

            string folderPath = Server.MapPath("~/Application/" + abc+"//");

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            if (file.ContentLength > 0)
            {
                var fileName = string.Format("{0}{1}", Guid.NewGuid(), Path.GetExtension(file.FileName));
                var path = Path.Combine(Server.MapPath("~/Application/" + abc + "//"), fileName);
                path = path.ToLower();
                file.SaveAs(path);

                var data = new
                {
                    file = "/Application/" + abc + "//" + fileName,
                    ext = Path.GetExtension(file.FileName).Replace(".", "")
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return Json("No file uploaded!", JsonRequestBehavior.AllowGet);
        }

        public ActionResult ActiveOrganization(int OrganizationID)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            string message = string.Empty;
            try
            {
                ApplicationServices.Instance.ActiveOrganization(OrganizationID);
               

            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            result.Data = message;
            return result;
        }

        public ActionResult DeActiveOrganization(int OrganizationID)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            string message = string.Empty;
            try
            {
                ApplicationServices.Instance.DeActiveOrganization(OrganizationID);


            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            result.Data = message;
            return result;
        }

        public string ApplicationEmailBody(string fullName, string fieldOfficer, string applicantName, string cnic, string contactNo, int applicationID, short roleID, string subject, string reason, int? approvalRequest)
        {
            string approval = string.Empty;
            //if(roleID == (short)RolesEnum.FieldWorker)
            {
                approval = @"<hr />
                             <p><strong>Application Approval:</strong></p>
                             <p>
                                 Click here to Approve Application: <a style='color:#ffffff;' href='http://www.ihsaas.com.pk/portal/application/approval' target='_blank'>Link</a><br />
                             </p>";
            }
            if (!string.IsNullOrEmpty(reason))
            {
                reason = "<br/>Reason: " + reason;
            }
            string html = @"<html>
                            <head>
                                <title>Ihsaas Trust Notification</title>
                            </head>
                            <body>
                                <div style='background:#194482;color:#ffffff;margin:auto;height:550px;width:500px;border-radius:15px;'>
                                    <div style='background:#194482;color:#ffffff;margin:auto;height:80px;width:500px;border-bottom:1px solid #ffffff;border-radius:15px;'>
                                        <div style='float:left'>
                                            <img src='http://www.ihsaas.com.pk/assets/dist/img/logo.png' style='width:75px;height:75px;' />
                                        </div>
                                        <div style='float:left;padding-left:30px;'>
                                            <h1>Ihsaas Trust Notification</h1>
                                        </div>
                                    </div>
                                    <div style='background:#3C8DBC;color:#ffffff;margin:auto;height:420px;width:500px;border-bottom:1px solid #ffffff;border-radius:15px;'>
                                        <div style='width:400px;margin:auto;padding-top:10px;'>
                                            <h3>Hi " + fullName + @"!</h3>
                                            <hr />
                                            <p>" + subject + @" by " + fieldOfficer + @" at "+ DateTime.Now.ToString("MMMM, dd-MMM-yyyy, hh:mm:ss") + @"</p>
                                            <hr />
                                            <p><strong>Application Summary:</strong></p>
                                            <p>
                                              
                                                Applicant Name: " + applicantName + @"<br />
                                                CNIC: " + cnic + @"<br />
                                                Contact No.: " + contactNo + @"<br />
                                                Application: <a style='color:#ffffff;' href='http://www.ihsaas.com.pk/portal/application/create?applicationID=" + applicationID + @"' target='_blank'>Link</a> "+ reason + @"
                                            </p>
                                           "+ approval + @"
                                            <hr />
                                            <p>Thank You!</p>
                                        </div>
                                    </div>
                                    <div>
                                        <p style='text-align:center;'>Copyright © 2020 IHSAAS TRUST PORTAL All rights reserved.</p>
                                    </div>
                                </div>
                            </body>
                            </html>";
            return html;
        }
        #endregion
    }
}