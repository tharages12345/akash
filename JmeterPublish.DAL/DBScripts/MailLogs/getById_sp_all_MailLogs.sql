
			  CREATE OR REPLACE FUNCTION  "getById_sp_all_MailLogs"
              (
			  pvar_MailLogsid Varchar
			  )
              RETURNS TABLE(
                "MailLogsid" uuid
,entityname Varchar
,entityid Varchar
,mailfor Varchar
,mailsubject Varchar
,mailto Varchar
,mailbody text
,issent Varchar
,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)

                
                
                
                )

              AS $BODY$
                BEGIN
			   
			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:58*/
			  		 
              RETURN QUERY
			  SELECT  
				 MailLogs.MailLogsid
,MailLogs.entityname
,MailLogs.entityid
,MailLogs.mailfor
,MailLogs.mailsubject
,MailLogs.mailto
,MailLogs.mailbody
,CAST(case when MailLogs.issent=true then 'Yes' else 'No' End AS Varchar) as issent

				 ,MailLogs.createduser,MailLogs.createddate,MailLogs.modifieduser,MailLogs.modifieddate
                 
                 
			  FROM  MailLogs 

			  WHERE CAST(MailLogs.MailLogsid AS Varchar)=pvar_MailLogsid ;
			  
					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

