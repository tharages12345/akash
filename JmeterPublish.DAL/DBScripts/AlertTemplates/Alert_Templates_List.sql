
			  CREATE OR REPLACE FUNCTION  "Alert_Templates_List"
              (pvar_entityname Varchar(1024)
,pvar_entityaction Varchar(1024)
,pvar_alerttype Varchar(1024)
)
			  RETURNS TABLE(AlertTemplatesid uuid
,entityname Varchar,entityaction Varchar,sendasbatch Varchar,alerttype Varchar,alertsubject Varchar,alertcopyto Varchar,alertcarboncopyto Varchar,alertcontent text,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)
)
			  AS $BODY$
              
              
			  BEGIN
			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:55*/
			  		
              
                RETURN QUERY
				SELECT  
				AlertTemplates.AlertTemplatesid
,AlertTemplates.entityname
,AlertTemplates.entityaction
,CAST(case when AlertTemplates.sendasbatch=true then 'Yes' else 'No' End AS Varchar) as sendasbatch
,AlertTemplates.alerttype
,AlertTemplates.alertsubject
,AlertTemplates.alertcopyto
,AlertTemplates.alertcarboncopyto
,AlertTemplates.alertcontent

				
				,AlertTemplates.createduser,AlertTemplates.createddate,AlertTemplates.modifieduser,AlertTemplates.modifieddate
				FROM  AlertTemplates 

				WHERE AlertTemplates.isdeleted=false 
AND (pvar_entityname is null or pvar_entityname ='0' or LENGTH(CAST(pvar_entityname as Varchar))=0 or CAST(AlertTemplates.entityname as VARCHAR)=pvar_entityname)
AND (pvar_entityaction is null or pvar_entityaction ='0' or LENGTH(CAST(pvar_entityaction as Varchar))=0 or CAST(AlertTemplates.entityaction as VARCHAR)=pvar_entityaction)
AND (pvar_alerttype is null or pvar_alerttype ='0' or LENGTH(CAST(pvar_alerttype as Varchar))=0 or CAST(AlertTemplates.alerttype as VARCHAR)=pvar_alerttype)

				 ORDER BY AlertTemplates.createddate DESC;
			  
					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

