namespace JmeterPublish.Models
								{
									using System;
									using System.ComponentModel.DataAnnotations;
									using Microsoft.AspNetCore.Mvc;
									//This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:42
									
										public class access_logsModel
										{

											public System.Guid? access_logsid { get; set; }


											public String users_id { get; set; }

											public System.DateTime? logged_date { get; set; }
											public System.DateTime? expiry_date { get; set; }

											[xssFilter]
											public String user_token { get; set; }

											[xssFilter]
											public String external_users_id { get; set; }

											[xssFilter]
											public String external_entity_name { get; set; }


											[xssFilter]
											public String latlan { get; set; }

											[xssFilter]
											public String clientipaddress { get; set; }


											[xssFilter]
											public String devicename { get; set; }

											[xssFilter]
											public String browsername { get; set; }


											[xssFilter]
											public String request_type { get; set; }


											[xssFilter]
											public String api_url { get; set; }

											[xssFilter]
											public String request_json { get; set; }

											[xssFilter]
											public String response_json { get; set; }





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
         
											

										}
                                        public class access_logsdetailsModel
										{

											public System.Guid? access_logsid { get; set; }
											[xssFilter]
											public String action_method_name { get; set; }
											[xssFilter]
											public String api_response { get; set; }


									    }


									 
								}
