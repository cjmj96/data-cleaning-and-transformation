-- Filter data across rows (listing table)
CREATE TABLE listing_prepared_filtered AS
SELECT *
FROM listing_prepared
WHERE
  last_scraped IN ('2024-03-24', '2024-03-25')
  AND (host_response_rate BETWEEN 0 AND 1)
  AND (host_acceptance_rate BETWEEN 0 AND 1)
  AND (host_listings_count > 0)
  AND (host_total_listings_count > 0)
  AND (minimum_nights > 0)
  AND (maximum_nights > 0)
  AND (latitude BETWEEN 42.227859 AND 42.397259)
  AND (longitude BETWEEN -71.191208 AND -70.923042)
  AND (accommodates > 0)
  AND (bedrooms >= 0)
  AND (beds >= 0)
  AND (availability_30 BETWEEN 0 AND 30)
  AND (availability_60 BETWEEN 0 AND 60)
  AND (availability_90 BETWEEN 0 AND 90)
  AND (availability_365 BETWEEN 0 AND 365)
  AND (calendar_last_scraped BETWEEN '2024-03-24' AND '2024-03-25')
  AND (review_scores_rating BETWEEN 0 AND 5)
  AND (review_scores_accuracy BETWEEN 0 AND 5)
  AND (review_scores_cleanliness BETWEEN 0 AND 5)
  AND (review_scores_checkin BETWEEN 0 AND 5)
  AND (review_scores_communication BETWEEN 0 AND 5)
  AND (review_scores_location BETWEEN 0 AND 5)
  AND (review_scores_value BETWEEN 0 AND 5)
  AND (calculated_host_listings_count > 0)
  AND (calculated_host_listings_count_entire_homes >= 0)
  AND (calculated_host_listings_count_private_rooms >= 0)
  AND (calculated_host_listings_count_shared_rooms >= 0)
  AND (bathrooms >= 0)
  AND (price > 0)
  AND (first_review BETWEEN '2008-08-01' AND '2024-03-24')
  AND (last_review BETWEEN '2008-08-01' AND '2024-03-24')
  AND (reviews_per_month >= 0);

-- Filter data across columns (listing table)
ALTER TABLE listing_prepared_filtered
DROP COLUMN listing_url,
DROP COLUMN last_scraped,
DROP COLUMN calendar_updated,
DROP COLUMN scrape_id,
DROP COLUMN source,
DROP COLUMN neighborhood_overview,
DROP COLUMN host_since,
DROP COLUMN host_location,
DROP COLUMN host_thumbnail_url,
DROP COLUMN host_verifications,
DROP COLUMN host_has_profile_pic,
DROP COLUMN host_identity_verified,
DROP COLUMN neighbourhood,
DROP COLUMN neighbourhood_cleansed,
DROP COLUMN neighbourhood_group_cleansed,
DROP COLUMN bathrooms_text,
DROP COLUMN minimum_minimum_nights,
DROP COLUMN maximum_minimum_nights,
DROP COLUMN minimum_maximum_nights,
DROP COLUMN maximum_maximum_nights,
DROP COLUMN minimum_nights_avg_ntm,
DROP COLUMN maximum_nights_avg_ntm,
DROP COLUMN availability_30,
DROP COLUMN availability_60,
DROP COLUMN availability_90,
DROP COLUMN availability_365,
DROP COLUMN review_scores_accuracy,
DROP COLUMN review_scores_cleanliness,
DROP COLUMN review_scores_checkin,
DROP COLUMN review_scores_communication,
DROP COLUMN review_scores_location,
DROP COLUMN review_scores_value,
DROP COLUMN license,
DROP COLUMN instant_bookable,
DROP COLUMN calculated_host_listings_count,
DROP COLUMN calculated_host_listings_count_entire_homes,
DROP COLUMN calculated_host_listings_count_private_rooms,
DROP COLUMN calculated_host_listings_count_shared_rooms;

-- Filter data across rows (calendar_prepared_filtered table)
CREATE TABLE calendar_prepared_filtered AS
SELECT *
FROM calendar_prepared
WHERE
  (date BETWEEN '2024-03-24' AND '2025-03-24')
  AND price > 0
  AND minimum_nights > 0
  AND maximum_nights > 0;


-- Filter data across columns (calendar_prepared_filtered table)
ALTER TABLE calendar_prepared_filtered
DROP COLUMN adjusted_price,
DROP COLUMN minimum_nights,
DROP COLUMN maximum_nights;


-- Filter data across rows (review_prepared_filtered table)
CREATE TABLE review_prepared_filtered AS
SELECT *
FROM review_prepared
WHERE
  (date BETWEEN '2008-08-01' AND '2024-03-24');

-- Filter data across columns (review_prepared_filtered table)
ALTER TABLE review_prepared_filtered
DROP COLUMN reviewer_name,
DROP COLUMN comments;
