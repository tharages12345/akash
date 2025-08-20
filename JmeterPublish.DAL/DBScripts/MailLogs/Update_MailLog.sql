
			  CREATE OR REPLACE FUNCTION  "Update_MailLog"
			  (
				  pvar_MailLogsid uuid
,
pvar_entityname Varchar(128)
,
pvar_entityid Varchar(128)
,
pvar_mailfor Varchar(256)
,
pvar_mailsubject Varchar(256)
,
pvar_mailto Varchar(4096)
,
pvar_mailbody text
,
pvar_issent Boolean

				  ,pvar_modifieduser  uuid  
				  ,OUT pvar_returnMessage Varchar(4000)
			  )
			  RETURNS Varchar(4000) 
              AS $BODY$  
              DECLARE lv_viewactionroles Varchar(128);
              BEGIN

			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:58*/
			  IF "Check_Authorization"(pvar_modifieduser, 'MailLogs', 'edit') THEN


			  pvar_returnMessage:='';

			  
                
			  IF(pvar_returnMessage='')
			  THEN

                    INSERT INTO MailLogs_history
SELECT *,NOW(),pvar_modifieduser::uuid,'Modified' FROM MailLogs
 WHERE MailLogsid= pvar_MailLogsid;

                    
                    UPDATE MailLogs SET
                    entityname=pvar_entityname
,entityid=pvar_entityid
,mailfor=pvar_mailfor
,mailsubject=pvar_mailsubject
,mailto=pvar_mailto
,mailbody=pvar_mailbody
,issent=pvar_issent

                    
                    ,modifieduser=pvar_modifieduser,modifieddate=NOW()
                    WHERE MailLogsid=pvar_MailLogsid;

                    

                    


					
							
					pvar_returnMessage := '201.1';
			
			  END IF;

			  
																ELSE
																

															
																INSERT INTO system_logging
																(
																Log_code
																,system_logging_guid
																,log_application
																,log_date
																,log_level
																,log_logger
																,log_message
																,log_user_name
																)
																VALUES
																('401.1'
																,gen_random_uuid()
																,'Store Proc Authorization Check'
																,NOW()
																,'Critical'
																,'Update_MailLog'
																,'Authorization Failed Update_MailLog'
																,pvar_modifieduser
																);
																pvar_returnMessage = '401.1';
																
																END IF;

			  			 /* EXCEPTION WHEN OTHERS THEN
			 
						INSERT INTO system_logging
						(
						Log_code
						,system_logging_guid
						,log_application
						,log_date
						,log_level
						,log_logger
						,log_message
						)
						VALUES
						('16'
						,gen_random_uuid()
						,'Postgre Function Exception'
						,NOW()
						,'16'
						,'Update_MailLog'
						,'update failed'
						);
                        pvar_returnMessage := 'Update_MailLog - update failed';*/
			  	
			  END
              $BODY$
              LANGUAGE plpgsql;

