--Daily report refresh
TRUNCATE TABLE test.dbo.sales_report

--Generate report on daily basis
INSERT INTO test.dbo.sales_report
(
location_name,
current_year_date,
current_year_sales,
last_year_date,
last_year_sales,
percentage_change
)

SELECT loc.Loc_Name AS location_name,
       cy.cy_date AS current_year_date,
       cy.cy_sales_amount AS current_year_sales,
       ly_date AS last_year_date,
       ISNULL(ly.ly_amount, 0) AS last_year_sales,
       CASE
           WHEN ly.ly_amount IS NULL THEN
               0
           ELSE
               ROUND((cy.cy_sales_amount - ISNULL(ly.ly_amount, 0)) * 100 / ISNULL(ly.ly_amount, 0), 2)
       END AS percentage_change
FROM
(
    SELECT fk_loc_id,
           sales_date AS cy_date,
           SUM(sales_amount) AS cy_sales_amount,
           CASE
               WHEN
               (
                   is_leap_year = 1
                   AND
                   (
                       DAY(cy.sales_date) = '29'
                       AND MONTH(cy.sales_date) = '02'
                   )
               ) THEN
                   NULL
               ELSE
                   DATEADD(yy, -1, cy.sales_date)
           END AS ly_date
    FROM
    (
        SELECT *,
               CASE
                   WHEN (
                            SUBSTRING(CAST(sales_date AS VARCHAR(20)), 1, 4) % 4 = 0
                            AND SUBSTRING(CAST(sales_date AS VARCHAR(20)), 1, 4) % 100 <> 0
                        )
                        OR (SUBSTRING(CAST(sales_date AS VARCHAR(20)), 1, 4) % 4 = 0) THEN
                       1
                   ELSE
                       0
               END is_leap_year
        FROM test.dbo.fact_sales
    ) cy
    GROUP BY fk_loc_id,
             sales_date,
             CASE
                 WHEN
                 (
                     is_leap_year = 1
                     AND
                     (
                         DAY(cy.sales_date) = '29'
                         AND MONTH(cy.sales_date) = '02'
                     )
                 ) THEN
                     NULL
                 ELSE
                     DATEADD(yy, -1, cy.sales_date)
             END
) cy
    LEFT JOIN
    (
        SELECT fk_loc_id AS ly_loc_id,
               sales_date AS ly_sales_date,
               SUM(sales_amount) ly_amount
        FROM test.dbo.fact_sales
        GROUP BY fk_loc_id,
                 sales_date
    ) ly
        ON cy.ly_date = ly.ly_sales_date
           AND cy.fk_loc_id = ly.ly_loc_id
    JOIN test.dbo.dim_location loc
        ON loc.Loc_id = cy.fk_loc_id
ORDER BY cy.fk_loc_id;
