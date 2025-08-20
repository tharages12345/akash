
			  CREATE OR REPLACE FUNCTION  "ViewList_tenant"
              ()
			  RETURNS TABLE(tenantid uuid
,firstname Varchar,lastname Varchar,username Varchar,userrole Varchar,userpassword Varchar,emailid Varchar,mobilenumber Varchar,passwordkey Varchar,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)
)
			  AS $BODY$
              
              
			  BEGIN
			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:52*/
			  		
              
                RETURN QUERY
				SELECT  
				tenant.tenantid
,tenant.firstname
,tenant.lastname
,tenant.username
,tenant.userrole
,tenant.userpassword
,tenant.emailid
,tenant.mobilenumber
,tenant.passwordkey

				
				,tenant.createduser,tenant.createddate,tenant.modifieduser,tenant.modifieddate
				FROM  tenant 

				WHERE tenant.isdeleted=false 

				 ORDER BY tenant.createddate DESC;
			  
					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

