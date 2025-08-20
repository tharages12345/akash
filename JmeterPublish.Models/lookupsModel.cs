namespace JmeterPublish.Models
								{
									using System.ComponentModel.DataAnnotations;
									using Microsoft.AspNetCore.Mvc;
									//This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:42
									public class lookupsModel
									{
										[Required(ErrorMessage="lookupid is Required")]
										public System.Guid lookupid	{ get; set; }
										public string entityname	{ get; set; }
										public string attributetype	{ get; set; }
										public string fieldname	{ get; set; }
										public string fielddesc	{ get; set; }
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
									}
								}
