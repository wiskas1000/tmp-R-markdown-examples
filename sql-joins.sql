/*
    Basic inner join
*/

SELECT
    edu.country_name,
    summary.country_code,
    edu.value
FROM
    `bigquery-public-data.world_bank_intl_education.international_education` AS edu
INNER JOIN
    `bigquery-public-data.world_bank_intl_education.country_summary` AS summary
ON edu.country_code = summary.country_code


/*
    Give the average values per region, joining education and summary on country code. Region should not be null. Grouping thus by region, ordering on average value.
*/

SELECT
    AVG(edu.value) average_value, summary.region
FROM
    `bigquery-public-data.world_bank_intl_education.international_education` AS edu
INNER JOIN
    `bigquery-public-data.world_bank_intl_education.country_summary` AS summary
ON edu.country_code = summary.country_code
WHERE summary.region IS NOT null
GROUP BY summary.region
ORDER BY average_value DESC

/*
    Left join example to add data of mascottes, but list all universities.
*/

SELECT
 seasons.market AS university,
 seasons.name AS team_name,
 seasons.wins,
 seasons.losses,
 seasons.ties,
 mascots.mascot AS team_mascot
FROM
 `bigquery-public-data.ncaa_basketball.mbb_historical_teams_seasons` AS seasons
LEFT JOIN
 `bigquery-public-data.ncaa_basketball.mascots` AS mascots
ON
 seasons.team_id = mascots.id
WHERE
 seasons.season = 1984
 AND seasons.division = 1
ORDER BY
 seasons.market
