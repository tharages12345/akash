 
			  
			  CREATE OR REPLACE FUNCTION  "get_all_users"
              (
			  pvar_tenantid Varchar=null
              )
			 RETURNS TABLE(
                firstname Varchar
,lastname Varchar
,profilepicture Varchar
,username Varchar
,emailid Varchar
,mobilenumber Varchar
,userrole Varchar
,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)
,tenantid uuid

                ,"usersid" uuid
                 
               )
               AS $BODY$
                declare lvar_tenantid varchar[];
                declare lstr_usersid varchar;
               BEGIN
              /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:48*/
              
                SELECT  SPLIT_PART(pvar_tenantid, '|', 1),SPLIT_PART(pvar_tenantid, '|', 2) into lstr_usersid,pvar_tenantid;
		        
                if(pvar_tenantid is null or pvar_tenantid='' or pvar_tenantid='00000000-0000-0000-0000-000000000000')	
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

				 users.firstname
,users.lastname
,users.profilepicture
,users.username
,users.emailid
,users.mobilenumber
,users.userrole

				 ,users.createduser,users.createddate,users.modifieduser,users.modifieddate
				,users.tenantid 
                ,users.usersid
				 
			  FROM users
			  WHERE
               (lvar_tenantid is null or COALESCE(cast(users.tenantid as varchar),'') = Any(lvar_tenantid))
                 
			  
			  ;
			 

					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

