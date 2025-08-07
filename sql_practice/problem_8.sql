/*
Find job postings from the first quarter that have a salary greater than $70K
- Combine job posting tables from the first quarter of 2023 (Jan–Mar)
- Gets job postings with an average yearly salary > $70,000
*/
SELECT 
    quarter_1_job_postings.job_title_short,
    quarter_1_job_postings.job_location,
    quarter_1_job_postings.job_via,
    quarter_1_job_postings.job_posted_date::date,
    quarter_1_job_postings.salary_year_avg
FROM(
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter_1_job_postings
WHERE
    quarter_1_job_postings.salary_year_avg > 70000 AND
    quarter_1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter_1_job_postings.salary_year_avg DESC