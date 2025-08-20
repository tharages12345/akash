
			  CREATE OR REPLACE FUNCTION  "Update_tenant"
			  (
				  pvar_tenantid uuid
,
pvar_firstname Varchar(50)
,
pvar_lastname Varchar(50)
,
pvar_username Varchar(150)
,
pvar_userrole Varchar(150)
,
pvar_userpassword Varchar(128)
,
pvar_emailid Varchar(128)
,
pvar_mobilenumber Varchar(20)

				  ,pvar_modifieduser  uuid  
				  ,OUT pvar_returnMessage Varchar(4000)
			  )
			  RETURNS Varchar(4000) 
              AS $BODY$  
              
              BEGIN

			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:52*/
			  


			  pvar_returnMessage:='';

			  if EXISTS (SELECT * from tenant where upper(tenant.username) = upper(pvar_username) and tenant.tenantid=pvar_tenantid  and tenant.tenantid <> pvar_tenantid)
																THEN

																  pvar_returnMessage := pvar_returnMessage||'username Already Exists.';

																END IF;
if EXISTS (SELECT * from tenant where upper(tenant.emailid) = upper(pvar_emailid) and tenant.tenantid=pvar_tenantid  and tenant.tenantid <> pvar_tenantid)
																THEN

																  pvar_returnMessage := pvar_returnMessage||'Email ID Already Exists.';

																END IF;
if EXISTS (SELECT * from tenant where upper(tenant.mobilenumber) = upper(pvar_mobilenumber) and tenant.tenantid=pvar_tenantid  and tenant.tenantid <> pvar_tenantid)
																THEN

																  pvar_returnMessage := pvar_returnMessage||'Mobile Number Already Exists.';

																END IF;

                
			  IF(pvar_returnMessage='')
			  THEN

                    INSERT INTO tenant_history
SELECT *,NOW(),pvar_modifieduser::uuid,'Modified' FROM tenant
 WHERE tenantid= pvar_tenantid;

                    
                    UPDATE tenant SET
                    firstname=pvar_firstname
,lastname=pvar_lastname
,username=pvar_username
,userrole=pvar_userrole

,emailid=pvar_emailid
,mobilenumber=pvar_mobilenumber

                    
                    ,modifieduser=pvar_modifieduser,modifieddate=NOW()
                    WHERE tenantid=pvar_tenantid;

                    
										UPDATE users SET
											firstname=pvar_firstname
,lastname=pvar_lastname
,username=pvar_username
,userrole=pvar_userrole

,emailid=pvar_emailid
,mobilenumber=pvar_mobilenumber

											,modifieduser=pvar_modifieduser,modifieddate=NOW()
										WHERE tenantid=pvar_tenantid;

                    


					
							
					pvar_returnMessage := '201.1';
			
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
						,'Update_tenant'
						,'update failed'
						);
                        pvar_returnMessage := 'Update_tenant - update failed';*/
			  	
			  END
              $BODY$
              LANGUAGE plpgsql;

