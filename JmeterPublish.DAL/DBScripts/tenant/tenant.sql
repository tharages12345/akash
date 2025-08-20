CREATE TABLE IF NOT EXISTS tenant
(
tenantid uuid  PRIMARY KEY
,firstname Varchar(50) NOT NULL
,lastname Varchar(50) NULL
,username Varchar(150) NOT NULL
,userrole Varchar(150) DEFAULT 'Retailers Inc Admin' NULL
,userpassword Varchar(128) NOT NULL
,emailid Varchar(128) NOT NULL
,mobilenumber Varchar(20) NOT NULL
,passwordkey Varchar(150) NULL
,UNIQUE(tenantid,username,emailid,mobilenumber)

,createduser uuid
,createddate  Timestamp(3) NOT NULL DEFAULT NOW()
,modifieduser uuid
,modifieddate Timestamp(3)
,isdeleted Boolean DEFAULT false
)


