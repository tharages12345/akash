 
			  
			  CREATE OR REPLACE FUNCTION  "get_project_tenant"
              (
                pvar_tenantid character varying
			   )
			 RETURNS TABLE(
                firstname Varchar
,lastname Varchar
,username Varchar
,userrole Varchar
,emailid Varchar
,mobilenumber Varchar
,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)

                ,"tenantid" uuid
                
               )
               AS $BODY$
                  declare lvar_tenantid varchar[];
                  declare lstr_usersid varchar;
               BEGIN
                /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:52*/

                SELECT  SPLIT_PART(pvar_tenantid, '|', 1),SPLIT_PART(pvar_tenantid, '|', 2) into lstr_usersid,pvar_tenantid;
			
			      if(pvar_tenantid='' or pvar_tenantid='00000000-0000-0000-0000-000000000000')	
				then
                    SELECT STRING_TO_ARRAY(viewertenantids, ',') into lvar_tenantid
				    FROM users where users.usersid::varchar=lstr_usersid;	
                    if(lvar_tenantid is NULL)
					then 
						SELECT array_agg(tenant.tenantid) INTO lvar_tenantid FROM tenant;
                        

					end if;
                else 
				  lvar_tenantid=ARRAY[pvar_tenantid];    
				
                end if;
                lvar_tenantid := lvar_tenantid || ARRAY[''::character varying] || ARRAY['00000000-0000-0000-0000-000000000000'::character varying];

                RETURN QUERY
			  SELECT 

				 tenant.firstname
,tenant.lastname
,tenant.username
,tenant.userrole
,tenant.emailid
,tenant.mobilenumber

				 ,tenant.createduser,tenant.createddate,tenant.modifieduser,tenant.modifieddate
				 
                ,tenant.tenantid
			    

			  FROM tenant
             WHERE 
             ((pvar_tenantid is null or lvar_tenantid is null) or COALESCE(cast(tenant.tenantid as varchar),'') = Any(lvar_tenantid))   
               AND tenant.isdeleted=false
               ;
			 

					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

