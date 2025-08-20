
namespace JmeterPublish.Models
{
    using System;
    using System.ComponentModel.DataAnnotations;
    using Microsoft.AspNetCore.Mvc;
    using System.Collections.Generic;
    using FluentValidation;
    using System.Linq;
    //This code generated from Deliveries Powered by Mahat, Source Machine : 15.206.208.9 , Build Number : Build 14092021 #2021-09-014(Updated on 29102021 12:49) on 08/17/2023 06:22:48
    public class RoleAuthorizationModel
    {

        public System.Guid? RoleAuthorizationid { get; set; }

        [xssFilter]
        public String userrole { get; set; }
        public String rolegroupname { get; set; }
        
        public string rolename { get; set; }
        public String clone { get; set; }
        public ICollection<RoleAuthorization_roleauthorizedModel> roleauthorized { get; set; }
        public System.Guid? createduser { get; set; }
        [DataType(DataType.Date)]
        [ModelBinder(BinderType = typeof(DateTimeModelBinder))]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public System.DateTime? createddate { get; set; }
        public System.Guid? modifieduser { get; set; }
        [DataType(DataType.Date)]
        [ModelBinder(BinderType = typeof(DateTimeModelBinder))]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public System.DateTime? modifieddate { get; set; }
        public bool isdeleted { get; set; }
        [xssFilter]
        [Required(ErrorMessage = "craftmyapp_actionmethodname is required,please pass current action name")]
        public String craftmyapp_actionmethodname { get; set; }



    }


    public class RoleAuthorizationModelValidator : AbstractValidator<RoleAuthorizationModel>
    {

        public RoleAuthorizationModelValidator()
        {

            When(model => model.craftmyapp_actionmethodname == "Add_Modify_Role_Authorizations", () =>
            {
                {
                }

            });
            When(model => model.craftmyapp_actionmethodname == "Update_Modify_Role_Authorizations", () =>
            {
                {
                }

            });

            RuleForEach(x => x.roleauthorized).SetValidator(new RoleAuthorization_roleauthorizedModelValidator());


        }

    }


    public class RoleAuthorization_roleauthorizedModel
    {



        public String roleauthorized { get; set; }


        public String controllername { get; set; }


        public String actionname { get; set; }


        public String actionmethodname { get; set; }


        public String viewname { get; set; }


        public String actiondisplayname { get; set; }


        public String viewactionroles { get; set; }

        public bool authorized { get; set; }
        public String craftmyapp_actionmethodname { get; set; }
        public String cma_client_row_id { get; set; }
        public System.Guid? RoleAuthorization_roleauthorizedid { get; set; }



    }


    public class RoleAuthorization_roleauthorizedModelValidator : AbstractValidator<RoleAuthorization_roleauthorizedModel>
    {

        public RoleAuthorization_roleauthorizedModelValidator()
        {

            When(model => model.craftmyapp_actionmethodname == "Add_Modify_Role_Authorizations", () =>
            {
                {
                }

            });
            When(model => model.craftmyapp_actionmethodname == "Update_Modify_Role_Authorizations", () =>
            {
                {
                }

            });


        }

    }

    public class AddRoleModel
    {
        [Required(ErrorMessage = "RolesID is Required")]
        public System.Guid rolesid { get; set; }


        public string rolename { get; set; }
        public string rolegroupname { get; set; }
        public string parentname { get; set; }

        public string clone { get; set; }

    }
    public class AddRoleModelValidator : AbstractValidator<AddRoleModel>
    {

        public AddRoleModelValidator()
        {

        }
    }

}
