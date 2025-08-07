/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
  helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND (AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'New York, NY'
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25

/*
1. Niche & Specialized Tools Pay the Most
Top 3:

elasticsearch ($185K)

neo4j ($185K)

cassandra ($175K)

These are not typical “entry-level” tools. They're used for big data, NoSQL databases, and graph databases. Analysts who master them are likely working on complex, high-impact systems — often close to engineering or data architecture roles.

2. Programming with Back-End/Systems Knowledge Pays Off
perl, c, c++, unix, linux, shell, spring, java, express

All above $125K

These aren’t just analyst tools — they suggest low-level systems knowledge or the ability to build and deploy production-grade applications. This implies that the line between analyst and engineer is blurring at the high end.

3. Analysts Who Touch Cloud/Data Pipelines Are Valued
gcp ($135K), azure ($122K), airflow ($122K), kafka ($135K)

These skills reflect infrastructure & workflow orchestration, meaning these analysts are likely managing data pipelines, ETL, or cloud-based analytics — not just running SQL queries.

4. Analysts Still Need Python Stack, but It Pays Slightly Less
pandas, numpy, scikit-learn, plotly — all between $122K–$133K

These are core tools for data analysis & machine learning. While still lucrative, they don’t hit the very top — possibly because they’re more commonplace and expected.

5. Visualization & BI-Specific Tools Appear Less Frequently
qlik ($120K), plotly ($122K)

Fewer BI/visualization tools show up here, suggesting they don’t drive the highest salaries compared to cloud, pipelines, or engineering-focused tools.

/*