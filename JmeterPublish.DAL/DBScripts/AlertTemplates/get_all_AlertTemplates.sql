 
			  
			  CREATE OR REPLACE FUNCTION  "get_all_AlertTemplates"
              (
			  pvar_tenantid Varchar=null
              )
			  RETURNS TABLE(
                entityname Varchar
,entityaction Varchar
,sendasbatch Boolean
,alerttype Varchar
,alertsubject Varchar
,alertcopyto Varchar
,alertcarboncopyto Varchar
,alertcontent text
,createduser uuid
,createddate Timestamp(5)
,modifieduser uuid
,modifieddate Timestamp(5)

                ,"AlertTemplatesid" uuid
               )
               AS $BODY$
               BEGIN

			  /*This code generated from staging Powered by Mahat, Source Machine : stg , Build Number : #2024-07-004 (Updated on 07/07/2024 22:07) on 06/12/2025 10:05:55*/

			 
                RETURN QUERY
                SELECT 
                AlertTemplates.entityname
,AlertTemplates.entityaction
,COALESCE(AlertTemplates.sendasbatch,true) as sendasbatch
,AlertTemplates.alerttype
,AlertTemplates.alertsubject
,AlertTemplates.alertcopyto
,AlertTemplates.alertcarboncopyto
,AlertTemplates.alertcontent

                ,AlertTemplates.createduser,AlertTemplates.createddate,AlertTemplates.modifieduser,AlertTemplates.modifieddate
                ,AlertTemplates.AlertTemplatesid
                FROM AlertTemplates
			    
                 WHERE AlertTemplates.isdeleted=false
                ;
			 

					 	
			  END
              $BODY$
              LANGUAGE plpgsql;

