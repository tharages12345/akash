
			  CREATE OR REPLACE FUNCTION  "List_of_User_Profiles"
              (pvar_tenantid Varchar
)
			  RETURNS TABLE(tenantid uuid
,_tenantName Varchar(128)
,usersid uuid
,firstname Varchar,lastname Varchar,profilepicture Varchar,username Varchar,userpassword Varchar,passwordkey Varchar,emailid Varchar,mobilenumber Varchar,userrole Varchar,"automaton_users_alloweddevices" json,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)
)
			  AS $BODY$
              declare lvar_tenantid varchar[];declare lstr_usersid varchar;
              
			  BEGIN
			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:48*/
			  		
                SELECT  SPLIT_PART(pvar_tenantid, '|', 1),SPLIT_PART(pvar_tenantid, '|', 2) into lstr_usersid,pvar_tenantid;
                if(pvar_tenantid='' or pvar_tenantid='00000000-0000-0000-0000-000000000000')	
				then
                  lvar_tenantid :=   ARRAY[''::character varying] || ARRAY['00000000-0000-0000-0000-000000000000'::character varying];

                else 
				  lvar_tenantid=ARRAY[pvar_tenantid];
                end if;

              
                RETURN QUERY
				SELECT  
				users.tenantid
,CAST(tenant.firstname ||' '|| COALESCE(cast(tenant.lastname as varchar),'') AS VARCHAR) as _tenantName
,users.usersid
,users.firstname
,users.lastname
,users.profilepicture
,users.username
,users.userpassword
,users.passwordkey
,users.emailid
,users.mobilenumber
,users.userrole

				,
                (SELECT json_agg(J) FROM (SELECT   
				 users_alloweddevices.devicename as "Device Name"
,users_alloweddevices.deviceid as "Device ID"
,users_alloweddevices.notificationid as "Notification ID"

		 	   FROM  users_alloweddevices 

			  WHERE users.usersid =users_alloweddevices.usersid
AND COALESCE(users_alloweddevices.isdeleted,false) = false 
) J)
			    as automaton_users_alloweddevices

				,users.createduser,users.createddate,users.modifieduser,users.modifieddate
				FROM  users 
 LEFT OUTER JOIN tenant ON users.tenantid=tenant.tenantid

				WHERE (lvar_tenantid is null or COALESCE(cast(users.tenantid as varchar), '') = Any(lvar_tenantid)) AND users.isdeleted=false

				 ORDER BY users.createddate DESC;
			  
					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

