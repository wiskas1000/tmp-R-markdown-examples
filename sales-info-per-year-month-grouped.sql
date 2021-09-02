/*
the total quantity sold for each ProductId grouped by the month and year it was sold:
*/
SELECT
    EXTRACT (YEAR FROM Date) AS Year,
    EXTRACT (MONTH FROM Date) AS Month,
    ProductId,
    ROUND(MAX(UnitPrice), 2) AS UnitPrice,
    SUM(Quantity) AS UnitsSold
FROM
    `data-analytics-course5.sales.sales_info`
GROUP BY
  Year,
  Month,
  ProductId
ORDER BY
  Year,
  Month,
  ProductId;
