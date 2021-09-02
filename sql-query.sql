--This query gives you the average temperature, wind_speed and precipitation for stations La Guardia (725030) and JFK (744860) for every year on 12th June post 2010, in descending order of date and ascending order of station ID (stn).

SELECT
  -- Create a timestamp from the date components.
  stn,
  TIMESTAMP(CONCAT(year,"-",mo,"-",da)) AS timestamp,
  -- Replace numerical null values with actual null
  AVG(
  IF
    (temp=9999.9,
      NULL,
      temp)) AS temperature,
  AVG(
  IF
    (wdsp="999.9",
      NULL,
      CAST(wdsp AS Float64))) AS wind_speed,
  AVG(
    IF
    (prcp=99.99,
      0,
      prcp)) AS precipitation
FROM
  `bigquery-public-data.noaa_gsod.gsod20*`
WHERE
  CAST(YEAR AS INT64) > 2010
  AND CAST(MO AS INT64) = 6
  AND CAST(DA AS INT64) = 12
  AND (stn="725030" OR  -- La Guardia
    stn="744860")    -- JFK
GROUP BY
  stn,
  timestamp
ORDER BY
  timestamp DESC,
  stn ASC
