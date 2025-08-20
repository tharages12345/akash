
			  CREATE OR REPLACE FUNCTION  "getById_sp_all_users"
              (
			  pvar_usersid Varchar
			  )
              RETURNS TABLE(
                tenantid uuid
,_tenantname Varchar
,"usersid" uuid
,firstname Varchar
,lastname Varchar
,profilepicture Varchar
,username Varchar
,userpassword Varchar
,passwordkey Varchar
,emailid Varchar
,mobilenumber Varchar
,userrole Varchar
,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)

                ,"automaton_users_alloweddevices" json
                ,"automaton_users_alloweddevices_history" json
                
                )

              AS $BODY$
                BEGIN
			   
			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:47*/
			  		 
              RETURN QUERY
			  SELECT  
				 users.tenantid
,CAST(tenant.firstname||' '|| tenant.lastname AS VARCHAR) as _tenantname
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

				 ,users.createduser,users.createddate,users.modifieduser,users.modifieddate
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

                 ,
                (
                SELECT json_agg(J) FROM (
                
                SELECT   
                users_alloweddevices.devicename as "Device Name"
,users_alloweddevices.deviceid as "Device ID"
,users_alloweddevices.notificationid as "Notification ID"

                ,coalesce(users_alloweddevices.action,'Added') as action
                 ,users.firstname as actionby
                 ,users_alloweddevices.action_date as actiondatewithtime	
                ,CAST(COALESCE(to_char(users_alloweddevices.action_date,'dd/MM/yyyy'),'') AS Varchar) as actiondate
                ,CAST(COALESCE(to_char(users_alloweddevices.action_date,'HH24:MI'),'') AS Varchar) as actiontime	
                ,users.profilepicture
    
                FROM  users_alloweddevices 
INNER JOIN users ON users.usersid=users_alloweddevices.action_by

                WHERE users.usersid =users_alloweddevices.usersid

                UNION
                SELECT   
                users_alloweddevices_history.devicename as "Device Name"
,users_alloweddevices_history.deviceid as "Device ID"
,users_alloweddevices_history.notificationid as "Notification ID"

                 ,coalesce(users_alloweddevices_history.action,'Added') as action
                 ,users.firstname as actionby
                 ,users_alloweddevices_history.action_date as actiondatewithtime	
                ,CAST(COALESCE(to_char(users_alloweddevices_history.action_date,'dd/MM/yyyy'),'') AS Varchar) as actiondate
                ,CAST(COALESCE(to_char(users_alloweddevices_history.action_date,'HH24:MI'),'') AS Varchar) as actiontime	
                ,users.profilepicture
    
                FROM  users_alloweddevices_history 
INNER JOIN users ON users.usersid=users_alloweddevices_history.action_by

                WHERE users.usersid =users_alloweddevices_history.usersid

                
                ) J)
			    as automaton_users_alloweddevices_audit

			  FROM  users 
 LEFT OUTER JOIN tenant ON users.tenantid=tenant.tenantid

			  WHERE CAST(users.usersid AS Varchar)=pvar_usersid ;
			  
					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

