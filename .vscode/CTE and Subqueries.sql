SELECT *
FROM (
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- cte definition

SELECT name AS company_name,
    company_id
FROM company_dim
WHERE company_id IN (
SELECT
    company_id
FROM
    job_postings_fact
WHERE
    job_no_degree_mention = true
ORDER BY 
    company_id
)

-- sub query

WITH company_job_count AS ( 
    SELECT
            company_id,
            COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC;

/*
Practice Problem 1
Question:
Identify the top 5 skills that are most frequently mentioned in job postings.
 Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table 
 and then join this result with the skills_dim table to get the skill names.
*/ 

SELECT
    skills_dim.skills AS skill_name,
    top_skills.skill_count
FROM ( 
    SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM
    skills_job_dim
GROUP BY 
    skill_id
ORDER BY
    skill_count DESC
) 

AS top_skills
INNER JOIN skills_dim
 ON top_skills.skill_id = skills_dim.skill_id;

/*
Practice Problem 2
Question:
Determine the size category ('Small', 'Medium', or 'Large') for each company 
by first identifying the number of job postings they have. 
Use a subquery to calculate the total job postings per company. 
A company is considered 'Small' if it has less than 10 job postings, 
'Medium' if the number of job postings is between 10 and 50, and 'Large'
 if it has more than 50 job postings. Implement a subquery to aggregate 
 job counts per company before classifying them based on size.
*/

SELECT 
    company_dim.name AS company_name,
    job_count,
    company_dim.company_id,
    CASE
        WHEN job_count < 10 THEN 'SMALL'
        WHEN job_count BETWEEN 10 AND 50 THEN 'MEDIUM'
        WHEN job_count > 50 THEN 'LARGE'
        END AS size_category
FROM (
    SELECT
        company_id,
        COUNT(*) job_count
        FROM
            job_postings_fact
        GROUP BY 
            company_id
) AS total_counts
INNER JOIN company_dim
    ON total_counts.company_id = company_dim.company_id
ORDER BY
    job_count DESC; 



