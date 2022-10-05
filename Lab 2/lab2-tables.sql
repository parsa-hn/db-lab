CREATE TABLE "evaluationAndStatus"."recruiter"
(
 "id"         uuid NOT NULL DEFAULT uuid_generate_v4(),
 "first_name" varchar(100) NOT NULL,
 "last_name"  varchar(100) NOT NULL,
 CONSTRAINT "PK_recruiter" PRIMARY KEY ( "id" )
);



CREATE TABLE process."step"
(
 "id"   uuid NOT NULL DEFAULT uuid_generate_v4(),
 "code" varchar(10) NOT NULL,
 "name" varchar(100) NOT NULL,
 CONSTRAINT "PK_step" PRIMARY KEY ( "id" )
);

CREATE TABLE process."process_step"
(
 "id"         uuid NOT NULL DEFAULT uuid_generate_v4(),
 "status"     varchar NULL,
 "priority"   int NOT NULL,
 "step_id"    uuid NOT NULL,
 "process_id" uuid NOT NULL,
 CONSTRAINT "PK_process_step" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_113" FOREIGN KEY ( "step_id" ) REFERENCES process."step" ( "id" ),
 CONSTRAINT "FK_118" FOREIGN KEY ( "process_id" ) REFERENCES process."process" ( "id" )
);

CREATE TABLE process."process"
(
 "id"           uuid NOT NULL DEFAULT uuid_generate_v4(),
 "code"         varchar(10) NOT NULL,
 "description"  varchar NOT NULL,
 "recruiter_id" uuid NOT NULL,
 CONSTRAINT "PK_process" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_280" FOREIGN KEY ( "recruiter_id" ) REFERENCES "evaluationAndStatus"."recruiter" ( "id" )
);



CREATE TABLE jobs."job_category"
(
 "id"          uuid NOT NULL DEFAULT uuid_generate_v4(),
 "code"        varchar(10) NOT NULL,
 "name"        varchar(100) NOT NULL,
 "description" varchar NOT NULL,
 CONSTRAINT "PK_job_category" PRIMARY KEY ( "id" )
);

CREATE TABLE jobs."job_platform"
(
 "id"          uuid NOT NULL DEFAULT uuid_generate_v4(),
 "code"        varchar(10) NOT NULL,
 "name"        varchar(100) NOT NULL,
 "description" varchar NOT NULL,
 CONSTRAINT "PK_job_platform" PRIMARY KEY ( "id" )
);

CREATE TABLE jobs."organization"
(
 "id"          uuid NOT NULL DEFAULT uuid_generate_v4(),
 "code"        varchar(10) NOT NULL,
 "name"        varchar(100) NOT NULL,
 "description" varchar NOT NULL,
 CONSTRAINT "PK_organization" PRIMARY KEY ( "id" )
);

CREATE TABLE jobs."job_position"
(
 "id"          uuid NOT NULL DEFAULT uuid_generate_v4(),
 "code"        varchar(10) NOT NULL,
 "name"        varchar(100) NOT NULL,
 "description" varchar NOT NULL,
 CONSTRAINT "PK_job_position" PRIMARY KEY ( "id" )
);

CREATE TABLE jobs."job"
(
 "id"              uuid NOT NULL DEFAULT uuid_generate_v4(),
 "code"            varchar(10) NOT NULL,
 "name"            varchar(100) NOT NULL,
 "description"     varchar NOT NULL,
 "date_published"  timestamp(3) NOT NULL,
 "job_start_date"  timestamp(3) NOT NULL,
 "no_of_vacancies" int NOT NULL,
 "job_category_id" uuid NOT NULL,
 "job_position_id" uuid NOT NULL,
 "job_platform_id" uuid NOT NULL,
 "organization_id" uuid NOT NULL,
 "process_id"      uuid NOT NULL,
 CONSTRAINT "PK_job" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_141" FOREIGN KEY ( "job_category_id" ) REFERENCES jobs."job_category" ( "id" ),
 CONSTRAINT "FK_144" FOREIGN KEY ( "job_position_id" ) REFERENCES jobs."job_position" ( "id" ),
 CONSTRAINT "FK_147" FOREIGN KEY ( "job_platform_id" ) REFERENCES jobs."job_platform" ( "id" ),
 CONSTRAINT "FK_150" FOREIGN KEY ( "organization_id" ) REFERENCES jobs."organization" ( "id" ),
 CONSTRAINT "FK_153" FOREIGN KEY ( "process_id" ) REFERENCES process."process" ( "id" )
);



CREATE TABLE application."applicant"
(
 "id"         uuid NOT NULL DEFAULT uuid_generate_v4(),
 "first_name" varchar(100) NOT NULL,
 "last_name"  varchar(100) NOT NULL,
 "email"      varchar(100) NOT NULL,
 "phone"      varchar(100) NOT NULL,
 "summary"    varchar NOT NULL,
 CONSTRAINT "PK_applicant" PRIMARY KEY ( "id" )
);

CREATE TABLE application."application"
(
 "id"                  uuid NOT NULL DEFAULT uuid_generate_v4(),
 "date_of_application" timestamp(3) NOT NULL,
 "education"           varchar NOT NULL,
 "experience"          varchar NOT NULL,
 "other_info"          varchar NOT NULL,
 "applicant_id"        uuid NOT NULL,
 "jobs_id"             uuid NOT NULL,
 CONSTRAINT "PK_application" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_172" FOREIGN KEY ( "applicant_id" ) REFERENCES application."applicant" ( "id" ),
 CONSTRAINT "FK_175" FOREIGN KEY ( "jobs_id" ) REFERENCES jobs."job" ( "id" )
);

CREATE TABLE application."document"
(
 "id"          uuid NOT NULL DEFAULT uuid_generate_v4(),
 "name"        varchar(100) NOT NULL,
 "document"    bytea NULL,
 "url"         varchar(200) NULL,
 "last_update" timestamp(3) NOT NULL,
 CONSTRAINT "PK_document" PRIMARY KEY ( "id" )
);

CREATE TABLE application."application_document"
(
 "id"             uuid NOT NULL DEFAULT uuid_generate_v4(),
 "document_id"    uuid NOT NULL,
 "application_id" uuid NOT NULL,
 CONSTRAINT "PK_application_document" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_189" FOREIGN KEY ( "document_id" ) REFERENCES application."document" ( "id" ),
 CONSTRAINT "FK_192" FOREIGN KEY ( "application_id" ) REFERENCES application."application" ( "id" )
);



CREATE TABLE "testsAndInterviews"."test"
(
 "id"        uuid NOT NULL DEFAULT uuid_generate_v4(),
 "code"      varchar(10) NOT NULL,
 "duration"  int NULL,
 "max_score" int NOT NULL,
 CONSTRAINT "PK_test" PRIMARY KEY ( "id" )
);

CREATE TABLE "testsAndInterviews"."application_test"
(
 "id"             uuid NOT NULL DEFAULT uuid_generate_v4(),
 "start_time"     timestamp(3) NULL,
 "end_time"       timestamp(3) NULL,
 "test_id"        uuid NOT NULL,
 "application_id" uuid NOT NULL,
 CONSTRAINT "PK_application_test" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_233" FOREIGN KEY ( "test_id" ) REFERENCES "testsAndInterviews"."test" ( "id" ),
 CONSTRAINT "FK_236" FOREIGN KEY ( "application_id" ) REFERENCES application."application" ( "id" )
);

CREATE TABLE "testsAndInterviews"."interview"
(
 "id"             uuid NOT NULL DEFAULT uuid_generate_v4(),
 "start_time"     timestamp(3) NOT NULL,
 "end_time"       timestamp(3) NOT NULL,
 "application_id" uuid NOT NULL,
 CONSTRAINT "PK_interview" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_206" FOREIGN KEY ( "application_id" ) REFERENCES application."application" ( "id" )
);

CREATE TABLE "testsAndInterviews"."answers"
(
 "id"                  uuid NOT NULL DEFAULT uuid_generate_v4(),
 "total_grades"        varchar(10) NULL,
 "pass"                boolean NULL,
 "answer_details"      varchar NULL,
 "application_test_id" uuid NOT NULL,
 "recruiter_id"        uuid NOT NULL,
 CONSTRAINT "PK_answers" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_228" FOREIGN KEY ( "application_test_id" ) REFERENCES "testsAndInterviews"."application_test" ( "id" ),
 CONSTRAINT "FK_274" FOREIGN KEY ( "recruiter_id" ) REFERENCES "evaluationAndStatus"."recruiter" ( "id" )
);

CREATE TABLE "testsAndInterviews"."interview_note"
(
 "id"           uuid NOT NULL DEFAULT uuid_generate_v4(),
 "notes"        varchar NULL,
 "pass"         boolean NULL,
 "interview_id" uuid NOT NULL,
 "recruiter_id" uuid NOT NULL,
 CONSTRAINT "PK_interview_note" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_216" FOREIGN KEY ( "interview_id" ) REFERENCES "testsAndInterviews"."interview" ( "id" ),
 CONSTRAINT "FK_270" FOREIGN KEY ( "recruiter_id" ) REFERENCES "evaluationAndStatus"."recruiter" ( "id" )
);



CREATE TABLE "evaluationAndStatus"."application_status"
(
 "id"   uuid NOT NULL DEFAULT uuid_generate_v4(),
 "stat" varchar NOT NULL,
 CONSTRAINT "PK_application_status" PRIMARY KEY ( "id" )
);

CREATE TABLE "evaluationAndStatus"."application_status_change"
(
 "id"                    uuid NOT NULL DEFAULT uuid_generate_v4(),
 "date_changed"          timestamp(3) NOT NULL,
 "application_status_id" uuid NOT NULL,
 "application_id"        uuid NOT NULL,
 CONSTRAINT "PK_application_status_change" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_263" FOREIGN KEY ( "application_status_id" ) REFERENCES "evaluationAndStatus"."application_status" ( "id" ),
 CONSTRAINT "FK_266" FOREIGN KEY ( "application_id" ) REFERENCES application."application" ( "id" )
);

CREATE TABLE "evaluationAndStatus"."applicant_evaluation"
(
 "id"             uuid NOT NULL DEFAULT uuid_generate_v4(),
 "notes"          varchar NOT NULL,
 "hired"          boolean NULL,
 "recruiter_id"   uuid NOT NULL,
 "application_id" uuid NOT NULL,
 CONSTRAINT "PK_applicant_evaluation" PRIMARY KEY ( "id" ),
 CONSTRAINT "FK_249" FOREIGN KEY ( "recruiter_id" ) REFERENCES "evaluationAndStatus"."recruiter" ( "id" ),
 CONSTRAINT "FK_252" FOREIGN KEY ( "application_id" ) REFERENCES application."application" ( "id" )
);