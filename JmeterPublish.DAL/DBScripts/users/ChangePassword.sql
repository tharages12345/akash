  
                    CREATE OR REPLACE FUNCTION "ChangePassword"
                    (
                    pvar_usersid Varchar(50)
                    ,pvar_userpassword Varchar(128)  
                    ,pvar_passwordkey Varchar(150)  
                    ,pvar_modifieduser  uuid 
                    ,OUT pvar_returnMessage Varchar(4000) 
                    )  
                    RETURNS Varchar(4000) 
                    AS $BODY$  
                    BEGIN
                    /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:48*/

 
                            UPDATE users SET
                            userpassword = pvar_userpassword
                            ,passwordkey = pvar_passwordkey
                            ,modifieduser=pvar_modifieduser
                            WHERE usersid::varchar = pvar_usersid;

                            pvar_returnMessage := '201.1';


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
                                ,'{ActionMethodName}'
                                ,'update failed'
                                );*/
			  
                    END
                    $BODY$
                    LANGUAGE plpgsql;
                    

