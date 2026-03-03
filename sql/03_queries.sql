-- QUERY 1: Enrollment size by phase
SELECT
    phase,
    COUNT(*)                        AS trial_count,
    ROUND(AVG(enrollment), 0)       AS avg_enrollment,
    MIN(enrollment)                 AS min_enrollment,
    MAX(enrollment)                 AS max_enrollment,
    ROUND(AVG(duration_months), 1)  AS avg_duration_months
FROM trials
WHERE enrollment > 0
GROUP BY phase
ORDER BY avg_enrollment DESC;


-- QUERY 2: Trial duration by funder type
SELECT
    funder_type,
    COUNT(*)                        AS trial_count,
    ROUND(AVG(enrollment), 0)       AS avg_enrollment,
    ROUND(AVG(duration_months), 1)  AS avg_duration_months
FROM trials
WHERE duration_months > 0
GROUP BY funder_type
ORDER BY avg_duration_months;


-- QUERY 3: Top 20 countries by trial activity
SELECT
    country,
    COUNT(DISTINCT nct_number)    AS trial_count,
    ROUND(AVG(enrollment), 0)     AS avg_enrollment,
    SUM(enrollment)               AS total_enrollment
FROM trial_countries
WHERE country != ''
GROUP BY country
ORDER BY trial_count DESC
LIMIT 20;


-- QUERY 4: Enrollment trend by start year
SELECT
    start_year,
    COUNT(*)                    AS trials_started,
    ROUND(AVG(enrollment), 0)   AS avg_enrollment,
    SUM(enrollment)             AS total_enrollment
FROM trials
WHERE start_year BETWEEN 2000 AND 2024
  AND enrollment > 0
GROUP BY start_year
ORDER BY start_year;


-- QUERY 5: Masking type vs enrollment
SELECT
    masking,
    COUNT(*)                        AS trial_count,
    ROUND(AVG(enrollment), 0)       AS avg_enrollment,
    ROUND(AVG(duration_months), 1)  AS avg_duration_months
FROM trials
WHERE masking IS NOT NULL
  AND enrollment > 0
GROUP BY masking
ORDER BY avg_enrollment DESC;


-- QUERY 6: Multinational vs single-country
SELECT
    CASE WHEN is_multinational = 1
         THEN 'Multinational'
         ELSE 'Single Country'
    END                             AS scope,
    COUNT(*)                        AS trial_count,
    ROUND(AVG(enrollment), 0)       AS avg_enrollment,
    ROUND(AVG(duration_months), 1)  AS avg_duration_months,
    ROUND(AVG(country_count), 1)    AS avg_countries
FROM trials
WHERE enrollment > 0
GROUP BY is_multinational;