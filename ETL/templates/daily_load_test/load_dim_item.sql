--daily refresh
Truncate TABLE  test.dbo.dim_item

--Loading data into dim item
INSERT INTO test.dbo.dim_item
(
item_key,
item_name
)
SELECT
item_key,
item_name
FROM test.dbo.stg_item
