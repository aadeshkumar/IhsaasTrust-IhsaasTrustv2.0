using Framework.Application.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Framework.ControlPanel.Controllers
{
    public class IhsaasAPIController : Controller
    {
        public JsonResult CNICVerification(int applicationID, string CNIC)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            try
            {
                if (!ApplicationServices.Instance.RequestInProgress())
                {
                    result.Data = new { Status = "Success", Response = ApplicationServices.Instance.AddCNICVerifications(applicationID, CNIC) };
                }
                else
                {
                    result.Data = new
                    {
                        Status = "Failed",
                        Response = "Can't proceed, if there's any request in progress."
                    };
                }
            }
            catch (Exception ex)
            {
                result.Data = "Failed to Verify due to " + ex.Message;
            }
            return result;
        }
        public JsonResult GetCNICVerification(int applicationID, string CNIC)
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            try
            {
                var data = ApplicationServices.Instance.GetCNICVerification(applicationID, CNIC);
                result.Data = new
                {
                    Status = data.StatusID == 11 ? "Please wait..." :
                data.StatusID == 12 ? "Verified" : "Invalid CNIC",
                    Response = data.ResponseText
                };
            }
            catch (Exception ex)
            {
                result.Data = "Failed to Verify due to " + ex.Message;
            }
            return result;
        }
        public JsonResult GetCNICVerifications()
        {
            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            try
            {
                var data = ApplicationServices.Instance.GetCNICVerifications(11);
                result.Data = data.Select(x => new
                {
                    CNIC = x.CNIC,
                    ApplicationID = x.ApplicationID
                });
            }
            catch (Exception ex)
            {
                result.Data = ex.Message;
            }
            return result;
        }
        [HttpPost]
        public JsonResult UpdateCNICVerifications(FormCollection form)
        {
            int applicationID = int.Parse(form["applicationID"]);
            string CNIC = form["CNIC"];
            string responseText = form["responseText"];
            short statusID = short.Parse(form["statusID"]);

            JsonResult result = new JsonResult();
            result.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
            try
            {
                var data = ApplicationServices.Instance.UpdateCNICVerification(applicationID, CNIC, responseText, statusID);
                result.Data = new { StatusMessage = data, StatusCode = 200 };
            }
            catch (Exception ex)
            {
                result.Data = new { StatusMessage = ex.Message, StatusCode = 500 };
            }
            return result;
        }
    }
}