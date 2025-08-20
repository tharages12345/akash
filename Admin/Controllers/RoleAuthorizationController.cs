namespace Admin.Controllers
{
    using System;
    using System.Data;
    using System.Linq;
    using Microsoft.AspNetCore.Mvc;
    using Newtonsoft.Json;
    using System.Net.Http;
    using System.Net.Http.Formatting;
    using System.Threading.Tasks;
    using System.Net.Http.Headers;
    using Microsoft.Extensions.Options;
    using Microsoft.AspNetCore.Http;
    using System.Collections.Generic;
    using System.IO;
    using Microsoft.AspNetCore.Hosting;
    using System.Net;
    using FluentValidation.Results;
    using JmeterPublish.Models;
    using Microsoft.AspNetCore.Mvc.Infrastructure;
    using Microsoft.AspNetCore.HttpOverrides;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.Logging;
    using System.Reflection;


    //This code generated from Deliveries Powered by Mahat, Source Machine : 15.206.208.9 , Build Number : Build 14092021 #2021-09-014(Updated on 29102021 12:49) on 08/17/2023 06:22:48



    public class RoleAuthorizationController : BaseController
    {

        private IWebHostEnvironment hostingEnv;
        private IOptions<ApiSettings> _balSettings;
        private IOptions<MailSettings> _mailSettings;
        private string url = "";
        private string baseUrl = "";
        private string adminUrl = "";
        private string clientUrl = "";
        private string accesskey = "";
        private IHttpContextAccessor _accessor;
        public IConfiguration Configuration { get; }
        private readonly ILogger<RoleAuthorizationController> _logger;

       
        public RoleAuthorizationController(IConfiguration configuration, IHttpContextAccessor accessor, IOptions<ApiSettings> ApiSettings, IOptions<MailSettings> MailSettings, IWebHostEnvironment env, ILogger<RoleAuthorizationController> logger) : base(configuration)
    {
            _logger = logger;
            this.hostingEnv = env;
            _balSettings = ApiSettings;
            _mailSettings = MailSettings;
            url = _balSettings.Value.apiURL;
            baseUrl = _balSettings.Value.baseURL;
            adminUrl = _balSettings.Value.adminURL;
            clientUrl = _balSettings.Value.clientURL;
            accesskey = _balSettings.Value.accesskey;

            _accessor = accessor;
            Configuration = configuration;

        }
        public virtual async Task<string> get_userrole()
        {
            return await ApiClient.Get_ApiValues(getHttpClient(), "api/RoleAuthorization/get_all_roles");
        }
        public virtual async Task<string> get_parentname()
        {
            return await ApiClient.Get_ApiValues(getHttpClient(), "api/RoleAuthorization/get_all_parentname");
        }

       


        public virtual async Task<string> prefill_RoleAuthorization_roleauthorized(string userrole)
        {
            return await ApiClient.Get_ApiValues(getHttpClient(), "api/RoleAuthorization/prefill_RoleAuthorization_roleauthorized?userrole=" + userrole + "&loginUserID=" + HttpContext.Session.GetString("JmeterPublishloginUserID"));

        }

        public virtual IActionResult Update_RoleAuthorization(string userrole)
        {
            RoleAuthorizationModel model = new RoleAuthorizationModel();
            if (userrole != "")
            {

                model.userrole = userrole; 
            }

            return View(model);
        }
        [HttpPost()]
        [RequestFormLimits(ValueCountLimit = int.MaxValue)]
        public virtual async Task<string> Update_RoleAuthorization(RoleAuthorizationModel model, IFormCollection collection)
        {
            string strReturnMessage = "";
            string userrole = Request.Query["userrole"];
            try
            {
                //ModelState.Remove("RoleAuthorizationid");
                ModelState.Remove("createduser");
                ModelState.Remove("craftmyapp_actionmethodname");
                model.craftmyapp_actionmethodname = "Update_RoleAuthorization";
                if (HttpContext.Session.GetString("JmeterPublishloginUserID") != null)
                    model.createduser = new Guid(HttpContext.Session.GetString("JmeterPublishloginUserID"));
                else
                    return "Session Expired";



                if (ModelState.IsValid)
                {
                    RoleAuthorizationModelValidator validator = new RoleAuthorizationModelValidator();
                    ValidationResult results = validator.Validate(model);
                    if (!results.IsValid)
                    {
                        var errorCollection = string.Join(" | ", results.Errors.Select(e => e.ErrorMessage.Replace("{propertyName}", e.PropertyName)));
                        strReturnMessage = errorCollection.ToString();
                        foreach (var failure in results.Errors)
                        {
                            ModelState.AddModelError(failure.PropertyName, failure.ErrorMessage);
                        }
                    }
                    else
                    {

                        strReturnMessage = await ApiClient.Post_ApiValuesGetString(getHttpClient(), "api/RoleAuthorization/Update_RoleAuthorization", model);
                    }
                }
                else
                {
                    var errorCollection = string.Join(" | ", ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage));
                    strReturnMessage = errorCollection.ToString();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError("Error occured in - RoleAuthorization / Update_RoleAuthorization , Error Message : " + ex.Message);
                Console.WriteLine(ex);
                strReturnMessage = ex.Message;
            }
            ViewData["message"] = strReturnMessage;
            if (strReturnMessage.Replace("\"", "").Contains("201.1"))
            {
                TempData["message"] = "Success";

                return "Success";
            }
            else
            {
                if (strReturnMessage == "401.1")
                    strReturnMessage = "Authorization Failed";

                return strReturnMessage;
            }

        }
        [HttpPost]
        public virtual async Task<string> Add_Role(AddRoleModel model)
        {
            string strReturnMessage = "";
            try
            {
                ModelState.Remove("rolesid");
                if (HttpContext.Session.GetString("JmeterPublishloginUserID") != null)
                    model.rolesid = new Guid(HttpContext.Session.GetString("JmeterPublishloginUserID"));
                else
                    return "Session Expired";

                strReturnMessage = await ApiClient.Post_ApiValuesGetString(getHttpClient(), "api/RoleAuthorization/Add_Role", model);

            }
            catch (Exception ex)
            {
                _logger.LogError("Error occured in - RoleAuthorization / Add_Role , Error Message : " + ex.Message);
                Console.WriteLine(ex);
                strReturnMessage = ex.Message;
            }
            ViewData["message"] = strReturnMessage;
            if (strReturnMessage.Replace("\"", "").Contains("201.1"))
            {
                TempData["message"] = "Success";

                return "Success";
            }
            else
            {
                if (strReturnMessage == "401.1")
                    strReturnMessage = "Authorization Failed";

                return strReturnMessage;
            }
        }

      
    }


}
