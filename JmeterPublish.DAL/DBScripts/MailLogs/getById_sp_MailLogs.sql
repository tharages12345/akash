 
			  
			  CREATE OR REPLACE FUNCTION  "getById_sp_MailLogs"
			  (
				  pvar_MailLogsid Varchar
			  )
			  RETURNS TABLE(
                entityname Varchar
,entityid Varchar
,mailfor Varchar
,mailsubject Varchar
,mailto Varchar
,mailbody text
,issent Boolean
,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)

                ,MailLogsid uuid
                
            )
            AS $BODY$
            BEGIN
			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:58*/
               
              RETURN QUERY
			  SELECT 
				 MailLogs.entityname
,MailLogs.entityid
,MailLogs.mailfor
,MailLogs.mailsubject
,MailLogs.mailto
,MailLogs.mailbody
,COALESCE(MailLogs.issent,true) as issent

				 ,MailLogs.createduser,MailLogs.createddate,MailLogs.modifieduser,MailLogs.modifieddate
				 
                 ,MailLogs.MailLogsid
                    
			  FROM MailLogs
			  WHERE CAST(MailLogs.MailLogsid AS Varchar)=pvar_MailLogsid
                       ;

					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

