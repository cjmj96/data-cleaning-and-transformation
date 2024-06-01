--  Clone listing table for reproduction purposes
CREATE TABLE listing_prepared AS
SELECT *
FROM listing;

--  Clone calendar table for reproduction purposes
CREATE TABLE calendar_prepared AS
SELECT *
FROM calendar;

--  Clone calendar table for reproduction purposes
CREATE TABLE review_prepared AS
SELECT *
FROM review;

--  Change data type of id from the listing_prepare table
--  Step 1: Add a new column with the appropriate data type (bigserial)
ALTER TABLE listing_prepared ADD COLUMN new_id BIGSERIAL;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_id = id;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN id;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_id TO id;

--  Change data type of scrape_id from the listing_prepare table
--  Step 1: Add a new column with the appropriate data type (bigserial)
ALTER TABLE listing_prepared ADD COLUMN new_scrape_id BIGSERIAL;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_scrape_id = scrape_id;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN scrape_id;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_scrape_id TO scrape_id;

--  Change data type of last_scraped from the listing_prepare table
--  Step 1: Add a new column with the appropriate data type (date)
ALTER TABLE listing_prepared ADD COLUMN new_last_scraped DATE;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_last_scraped = last_scraped;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN last_scraped;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_last_scraped TO last_scraped;

--  Change data type of host_id from the listing_prepare table
--  Step 1: Add a new column with the appropriate data type (bigserial)
ALTER TABLE listing_prepared ADD COLUMN new_host_id BIGSERIAL;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_id = host_id;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_id;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_id TO host_id;

--  Change data type of host_since from the listing_prepare table
--  Step 1: Add a new column with the appropriate data type (date)
ALTER TABLE listing_prepared ADD COLUMN new_host_since DATE;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_since = host_since;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_since;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_since TO host_since;

--  Change data type of host_response_rate from the listing_prepare table
--  Step 1: Add a new column with the appropriate data type (numeric)
ALTER TABLE listing_prepared ADD COLUMN new_host_response_rate NUMERIC;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_response_rate =
	CASE
		WHEN host_response_rate = 'N/A' THEN NULL
		ELSE CAST(REPLACE(host_response_rate, '%', '') AS NUMERIC) / 100
	END;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_response_rate;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_response_rate TO host_response_rate;

--  Change data type of host_acceptance_rate from the listing_prepare table
--  Step 1: Add a new column with the appropriate data type (numeric)
ALTER TABLE listing_prepared ADD COLUMN new_host_acceptance_rate NUMERIC;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_acceptance_rate =
	CASE
		WHEN host_acceptance_rate = 'N/A' THEN NULL
		ELSE CAST(REPLACE(host_acceptance_rate, '%', '') AS NUMERIC) / 100
	END;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_acceptance_rate;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_acceptance_rate TO host_acceptance_rate;

--  Change data type of host_is_superhost from the listing_prepare table

--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE listing_prepared ADD COLUMN new_host_is_superhost BOOLEAN;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_is_superhost =
	CASE
		WHEN host_is_superhost = 't' THEN TRUE
		WHEN host_is_superhost = 'f' THEN FALSE
		WHEN host_is_superhost IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_is_superhost;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_is_superhost TO host_is_superhost;

--  Change data type of host_verifications from the listing_prepare table

--  Step 1: Add a new array of text column
ALTER TABLE listing_prepared ADD COLUMN new_host_verifications TEXT[];

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_verifications =
  REPLACE(REPLACE(host_verifications, '[', '{'), ']', '}')::TEXT[];

--  Step 3: Update empty arrays with NULL values
UPDATE listing_prepared
SET new_host_verifications = NULLIF(host_verifications, '{NULL}');

--  Step 4: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_verifications;

--  Step 5: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_verifications TO host_verifications;

--  Change data type of host_has_profile_pic from the listing_prepare table

--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE listing_prepared ADD COLUMN new_host_has_profile_pic BOOLEAN;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_has_profile_pic =
	CASE
		WHEN host_has_profile_pic = 't' THEN TRUE
		WHEN host_has_profile_pic = 'f' THEN FALSE
		WHEN host_has_profile_pic IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_has_profile_pic;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_has_profile_pic TO host_has_profile_pic;

--  Change data type of host_identity_verified from the listing_prepare table

--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE listing_prepared ADD COLUMN new_host_identity_verified BOOLEAN;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_identity_verified =
	CASE
		WHEN host_identity_verified = 't' THEN TRUE
		WHEN host_identity_verified = 'f' THEN FALSE
		WHEN host_identity_verified IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_identity_verified;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_identity_verified TO host_identity_verified;

--  Change data type of amenities from the listing_prepare table

--  Step 1: Add a new column with the appropriate data type (TEXT[])
ALTER TABLE listing_prepared ADD COLUMN new_amenities TEXT[];

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_amenities =
  REPLACE(REPLACE(amenities, '[', '{'), ']', '}')::TEXT[];

--  Step 3: Update empty arrays with NULL values
UPDATE listing_prepared
SET new_amenities = NULLIF(amenities, '{NULL}');

--  Step 4: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN amenities;

--  Step 5: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_amenities TO amenities;

--  Change data type of price from the listing_prepare table

--  Step 1: Add a new column with the appropriate data type (float8)
ALTER TABLE listing_prepared ADD COLUMN new_price FLOAT8;

--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_price =
  REPLACE(SUBSTR(price, 2), ',',  '')::FLOAT8;

--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN price;

--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_price TO price;

--  Change data type of listing_id from the calendar table

--  Step 1: Add a new column with the appropriate data type (bigserial)
ALTER TABLE calendar_prepared ADD COLUMN new_listing_id BIGSERIAL;

--  Step 2: Update the new column based on the values in the original column
UPDATE calendar_prepared SET new_listing_id = listing_id;

--  Step 3: Drop the old column
ALTER TABLE calendar_prepared DROP COLUMN listing_id;

--  Step 4: Rename the new column to the original name
ALTER TABLE calendar_prepared RENAME COLUMN new_listing_id TO listing_id;

--  Change data type of price from the calendar_prepared table

--  Step 1: Add a new column with the appropriate data type (float8)
ALTER TABLE calendar_prepared ADD COLUMN new_price FLOAT8;

--  Step 2: Update the new column based on the values in the original column
UPDATE calendar_prepared SET new_price = REPLACE(SUBSTR(price, 2), ',',  '')::FLOAT8;

--  Step 3: Drop the old column
ALTER TABLE calendar_prepared DROP COLUMN price;

--  Step 4: Rename the new column to the original name
ALTER TABLE calendar_prepared RENAME COLUMN new_price TO price;

--  Change data type of date from the calendar_prepared table

--  Step 1: Add a new column with the appropriate data type (date)
ALTER TABLE calendar_prepared ADD COLUMN new_date DATE;

--  Step 2: Update the new column based on the values in the original column
UPDATE calendar_prepared SET new_date = date;

--  Step 3: Drop the old column
ALTER TABLE calendar_prepared DROP COLUMN date;

--  Step 4: Rename the new column to the original name
ALTER TABLE calendar_prepared RENAME COLUMN new_date TO date;

--  Change data type of available from the calendar_prepared table

--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE calendar_prepared ADD COLUMN new_available BOOLEAN;

--  Step 2: Update the new column based on the values in the original column
UPDATE calendar_prepared SET new_available =
	CASE
		WHEN available = 't' THEN TRUE
		WHEN available = 'f' THEN FALSE
		WHEN available IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;

--  Step 3: Drop the old column
ALTER TABLE calendar_prepared DROP COLUMN available;

--  Step 4: Rename the new column to the original name
ALTER TABLE calendar_prepared RENAME COLUMN new_available TO available;

--  Change data type of price from the calendar_prepared table

--  Step 1: Add a new column with the appropriate data type (float8)
ALTER TABLE calendar_prepared ADD COLUMN new_price FLOAT8;

--  Step 2: Update the new column based on the values in the original column
UPDATE calendar_prepared SET new_price = REPLACE(SUBSTR(price, 2), ',',  '')::FLOAT8;

--  Step 3: Drop the old column
ALTER TABLE calendar_prepared DROP COLUMN price;

--  Step 4: Rename the new column to the original name
ALTER TABLE calendar_prepared RENAME COLUMN new_price TO price;

--  Change data type of minimum_nights from the calendar_prepared table

--  Step 1: Add a new column with the appropriate data type (INTEGER)
ALTER TABLE calendar_prepared ADD COLUMN new_minimum_nights INTEGER;

--  Step 2: Update the new column based on the values in the original column
UPDATE calendar_prepared SET new_minimum_nights = minimum_nights;

--  Step 3: Drop the old column
ALTER TABLE calendar_prepared DROP COLUMN minimum_nights;

--  Step 4: Rename the new column to the original name
ALTER TABLE calendar_prepared RENAME COLUMN new_minimum_nights TO minimum_nights;

--  Change data type of maximum_nights from the calendar_prepared table

--  Step 1: Add a new column with the appropriate data type (INTEGER)
ALTER TABLE calendar_prepared ADD COLUMN new_maximum_nights INTEGER;

--  Step 2: Update the new column based on the values in the original column
UPDATE calendar_prepared SET new_maximum_nights = maximum_nights;

--  Step 3: Drop the old column
ALTER TABLE calendar_prepared DROP COLUMN maximum_nights;

--  Step 4: Rename the new column to the original name
ALTER TABLE calendar_prepared RENAME COLUMN new_maximum_nights TO maximum_nights;

--  Change data type of listing_id from the review_prepared table

--  Step 1: Add a new column with the appropriate data type (BIGSERIAL)
ALTER TABLE review_prepared ADD COLUMN new_listing_id BIGSERIAL;

--  Step 2: Update the new column based on the values in the original column
UPDATE review_prepared SET new_listing_id = listing_id;

--  Step 3: Drop the old column
ALTER TABLE review_prepared DROP COLUMN listing_id;

--  Step 4: Rename the new column to the original name
ALTER TABLE review_prepared RENAME COLUMN new_listing_id TO listing_id;

--  Change data type of id from the review_prepared table

--  Step 1: Add a new column with the appropriate data type (BIGSERIAL)
ALTER TABLE review_prepared ADD COLUMN new_id BIGSERIAL;

--  Step 2: Update the new column based on the values in the original column
UPDATE review_prepared SET new_id = id;

--  Step 3: Drop the old column
ALTER TABLE review_prepared DROP COLUMN id;

--  Step 4: Rename the new column to the original name
ALTER TABLE review_prepared RENAME COLUMN new_id TO id;

--  Change data type of date from the review_prepared table

--  Step 1: Add a new column with the appropriate data type (date)
ALTER TABLE calendar_prepared ADD COLUMN new_date DATE;

--  Step 2: Update the new column based on the values in the original column
UPDATE calendar_prepared SET new_date = date;

--  Step 3: Drop the old column
ALTER TABLE calendar_prepared DROP COLUMN date;

--  Step 4: Rename the new column to the original name
ALTER TABLE calendar_prepared RENAME COLUMN new_date TO date;

--  Change data type of reviewer_id from the review_prepared table

--  Step 1: Add a new column with the appropriate data type (BIGSERIAL)
ALTER TABLE review_prepared ADD COLUMN new_reviewer_id BIGSERIAL;

--  Step 2: Update the new column based on the values in the original column
UPDATE review_prepared SET new_reviewer_id = reviewer_id;

--  Step 3: Drop the old column
ALTER TABLE review_prepared DROP COLUMN reviewer_id;

--  Step 4: Rename the new column to the original name
ALTER TABLE review_prepared RENAME COLUMN new_reviewer_id TO reviewer_id;
