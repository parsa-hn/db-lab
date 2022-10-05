CREATE TABLE "Account"
(
 "account_type" int NOT NULL,
 "price"        int NOT NULL,
 "duration"     int NOT NULL,
 "free_ads_num" int NOT NULL,
 CONSTRAINT "PK_account" PRIMARY KEY ( "account_type" )
);

CREATE TABLE "Applicant"
(
 "applicant_id"        uuid NOT NULL,
 "first_name"          character varying(50) NOT NULL,
 "last_name"           character varying(50) NOT NULL,
 "email"               character varying(50) NOT NULL,
 "phone"               char(11) NULL,
 "password"            character varying(100) NOT NULL,
 "resume"              json NULL,
 "profile_picture_url" character varying(50) NULL,
 "creation_time"       timestamp NOT NULL,
 CONSTRAINT "PK_employer" PRIMARY KEY ( "applicant_id" )
);

CREATE TABLE "Company"
(
 "company_id"              uuid NOT NULL,
 "name"                    character varying(50) NOT NULL,
 "email"                   character varying(100) NOT NULL,
 "phone"                   char(11) NOT NULL,
 "description"             character varying(250) NOT NULL,
 "resume"                  json NULL,
 "logo_url"                character varying(50) NULL,
 "location"                character varying(50) NULL,
 "creation_time"           timestamp NOT NULL,
 "account_activation_time" timestamp NULL,
 "account_type"            int NOT NULL,
 CONSTRAINT "PK_company" PRIMARY KEY ( "company_id" ),
 CONSTRAINT "FK_44" FOREIGN KEY ( "account_type" ) REFERENCES "Account" ( "account_type" )
);

CREATE INDEX "fkIdx_44" ON "Company"
(
 "account_type"
);

CREATE TABLE "Agent"
(
 "agent_id"            uuid NOT NULL,
 "first_name"          character varying(50) NOT NULL,
 "last_name"           character varying(50) NOT NULL,
 "email"               character varying(50) NOT NULL,
 "phone"               char(11) NULL,
 "password"            character varying(100) NOT NULL,
 "profile_picture_url" character varying(50) NULL,
 "role"                int NOT NULL,
 "creation_time"       timestamp NOT NULL,
 "company_id"          uuid NOT NULL,
 CONSTRAINT "PK_agent" PRIMARY KEY ( "agent_id" ),
 CONSTRAINT "FK_55" FOREIGN KEY ( "company_id" ) REFERENCES "Company" ( "company_id" )
);

CREATE INDEX "fkIdx_55" ON "Agent"
(
 "company_id"
);

CREATE TABLE "Ad"
(
 "ad_id"          uuid NOT NULL,
 "title"          character varying(50) NOT NULL,
 "description"    character varying(250) NOT NULL,
 "category"       character varying(50) NOT NULL,
 "prerequisites"  character varying(250) NOT NULL,
 "tags"           character varying(50)[] NULL,
 "archived"       boolean NOT NULL,
 "money_to_check" int NOT NULL,
 "company_id"     uuid NOT NULL,
 "agent_id"       uuid NOT NULL,
 CONSTRAINT "PK_ad" PRIMARY KEY ( "ad_id" ),
 CONSTRAINT "FK_67" FOREIGN KEY ( "company_id" ) REFERENCES "Company" ( "company_id" ),
 CONSTRAINT "FK_70" FOREIGN KEY ( "agent_id" ) REFERENCES "Agent" ( "agent_id" )
);

CREATE INDEX "fkIdx_67" ON "Ad"
(
 "company_id"
);

CREATE INDEX "fkIdx_70" ON "Ad"
(
 "agent_id"
);

CREATE TABLE "Applied_For"
(
 "application_id" uuid NOT NULL,
 "creation_time"  timestamp NOT NULL,
 "status"         int NOT NULL,
 "ad_id"          uuid NOT NULL,
 "applicant_id"   uuid NOT NULL,
 "has_paid"       boolean NOT NULL,
 CONSTRAINT "PK_applied_for" PRIMARY KEY ( "application_id" ),
 CONSTRAINT "FK_82" FOREIGN KEY ( "ad_id" ) REFERENCES "Ad" ( "ad_id" ),
 CONSTRAINT "FK_85" FOREIGN KEY ( "applicant_id" ) REFERENCES "Applicant" ( "applicant_id" )
);

CREATE INDEX "fkIdx_82" ON "Applied_For"
(
 "ad_id"
);

CREATE INDEX "fkIdx_85" ON "Applied_For"
(
 "applicant_id"
);