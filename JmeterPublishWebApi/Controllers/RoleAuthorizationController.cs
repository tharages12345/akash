
namespace JmeterPublishWebApi.Controllers
{
    using System;
    using System.Data;
    using System.Linq;
    using Microsoft.AspNetCore.Mvc;
    using System.Collections.Generic;
    using Microsoft.Extensions.Options;
    using Microsoft.Extensions.Logging;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.Extensions.Configuration;
    using System.IdentityModel.Tokens.Jwt;
    using System.Security.Claims;
    using System.Text;
    using Microsoft.IdentityModel.Tokens;
    using JmeterPublish.Models;
    using JmeterPublish.DAL;
    using FluentValidation.Results;

    using Microsoft.AspNetCore.Hosting;
    using System.IO;
    using System.Net.Http.Headers;
    

    
    [Route("api/[controller]/[action]")]
    //This code generated from Deliveries Powered by Mahat, Source Machine : 15.206.208.9 , Build Number : Build 14092021 #2021-09-014(Updated on 29102021 12:49) on 08/17/2023 06:22:48
    public class RoleAuthorizationController : Controller
    {
        public RoleAuthorizationController(IOptions<ConnectionSettings> connectionSettings, ILoggerFactory loggerFactory, IConfiguration configuration, IWebHostEnvironment hostingEnvironment)
        {
            _configuration = configuration;
            _logger = loggerFactory.CreateLogger<RoleAuthorizationController>();
            _connectionSettings = connectionSettings;
            objRoleAuthorizationDAL = new RoleAuthorizationDAL(_connectionSettings.Value.ConnectionString);
            obj_External_System_DAL = new External_System_DAL(_connectionSettings.Value.ConnectionString);
            objExternalSystemUtitlity = new ExternalSystemUtility(_connectionSettings, _configuration);
            hostingEnv = hostingEnvironment;
        }
        private RoleAuthorizationDAL objRoleAuthorizationDAL;
        private External_System_DAL obj_External_System_DAL;
        private IOptions<ConnectionSettings> _connectionSettings;
        private ILogger _logger;
        private IConfiguration _configuration;
        private IWebHostEnvironment hostingEnv;
        private ExternalSystemUtility objExternalSystemUtitlity;


 [HttpGet()]
        [ActionName("prefill_RoleAuthorization_roleauthorized")]
        public virtual System.Data.DataTable prefill_RoleAuthorization_roleauthorized(string userrole)
        {
            DataTable dtPrefill = new DataTable();
            try
            {
                dtPrefill = objRoleAuthorizationDAL.prefill_RoleAuthorization_roleauthorized(userrole);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }
            return dtPrefill;


        }

        [HttpGet()]
        [ActionName("get_all_parentname")]
        public virtual System.Data.DataTable get_all_parentname()
        {
            DataTable dtPrefill = new DataTable();
            try
            {
                dtPrefill = objRoleAuthorizationDAL.get_all_parentname();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }
            return dtPrefill;

        }

        [HttpGet()]
        [ActionName("get_all_roles")]
        public virtual System.Data.DataTable get_all_roles()
        {
            DataTable dtPrefill = new DataTable();
            try
            {
                dtPrefill = objRoleAuthorizationDAL.get_all_roles();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
            }
            return dtPrefill;

        }
        [HttpPost()]
        [ActionName("Update_RoleAuthorization")]
        public virtual IActionResult Update_RoleAuthorization([FromBody] RoleAuthorizationModel model)
        {

            string message = "";
            access_logsdetailsModel obj_access_logsdetailsModel = new access_logsdetailsModel();
            obj_access_logsdetailsModel.action_method_name = "Update_RoleAuthorization";
            try
            {

                if (ModelState.IsValid)
                {

                    RoleAuthorizationModelValidator validator = new RoleAuthorizationModelValidator();
                    ValidationResult results = validator.Validate(model);
                    if (!results.IsValid)
                    {
                        var errorCollection = string.Join(" | ", results.Errors.Select(e => e.ErrorMessage.Replace("{propertyName}", e.PropertyName)));
                        message = ("Validation Error : " + errorCollection);


                    }
                    else
                    {

                        var authHeader = HttpContext.Request.Headers["Authorization"][0];
                        if (authHeader.StartsWith("Bearer "))
                        {
                            var token = authHeader.Substring("Bearer ".Length);
                            String[] userdetails = obj_External_System_DAL.get_users_by_token(token);
                            model.createduser = new Guid(userdetails[0].ToString());
                            obj_access_logsdetailsModel.access_logsid = new Guid(userdetails[1].ToString());




                            message = objRoleAuthorizationDAL.Update_RoleAuthorization(model);
                        }
                        else
                        {
                            message = "Invalid Token";
                        }

                    }


                }
                else
                {
                    var errorCollection = string.Join(" | ", ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage));
                    message = errorCollection.ToString();

                    _logger.LogError("RoleAuthorizationModel - Update_RoleAuthorization , Validation Error :" + message);
                    message = ("Validation Error : " + message);
                }






            }
            catch (Exception ex)
            {
                message = ex.Message;
                _logger.LogError(ex.Message);
                message = ("Exception : " + ex.Message);
            }

            obj_access_logsdetailsModel.api_response = message.Replace("\"", "");
            obj_External_System_DAL.create_access_logs_details(obj_access_logsdetailsModel);


            if (message.Replace("\"", "").Contains("201.1"))
                return Ok(message);
            else if (message.Replace("\"", "") == "401.1")
                return Unauthorized(message);
            else
                return BadRequest("DB Exception : " + message);
        }


        [HttpPost()]
        [ActionName("Add_Role")]
        public virtual IActionResult Add_Role([FromBody] AddRoleModel model)
        {
            string message = "";
            access_logsdetailsModel obj_access_logsdetailsModel = new access_logsdetailsModel();
            obj_access_logsdetailsModel.action_method_name = "Add_Role";
            try
            {

                if (ModelState.IsValid)
                {

                    AddRoleModelValidator validator = new AddRoleModelValidator();
                    ValidationResult results = validator.Validate(model);
                    if (!results.IsValid)
                    {
                        var errorCollection = string.Join(" | ", results.Errors.Select(e => e.ErrorMessage.Replace("{propertyName}", e.PropertyName)));
                        message = ("Validation Error : " + errorCollection);


                    }
                    else
                    {

                        var authHeader = HttpContext.Request.Headers["Authorization"][0];
                        if (authHeader.StartsWith("Bearer "))
                        {
                            var token = authHeader.Substring("Bearer ".Length);
                            String[] userdetails = obj_External_System_DAL.get_users_by_token(token);
                            model.rolesid = new Guid(userdetails[0].ToString());
                            obj_access_logsdetailsModel.access_logsid = new Guid(userdetails[1].ToString());




                            message = objRoleAuthorizationDAL.Add_Role(model);
                        }
                        else
                        {
                            message = "Invalid Token";
                        }

                    }


                }






            }
            catch (Exception ex)
            {
                message = ex.Message;
                _logger.LogError(ex.Message);
                message = ("Exception : " + ex.Message);
            }

            obj_access_logsdetailsModel.api_response = message.Replace("\"", "");
            obj_External_System_DAL.create_access_logs_details(obj_access_logsdetailsModel);


            if (message.Replace("\"", "").Contains("201.1"))
                return Ok(message);
            else if (message.Replace("\"", "") == "401.1")
                return Unauthorized(message);
            else
                return BadRequest("DB Exception : " + message);
        }

    }


}
