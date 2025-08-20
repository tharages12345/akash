CREATE TABLE IF NOT EXISTS users_alloweddevices
(
users_alloweddevicesid uuid PRIMARY KEY
,usersid uuid REFERENCES users(usersid)
,record_order int
,devicename Varchar(1024) NULL
,deviceid Varchar(1024) NULL
,notificationid Varchar(1024) NULL
,action_date Timestamp(3) NOT NULL DEFAULT NOW()
,action_by uuid
,action character varying(50)
,isdeleted boolean NOT NULL DEFAULT FALSE
);


