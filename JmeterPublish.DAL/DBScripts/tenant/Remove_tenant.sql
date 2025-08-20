
			  CREATE OR REPLACE FUNCTION  "Remove_tenant"
			  (
				  pvar_tenantid Varchar(50)
				  ,pvar_modifieduser  Varchar(50)
				  ,OUT pvar_returnMessage Varchar(4000)
			  )
			  RETURNS Varchar(4000) 
              AS $BODY$  
              DECLARE lv_viewactionroles Varchar(128);
              BEGIN
              /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:52*/
			  
			  
            INSERT INTO tenant_history
SELECT *,NOW(),pvar_modifieduser::uuid,'Deleted' FROM tenant
 WHERE CAST(tenantid AS VARCHAR)= pvar_tenantid;

			 
			 UPDATE tenant SET
													isdeleted=true ,modifieduser=CAST(pvar_modifieduser AS UUID),modifieddate=NOW()
													WHERE CAST(tenant.tenantid AS VARCHAR)=pvar_tenantid;
					 
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
						,'Remove_tenant'
						,'user delete failed'
						);				 
					    pvar_returnMessage := 'user delete failed';*/
				  
			  
 			  END
              $BODY$
              LANGUAGE plpgsql;

