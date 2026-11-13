SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT '2023-02-19' ::DATE;

SELECT 
    '2023-02-19' ::DATE,
    '123' ::INTEGER,
    'true' ::BOOLEAN,
    '3.14' ::REAL;

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM job_postings_fact;

--changing timezones to UTC to EST
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM job_postings_fact
LIMIT 5;

-- what is the purpose of this extract function?

SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    month
ORDER BY
    job_count DESC;

/* Practice Problem 1
Question:
Write a query to find the average salary both yearly (salary year_avg)and hourly (salary_hour_avg ) for job postings that were posted after June 1, 2023. Group the results by job schedule type.
*/

SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS avg_yearly,
    AVG(salary_hour_avg) AS avg_hourly
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type;

/*
Practice Problem 2
Question:
Write a query to count the number of job postings for each month in 2023, adjusting the job_posted_date to be in 'America/New_York' time zone before extracting (hint) the month.
Assume the job_posted_date is stored in UTC. Group by and order by the month.
*/

SELECT
    COUNT(job_id) AS job_count,
    EXTRACT (MONTH FROM job_posted_date AT TIME ZONE 'America/New_York') AS month
FROM
    job_postings_fact
WHERE
    EXTRACT (YEAR FROM job_posted_date AT TIME ZONE 'America/New_York') = '2023'
GROUP BY 
    month
ORDER BY
    month;
/*
Practice Problem 3
Question:
Write a query to find companies (include company name) that have posted jobs offering health insurance, where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter.
Solution:
Result:
*/

SELECT
    name AS company_name,
    job_id,
    job_title_short
FROM
    job_postings_fact
INNER JOIN
    company_dim AS c On job_postings_fact.company_id = c.company_id
WHERE
    job_health_insurance = TRUE AND
    (EXTRACT(QUARTER FROM job_posted_date) = 2)AND
    (EXTRACT(YEAR FROM job_posted_date) = '2023');

