# Introduction
This project breaks down what’s happening in the data job market. We’re looking at which roles pay the most, what skills companies are looking for, and where opportunities line up based on skills and salary.

Queries used: [project_sql folder](/project_sql/)
# Background
As a new and aspiring data analyst, I wanted to understand the job market and the skills needed to succeed in this field. I found the perfect project and teacher in Luke Barousse, who created an open-source course with the data needed to take a strong first step into the industry.

Course link: [Luke Barousse SQL intro](https://www.youtube.com/watch?v=7mz73uXD9DA)
# Tools I Used
To explore the data analyst job market, I relied on a few main tools:

- **SQL:** Used it to query the data and pull out key insights.

- **PostgreSQL:** The database I worked with to store and manage the job data.

- **Visual Studio Code:** The editor I used to write and run my SQL queries.

- **Git & GitHub:** Helped me keep track of changes and share my work easily.
# The Analysis
For this project, I ran a set of queries to look into different parts of the data analyst job market. Here’s what I did for each one:

### 1. Top Paying Data Analyst Jobs
To find the highest-paying roles, I filtered job listings by average salary and location, with a focus on roles based in NYC. This helped highlight where the best-paying opportunities are.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
```
### Insights:

- NYC Pays Big for Senior Analyst Roles
The highest salaries—up to $240K—come from roles like “Data Sector Analyst” and “Lead Data Analyst” tied to hedge funds and major tech firms. These aren’t entry-level jobs; they show how NYC rewards analysts who bring both domain knowledge and leadership.

- Tech & Finance Drive Demand
Companies like TikTok, Blink Health, and hedge funds are leading the charge, showing that NYC’s strongest opportunities for data analysts are in tech, healthcare, finance, and compliance-heavy industries.

- Even Traditional Titles Pay Well
Roles with titles like “Data Research Analyst” or “Data Associate” still land salaries in the $175K–$180K range. In NYC, even roles that sound standard often involve high-impact work, especially when tied to investor relations, compliance, or large-scale data environments.

### 2. Top paying Data Analyst Job Skills
This query pulls the top 10 highest-paying data analyst jobs in New York, NY (with non-null salaries), then joins them with related tables to show the skills required for each of those jobs. The final result lists job details, company names, and associated skills, sorted by salary from highest to lowest.

```sql
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
```

### Insights:

- SQL is the most frequently required skill, appearing in the highest number of top-paying job postings.

- Python, Pandas, and Excel are also highly sought after, highlighting the importance of programming and data manipulation skills.

- Tools and languages like Tableau, NumPy, and R also make notable appearances, showing demand for both data visualization and statistical analysis.

### 3. Top demanded skills for Data Analyst?

This query finds the top 10 most in-demand skills for Data Analyst roles in New York, NY. It counts how often each skill appears in job listings and ranks them by demand, showing which skills show up the most across relevant postings.

```sql
SELECT 
   skills,
   COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
   job_title_short = 'Data Analyst' AND job_location = 'New York, NY'
GROUP BY
   skills
ORDER BY
   demand_count DESC
LIMIT 10
```
### Insights:
- SQL is Essential
With 1,695 mentions, SQL is by far the most in-demand skill for data analysts in NYC. If you're not comfortable with SQL, you're missing the baseline requirement for most roles.

- Excel Still Matters
Despite the rise of newer tools, Excel (1,294 mentions) is the second most requested skill—showing that businesses still rely heavily on it for quick analysis, reporting, and day-to-day data tasks.

- Python and Tableau Are Core Tools
Both Python (988) and Tableau (968) are nearly tied in demand, pointing to a need for both data manipulation (Python) and data visualization (Tableau) in modern analyst roles.

### 4. Top Paying Skills for Data Analyst
This query finds the 25 highest-paying skills for Data Analyst roles in New York, NY by calculating the average salary for each skill, then sorting them from highest to lowest.

```sql
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
```
### Insights:

- Niche & Specialized Tools Pay the Most


    These are not typical “entry-level” tools. They're used for big data, NoSQL databases, and graph databases. Analysts who master them are likely working on complex, high-impact systems — often close to engineering or data architecture roles.

- Programming with Back-End/Systems Knowledge Pays Off
    perl, c, c++, unix, linux, shell, spring, java, express
    
    All above $125K

    These aren’t just analyst tools — they suggest low-level systems knowledge or the ability to build and deploy production-grade applications. This implies that the line between analyst and engineer is blurring at the high end.

- Analysts Who Touch Cloud/Data Pipelines Are Valued
    gcp ($135K), azure ($122K), airflow ($122K), kafka ($135K)

    These skills reflect infrastructure & workflow orchestration, meaning these analysts are likely managing data pipelines, ETL, or cloud-based analytics — not just running SQL queries.

- Analysts Still Need Python Stack, but It Pays Slightly Less
    pandas, numpy, scikit-learn, plotly — all between $122K–$133K

    These are core tools for data analysis & machine learning. While still lucrative, they don’t hit the very top — possibly because they’re more commonplace and expected.

- Visualization & BI-Specific Tools Appear Less Frequently
    qlik ($120K), plotly ($122K)

    Fewer BI/visualization tools show up here, suggesting they don’t drive the highest salaries compared to cloud, pipelines, or engineering-focused tools.

### 5. Optimal skills to learn as a Data Analyst
This query pulls the top 25 skills for Data Analyst jobs in New York, NY that appear in more than 10 job listings. For each skill, it shows:

The number of jobs requiring it (demand count)

The average salary for those jobs

Results are sorted by highest average salary first, then by demand, giving a balanced view of high-paying and in-demand skills.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'New York, NY'
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
### Insights:
- Niche Tools Pay More, Even if Demand is Low
Skills like Express ($126K), Azure ($122K), and Snowflake ($119K) appear in fewer job listings (10–15), but they command higher average salaries. This suggests that less common, specialized tools can give you a big salary boost.

- Core Skills Are Widely Required but Pay Slightly Less
SQL (206 listings), Excel (140), Python (126), and Tableau (116) are the most in-demand, but average salaries range from $92K to $110K. These are must-know tools, but because they're common, they don’t push salaries as high on their own.

- Visualization & BI Tools Are Strong Middle Ground
Tools like Power BI, Looker, and Tableau offer solid pay ($95K–$111K) and show up frequently. These sit in the sweet spot of being both in-demand and decently compensated, making them good targets for skill-building.

# What I Learned
Throughout this project, I strengthened my SQL skills across several core areas:

Advanced Query Building: Learned to write more complex queries using JOIN, CTE (WITH) clauses, and subqueries to combine and organize data from multiple tables efficiently.

Data Aggregation: Applied functions like COUNT(), AVG(), and GROUP BY to summarize large datasets and extract meaningful insights.

Skill and Salary Analysis: Used filtering, grouping, and aggregation to evaluate the relationship between specific skills and salary trends across data analyst roles in New York.

Ranking and Demand Measurement: Identified top-paying jobs and most in-demand skills by writing queries that rank and count job postings based on selected criteria.

Insight Extraction: Improved my ability to translate raw job posting data into clear, actionable takeaways that highlight salary ranges, market demand, and valuable technical skills for data analysts.


# Conclusions

This project gave me a practical, hands-on look at the data analyst job market in New York. By working directly with real job posting data, I was able to explore which roles pay the most, which skills are most in demand, and how different tools and technologies connect to salary trends.

Through this process, I developed a deeper understanding of SQL and data analysis. I practiced everything from joining and filtering tables to building queries that surface meaningful patterns in large datasets. Most importantly, I learned how to go beyond just writing queries—I learned how to extract insights that matter.

This was a strong first step in my journey as a data analyst, and it gave me a clearer view of what the field expects and how I can continue building toward it.
