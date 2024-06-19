--  Clone listing table for reproduction purposes
CREATE TABLE listing_prepared AS
SELECT *
FROM listing;
--
--  Clone calendar table for reproduction purposes
CREATE TABLE calendar_prepared AS
SELECT *
FROM calendar;
--
--  Clone review table for reproduction purposes
CREATE TABLE review_prepared AS
SELECT *
FROM review;
--
--  Change data type of id from the listing_prepared table
ALTER TABLE listing_prepared
ALTER COLUMN id TYPE BIGINT USING id::BIGINT;
--
--  Change data type of scrape_id from the listing_prepared table
ALTER TABLE listing_prepared
ALTER COLUMN scrape_id TYPE BIGINT USING id::BIGINT;
--
--  Change data type of host_id from the listing_prepared table
ALTER TABLE listing_prepared
ALTER COLUMN host_id TYPE BIGINT USING host_id::BIGINT;
--
--  Change data type of last_scraped from the listing_prepared table
ALTER TABLE listing_prepared
ALTER COLUMN last_scraped TYPE DATE USING (last_scraped::DATE);
--
--  Change data type of host_since from the listing_prepared table
ALTER TABLE listing_prepared
ALTER COLUMN host_since TYPE DATE USING (host_since::DATE);

--  Change data type of host_response_rate from the listing_prepare table
--  Step 1: Add a new column with the appropriate data type (numeric)
ALTER TABLE listing_prepared ADD COLUMN new_host_response_rate NUMERIC;
--
--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_response_rate =
	CASE
		WHEN host_response_rate = 'N/A' THEN NULL
		ELSE CAST(REPLACE(host_response_rate, '%', '') AS NUMERIC) / 100
	END;
--
--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_response_rate;
--
--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_response_rate TO host_response_rate;
--
--  Change data type of host_acceptance_rate from the listing_prepare table
--  Step 1: Add a new column with the appropriate data type (numeric)
ALTER TABLE listing_prepared ADD COLUMN new_host_acceptance_rate NUMERIC;
--
--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_acceptance_rate =
	CASE
		WHEN host_acceptance_rate = 'N/A' THEN NULL
		ELSE CAST(REPLACE(host_acceptance_rate, '%', '') AS NUMERIC) / 100
	END;
--
--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_acceptance_rate;
--
--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_acceptance_rate TO host_acceptance_rate;
--
--  Change data type of host_is_superhost from the listing_prepare table
--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE listing_prepared ADD COLUMN new_host_is_superhost BOOLEAN;
--
--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_is_superhost =
	CASE
		WHEN host_is_superhost = 't' THEN TRUE
		WHEN host_is_superhost = 'f' THEN FALSE
		WHEN host_is_superhost IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;
--
--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_is_superhost;
--
--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_is_superhost TO host_is_superhost;
--
--  Change data type of host_verifications from the listing_prepare table
ALTER TABLE listing_prepared
ALTER COLUMN host_verifications
TYPE TEXT[]
USING ARRAY[REPLACE(REPLACE(host_verifications, '[', ''), ']', '')];
--
--  Change data type of host_has_profile_pic from the listing_prepare table
--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE listing_prepared ADD COLUMN new_host_has_profile_pic BOOLEAN;
--
--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_has_profile_pic =
	CASE
		WHEN host_has_profile_pic = 't' THEN TRUE
		WHEN host_has_profile_pic = 'f' THEN FALSE
		WHEN host_has_profile_pic IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;
--
--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_has_profile_pic;
--
--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_has_profile_pic TO host_has_profile_pic;
--
--  Change data type of host_identity_verified from the listing_prepare table
--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE listing_prepared ADD COLUMN new_host_identity_verified BOOLEAN;
--
--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_host_identity_verified =
	CASE
		WHEN host_identity_verified = 't' THEN TRUE
		WHEN host_identity_verified = 'f' THEN FALSE
		WHEN host_identity_verified IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;
--
--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN host_identity_verified;
--
--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_host_identity_verified TO host_identity_verified;
--
--  Change data type of amenities from the listing_prepare table
ALTER TABLE listing_prepared
ALTER COLUMN amenities
TYPE TEXT[]
USING ARRAY[REPLACE(REPLACE(amenities, '[', ''), ']', '')];
--
--  Change data type of price from the listing_prepare table
ALTER TABLE listing_prepared
ALTER COLUMN price
TYPE NUMERIC(10, 2)
USING REPLACE(SUBSTR(price, 2), ',', '')::NUMERIC(10,2);
--
-- Change data type of calendar_updated from the listing_prepared table
ALTER TABLE listing_prepared
ALTER COLUMN calendar_updated TYPE DATE USING (calendar_updated::DATE);
--
--  Change data type of has_availability from the listing_prepare table
--
--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE listing_prepared ADD COLUMN new_has_availability BOOLEAN;
--
--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_has_availability =
	CASE
		WHEN has_availability = 't' THEN TRUE
		WHEN has_availability = 'f' THEN FALSE
		WHEN has_availability IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;
--
--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN has_availability;
--
--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_has_availability TO has_availability;
--
-- Change data type of calendar_last_scraped from the listing_prepared table
ALTER TABLE listing_prepared
ALTER COLUMN calendar_last_scraped TYPE DATE USING (calendar_last_scraped::DATE);
--
-- Change data type of first_review from the listing_prepared table
ALTER TABLE listing_prepared
ALTER COLUMN first_review TYPE DATE USING (first_review::DATE);
--
-- Change data type of last_review from the listing_prepared table
ALTER TABLE listing_prepared
ALTER COLUMN last_review TYPE DATE USING (last_review::DATE);
--
--  Change data type of instant_bookable from the listing_prepare table
--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE listing_prepared ADD COLUMN new_instant_bookable BOOLEAN;
--
--  Step 2: Update the new column based on the values in the original column
UPDATE listing_prepared SET new_instant_bookable =
	CASE
		WHEN instant_bookable = 't' THEN TRUE
		WHEN instant_bookable = 'f' THEN FALSE
		WHEN instant_bookable IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;
--
--  Step 3: Drop the old column
ALTER TABLE listing_prepared DROP COLUMN instant_bookable;
--
--  Step 4: Rename the new column to the original name
ALTER TABLE listing_prepared RENAME COLUMN new_instant_bookable TO instant_bookable;
--
--  Change data type of listing_id from the calendar_prepared table
ALTER TABLE calendar_prepared
ALTER COLUMN listing_id TYPE BIGINT USING listing_id::BIGINT;
--
--  Change data type of date from the calendar table
ALTER TABLE calendar_prepared
ALTER COLUMN date TYPE DATE USING (date::DATE);
--
--  Change data type of available from the calendar_prepared table
--  Step 1: Add a new NUMERIC (BOOLEAN) column
ALTER TABLE calendar_prepared ADD COLUMN new_available BOOLEAN;
--
--  Step 2: Update the new column based on the values in the original column
UPDATE calendar_prepared SET new_available =
	CASE
		WHEN available = 't' THEN TRUE
		WHEN available = 'f' THEN FALSE
		WHEN available IN ('N/A', ' ') THEN NULL
		ELSE NULL -- Handle unexpected values by setting them to NULL
	END;
--
--  Step 3: Drop the old column
ALTER TABLE calendar_prepared DROP COLUMN available;
--
--  Step 4: Rename the new column to the original name
ALTER TABLE calendar_prepared RENAME COLUMN new_available TO available;
--
--  Change data type of price from the calendar_prepared table
ALTER TABLE calendar_prepared
	ALTER COLUMN price
TYPE NUMERIC(10, 2)
USING REPLACE(SUBSTR(price, 2), ',', '')::NUMERIC(10,2);
--
--  Change data type of listing_id from the review_prepared table
ALTER TABLE review_prepared
ALTER COLUMN listing_id TYPE BIGINT USING listing_id::BIGINT;
--
--  Change data type of id from the review_prepared table
ALTER TABLE review_prepared
ALTER COLUMN id TYPE BIGINT USING id::BIGINT;
--
-- Change data type of date from the calendar table
ALTER TABLE review_prepared
ALTER COLUMN date TYPE DATE USING (date::DATE);
--
--  Change data type of reviewer_id from the review_prepared table
ALTER TABLE review_prepared
ALTER COLUMN reviewer_id TYPE BIGINT USING reviewer_id::BIGINT;
