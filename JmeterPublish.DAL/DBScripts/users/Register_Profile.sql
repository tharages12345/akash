
			  CREATE OR REPLACE FUNCTION  "Register_Profile"
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
pvar_userpassword Varchar(128)
,
pvar_emailid Varchar(128)
,
pvar_mobilenumber Varchar(20)
,
pvar_userrole   Varchar(1024)
,pvar_alloweddevices json
,pvar_passwordkey Varchar(150)
 
				  ,pvar_createduser  uuid 

				  ,OUT pvar_returnMessage Varchar(4000)
			  )
			  RETURNS Varchar(4000) 
              AS $BODY$  
              
              BEGIN

				/*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:47*/
		

			  
                                                                                    if pvar_usersid is null then
                                                                                    pvar_usersid:=gen_random_uuid();
                                                                                    end if;	
                                                                                    
			  
			  
			  pvar_returnMessage:='';
			  IF EXISTS (SELECT * from users where upper(users.username::varchar) = upper(pvar_username::varchar))
																THEN

																pvar_returnMessage := pvar_returnMessage||'UserName Already Exists.';

																END IF;
IF EXISTS (SELECT * from users where upper(users.emailid::varchar) = upper(pvar_emailid::varchar))
																THEN

																pvar_returnMessage := pvar_returnMessage||'Email ID Already Exists.';

																END IF;
IF EXISTS (SELECT * from users where upper(users.mobilenumber::varchar) = upper(pvar_mobilenumber::varchar))
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
  
			  if(pvar_returnMessage='')
			  THEN

			  

			  INSERT INTO users(
				 firstname
,lastname
,profilepicture
,username
,userpassword
,emailid
,mobilenumber
,userrole
,passwordkey

				 ,createduser
				 ,usersid
				 ,tenantid
                
			  )
			  VALUES (
 				 pvar_firstname
,pvar_lastname
,pvar_profilepicture
,pvar_username
,pvar_userpassword
,pvar_emailid
,pvar_mobilenumber
,pvar_userrole
,pvar_passwordkey

				 ,pvar_createduser
				 ,pvar_usersid
				 ,pvar_tenantid
                   
			  );
			   
               

			  


			  
								
								
								INSERT INTO users_alloweddevices (
									usersid
									,users_alloweddevicesid 
                                    ,record_order  
                                    ,action_date,action_by,action
    
									,devicename
,deviceid
,notificationid

									
                                
									)
									SELECT 
									pvar_usersid
                                    ,gen_random_uuid()
                                    ,CAST(coalesce(j->>'record_order','0') as INT)
                                    ,NOW(),pvar_createduser,'Added' 
									,j->>'devicename' as devicename
,j->>'deviceid' as deviceid
,j->>'notificationid' as notificationid

									
                                    FROM json_array_elements(pvar_alloweddevices) as j;
									

					 
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
						,'Register_Profile'
						,'insert failed'
						);
                        pvar_returnMessage := 'Register_Profile - Insert failed';*/
			  	
			  END
              $BODY$
              LANGUAGE plpgsql;

