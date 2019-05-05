--Daily refresh
TRUNCATE TABLE test.dbo.dim_location

--Load into dim_location
INSERT INTO dim_location
(
loc_key,
loc_name,
loc_type
)
SELECT
loc_key,
loc_name,
loc_type
FROM test.dbo.stg_location
