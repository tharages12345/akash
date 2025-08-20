
			  CREATE OR REPLACE FUNCTION  "Update_Profile"
			  (
				  pvar_usersid uuid
,pvar_tenantid uuid
,
pvar_firstname Varchar(50)
,
pvar_lastname Varchar(50)
,
pvar_profilepicture Varchar(1024)
,
pvar_username Varchar(150)
,
pvar_emailid Varchar(128)
,
pvar_mobilenumber Varchar(20)
,
pvar_userrole   Varchar(1024)
,pvar_alloweddevices json

				  ,pvar_modifieduser  uuid  
				  ,OUT pvar_returnMessage Varchar(4000)
			  )
			  RETURNS Varchar(4000) 
              AS $BODY$  
              
              BEGIN

			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:48*/
			  


			  pvar_returnMessage:='';

			  if EXISTS (SELECT * from users where upper(users.username) = upper(pvar_username)  and users.usersid <> pvar_usersid)
																THEN

																  pvar_returnMessage := pvar_returnMessage||'UserName Already Exists.';

																END IF;
if EXISTS (SELECT * from users where upper(users.emailid) = upper(pvar_emailid)  and users.usersid <> pvar_usersid)
																THEN

																  pvar_returnMessage := pvar_returnMessage||'Email ID Already Exists.';

																END IF;
if EXISTS (SELECT * from users where upper(users.mobilenumber) = upper(pvar_mobilenumber)  and users.usersid <> pvar_usersid)
																THEN

																  pvar_returnMessage := pvar_returnMessage||'Mobile Number Already Exists.';

																END IF;

               IF(pvar_userrole is not null AND pvar_userrole!='0' AND LENGTH(pvar_userrole)>0)
                                                            THEN                        
                                                                 if(CAST((SELECT Count(T1.T1) 
                                                                    FROM regexp_split_to_table(pvar_userrole, ',') AS T1
                                                                        INNER JOIN (Select DISTINCT roles.rolename from roles) AS T2 on T1.T1 = T2.rolename) AS int) <> CAST((SELECT Count(T1.T1)
                                                                    FROM regexp_split_to_table(pvar_userrole, ',')  AS T1) AS int))
                                                                    THEN
                                                                         pvar_returnMessage := pvar_returnMessage || ' userrole value is invalid';


                                                                    END IF;
                                                                    END IF;
 
			  IF(pvar_returnMessage='')
			  THEN

                    INSERT INTO users_history
SELECT *,NOW(),pvar_modifieduser::uuid,'Modified' FROM users
 WHERE usersid= pvar_usersid;

                    
                    UPDATE users SET
                    firstname=pvar_firstname
,lastname=pvar_lastname
,profilepicture=pvar_profilepicture
,username=pvar_username
,emailid=pvar_emailid
,mobilenumber=pvar_mobilenumber
,userrole=pvar_userrole

                    
                    ,modifieduser=pvar_modifieduser,modifieddate=NOW()
                    WHERE usersid=pvar_usersid;

                    

                    
							-- Inserts deleted data into a history.
                            INSERT INTO users_alloweddevices_history
                            (
                            usersid
                            ,users_alloweddevicesid 
                            ,record_order  
                            ,devicename
,deviceid
,notificationid

                            ,action_date
                            ,action_by
                            ,action	
                            ) 
                            SELECT 
                            usersid
                            ,users_alloweddevicesid 
                            ,record_order  
                            ,devicename
,deviceid
,notificationid

                            ,NOW()
                            ,pvar_modifieduser
                            ,'Deleted'
                            FROM users_alloweddevices 
                            WHERE users_alloweddevicesid IN (
                            Select users_alloweddevicesid from users_alloweddevices
                            where users_alloweddevicesid not in (
                            SELECT 
                            CAST(coalesce(j->>'users_alloweddevicesid','00000000-0000-0000-0000-000000000000') as uuid) 
                            FROM json_array_elements(pvar_alloweddevices) as j
                            ) AND usersid=pvar_usersid);

                                -- Mark users_alloweddevices data as deleted.
                                UPDATE users_alloweddevices 
                                set isdeleted=true
                                WHERE users_alloweddevicesid IN(
                                Select users_alloweddevicesid from users_alloweddevices
                                where users_alloweddevicesid not in (
                                SELECT 
                                CAST(coalesce(j->>'users_alloweddevicesid','00000000-0000-0000-0000-000000000000') as uuid)
                                FROM json_array_elements(pvar_alloweddevices) as j
                                ) AND usersid=pvar_usersid);
	                                

                                -- Insert newly added items to users_alloweddevices
                                INSERT INTO users_alloweddevices(
                                usersid
                                ,users_alloweddevicesid 
                                ,record_order  
                                ,devicename
,deviceid
,notificationid

                                ,action_date
                                ,action_by
                                ,action	
                                ) 
                                SELECT 
                                pvar_usersid
                                ,gen_random_uuid()
                                ,CAST(coalesce(j->>'record_order','0') as INT)
                                 ,j->>'devicename' as devicename
,j->>'deviceid' as deviceid
,j->>'notificationid' as notificationid

                                 ,NOW()
                                 ,pvar_modifieduser
                                ,'Added'
                                FROM json_array_elements(pvar_alloweddevices) as j
                                WHERE CAST(coalesce(j->>'users_alloweddevicesid','00000000-0000-0000-0000-000000000000') as uuid)='00000000-0000-0000-0000-000000000000';
                                        
                                -- INSERT UPDATED DATA INTO HISTORY
                                INSERT INTO users_alloweddevices_history(
                                usersid
                                ,users_alloweddevicesid 
                                ,record_order  
                                ,devicename
,deviceid
,notificationid

                                ,action_date
                                ,action_by
                                ,action	)
                                SELECT 
                                r.usersid
                                ,r.users_alloweddevicesid
                                ,r.record_order 
                                ,r.devicename
,r.deviceid
,r.notificationid

                                ,r.action_date
                                ,r.action_by
                                ,r.action
                                FROM json_array_elements(pvar_alloweddevices) as j
                                JOIN users_alloweddevices AS r 
                                ON r.users_alloweddevicesid = CAST(j->>'users_alloweddevicesid' AS uuid) 
                                AND r.usersid = pvar_usersid
                                WHERE 
                                r.users_alloweddevicesid = CAST(j->>'users_alloweddevicesid' AS uuid)
                                AND r.usersid = pvar_usersid
                                AND 
                                (r.devicename
,r.deviceid
,r.notificationid
) 
                                IS 
                                DISTINCT FROM (
                                 j->>'devicename'
,j->>'deviceid'
,j->>'notificationid'

                                );


                                -- UPDATE DATA IN TRANSACTION
                                UPDATE users_alloweddevices AS r
                                SET 
                                record_order=CAST(coalesce(j->>'record_order','0') as INT)
                                ,devicename=j->>'devicename'
,deviceid=j->>'deviceid'
,notificationid=j->>'notificationid'

								
                                ,action='updated'
                                ,action_date=NOW()
                                ,action_by=pvar_modifieduser
                                FROM json_array_elements(pvar_alloweddevices) as j
                                WHERE 
                                r.users_alloweddevicesid = CAST(j->>'users_alloweddevicesid' AS uuid)
                                AND r.usersid = pvar_usersid
                                AND 
                                (r.devicename
,r.deviceid
,r.notificationid
) 
                                IS 
                                DISTINCT FROM (
                                j->>'devicename'
,j->>'deviceid'
,j->>'notificationid'

                                );



					
							
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
						,'Update_Profile'
						,'update failed'
						);
                        pvar_returnMessage := 'Update_Profile - update failed';*/
			  	
			  END
              $BODY$
              LANGUAGE plpgsql;

