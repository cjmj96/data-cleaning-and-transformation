-- List column names and their data types for the calendar table
--  SELECT column_name, data_type
--  FROM information_schema.columns
--  WHERE table_schema = 'public'
--  AND table_name = 'calendar';

-- List first 5 observations of calendar table
--  SELECT *
--  FROM calendar
--  LIMIT 5;

-- Count observations for calendar table
SELECT COUNT(*)
FROM calendar;

-- List column names and their data types for the listing table
--  SELECT column_name, data_type
--  FROM information_schema.columns
--  WHERE table_schema = 'public'
--  AND table_name = 'listing';

-- List first 5 observations of listing table
--  SELECT *
--  FROM listing
--  LIMIT 5;

-- Count observations for listing table
SELECT COUNT(*)
FROM listing;

-- List column names and their data types for the review table
--  SELECT column_name, data_type
--  FROM information_schema.columns
--  WHERE table_schema = 'public'
--  AND table_name = 'review';

-- List first 5 observations of review table
--  SELECT *
--  FROM review
--  LIMIT 5;

-- Count observations for review table
SELECT COUNT(*)
FROM review;
