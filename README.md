# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

SQL queries? Check them out here:[project_sql folder](/project_sql/)
# Background
I started this project because I wanted a clearer picture of data analyst job market.As someone learning SQL, I wanted to know which skills actually pay well and which skills ones employers ask for most, so i focus my learning on what matters instead of guessing.

The data comes from the SQL course i'm taking[SQL Course](https://lukebarousse.com/sql). It's rich dataset covering job titles,salaries,locations, and the skills attached to each posting, which made it perfect for hands-on practice.

### The questions I set out to answer with SQL:
    1. What are the top-paying data analyst jobs?
    2. What skills do those top-paying jobs require?
    3. Which skills are in highest demand for data analysts?
    4. Which skills are linked to higher salaries?
    5. What are the most optimal skills to learn(high demand and high pay)?

# Tools I Used 
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis, ensurin collaboration and project tracking. 
# The Analysis
Each query for this project is aimed at investigating specific aspects of the data analysts job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles, I filtered data analyst position by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

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
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    SALARY_YEAR_AVG DESC
LIMIT 10
```
Here's the breakdown of the top data analyst jobs in  2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employement:** Companies limke SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Aanalyst to Director of Analytics, reflecting varied roles and speculations within data analytics.
![Top Paying Roles](assets\1_top_paying_roles.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results* 

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS (
    SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills   
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
 salary_year_avg DESC
 ```
 Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
 - **SQL** is leading with a bold count of 8.
 -**Python** follows closely with a bold count of 7.
 **Tableau** is also highly sought after, with a bold count of 6. Other skills like **R**, **Snowflake**,**Pandas**, and **Excel** show varying degrees of demand.
 ![Top Paying Skills](assets\2_top_paying_job_skills.png)

 ### 3. In- Demand Skills for Data Analysts
 This query helped identify the skills most frequently requested in job postings =,directing focus to areas with high demand.
 ```
 SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE   
    job_title_short ='Data Analyst' AND 
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
Here's the breakdown of the most demanded skills for data analysts in 2023.
-**SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.

-**Programming** and **Visualization** Tools like Python, Tableau and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support. 

Most In-Demand Skills for Data Analysts
| Skill      | Demand Count|
|------------|-------------|
|   SQL	     | 7,291       |
|   Excel	 | 4,611       |
|   Python	 | 4,330       |
|   Tableau  | 3,745       |
|   Power BI | 2,609       |
*Table of the demand for the top 5 skills in data analyst job postings*

Key insight: SQL is the most in-demand skill, with 7,291 mentions, followed by Excel and Python. These results highlight the importance of database querying, spreadsheet analysis, and programming in data analyst job postings.

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
Top 25 Highest-Paying Skills for Data Analysts
|	Skill	      |Average Annual Salary (USD)
|-----------------|---------------------------
|	PySpark	      | $208,172
|	Bitbucket	  |$189,155
|	Couchbase	  |$160,515
|	Watson	      |$160,515
|	DataRobot	  |$155,486
|	GitLab	      |$154,500
|	Swift	      |$153,750
|	Jupyter	      |$152,777
|	Pandas	      |$151,821
|   Elasticsearch |$145,000
|	Golang	      |$145,000
|	NumPy	      |$143,513
|	Databricks	  |$141,907
|	Linux	      |$136,508
|	Kubernetes	  |$132,500
|	Atlassian	  |$131,162
|	Twilio	      |$127,000
|	Airflow       |$126,103
|	Scikit-learn  |$125,781
|	Jenkins	      |$125,436
|	Notion	      |$125,000
|	Scala	      |$124,903
|	PostgreSQL	  |$123,879
|	GCP        	  |$122,500
|	MicroStrategy  $121,619
*Table of the average salary for the 25 paying skills for data analysts*
Key insight: PySpark ranks first, with an average annual salary of $208,172, followed by Bitbucket at $189,155. The list includes data-processing tools, programming libraries, cloud platforms, and DevOps technologies.
### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```
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
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

### Data Analyst Skills: Demand and Average Salary

| Skill ID | Skill | Demand Count | Average Annual Salary (USD) |
|---:|---|---:|---:|
| 8 | Go | 27 | $115,320 |
| 234 | Confluence | 11 | $114,210 |
| 97 | Hadoop | 22 | $113,193 |
| 80 | Snowflake | 37 | $112,948 |
| 74 | Azure | 34 | $111,225 |
| 77 | BigQuery | 13 | $109,654 |
*Table of the most optimal skills for data analysts sorted by salary*
Go has the highest average salary among these six skills, despite having fewer demand counts than Snowflake and Azure.
Snowflake and Azure show relatively high demand in this dataset, making them notable skills to explore.
The salary figures are relatively close, ranging from approximately $110,000 to $115,000 per year.
# What I Learned
# Conclusions