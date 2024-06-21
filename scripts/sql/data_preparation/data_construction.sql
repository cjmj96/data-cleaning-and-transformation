-- Add total_potential_revenue column
ALTER TABLE listing_cleaned
ADD COLUMN total_potential_revenue NUMERIC GENERATED ALWAYS AS (365 * price) STORED;
