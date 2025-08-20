
			  CREATE OR REPLACE FUNCTION  "Create_tenant"
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
,pvar_passwordkey Varchar(150)
 
				  ,pvar_createduser  uuid 

				  ,OUT pvar_returnMessage Varchar(4000)
			  )
			  RETURNS Varchar(4000) 
              AS $BODY$  
              
              BEGIN

				/*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:52*/
		

			  
			  
			  
			  pvar_returnMessage:='';
			  IF EXISTS (SELECT * from tenant where upper(tenant.username::varchar) = upper(pvar_username::varchar) and tenant.tenantid=pvar_tenantid)
																THEN

																pvar_returnMessage := pvar_returnMessage||'username Already Exists.';

																END IF;
IF EXISTS (SELECT * from tenant where upper(tenant.emailid::varchar) = upper(pvar_emailid::varchar) and tenant.tenantid=pvar_tenantid)
																THEN

																pvar_returnMessage := pvar_returnMessage||'Email ID Already Exists.';

																END IF;
IF EXISTS (SELECT * from tenant where upper(tenant.mobilenumber::varchar) = upper(pvar_mobilenumber::varchar) and tenant.tenantid=pvar_tenantid)
																THEN

																pvar_returnMessage := pvar_returnMessage||'Mobile Number Already Exists.';

																END IF;

                
			  if(pvar_returnMessage='')
			  THEN

			  

			  INSERT INTO tenant(
				 firstname
,lastname
,username
,userrole
,userpassword
,emailid
,mobilenumber
,passwordkey

				 ,createduser
				 ,tenantid
				 
                
			  )
			  VALUES (
 				 pvar_firstname
,pvar_lastname
,pvar_username
,pvar_userrole
,pvar_userpassword
,pvar_emailid
,pvar_mobilenumber
,pvar_passwordkey

				 ,pvar_createduser
				 ,pvar_tenantid
				 
                   
			  );
			   
               

			   INSERT INTO users(
										firstname
,lastname
,username
,userrole
,userpassword
,emailid
,mobilenumber
,passwordkey

										,createduser
										,usersid
										,tenantid
										)
										VALUES (
										pvar_firstname
,pvar_lastname
,pvar_username
,pvar_userrole
,pvar_userpassword
,pvar_emailid
,pvar_mobilenumber
,pvar_passwordkey

										,pvar_createduser
										,gen_random_uuid()
										 ,pvar_tenantid
										);


			  
					 
			  pvar_returnMessage := '201.1';
               
              END IF;
			   

			  
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
						,'Store Proc Exception'
						,NOW()
						,'16'
						,'Create_tenant'
						,'insert failed'
						);
                        pvar_returnMessage := 'Create_tenant - Insert failed';*/
			  	
			  END
              $BODY$
              LANGUAGE plpgsql;

