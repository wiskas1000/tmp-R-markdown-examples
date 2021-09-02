--This query gives you the number of complaints num_complaints for all individual complaint types complaint_type created every year and ordered in descending order of count of complaints num_complaints.



SELECT
  EXTRACT(YEAR
  FROM
    created_date) AS year,
  complaint_type,
  COUNT(1) AS num_complaints
FROM
  `bigquery-public-data.new_york.311_service_requests`
GROUP BY
  year,
  complaint_type
ORDER BY
  num_complaints DESC
