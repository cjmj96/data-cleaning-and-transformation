-- Identify property_type unique values to determine
-- its validity and accuracy (listing_prepared table)
SELECT DISTINCT property_type
FROM listing_prepared;

-- Identify room_type unique values to determine
-- its validity and accuracy (listing_prepared table)
SELECT DISTINCT room_type
FROM listing_prepared;

-- Identify host_response_time unique values to determine
-- its validity and accuracy (listing_prepared table)
SELECT DISTINCT host_response_time
FROM listing_prepared;

-- Ensure validity and accuracy of host_response_time
-- values (listing_prepared table)
UPDATE listing_prepared
SET host_response_time = NULL
WHERE host_response_time = 'N/A';

-- Identify host_neighbourhood unique values to determine
-- its validity and accuracy (listing_prepared table)
SELECT DISTINCT host_neighbourhood
FROM listing_prepared;

-- Transform data to ensure data validity and accuracy of host_neighbourhood values
--  Step 1: Create a Reference Table for Standard Neighborhood Names
CREATE TABLE standard_neighborhoods (
    id SERIAL PRIMARY KEY,
    neighborhood_name VARCHAR(100) UNIQUE NOT NULL
);

--  Insert the standard neighborhood names into this table
INSERT INTO standard_neighborhoods (neighborhood_name)
VALUES
    ('Allston'),
    ('Back Bay'),
    ('Bay Vilage'),
	('Beacon Hill'),
	('Brighton'),
	('Charlestown'),
	('Chinatown-Leather District'),
	('Dorchester'),
	('Downtown'),
	('East Boston'),
	('Fenway-Kenmore'),
	('Hyde Park'),
	('Jamaica Plain'),
	('Mattapan'),
	('Mid-Dorchester'),
	('Mission Hill'),
	('North End'),
	('Roslindale'),
	('Roxbury'),
	('South Boston'),
	('South End'),
	('West End'),
	('West Roxbury'),
	('Wharf District');

-- Step 2: Create a Mapping Table for Variants
CREATE TABLE neighborhood_mappings (
    variant_name TEXT PRIMARY KEY,
    standard_name TEXT NOT NULL REFERENCES standard_neighborhoods(neighborhood_name)
);

--  Insert the mappings into this table
INSERT INTO neighborhood_mappings (variant_name, standard_name)
VALUES
  ('West Yarmouth', 'Brighton'),
  ('Valley Village', 'Roxbury'),
  ('Malden', 'East Boston'),
  ('Allston-Brighton', 'Brighton'),
  ('City Point', 'South Boston'),
  ('Jeffries Point', 'East Boston'),
  ('North Falmouth', 'South Boston'),
  ('Rockport', 'Charlestown'),
  ('Paradise Valley Village', 'Beacon Hill'),
  ('D Street / West Broadway', 'South Boston'),
  ('Chestnut Hill', 'West Roxbury'),
  ('Wellington-Harrington', 'Allston'),
  ('Franklin Field South', 'Dorchester'),
  ('South Medford', 'Dorchester'),
  ('East Falmouth', 'Roslindale'),
  ('Vineyard Haven', 'Beacon Hill'),
  ('Bowdoin North / Mount Bowdoin',  'Dorchester'),
  ('Codman Square', 'Dorchester'),
  ('Spring Hill', 'Roslindale'),
  ('Theater District', 'Downtown'),
  ('Oak Square', 'Brighton'),
  ('Brook Farm', 'Roslindale'),
  ('West Fens', 'Fenway-Kenmore'),
  ('Waban', 'Brighton'),
  ('Harwich Port', 'Charlestown'),
  ('Ward Two', 'East Boston'),
  ('Wellington Hill', 'Mattapan'),
  ('Fort Point', 'South Boston'),
  ('Columbus Park / Andrew Square', 'South Boston'),
  ('Eagle Hill', 'East Boston'),
  ('Newton Highlands', 'Beacon Hill'),
  ('East Otis', 'South Boston'),
  ('Hell''s Kitchen', 'Chinatown-Leather District'),
  ('Sun Bay South', 'Brighton'),
  ('Peoplestown', 'South Boston'),
  ('Islington', 'Allston'),
  ('Fairmount Hill', 'Hyde Park'),
  ('Blackstone Boulevard Realty Plat Historic District', 'Jamaica Plain'),
  ('Cape Neddick', 'Jamaica Plain'),
  ('Brewster', 'Jamaica Plain'),
  ('Cambridgeport', 'Beacon Hill'),
  ('Gateway District', 'Downtown'),
  ('Boston Theater District', 'Downtown'),
  ('Newton', 'Fenway-Kenmore'),
  ('Popponesset', 'Fenway-Kenmore'),
  ('Cambridge', 'West End'),
  ('Nolita', 'Charlestown'),
  ('East Somerville', 'Charlestown'),
  ('Back Bay West', 'Roxbury'),
  ('Watertown', 'Fenway-Kenmore'),
  ('Dudley / Brunswick King', 'Dorchester'),
  ('Downtown Crossing', 'Chinatown-Leather District'),
  ('Cedar Grove', 'Dorchester'),
  ('Southern Mattapan', 'Mattapan'),
  ('Orient Heights', 'East Boston'),
  ('Noe Valley', 'West Roxbury'),
  ('Lower Washington / Mount Hope', 'Roslindale'),
  ('Barney Circle', 'North End'),
  ('Belmar', 'Fenway-Kenmore'),
  ('Dennis Port', 'Dorchester'),
  ('Boylston Street', 'Jamaica Plain'),
  ('Mid-Cambridge', 'Brighton'),
  ('Brookline', 'Brighton'),
  ('Financial District', 'Downtown'),
  ('Riverside', 'Dorchester'),
  ('Longwood Medical and Academic Area', 'Fenway-Kenmore'),
  ('Burbank Gardens Neighborhood Association', 'Charlestown'),
  ('South Scottsdale', 'Jamaica Plain'),
  ('Metropolitan Hill / Beech Street', 'Roslindale'),
  ('Fenway/Kenmore', 'Fenway-Kenmore'),
  ('Chinatown', 'Chinatown-Leather District'),
  ('Coolidge Corner', 'Fenway-Kenmore'),
  ('South Beach', 'Jamaica Plain'),
  ('Stony Brook / Cleary Square', 'Hyde Park'),
  ('South Sanford', 'South Boston'),
  ('Franklin Field North', 'Dorchester'),
  ('Newport East', 'Mission Hill'),
  ('Leather District', 'Downtown'),
  ('East Downtown', 'Back Bay'),
  ('Harbor View / Orient Heights', 'East Boston'),
  ('Midtown - Downtown', 'South Boston'),
  ('Medford Street / The Neck', 'Charlestown'),
  ('White Rock East', 'North End'),
  ('Williamsburg', 'Brighton'),
  ('Prudential / St. Botolph', 'Back Bay'),
  ('Lower Allston', 'Allston'),
  ('Harvard Square', 'Beacon Hill'),
  ('Tribeca', 'South Boston'),
  ('Whitney', 'Roxbury'),
  ('Upper East Side', 'Downtown'),
  ('Central City', 'Dorchester'),
  ('Commonwealth', 'Allston'),
  ('Hawthorne', 'Roxbury'),
  ('Redondo Beach', 'Charlestown'),
  ('West Street / River Street', 'Hyde Park'),
  ('St. Elizabeth''s', 'Brighton'),
  ('Dorchester Center', 'Dorchester'),
  ('Government Center', 'Beacon Hill'),
  ('Wanskuck', 'Dorchester');

--  Step 3: Update the host_neighborhood Column
UPDATE listing_prepared AS lp
SET host_neighbourhood = nm.standard_name
FROM neighborhood_mappings AS nm
WHERE lp.host_neighbourhood = nm.variant_name;

-- Step 4: Verify the update
SELECT DISTINCT host_neighborhood
FROM listing_prepared
ORDER BY host_neighborhood;

-- Create CTE containing Q1, Q3, and IQR for price column in the calendar_prepared table
WITH central_tendency_measures_price_calendar_prepared_cte AS (
	SELECT PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY price) AS Q1_price,
	  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY price) AS Q3_price
	  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY price) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY price) AS IQR_price
	FROM calendar_prepared
);

-- Create CTE containing Q1, Q3, and IQR for minimum_nights column in the listing_prepared table
WITH central_tendency_measures_minimum_nights_listing_prepared_cte AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY minimum_nights) AS Q1_minimum_nights,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY minimum_nights) AS Q3_minimum_nights,
        ((PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY minimum_nights)) - (PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY minimum_nights))) AS IQR_minimum_nights
    FROM listing_prepared
),
-- Create CTE containing Q1, Q3, and IQR for maximum_nights column in the listing_prepared table
central_tendency_measures_maximum_nights_listing_prepared_cte AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY maximum_nights) AS Q1_maximum_nights,
      PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY maximum_nights) AS Q3_maximum_nights,
      ((PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY maximum_nights)) - (PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY maximum_nights))) AS IQR_maximum_nights
    FROM listing_prepared
),
-- Create CTE containing Q1, Q3, and IQR for price column in the listing_prepared table
central_tendency_measures_price_listing_prepared_cte AS (
    SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS Q1_price,
      PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS Q3_price,
      ((PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price)) - (PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price))) AS IQR_price
    FROM listing_prepared
)

-- Repair data in the listing_prepared table using rule-based data cleaning
SELECT *
INTO listing_prepared_cleaned
FROM listing_prepared lp
WHERE
  -- Ensure data validity of host_listing_count
  lp.host_listings_count > 0
  -- Ensure data validity of host_total_listings_count
  AND lp.host_total_listings_count > 0
  -- Ensure data validity of latitude
  AND (lp.latitude BETWEEN 42.227859 AND 42.397259)
  -- Ensure data validity of longitude
  AND (lp.longitude BETWEEN -71.191208 AND -70.923042)
  -- Ensure data validity of accommodates
  AND lp.accommodates > 0
  -- Ensure data validity of bathrooms
  AND lp.bathrooms > 0
  -- Ensure data validity of bedrooms
  AND lp.bedrooms > 0
  -- Ensure data validity of beds
  AND lp.beds > 0
  -- Ensure data validity of price using IQR method for outlier detection
  AND lp.price BETWEEN ((SELECT Q1_price FROM central_tendency_measures_price_listing_prepared_cte) - 1.5 * (SELECT IQR_price FROM central_tendency_measures_price_listing_prepared_cte)) AND ((SELECT Q3_price FROM central_tendency_measures_price_listing_prepared_cte) + 1.5 * (SELECT IQR_price FROM central_tendency_measures_price_listing_prepared_cte))
  -- Ensure data currency
  AND (lp.calendar_last_scraped BETWEEN '2024-03-24' AND '2024-03-25')
  -- Ensure data validity of number_of_reviews
  AND lp.number_of_reviews >= 0
  -- Ensure data validity of number_of_reviews_ltm
  AND lp.number_of_reviews_ltm >= 0
  -- Ensure data validity of number_of_reviews_l30d
  AND lp.number_of_reviews_l30d >= 0
  -- Ensure data validity of first_review
  AND (lp.first_review BETWEEN '2008-08-01' AND '2024-03-24')
  -- Ensure data validity of last_review
  AND (lp.last_review BETWEEN '2008-08-01' AND '2024-03-24')
  -- Ensure data validity of review_scores_rating
  AND (lp.review_scores_rating BETWEEN 0 AND 5)
  -- Ensure data validity of reviews_per_month
  AND lp.reviews_per_month >= 0
  -- Ensure data validity of host_response_rate
  AND lp.host_response_rate BETWEEN 0 AND 1
  -- Ensure data validity of host_acceptance_rate
  AND lp.host_acceptance_rate BETWEEN 0 AND 1
  -- Ensure data validity of minimum_nights using IQR method for outlier detection
  AND lp.minimum_nights BETWEEN ((SELECT Q1_minimum_nights FROM central_tendency_measures_minimum_nights_listing_prepared_cte) - 1.5 * (SELECT IQR_minimum_nights FROM central_tendency_measures_minimum_nights_listing_prepared_cte)) AND ((SELECT Q3_minimum_nights FROM central_tendency_measures_minimum_nights_listing_prepared_cte) + 1.5 * (SELECT IQR_minimum_nights FROM central_tendency_measures_minimum_nights_listing_prepared_cte))
  -- Ensure data validity of maximum_nights using IQR method for outlier detection
  AND lp.maximum_nights BETWEEN ((SELECT Q1_maximum_nights FROM central_tendency_measures_maximum_nights_listing_prepared_cte) - 1.5 * (SELECT IQR_maximum_nights FROM central_tendency_measures_maximum_nights_listing_prepared_cte)) AND ((SELECT Q3_maximum_nights FROM central_tendency_measures_maximum_nights_listing_prepared_cte) + 1.5 * (SELECT IQR_maximum_nights FROM central_tendency_measures_maximum_nights_listing_prepared_cte));

-- Identify duplicate data in the listing_prepared_cleaned table
SELECT id, COUNT(*)
FROM listing_prepared_cleaned
GROUP BY id
HAVING COUNT(*) > 1;

-- Identify and count missing values in the listing_prepared_cleaned table
SELECT
  COUNT(*) FILTER (WHERE id IS NULL) AS id_nulls,
  COUNT(*) FILTER (WHERE name IS NULL) AS name_nulls,
  COUNT(*) FILTER (WHERE host_id IS NULL) AS host_id_nulls,
  COUNT(*) FILTER (WHERE host_name IS NULL) AS host_name_nulls,
  COUNT(*) FILTER (WHERE host_response_time IS NULL) AS host_response_time_nulls,
  COUNT(*) FILTER (WHERE host_response_rate IS NULL) AS host_response_rate_nulls,
  COUNT(*) FILTER (WHERE host_acceptance_rate IS NULL) AS host_acceptance_rate_nulls,
  COUNT(*) FILTER (WHERE host_is_superhost IS NULL) AS host_is_superhost_nulls,
  COUNT(*) FILTER (WHERE host_neighbourhood IS NULL) AS host_neighbourhood_nulls,
  COUNT(*) FILTER (WHERE host_listings_count IS NULL) AS host_listings_count_nulls,
  COUNT(*) FILTER (WHERE host_total_listings_count IS NULL) AS host_total_listings_count_nulls,
  COUNT(*) FILTER (WHERE latitude IS NULL) AS latitude_nulls,
  COUNT(*) FILTER (WHERE longitude IS NULL) AS longitude_nulls,
  COUNT(*) FILTER (WHERE property_type IS NULL) AS property_type_nulls,
  COUNT(*) FILTER (WHERE room_type  IS NULL) AS room_type_nulls,
  COUNT(*) FILTER (WHERE accommodates  IS NULL) AS accommodates_nulls,
  COUNT(*) FILTER (WHERE bathrooms IS NULL) AS bathrooms_nulls,
  COUNT(*) FILTER (WHERE bedrooms IS NULL) AS bedrooms_nulls,
  COUNT(*) FILTER (WHERE beds IS NULL) AS beds_nulls,
  COUNT(*) FILTER (WHERE amenities IS NULL) AS amenities_nulls,
  COUNT(*) FILTER (WHERE price IS NULL) AS price_nulls,
  COUNT(*) FILTER (WHERE minimum_nights IS NULL) AS minimum_nights_nulls,
  COUNT(*) FILTER (WHERE maximum_nights IS NULL) AS maximum_nights_nulls,
  COUNT(*) FILTER (WHERE calendar_last_scraped IS NULL) AS calendar_last_scraped_nulls,
  COUNT(*) FILTER (WHERE has_availability IS NULL) AS has_availability_nulls,
  COUNT(*) FILTER (WHERE number_of_reviews IS NULL) AS number_of_reviews_nulls,
  COUNT(*) FILTER (WHERE number_of_reviews_ltm IS NULL) AS number_of_reviews_ltm_nulls,
  COUNT(*) FILTER (WHERE number_of_reviews_l30d IS NULL) AS number_of_reviews_l30d_nulls,
  COUNT(*) FILTER (WHERE first_review IS NULL) AS first_review_nulls,
  COUNT(*) FILTER (WHERE last_review IS NULL) AS last_review_nulls,
  COUNT(*) FILTER (WHERE review_scores_rating IS NULL) AS review_scores_rating_nulls,
  COUNT(*) FILTER (WHERE reviews_per_month IS NULL) AS reviews_per_month_nulls
FROM listing_prepared_cleaned;

-- Fill in missing values present in host_neighbourhood column
UPDATE listing_prepared_cleaned
SET host_neighbourhood = CASE
    WHEN id = 633889528816089164 AND host_neighbourhood IS NULL THEN 'Fenway-Kenmore'
	WHEN id = 18305618 AND host_neighbourhood IS NULL THEN 'Hyde Park'
	WHEN id = 29739809  AND host_neighbourhood IS NULL THEN 'South End'
	WHEN id = 13797162  AND host_neighbourhood IS NULL THEN 'Roxbury'
	WHEN id = 6609546  AND host_neighbourhood IS NULL THEN 'Downtown'
	WHEN id = 6248970  AND host_neighbourhood IS NULL THEN 'Jamaica Plain'
	WHEN id = 8483020  AND host_neighbourhood IS NULL THEN 'Hyde Park'
	WHEN id = 28912741  AND host_neighbourhood IS NULL THEN 'South Boston'
	WHEN id = 5782221  AND host_neighbourhood IS NULL THEN 'South Boston'
	WHEN id = 6914622  AND host_neighbourhood IS NULL THEN 'Jamaica Plain'
	WHEN id = 8170181  AND host_neighbourhood IS NULL THEN 'Beacon Hill'
	WHEN id = 10132073  AND host_neighbourhood IS NULL THEN 'East Boston'
	WHEN id = 16892278  AND host_neighbourhood IS NULL THEN 'Roslindale'
	WHEN id = 17523133  AND host_neighbourhood IS NULL THEN 'Dorchester'
	WHEN id = 19373388  AND host_neighbourhood IS NULL THEN 'Dorchester'
	WHEN id = 24971621  AND host_neighbourhood IS NULL THEN 'West Roxbury'
	WHEN id = 28915006  AND host_neighbourhood IS NULL THEN 'East Boston'
	WHEN id = 29082416  AND host_neighbourhood IS NULL THEN 'Brighton'
	WHEN id = 34936983  AND host_neighbourhood IS NULL THEN 'Brighton'
	WHEN id = 36622810  AND host_neighbourhood IS NULL THEN 'Charlestown'
	WHEN id = 40439006  AND host_neighbourhood IS NULL THEN 'Dorchester'
	WHEN id = 40348580  AND host_neighbourhood IS NULL THEN 'Downtown'
    WHEN id = 1066879803257359794 AND host_neighbourhood IS NULL THEN 'East Boston'
    ELSE host_neighbourhood
END;

-- Perform complete case analysis (CCA) for host_is_superhost column
SELECT *
INTO listing_cleaned
FROM listing_prepared_cleaned lpc
WHERE
  host_is_superhost IS NOT NULL;

-- Create CTE containing Q1, Q3, and IQR for price column in the calendar_prepared table
WITH central_tendency_measures_price_calendar_prepared_cte AS (
	SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY price) AS Q1_price,
	  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price) AS Q3_price,
	  ((PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY price)) - (PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY price))) AS IQR_price
	FROM calendar_prepared
)

-- Repair data in the calendar_prepared table using rule-based data cleaning
SELECT *
INTO calendar_prepared_cleaned
FROM calendar_prepared cp
WHERE
  -- Ensure data validity of date
  cp.date BETWEEN '2024-03-24' AND '2025-03-24'
  -- Ensure data validity of price using IQR method for outlier detection
  AND cp.price BETWEEN ((SELECT Q1_price FROM central_tendency_measures_price_calendar_prepared_cte) - 1.5 * (SELECT IQR_price FROM central_tendency_measures_price_calendar_prepared_cte)) AND ((SELECT Q3_price FROM central_tendency_measures_price_calendar_prepared_cte) + 1.5 * (SELECT IQR_price FROM central_tendency_measures_price_calendar_prepared_cte));

-- Repair data in the review_prepared table using rule-based data cleaning
SELECT *
INTO review_prepared_cleaned
FROM review_prepared rp
WHERE
  -- Ensure data validity of date
  rp.date BETWEEN '2008-08-01' AND '2024-03-24';

-- Identify duplicate data in the listing_prepared_cleaned table
SELECT id, COUNT(*)
FROM review_prepared
GROUP BY id
HAVING COUNT(*) > 1;
