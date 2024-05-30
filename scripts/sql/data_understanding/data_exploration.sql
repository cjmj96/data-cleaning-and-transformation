--  Number of currently available listings
SELECT COUNT(DISTINCT id) AS count_listings
FROM listing
WHERE has_availability = 't'
ORDER BY 1 DESC;

--  Number of neighboorhoods
SELECT COUNT(DISTINCT host_neighbourhood)
FROM listing
WHERE host_neighbourhood IS NOT NULL;

--  Number of hosts
SELECT COUNT(DISTINCT host_id) AS count_hosts
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't'
  OR host_is_superhost = 'f');

--  Number of hosts by type
SELECT COUNT(DISTINCT host_id) FILTER (WHERE host_is_superhost = 't' AND has_availability = 't') AS count_superhosts,
  COUNT(DISTINCT host_id) FILTER (WHERE host_is_superhost = 'f' AND has_availability = 't') AS count_regular_hosts
FROM listing;

--  Number of professional hosts
SELECT COUNT(*) AS count_professional_hosts,
  SUM(count_listings) AS count_listings_professional_hosts
FROM (
  SELECT host_name,
	COUNT(DISTINCT id) AS count_listings
  FROM listing
  WHERE has_availability = 't' AND (host_is_superhost = 't'
  OR host_is_superhost = 'f')
  GROUP BY 1
  HAVING COUNT(DISTINCT id) > 21
  ORDER BY 2 DESC
);

--  Number of professional hosts by neighboorhood
SELECT
  host_neighbourhood,
  COUNT(*) AS count_professional_hosts
FROM (
  SELECT
	host_neighbourhood,
	host_name,
	COUNT(DISTINCT id) AS count_listings
  FROM listing
  WHERE has_availability = 't' AND (host_is_superhost = 't' OR host_is_superhost = 'f')
  GROUP BY host_neighbourhood, host_name
  HAVING COUNT(DISTINCT id) > 21
  ORDER BY 3 DESC
)
GROUP BY host_neighbourhood
ORDER BY count_professional_hosts DESC;

--  Number of different property types
SELECT COUNT(DISTINCT property_type)
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't'
	OR host_is_superhost = 'f');


--  Distribution of property type
SELECT DISTINCT property_type,
  COUNT(property_type)
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 't' OR host_is_superhost = 'f')
GROUP BY 1
ORDER BY 2 DESC;

--  Distribution of superhosts by property type
SELECT DISTINCT property_type,
  COUNT(property_type)
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

--  Distribution of regular hosts by property type
SELECT DISTINCT property_type,
  COUNT(property_type)
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f')
GROUP BY 1
ORDER BY 2 DESC;

--  Distribution of room_type
SELECT DISTINCT room_type AS room_type,
  COUNT(room_type) AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 't' OR host_is_superhost = 'f')
GROUP BY 1
ORDER BY 2 DESC;

--  Distribution of superhosts by room_type
SELECT DISTINCT room_type AS room_type,
  COUNT(room_type) AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

--  Distribution of regular hosts by room_type
SELECT DISTINCT room_type AS room_type,
  COUNT(room_type) AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f')
GROUP BY 1
ORDER BY 2 DESC;

--  Distribution of accommodates
SELECT DISTINCT accommodates AS accommodates,
  COUNT(accommodates)  AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f' OR host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of accommodates (only superhosts)
SELECT DISTINCT accommodates AS accommodates,
  COUNT(accommodates)  AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of accommodates (only regular hosts)
SELECT DISTINCT accommodates AS accommodates,
  COUNT(accommodates)  AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of bathrooms
SELECT DISTINCT bathrooms AS bathrooms,
  COUNT(bathrooms)  AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f' OR host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of bathrooms (only superhosts)
SELECT DISTINCT bathrooms AS bathrooms,
  COUNT(bathrooms)  AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of bathrooms (only regular hosts)
SELECT DISTINCT bathrooms AS bathrooms,
  COUNT(bathrooms)  AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f')
GROUP BY 1
ORDER BY 2 DESC;

--  Distribution of bedrooms
SELECT DISTINCT bedrooms AS bedrooms,
  COUNT(bedrooms) AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f' OR host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of bedrooms (only superhosts)
SELECT DISTINCT bedrooms AS bedrooms,
  COUNT(bedrooms) AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of bedrooms (only regular hosts)
SELECT DISTINCT bedrooms AS bedrooms,
  COUNT(bedrooms)  AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of beds
SELECT DISTINCT beds AS beds,
  COUNT(beds) AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f' OR host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of beds (only superhosts)
SELECT DISTINCT beds AS beds,
  COUNT(beds) AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 't')
GROUP BY 1
ORDER BY 2 DESC;

-- Distribution of beds (only regular hosts)
SELECT DISTINCT beds AS beds,
  COUNT(beds)  AS count_listings
FROM listing
WHERE has_availability = 't' AND (host_is_superhost = 'f')
GROUP BY 1
ORDER BY 2 DESC;

--  Distribution of amenities
SELECT amenity, COUNT(*)
FROM (
	SELECT UNNEST(REPLACE(REPLACE(amenities, '[', '{'), ']', '}')::TEXT[]) AS amenity
	FROM listing
	WHERE has_availability = 't'
	  AND (host_is_superhost = 't'
		OR host_is_superhost = 'f')
) subquery
GROUP BY amenity
ORDER BY COUNT(*) DESC;

--  Distribution of amenities (only superhosts)
SELECT amenity, COUNT(*)
FROM (
	SELECT UNNEST(REPLACE(REPLACE(amenities, '[', '{'), ']', '}')::TEXT[]) AS amenity
	FROM listing
	WHERE has_availability = 't'
	  AND (host_is_superhost = 't')
) subquery
GROUP BY amenity
ORDER BY COUNT(*) DESC;

--  Distribution of amenities (only regular hosts)
SELECT amenity, COUNT(*)
FROM (
	SELECT UNNEST(REPLACE(REPLACE(amenities, '[', '{'), ']', '}')::TEXT[]) AS amenity
	FROM listing
	WHERE has_availability = 't'
	  AND (host_is_superhost = 'f')
) subquery
GROUP BY amenity
ORDER BY COUNT(*) DESC;

-- COMPUTE SUMMARY STATISTICS OF LOCATION AND DISPERSION

-- Compute summary statistics of location and dispersion for number_of_reviews
SELECT
  MIN(number_of_reviews) AS min_number_of_reviews,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews) AS Q1_number_of_reviews,
  MODE() WITHIN GROUP(ORDER BY number_of_reviews) AS mode_number_of_reviews,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY number_of_reviews) AS median_number_of_reviews,
  AVG(number_of_reviews) AS avg_number_of_reviews,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews) AS Q3_number_of_reviews,
  MAX(number_of_reviews) AS max_number_of_reviews,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews) AS IQR_number_of_reviews,
  STDDEV(number_of_reviews) AS stddev_number_of_reviews
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

-- Compute summary statistics of location and dispersion for number_of_reviews in superhosts
SELECT
  MIN(number_of_reviews) AS min_number_of_reviews,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews) AS Q1_number_of_reviews,
  MODE() WITHIN GROUP(ORDER BY number_of_reviews) AS mode_number_of_reviews,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY number_of_reviews) AS median_number_of_reviews,
  AVG(number_of_reviews) AS avg_number_of_reviews,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews) AS Q3_number_of_reviews,
  MAX(number_of_reviews) AS max_number_of_reviews,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews) AS IQR_number_of_reviews,
  STDDEV(number_of_reviews) AS stddev_number_of_reviews
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't');

-- Compute summary statistics of location and dispersion for number_of_reviews in regular hosts
SELECT
  MIN(number_of_reviews) AS min_number_of_reviews,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews) AS Q1_number_of_reviews,
  MODE() WITHIN GROUP(ORDER BY number_of_reviews) AS mode_number_of_reviews,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY number_of_reviews) AS median_number_of_reviews,
  AVG(number_of_reviews) AS avg_number_of_reviews,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews) AS Q3_number_of_reviews,
  MAX(number_of_reviews) AS max_number_of_reviews,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews) AS IQR_number_of_reviews,
  STDDEV(number_of_reviews) AS stddev_number_of_reviews
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 'f');

--  Compute summary statistics of location and dispersion for number_of_reviews_ltm
SELECT
  MIN(number_of_reviews_ltm) AS min_number_of_reviews_ltm,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS Q1_number_of_reviews_ltm,
  MODE() WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS mode_number_of_reviews_ltm,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS median_number_of_reviews_ltm,
  AVG(number_of_reviews_ltm) AS avg_number_of_reviews_ltm,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS Q3_number_of_reviews_ltm,
  MAX(number_of_reviews_ltm) AS max_number_of_reviews_ltm,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_ltm) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS IQR_number_of_reviews_ltm,
  STDDEV(number_of_reviews_ltm) AS stddev_number_of_reviews_ltm
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute summary statistics of location and dispersion for number_of_reviews_ltm in superhosts
SELECT
  MIN(number_of_reviews_ltm) AS min_number_of_reviews_ltm,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS Q1_number_of_reviews_ltm,
  MODE() WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS mode_number_of_reviews_ltm,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS median_number_of_reviews_ltm,
  AVG(number_of_reviews_ltm) AS avg_number_of_reviews_ltm,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS Q3_number_of_reviews_ltm,
  MAX(number_of_reviews_ltm) AS max_number_of_reviews_ltm,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_ltm) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS IQR_number_of_reviews_ltm,
  STDDEV(number_of_reviews_ltm) AS stddev_number_of_reviews_ltm
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't');

--  Compute summary statistics of location and dispersion for number_of_reviews_ltm in regular hosts
SELECT
  MIN(number_of_reviews_ltm) AS min_number_of_reviews_ltm,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS Q1_number_of_reviews_ltm,
  MODE() WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS mode_number_of_reviews_ltm,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS median_number_of_reviews_ltm,
  AVG(number_of_reviews_ltm) AS avg_number_of_reviews_ltm,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS Q3_number_of_reviews_ltm,
  MAX(number_of_reviews_ltm) AS max_number_of_reviews_ltm,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_ltm) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_ltm) AS IQR_number_of_reviews_ltm,
  STDDEV(number_of_reviews_ltm) AS stddev_number_of_reviews_ltm
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 'f');

--  Compute summary statistics of location and dispersion for number_of_reviews_l30d
SELECT
  MIN(number_of_reviews_l30d) AS min_number_of_reviews_l30d,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS Q1_number_of_reviews_l30d,
  MODE() WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS mode_number_of_reviews_l30d,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS median_number_of_reviews_l30d,
  AVG(number_of_reviews_l30d) AS avg_number_of_reviews_l30d,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS Q3_number_of_reviews_l30d,
  MAX(number_of_reviews_l30d) AS max_number_of_reviews_l30d,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_l30d) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS IQR_number_of_reviews_l30d,
  STDDEV(number_of_reviews_l30d) AS stddev_number_of_reviews_l30d
FROM listing
WHERE has_availability = 't';

--  Compute summary statistics of location and dispersion for number_of_reviews_l30d in superhosts
SELECT
  MIN(number_of_reviews_l30d) AS min_number_of_reviews_l30d,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS Q1_number_of_reviews_l30d,
  MODE() WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS mode_number_of_reviews_l30d,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS median_number_of_reviews_l30d,
  AVG(number_of_reviews_l30d) AS avg_number_of_reviews_l30d,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS Q3_number_of_reviews_l30d,
  MAX(number_of_reviews_l30d) AS max_number_of_reviews_l30d,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_l30d) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS IQR_number_of_reviews_l30d,
  STDDEV(number_of_reviews_l30d) AS stddev_number_of_reviews_l30d
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't');

--  Compute summary statistics of location and dispersion for number_of_reviews_l30d in regular host
SELECT
  MIN(number_of_reviews_l30d) AS min_number_of_reviews_l30d,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS Q1_number_of_reviews_l30d,
  MODE() WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS mode_number_of_reviews_l30d,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS median_number_of_reviews_l30d,
  AVG(number_of_reviews_l30d) AS avg_number_of_reviews_l30d,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS Q3_number_of_reviews_l30d,
  MAX(number_of_reviews_l30d) AS max_number_of_reviews_l30d,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY number_of_reviews_l30d) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY number_of_reviews_l30d) AS IQR_number_of_reviews_l30d,
  STDDEV(number_of_reviews_l30d) AS stddev_number_of_reviews_l30d
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 'f');

--  Compute summary statistics of location and dispersion for review_scores_rating
SELECT
  MIN(review_scores_rating) AS min_review_scores_rating,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY review_scores_rating) AS Q1_review_scores_rating,
  MODE() WITHIN GROUP(ORDER BY review_scores_rating) AS mode_review_scores_rating,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY review_scores_rating) AS median_review_scores_rating,
  AVG(review_scores_rating) AS avg_review_scores_rating,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY review_scores_rating) AS Q3_review_scores_rating,
  MAX(review_scores_rating) AS max_review_scores_rating,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY review_scores_rating) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY review_scores_rating) AS IQR_review_scores_rating,
  STDDEV(review_scores_rating) AS stddev_review_scores_rating
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute summary statistics of location and dispersion for review_scores_rating in superhosts
SELECT
  MIN(review_scores_rating) AS min_review_scores_rating,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY review_scores_rating) AS Q1_review_scores_rating,
  MODE() WITHIN GROUP(ORDER BY review_scores_rating) AS mode_review_scores_rating,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY review_scores_rating) AS median_review_scores_rating,
  AVG(review_scores_rating) AS avg_review_scores_rating,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY review_scores_rating) AS Q3_review_scores_rating,
  MAX(review_scores_rating) AS max_review_scores_rating,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY review_scores_rating) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY review_scores_rating) AS IQR_review_scores_rating,
  STDDEV(review_scores_rating) AS stddev_review_scores_rating
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't');

--  Compute summary statistics of location and dispersion for review_scores_rating in regular hosts
SELECT
  MIN(review_scores_rating) AS min_review_scores_rating,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY review_scores_rating) AS Q1_review_scores_rating,
  MODE() WITHIN GROUP(ORDER BY review_scores_rating) AS mode_review_scores_rating,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY review_scores_rating) AS median_review_scores_rating,
  AVG(review_scores_rating) AS avg_review_scores_rating,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY review_scores_rating) AS Q3_review_scores_rating,
  MAX(review_scores_rating) AS max_review_scores_rating,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY review_scores_rating) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY review_scores_rating) AS IQR_review_scores_rating,
  STDDEV(review_scores_rating) AS stddev_review_scores_rating
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 'f');

--  Compute summary statistics of location and dispersion for host_response_rate
SELECT
  MIN(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS min_host_response_rate,
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS Q1_host_response_rate,
  MODE() WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS mode_host_response_rate,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS median_host_response_rate,
  AVG(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS avg_host_response_rate,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS Q3_host_response_rate,
  MAX(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS max_host_response_rate,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) -
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS IQR_host_response_rate,
  STDDEV(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS stddev_host_response_rate
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute summary statistics of location and dispersion for host_response_rate in superhosts
SELECT
  MIN(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS min_host_response_rate,
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS Q1_host_response_rate,
  MODE() WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS mode_host_response_rate,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS median_host_response_rate,
  AVG(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS avg_host_response_rate,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS Q3_host_response_rate,
  MAX(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS max_host_response_rate,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) -
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS IQR_host_response_rate,
  STDDEV(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS stddev_host_response_rate
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't');

--  Compute summary statistics of location and dispersion for host_response_rate in regular hosts
SELECT
  MIN(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS min_host_response_rate,
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS Q1_host_response_rate,
  MODE() WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS mode_host_response_rate,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS median_host_response_rate,
  AVG(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS avg_host_response_rate,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS Q3_host_response_rate,
  MAX(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS max_host_response_rate,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) -
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS IQR_host_response_rate,
  STDDEV(CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) END) AS stddev_host_response_rate
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 'f');

--  Compute summary statistics of location and dispersion for price (nightly rate)
SELECT
  MIN(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS min_price,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS Q1_price,
  MODE() WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS mode_price,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS median_price,
  AVG(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS avg_price,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS Q3_price,
  MAX(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS max_price,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS IQR_price,
  STDDEV(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS stddev_price
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute summary statistics of location and dispersion for price (nightly rate) in superhosts
SELECT
  MIN(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS min_price,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS Q1_price,
  MODE() WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS mode_price,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS median_price,
  AVG(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS avg_price,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS Q3_price,
  MAX(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS max_price,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS IQR_price,
  STDDEV(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS stddev_price
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't');

--  Compute summary statistics of location and dispersion for price (nightly rate) in regular hosts
SELECT
  MIN(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS min_price,
  PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS Q1_price,
  MODE() WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS mode_price,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS median_price,
  AVG(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS avg_price,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS Q3_price,
  MAX(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS max_price,
  PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) - PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS IQR_price,
  STDDEV(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8)) AS stddev_price
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 'f');


-- COMPUTE CORRELATION COEFFICIENT BETWEEN PRICE AND QUANTITATIVE VARIABLES

--  Compute correlation coefficient between price and host_response_rate
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), CASE WHEN host_response_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_response_rate, '%', '') AS INTEGER) / 100 END) AS corr_price_host_response_rate
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and host_acceptance_rate
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), CASE WHEN host_acceptance_rate = 'N/A' THEN NULL ELSE CAST(REPLACE(host_acceptance_rate, '%', '') AS INTEGER)/ 100 END) AS corr_price_host_acceptance_rate
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and host_listings_count
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), host_listings_count) AS corr_price_host_listings_count
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and host_listings_count
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), host_total_listings_count) AS corr_price_host_total_listings_count
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and latitude
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), latitude) AS corr_price_latitude
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and longitude
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), longitude) AS corr_price_longitude
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and accommodates
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), accommodates) AS corr_price_accommodates
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and bathrooms
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), bathrooms) AS corr_price_bathrooms
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and bedrooms
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), bedrooms) AS corr_price_bedrooms
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and beds
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), beds) AS corr_price_beds
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and minimum_nights
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), minimum_nights) AS corr_price_minimum_nights
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and maximum_nights
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), maximum_nights) AS corr_price_maximum_nights
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and minimum_minimum_nights
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), minimum_minimum_nights) AS corr_price_minimum_minimum_nights
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and maximum_minimum_nights
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), maximum_minimum_nights) AS corr_price_maximum_minimum_nights
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and minimum_maximum_nights
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), minimum_maximum_nights) AS corr_price_minimum_maximum_nights
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and maximum_maximum_nights
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), maximum_maximum_nights) AS corr_price_maximum_maximum_nights
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and minimum_nights_avg_ntm
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), minimum_nights_avg_ntm) AS corr_price_minimum_nights_avg_ntm
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and maximum_nights_avg_ntm
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), maximum_nights_avg_ntm) AS corr_price_maximum_nights_avg_ntm
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and availability_30
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), availability_30) AS corr_price_availability_30
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and availability_60
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), availability_60) AS corr_price_availability_60
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and availability_90
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), availability_90) AS corr_price_availability_90
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and availability_365
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), availability_365) AS corr_price_availability_365
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and number_of_reviews
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), number_of_reviews) AS corr_price_number_of_reviews
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and number_of_reviews_ltm
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), number_of_reviews_ltm) AS corr_price_number_of_reviews_ltm
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and number_of_reviews_l30d
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), number_of_reviews_l30d) AS corr_price_number_of_reviews_l30d
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and review_scores_rating
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), review_scores_rating) AS corr_price_review_scores_rating
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and review_scores_accuracy
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), review_scores_accuracy) AS corr_price_review_scores_accuracy
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and review_scores_cleanliness
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), review_scores_cleanliness) AS corr_price_review_scores_cleanliness
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and review_scores_checkin
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), review_scores_checkin) AS corr_price_review_scores_checkin
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and review_scores_communication
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), review_scores_communication) AS corr_price_review_scores_communication
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and review_scores_location
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), review_scores_location) AS corr_price_review_scores_location
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and review_scores_value
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), review_scores_value) AS corr_price_review_scores_value
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and calculated_host_listings_count
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), calculated_host_listings_count) AS corr_price_calculated_host_listings_count
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and calculated_host_listings_count_entire_homes
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), calculated_host_listings_count_entire_homes) AS corr_price_calculated_host_listings_count_entire_homes
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and calculated_host_listings_count_private_rooms
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), calculated_host_listings_count_private_rooms) AS corr_price_calculated_host_listings_count_private_rooms
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and calculated_host_listings_count_shared_rooms
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), calculated_host_listings_count_shared_rooms) AS corr_price_calculated_host_listings_count_shared_rooms
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  Compute correlation coefficient between price and reviews_per_month
SELECT CORR(CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8), reviews_per_month) AS corr_price_reviews_per_month
FROM listing
WHERE has_availability = 't'
  AND (host_is_superhost = 't' OR host_is_superhost = 'f');

--  PERFORM CORRELATION ANALYSIS TO QUALITATIVE VARIABLES

--  Compute correlation analysis between price and host_response_time
SELECT
	'a few days or more' AS variable,
	corr(price_formatted, host_response_time_a_few_days_or_more) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN host_response_time = 'a few days or more' THEN 1 ELSE 0 END AS host_response_time_a_few_days_or_more
	FROM listing
) subquery
--
UNION ALL
--
SELECT
	'within an hour' AS variable,
	corr(price_formatted, host_response_time_within_an_hour) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN host_response_time = 'within an hour' THEN 1 ELSE 0 END AS host_response_time_within_an_hour
	FROM listing
) subquery
--
UNION ALL
--
SELECT
	'within a few hours' AS variable,
	corr(price_formatted, host_response_time_within_a_few_hours) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN host_response_time = 'within a few hours' THEN 1 ELSE 0 END AS host_response_time_within_a_few_hours
	FROM listing
) subquery
--
UNION ALL
--
SELECT
	'within a day' AS variable,
	corr(price_formatted, host_response_time_within_a_day) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN host_response_time = 'within a day' THEN 1 ELSE 0 END AS host_response_time_within_a_day
	FROM listing
) subquery;


--  Compute correlation analysis between price and host_is_superhost
SELECT
	't' AS variable,
	corr(price_formatted, host_is_superhost_t) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN host_is_superhost = 't' THEN 1 ELSE 0 END AS host_is_superhost_t
	FROM listing
) subquery
--
UNION ALL
--
SELECT
	'f' AS variable,
	corr(price_formatted, host_is_superhost_f) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN host_is_superhost = 'f' THEN 1 ELSE 0 END AS host_is_superhost_f
	FROM listing
) subquery;

--  Compute correlation analysis between price and host_verifications
SELECT
	'email' AS variable,
	corr(price_formatted, host_verifications_email) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN
		  REPLACE(REPLACE(host_verifications, '[', '{'), ']', '}')::TEXT[] = '{email}' THEN 1 ELSE 0 END AS host_verifications_email
	FROM listing
) subquery
--
UNION ALL
--
SELECT
	'phone' AS variable,
	corr(price_formatted, host_verifications_phone) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN REPLACE(REPLACE(host_verifications, '[', '{'), ']', '}')::TEXT[] = '{phone}' THEN 1 ELSE 0 END AS host_verifications_phone
	FROM listing
) subquery
--
UNION ALL
--
SELECT
	'work_email' AS variable,
	corr(price_formatted, host_verifications_work_email) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN REPLACE(REPLACE(host_verifications, '[', '{'), ']', '}')::TEXT[] = '{work_email}' THEN 1 ELSE 0 END AS host_verifications_work_email
	FROM listing
) subquery;

--  Compute correlation analysis between price and has_availability
SELECT
	't' AS variable,
	corr(price_formatted, has_availability_t) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN has_availability = 't' THEN 1 ELSE 0 END AS has_availability_t
	FROM listing
) subquery
--
UNION ALL
--
SELECT
	'f' AS variable,
	corr(price_formatted, has_availability_f) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN has_availability = 'f' THEN 1 ELSE 0 END AS has_availability_f
	FROM listing
) subquery;
--
-- Compute correlation analysis between price and instant_bookable
SELECT
	't' AS variable,
	corr(price_formatted, instant_bookable_t) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN instant_bookable = 't' THEN 1 ELSE 0 END AS instant_bookable_t
	FROM listing
) subquery
--
UNION ALL
--
SELECT
	'f' AS variable,
	corr(price_formatted, instant_bookable_f) AS correlation
FROM (
	SELECT
		CAST(REPLACE(SUBSTR(price, 2), ',', '') AS FLOAT8) AS price_formatted,
		CASE WHEN instant_bookable = 'f' THEN 1 ELSE 0 END AS instant_bookable_f
	FROM listing
) subquery;
