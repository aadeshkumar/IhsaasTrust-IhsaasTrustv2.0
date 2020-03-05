using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using Framework.Application.Services;
using Framework.ControlPanel.CommonCode.Helpers;
using Framework.Shared;
using Framework.Shared.DataServices;
using Framework.Shared.Enums;

namespace Framework.ControlPanel.Controllers
{
    public class AuthenticationController : Controller //This will not be inhirited from Base 
    {
            public ActionResult Main()
            {
                return View();
            }

            public ActionResult Logout()
            {
            if (Request.UrlReferrer != null && Request.UrlReferrer.AbsolutePath.ToLower().Contains("/portal/application/create?applicationID="))
            {

            }
            Response.Cookies.Clear();
            Session.Clear();
            Session.RemoveAll();
            return View("Login");
        }
        public ActionResult Login()
        {
            if (Request.UrlReferrer != null && Request.UrlReferrer.AbsolutePath.ToLower().Contains("/portal/application/create?applicationID="))
            {

            }
            return View("Login");
        }

        [HttpPost]
        public JsonResult LoginJSON(FormUser form)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            string emailAddress = form.EmailAddress;
            string password = form.Password;
            string rememberMe = form.RememberMe;
            var user = AuthenticationServices.Instance.LoginUser(emailAddress, password.Encrypt());
            if (user != null)
            {
                user.RolesRights = AccountServices.Instance.GetUserRoleRights(user.UserID);
                user.UserOrganizations = AuthenticationServices.Instance.GetUserOrganizations(user.UserID);
                Session["User"] = user;
                if (Request.UrlReferrer != null && Request.UrlReferrer.AbsolutePath.ToLower().Contains("/portal/application/create?applicationID="))
                    result.Data = "Request.UrlReferrer";
                else if (user.UserOrganizations != null && user.UserOrganizations.Count > 1)
                    result.Data = "/portal/home/organizations/list";
                else
                    result.Data = "/portal/home/dashboard";
                if (rememberMe.ToLower() == "on" && user != null)
                {
                    HttpCookie userId = new HttpCookie(Authentication.UserID, user.UserID.ToString());
                    userId.Expires = Authentication.ExpireCookiesOn;
                    Response.Cookies.Set(userId);
                    var md5Hash = new HttpCookie(Authentication.MD5Hash, user.MD5Hash);
                    md5Hash.Expires = Authentication.ExpireCookiesOn;
                    Response.Cookies.Set(md5Hash);
                    var OrganizationID = new HttpCookie(Authentication.OrganizationID, user.OrganizationID.ToString());
                    OrganizationID.Expires = Authentication.ExpireCookiesOn;
                    Response.Cookies.Set(OrganizationID);
                }
            }
            else
            {
                Response.Status = "Login Failed, Please Try Again with correct User name and Password.";
                Response.StatusCode = 321;
                result.Data = "";
            }
            return result;
        }

        public JsonResult ForgetPassword(FormCollection form)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            string emailAddress = form["EmailAddress"];

            var user = AuthenticationServices.Instance.LoginUser(emailAddress);
            if (user != null)
            {
                result.Data = string.Format("Password is sent to your email address {0}.", user.Email);
            }
            else
            {
                Response.Status = "Login Failed, Please Try Again with correct User name and Password.";
                Response.StatusCode = 321;
                result.Data = "The Email address or the Login Name is not found in the system.";
            }
            return result;
        }



   
       

        [HttpPost]
        public JsonResult UploadFile()
        {
            string folderPath = Server.MapPath("~/uploads/");

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }
            HttpPostedFileBase file = Request.Files[0];
            if (file.ContentLength > 0)
            {
                var fileName = string.Format("{0}{1}", Guid.NewGuid(), Path.GetExtension(file.FileName));
                var path = Path.Combine(Server.MapPath("~/uploads/"), fileName);
                path = path.ToLower();
                file.SaveAs(path);
               
                var data = new
                {
                    file = "/uploads/" + fileName,
                    ext = Path.GetExtension(file.FileName).Replace(".", "")
                };
                return Json(data, JsonRequestBehavior.AllowGet);
            }
            return Json("No file uploaded!", JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult SendEmail(string OrganizationName, string RequestEmail, string subject, string message)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var senderEmail = new MailAddress("organizationkarachi@gmail.com", "Organization Karachi");
                    var receiverEmail = new MailAddress(RequestEmail, "RequestEmail");
                    var password = "Org.1234";
                    subject = "Confirmation For Subscription For your Portal";
                    message = "Your Email is your login ID & your password is 1234";

                    var smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com",
                        Port = 587,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        UseDefaultCredentials = false,
                        Credentials = new NetworkCredential(senderEmail.Address, password)
                    };
                    using (var mess = new MailMessage(senderEmail, receiverEmail)
                    {
                        Subject = subject,
                        Body = message
                    })
                    {
                        smtp.Send(mess);
                    }
                    return View("CheckEmail");
                }
            }
            catch (Exception ex)
            {

                ViewBag.Error = "Some Error";
            }
            return View("CheckEmail");
        }

        //[HttpPost]
        //public JsonResult CheckEmail(string Email)
        //{
        //    SubscriptionRequest org = new SubscriptionRequest();
        //    bool isValid = !org.RequestEmail.ToList().Exists(p => Equals(Email, StringComparison.CurrentCultureIgnoreCase));
        //    return Json(isValid);
        //}


        public class FormUser
        {
            public string EmailAddress { get; set; }
            public string Password { get; set; }
            public string RememberMe { get; set; }
        }

      
    }
}
