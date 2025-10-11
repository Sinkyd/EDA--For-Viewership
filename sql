CREATE OR REPLACE VIEW joined_data AS
WITH temp_user_info AS (
  SELECT
    UserID,
    COALESCE(Name, 'Unknown') AS Name,
    COALESCE(Province, 'Unknown') AS Province,
    COALESCE(Gender, 'Unknown') AS Gender,
    COALESCE(Race, 'Unknown') AS Race,
    CASE
      WHEN Age < 1 THEN 'infant'
      WHEN Age >= 1 AND Age <= 5 THEN 'child'
      WHEN Age = 5 THEN 'junior'
      WHEN Age >= 13 AND Age <= 16 THEN 'teen'
      WHEN Age >= 17 AND Age <= 25 THEN 'youth'
      WHEN Age >= 26 AND Age <= 35 THEN 'adult'
      WHEN Age = 36 THEN 'elders'
      ELSE 'Unknown'
    END AS age_bucket
  FROM workspace.default.user_profiles_btv
