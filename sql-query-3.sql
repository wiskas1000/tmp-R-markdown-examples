--This query gives you the averages of temperature, wind_speed, visibility, wind_gust, precipitation and snow_depth for stations La Guardia (725030) and JFK (744860) for every year post 2008 grouped by date.


SELECT
  -- Create a timestamp from the date components.
  TIMESTAMP(CONCAT(year,"-",mo,"-",da)) AS timestamp,
  -- Replace numerical null values with actual nulls
  AVG(
  IF
    (temp=9999.9,
      NULL,
      temp)) AS temperature,
  AVG(
  IF
    (visib=999.9,
      NULL,
      visib)) AS visibility,
  AVG(
  IF
    (wdsp="999.9",
      NULL,
      CAST(wdsp AS Float64))) AS wind_speed,
  AVG(
  IF
    (gust=999.9,
      NULL,
      gust)) AS wind_gust,
  AVG(
  IF
    (prcp=99.99,
      NULL,
      prcp)) AS precipitation,
  AVG(
  IF
    (sndp=999.9,
      NULL,
      sndp)) AS snow_depth
FROM
  `bigquery-public-data.noaa_gsod.gsod20*`
WHERE
  CAST(YEAR AS INT64) > 2008
  AND (stn="725030" OR  -- La Guardia
    stn="744860")    -- JFK
GROUP BY
  timestamp
