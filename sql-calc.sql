/*
Simple addition
*/


SELECT
    Date,
    region,
    Small_Bags,
    Large_Bags,
    XLarge_Bags,
    Total_Bags,
    Small_Bags + Large_Bags + XLarge_Bags AS Total_Bags_Calc
FROM
    `data-analytics-course5.avocado_data.avocado_prices`

/*
Example with percentages, cant divide by 0
*/

SELECT
    Date,
    region,
    Small_Bags,
    Total_Bags,
    (Small_Bags / Total_Bags) * 100 AS Small_Bags_Percent
FROM
    `data-analytics-course5.avocado_data.avocado_prices`
WHERE
    Total_Bags <> 0
