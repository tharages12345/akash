namespace JmeterPublish.Models{
			using System;
			using System.ComponentModel.DataAnnotations;
			using Microsoft.AspNetCore.Mvc;
			using System.Collections.Generic;
			using FluentValidation;
			using System.Linq;
			//This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:58
			public class MailLogsModel
			{

			 public System.Guid ?MailLogsid	{ get; set; }

[xssFilter]
public string entityname{ get; set; }

[xssFilter]
public string? entityid{ get; set; }

[xssFilter]
public string? mailfor{ get; set; }

[xssFilter]
public string? mailsubject{ get; set; }

[xssFilter]
public string? mailto{ get; set; }

[xssFilter]
public string? mailbody{ get; set; }

public bool issent	{ get; set; }
public System.Guid ?createduser	{ get; set; }
[DataType(DataType.Date)]
[ModelBinder(BinderType = typeof(DateTimeModelBinder))]
[DisplayFormat(DataFormatString="{0:dd/MM/yyyy}", ApplyFormatInEditMode=true)]
public System.DateTime ?createddate	{ get; set; }
public System.Guid ?modifieduser	{ get; set; }
[DataType(DataType.Date)]
[ModelBinder(BinderType = typeof(DateTimeModelBinder))]
[DisplayFormat(DataFormatString="{0:dd/MM/yyyy}", ApplyFormatInEditMode=true)]
public System.DateTime ?modifieddate	{ get; set; }
public bool isdeleted	{ get; set; }
[xssFilter]
                        [Required(ErrorMessage = "craftmyapp_actionmethodname is required,please pass current action name")]
                        public String craftmyapp_actionmethodname{ get; set; }



			}
			

			public class MailLogsModelValidator: AbstractValidator<MailLogsModel>
			{
					 
					public MailLogsModelValidator()
					{

						 When(model => model.craftmyapp_actionmethodname == "Create_MailLog", () =>
                                    {
                                        {RuleFor(m => m.entityname)
.NotEmpty().WithMessage("Entity Name is required")
.MaximumLength(128).WithMessage("The allowed length of Entity Name is 128 characters or fewer")
;






}

                                    });
When(model => model.craftmyapp_actionmethodname == "Update_MailLog", () =>
                                    {
                                        {RuleFor(m => m.entityname)
.NotEmpty().WithMessage("Entity Name is required")
.MaximumLength(128).WithMessage("The allowed length of Entity Name is 128 characters or fewer")
;






}

                                    });

						 
						
					}

			}

                

                

                
 

                  public class mailmodel
    {

     

        [xssFilter]
        public String mailsubject { get; set; }

        [xssFilter]
        public String mailto { get; set; }

        [xssFilter]
        public String mailbody { get; set; }

        [xssFilter]
        public String mailtoname { get; set; }


    }

                

			}
