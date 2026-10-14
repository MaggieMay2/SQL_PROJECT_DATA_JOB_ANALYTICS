-- January
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

    --February
CREATE TABLE February_jpobs AS
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;


        --March
    CREATE TABLE march_jpobs AS
    SELECT*
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;