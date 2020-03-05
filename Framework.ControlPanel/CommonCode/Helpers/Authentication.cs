using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Framework.Application.Services;
using Framework.Shared.DataServices;

namespace Framework.ControlPanel.CommonCode.Helpers
{
    #region SSO Cookie(s)
    //public class Authentication
    //{
    //    #region Define as Singleton

    //    private static Authentication _Instance;

    //    public static Authentication Instance
    //    {
    //        get
    //        {
    //            if (_Instance == null)
    //            {
    //                _Instance = new Authentication();
    //            }
    //            return (_Instance);
    //        }
    //    }

    //    private Authentication()
    //    {
    //        //  HttpContext.Current.Session["LastErrorAuthorization"] = "";
    //    }
    //    #endregion
    //    //public const string UserID = "BarNo";
    //    //public const string MD5Hash= "BarHash";

    //    #region SSOCookie

    //    public static DateTime ExpireCookiesOn
    //    {
    //        get
    //        {
    //            return DateTime.Now.AddDays(4);
    //        }
    //    }

    //    public void AddAuthenticationCookie(UserEntity user, DateTime cookieExpiryDate)
    //    {
    //        SSOCookieHelper.AddSSOCookie(user.UserID, user.Email, cookieExpiryDate, user.UniqueID);
    //    }

    //    public void ExpireAuthenticationCookie()
    //    {
    //        SSOCookieHelper.ExpireSSOCookie();
    //    }

    //    public bool ValidateAuthenticationCookie()
    //    {
    //        return SSOCookieHelper.ValidateSSOCookie();
    //    }

    //    public bool AuthenticateUserFromSSOCookie()
    //    {
    //        bool userAuthenticatedFromSSOCookie = false;

    //        ResetSession();

    //        if (ValidateAuthenticationCookie())
    //        {
    //            int userID = SSOCookieHelper.GetUserIDFromSSOCookie();
    //            Guid? userGuid = SSOCookieHelper.GetUserLoginIDFromSSOCookie();
    //            string uniqueID = userGuid.HasValue ? userGuid.Value.ToString() : string.Empty;

    //            //uncomment following code (if and else as well) if multiple machine logins are not allowed for CP
    //            //if (UserRoleRightHelper.VerifyLogin(userID, uniqueID))
    //            //{
    //            /*User is verified upto this point, now check if it is ArgaamPlusCP user or not. If not 
    //              then do not allow the user to enter the CP site.
    //            */
    //            var user = AuthenticationServices.Instance.LoginUser(Authentication.Instance.User.UserID);
    //            user.RolesRights = AccountServices.Instance.GetUserRoleRights(user.UserID);

    //            if (user != null)
    //            {
    //                HttpContext.Current.Session["User"] = user;
    //                userAuthenticatedFromSSOCookie = true;

    //                //Uncomment this if need to update the cookie everytime user is authenticated from existing cookie
    //                //AddAuthenticationCookie(user, Authentication.ExpireCookiesOn);

    //            } /* do not expire authenticationcookie in this case as if the user is coming from sites 
    //                  * other than ArgaamPlusCP (e.g. ArgaamPlusPP, ArgaamPP, ArgaamCP, akhbaarPP, akhbaarCP etc), 
    //                  * then the user will be loggedout from those sites as well which is not correct behaviour.
    //                  */
    //              //}
    //              //else 
    //              //{
    //              //Decide here if you want to remove ssocookie or not, as if you will remove sso cookie then the users 
    //              //which are logged in on other websites on the same machine will also become logout as ssocookie is removed.
    //              //ExpireAuthenticationCookie();
    //              //}
    //        }
    //        else //expire AuthenticationCookie as it is not validated.
    //        {
    //            ExpireAuthenticationCookie();
    //        }

    //        return userAuthenticatedFromSSOCookie;
    //    }
    //    #endregion

    //    public void ResetSession()
    //    {
    //        HttpContext.Current.Session.Clear();
    //        if (HttpContext.Current.Session.Keys.Count > 0)
    //        {
    //            HttpContext.Current.Session["User"] = null;
    //            HttpContext.Current.Session["Menu"] = null;
    //        }
    //    }

    //    public void AbandonSession()
    //    {
    //        HttpContext.Current.Session.Abandon();
    //    }

    //    public void Logout()
    //    {
    //        //Response.Cookies.Clear();
    //        //ResetSession();
    //        //ExpireCookies();
    //        //SSOCookieHelper.ExpireSSOCookie();

    //        ExpireAuthenticationCookie();

    //        if (HttpContext.Current.Session.Keys.Count > 0)
    //        {
    //            ResetSession();
    //        }
    //    }

    //    public UserEntity User
    //    {
    //        get
    //        {
    //            /* no need for this check as it will be too much to authenticate user from cookie every time 
    //             * this property is called and this property is being called extensively at many places
    //            if (HttpContext.Current.Session["User"] == null)
    //            {
    //                AuthenticateUserFromSSOCookie();
    //            }
    //             */
    //            return (UserEntity)HttpContext.Current.Session["User"];
    //        }
    //        set
    //        {
    //            HttpContext.Current.Session["User"] = value;
    //        }
    //    }

    //    public bool IsLoggedIn
    //    {
    //        get
    //        {
    //            return (HttpContext.Current.Session["User"] != null);

    //        }
    //    }
    //    public string LastSecurityError
    //    {
    //        get
    //        {
    //            if (HttpContext.Current.Session["LastErrorAuthorization"] == null)
    //            {
    //                HttpContext.Current.Session["LastErrorAuthorization"] = new Queue<string>();
    //            }
    //            Queue<string> queue = (Queue<string>)HttpContext.Current.Session["LastErrorAuthorization"];
    //            if (queue.Count > 0)
    //                return queue.Dequeue();
    //            return "";
    //        }
    //        set
    //        {
    //            if (HttpContext.Current.Session["LastErrorAuthorization"] == null)
    //            {
    //                HttpContext.Current.Session["LastErrorAuthorization"] = new Queue<string>();
    //            }
    //            Queue<string> queue = (Queue<string>)HttpContext.Current.Session["LastErrorAuthorization"];
    //            queue.Enqueue(value);
    //        }
    //    }

    //}
    #endregion
    public class Authentication
    {
        #region Define as Singleton

        public static Authentication Instance
        {
            get
            {
                return new Authentication();
            }
        }

        private Authentication()
        {
            HttpContext.Current.Session["LastErrorAuthorization"] = "";
        }
        #endregion
        public const string UserID = "BarNo";
        public const string MD5Hash = "BarHash";
        public const string OrganizationID = "HashNo";

        public static DateTime ExpireCookiesOn
        {
            get
            {
                return DateTime.Now.AddDays(4);
            }
        }
        public UserEntity User
        {
            get
            {
                if (HttpContext.Current.Session["User"] == null)
                {
                    if (HttpContext.Current.Request.Cookies[UserID] != null && HttpContext.Current.Request.Cookies[MD5Hash] != null)
                    {
                        int userId = int.Parse(HttpContext.Current.Request.Cookies[UserID].Value);
                        string md5 = HttpContext.Current.Request.Cookies[MD5Hash].Value;
                        var user = AuthenticationServices.Instance.LoginUser(userId, md5);
                        HttpContext.Current.Session["User"] = user;
                        return user;
                    }
                    return null;
                }
                return (UserEntity)HttpContext.Current.Session["User"];
            }
            set
            {
                HttpContext.Current.Session.Add("User", value);
            }
        }
        public bool IsLoggedIn
        {
            get
            {
                if (HttpContext.Current.Session["User"] == null)
                {
                    if (HttpContext.Current.Request.Cookies[UserID] != null && HttpContext.Current.Request.Cookies[MD5Hash] != null)
                    {
                        return true;
                    }
                    else if (Authentication.Instance.User != null)
                    {
                        var user = AuthenticationServices.Instance.LoginUser(Authentication.Instance.User.UserID);
                        user.RolesRights = AccountServices.Instance.GetUserRoleRights(user.UserID);
                        HttpContext.Current.Session["User"] = user;
                        return true;
                    }
                    return false;
                }
                return true;                
            }
        }

        /// <summary>
        /// Comma Seperated List of User Assigned Roles
        /// </summary>
        public string UserRoles
        {
            get
            {
                return "Admin";//
            }
        }
        public string LastSecurityError
        {
            get
            {
                if (HttpContext.Current.Session["LastErrorAuthorization"] == null)
                {
                    HttpContext.Current.Session["LastErrorAuthorization"] = new Queue<string>();
                }
                Queue<string> queue = (Queue<string>)HttpContext.Current.Session["LastErrorAuthorization"];
                if (queue.Count > 0)
                    return queue.Dequeue();
                return "";
            }
            set
            {
                if (HttpContext.Current.Session["LastErrorAuthorization"] == null)
                {
                    HttpContext.Current.Session["LastErrorAuthorization"] = new Queue<string>();
                }
                Queue<string> queue = (Queue<string>)HttpContext.Current.Session["LastErrorAuthorization"];
                queue.Enqueue(value);
            }
        }
        public object Session { get; private set; }
    }
}