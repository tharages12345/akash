
			  CREATE OR REPLACE FUNCTION  "Suspend_Profile"
			  (
				  pvar_usersid Varchar(50)
				  ,pvar_modifieduser  Varchar(50)
				  ,OUT pvar_returnMessage Varchar(4000)
			  )
			  RETURNS Varchar(4000) 
              AS $BODY$  
              DECLARE lv_viewactionroles Varchar(128);
              BEGIN
              /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:48*/
			  
			  
            INSERT INTO users_history
SELECT *,NOW(),pvar_modifieduser::uuid,'Deleted' FROM users
 WHERE CAST(usersid AS VARCHAR)= pvar_usersid;

			 INSERT INTO users_alloweddevices_history
SELECT * FROM users_alloweddevices 
 WHERE usersid= pvar_usersid::uuid;


			 UPDATE users SET
													isdeleted=true ,modifieduser=CAST(pvar_modifieduser AS UUID),modifieddate=NOW()
													WHERE CAST(users.usersid AS VARCHAR)=pvar_usersid;
					 
				  pvar_returnMessage := '201.1';
					 
			  
                    /*EXCEPTION WHEN OTHERS THEN
			 
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
						,'Suspend_Profile'
						,'user delete failed'
						);				 
					    pvar_returnMessage := 'user delete failed';*/
				  
			  
 			  END
              $BODY$
              LANGUAGE plpgsql;

