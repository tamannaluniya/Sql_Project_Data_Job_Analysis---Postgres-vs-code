SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    febraury_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;

-- union all - combines the result of two or more SELECT statements

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    febraury_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs;

/*
Practice Problem 
Question 
- Get the corresponding skill and skill type for each job posting in q1
-Include those without any skills,too
- Why? Look at the skills and the type for each job in the first quarter that has a salary > 70000
*/


SELECT
    j.job_id,
    j.job_title,
    s.skills,
    s.type
FROM january_jobs AS j


LEFT JOIN skills_job_dim AS sj
    ON j.job_id = sj.job_id

INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id

WHERE j.salary_year_avg > 70000

UNION ALL

SELECT
    f.job_id,
    f.job_title,
    s.skills,
    s.type
FROM febraury_jobs AS f

LEFT JOIN skills_job_dim AS sj
    ON f.job_id = sj.job_id

LEFT JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id

WHERE f.salary_year_avg > 70000

UNION ALL

-- March jobs
SELECT
    m.job_id,
    m.job_title,
    s.skills,
    s.type
FROM march_jobs AS m

LEFT JOIN skills_job_dim AS sj
    ON m.job_id = sj.job_id

INNER JOIN skills_dim AS s
    ON sj.skill_id = s.skill_id

WHERE m.salary_year_avg > 70000;