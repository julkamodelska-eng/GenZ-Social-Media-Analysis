SELECT DISTINCT daily_usage_hours
FROM dbo.genz_social_media_usage_1M

SELECT COUNT(*) AS total_rows
FROM dbo.genz_social_media_usage_1M;
--==============================================================================================================================
--The most popular platforms

SELECT
      primary_platform,
      COUNT(*) AS users_count
FROM dbo.genz_social_media_usage_1M
GROUP BY primary_platform
ORDER BY users_count DESC; 

--Average daily usage hours

SELECT
     ROUND(AVG(TRY_CAST(daily_usage_hours AS FLOAT)),2) AS average_usage
FROM dbo.genz_social_media_usage_1M;

--Average social media usage hours by gender

SELECT
     gender,
     ROUND(AVG(TRY_CAST(daily_usage_hours AS FLOAT)),2) AS average_usage
FROM dbo.genz_social_media_usage_1M
GROUP BY gender
ORDER BY average_usage DESC;

--Relationship beetween night usage and mental health

SELECT
     CASE
         WHEN night_usage = '1' THEN 'Night User'
         WHEN night_usage = '0' THEN 'Non-Night User'
    END AS user_type,

    ROUND(
          AVG(TRY_CAST(mental_health_score AS FLOAT)),
          2
        ) AS avg_mental_health_score
FROM dbo.genz_social_media_usage_1M
GROUP BY night_usage;

--User segmentation based on daily social media usage

SELECT
    CASE
        WHEN TRY_CAST(daily_usage_hours AS FLOAT) > 5 THEN 'Heavy User'
        WHEN TRY_CAST(daily_usage_hours AS FLOAT) BETWEEN 2 AND 5 THEN 'Medium User'
        ELSE 'Light User'
    END AS user_type,

    COUNT(*) AS total_users
    
FROM dbo.genz_social_media_usage_1M
GROUP BY
     CASE
        WHEN TRY_CAST(daily_usage_hours AS FLOAT) > 5 THEN 'Heavy User'
        WHEN TRY_CAST(daily_usage_hours AS FLOAT) BETWEEN 2 AND 5 THEN 'Medium User'
        ELSE 'Light User'
    END;
         