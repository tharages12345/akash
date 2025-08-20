CREATE OR REPLACE FUNCTION "getById_sp_users_alloweddevices"(
												 pvar_usersid Varchar(50)
											 )
                                             RETURNS TABLE("usersid" uuid,"users_alloweddevicesid" uuid ,devicename Varchar
,deviceid Varchar
,notificationid Varchar
)
											 AS $BODY$
											 BEGIN
											 
											 RETURN QUERY
											 SELECT 
											 users_alloweddevices.usersid
                                             ,users_alloweddevices.users_alloweddevicesid   
											 ,users_alloweddevices.devicename
,users_alloweddevices.deviceid
,users_alloweddevices.notificationid
 
											 
											 FROM users_alloweddevices
											 WHERE 
											 CAST(users_alloweddevices.usersid AS VARCHAR)=pvar_usersid
                                             AND COALESCE(users_alloweddevices.isdeleted,false) = false   
                                             ORDER BY record_order ASC;
											
											 END
                                             $BODY$
                                             LANGUAGE plpgsql;

