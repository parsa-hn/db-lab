--a
select distinct "name"
from jobs.job_category;

--b
select count(*)
from "evaluationAndStatus".applicant_evaluation ae, application.application a, jobs.job j
where ae.application_id = a.id and a.jobs_id = j.id 
group by j.job_category_id;

--c
select distinct jp."name"
from application.applicant a, jobs.job j, jobs.job_position jp, application.application a2 
where a.id = a2.applicant_id and a2.jobs_id = j.id and j.job_position_id = jp.id;

select a.*
from application.applicant a
where  a.id not in (select a2.applicant_id
					from application.application a2);
--e					
SELECT jp."name", o."name" 
FROM jobs.job_position jp, jobs.organization o
LEFT JOIN jobs.job j on o.id = j.organization_id
where jp.id = j.job_position_id;

--f
select a2.*
from "testsAndInterviews".interview i, application.application a, application.applicant a2, application."document" d, application.application_document ad
where i.application_id = a.id and a.jobs_id = '67834df2-9dc7-4d09-a41e-6512579470fc' 
	  and a2.id = a.applicant_id and ad.application_id = a.id and ad.document_id = d.id and d."document" notnull;	 
	 
--g	 
select j."name" , jp."name" 
from jobs.job j , jobs.job j2 ,jobs.job_position jp 
where j."name" = 'job1' 
and j."name" = j2."name" 
and j2.job_position_id = jp.id;

select j."name"
from jobs.job j
group by j."name" 
having count(j.job_position_id) > 1;

--h
select t.max_score, a3.answer_details, a3.total_grades, in2.notes 
from application.applicant a, application.application a2, "testsAndInterviews".application_test at2, 
"testsAndInterviews".test t, "testsAndInterviews".answers a3, "testsAndInterviews".interview i, "testsAndInterviews".interview_note in2 
where at2.application_id = a2.id and a.id = a2.applicant_id and t.id = at2.test_id and a3.application_test_id = at2.id and i.application_id = a.id 
and in2.interview_id = i.id

--j
select job_platform_id , count(*) 
from jobs.job j2 
group by j2.job_platform_id
