/*
Question: What skills are required for the top-paying data analyst jobs?
– Use the top 10 highest-paying Data Analyst jobs from first query
– Add the specific skills required for these roles
– Why? It provides a detailed look at which high-paying jobs demand certain skills,
        helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact AS jpf
    LEFT JOIN company_dim  ON jpf.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'New York, NY' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY
    salary_year_avg DESC

/*
Insights:
SQL is the most frequently required skill, appearing in the highest number of top-paying job postings.

Python, Pandas, and Excel are also highly sought after, highlighting the importance of programming and data manipulation skills.

Tools and languages like Tableau, NumPy, and R also make notable appearances, showing demand for both data visualization and statistical analysis.
/*