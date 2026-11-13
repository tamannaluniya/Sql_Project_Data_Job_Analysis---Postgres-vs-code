SELECT
   COUNT(job_id) AS number_of_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'REMOTE'
        WHEN job_location =  'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

/* Practice Problem 1
Question:
I want to categorize the salaries from each job posting. To see if it fits in my desired salary range.
Put salary into different buckets
Define what's a high, standard, or low salary with our own conditions
Why? It is easy to determine which job postings are worth looking at based on salary. Bucketing is a common practice in data analysis when viewing categories.
I only want to look at data analyst roles
Order from highest to lowest
Solution:
Result:
*/

SELECT
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg > 100000 THEN 'High_salary'
        WHEN salary_year_avg > 50000 AND salary_year_avg < 100000 THEN 'Standard'
        ELSE 'Low'
    END AS salary_bucket
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC