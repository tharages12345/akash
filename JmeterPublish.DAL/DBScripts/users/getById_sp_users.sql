 
			  
			  CREATE OR REPLACE FUNCTION  "getById_sp_users"
			  (
				  pvar_usersid Varchar
			  )
			  RETURNS TABLE(
                firstname Varchar
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
,tenantid uuid

                ,usersid uuid
                ,alloweddevices JSON
            )
            AS $BODY$
            BEGIN
			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:48*/
               
              RETURN QUERY
			  SELECT 
				 users.firstname
,users.lastname
,users.profilepicture
,users.username
,users.userpassword
,users.passwordkey
,users.emailid
,users.mobilenumber
,users.userrole

				 ,users.createduser,users.createddate,users.modifieduser,users.modifieddate
				 ,users.tenantid
                 ,users.usersid
                 ,(SELECT json_agg(J) FROM (
											 SELECT 
											 users_alloweddevices.usersid
                                             ,users_alloweddevices.users_alloweddevicesid   
											 ,users_alloweddevices.devicename
,users_alloweddevices.deviceid
,users_alloweddevices.notificationid
 
											  
											 FROM users_alloweddevices
											 WHERE 
											 users_alloweddevices.usersid=users.usersid
                                             AND COALESCE(users_alloweddevices.isdeleted,false) = false 
                                             ORDER BY record_order ASC
											) J) as alloweddevices
   
			  FROM users
			  WHERE CAST(users.usersid AS Varchar)=pvar_usersid
                       ;

					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

