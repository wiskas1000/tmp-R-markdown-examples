# Add entry
INSERT INTO
    `booming-oarlock-315811.customer_data.customer_address`
    (customer_id, address, city, state, zipcode, country)
VALUES 
    (2645, '333 SQL Road', 'Jackson', 'MI', 49202, 'US')

# Modify field, Update entry
UPDATE
    `booming-oarlock-315811.customer_data.customer_address`
SET 
    address = '123 New Address'
WHERE 
    customer_id = 2645

# Select distinct, unique, values
SELECT
    DISTINCT customer_id
FROM
    `booming-oarlock-315811.customer_data.customer_address`

# Show length of a string as the variable letters_in_country
SELECT
    LENGTH(country) AS letters_in_country
FROM
    `booming-oarlock-315811.customer_data.customer_address`

# Only show countries with a length over 2
SELECT
    country
FROM
    `booming-oarlock-315811.customer_data.customer_address`
WHERE
    LENGTH(country) > 2


# Show customer ids with first two characters being US
SELECT DISTINCT
    customer_id
FROM
    `booming-oarlock-315811.customer_data.customer_address`
WHERE
    SUBSTR(country, 1, 2) = 'US'

# Show states with a length over 2
SELECT 
    state
FROM 
    `booming-oarlock-315811.customer_data.customer_address`
WHERE 
    LENGTH(state) > 2


# TRIM VALUES. Show customer ids where the state of ohio is trimmed
SELECT DISTINCT
    customer_id
FROM
    `booming-oarlock-315811.customer_data.customer_address`
WHERE
    TRIM(state) = 'OH'
