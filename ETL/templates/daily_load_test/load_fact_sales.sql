
INSERT INTO test.dbo.fact_sales
(
    Fk_loc_id,
    FK_loc_type_id,
    FK_item_id,
    sales_date,
    sales_amount
)

SELECT
loc.loc_id,
lt.loc_type_id,
i.item_id,
s.sales_date,
s.sales_amount
FROM test.dbo.stg_sales s JOIN test.dbo.dim_location loc
ON s.location_key= loc.loc_key
JOIN test.dbo.dim_location_type lt
ON loc.loc_type=lt.loc_type_id
JOIN test.dbo.dim_item i
ON i.item_key=s.item_key
where s.sales_date<'{{ execution_date.strftime("%Y-%m-%d") }}'
