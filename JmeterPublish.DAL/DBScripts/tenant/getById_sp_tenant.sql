 
			  
			  CREATE OR REPLACE FUNCTION  "getById_sp_tenant"
			  (
				  pvar_tenantid Varchar
			  )
			  RETURNS TABLE(
                firstname Varchar
,lastname Varchar
,username Varchar
,userrole Varchar
,userpassword Varchar
,emailid Varchar
,mobilenumber Varchar
,passwordkey Varchar
,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)

                ,tenantid uuid
                
            )
            AS $BODY$
            BEGIN
			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:52*/
               
              RETURN QUERY
			  SELECT 
				 tenant.firstname
,tenant.lastname
,tenant.username
,tenant.userrole
,tenant.userpassword
,tenant.emailid
,tenant.mobilenumber
,tenant.passwordkey

				 ,tenant.createduser,tenant.createddate,tenant.modifieduser,tenant.modifieddate
				 
                 ,tenant.tenantid
                    
			  FROM tenant
			  WHERE CAST(tenant.tenantid AS Varchar)=pvar_tenantid
                       ;

					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

