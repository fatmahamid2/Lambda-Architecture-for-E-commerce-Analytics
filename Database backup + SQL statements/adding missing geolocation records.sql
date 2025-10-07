-- selecting the zip code prefixes that exist in the customers table but not in the geolocation table 
SELECT DISTINCT customer_zip_code_prefix
FROM customers
WHERE customer_zip_code_prefix NOT IN (
	SELECT geolocation_zip_code_prefix FROM geolocation
);  -- 157 rows

-- selecting the zip code prefixes that exist in the sellers table but not in the geolocation table 
SELECT DISTINCT seller_zip_code_prefix
FROM sellers
WHERE seller_zip_code_prefix NOT IN(
	SELECT geolocation_zip_code_prefix FROM geolocation
); -- 7 rows

-- inserting the missing rows into the geolocation table to preserve the referential integrity
INSERT INTO geolocation (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state)
SELECT DISTINCT c.customer_zip_code_prefix, 0.0, 0.0, c.customer_city, c.customer_state
FROM customers c
WHERE c.customer_zip_code_prefix NOT IN (
	SELECT geolocation_zip_code_prefix FROM geolocation
);

INSERT INTO geolocation (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state)
SELECT DISTINCT s.seller_zip_code_prefix, 0.0, 0.0, s.seller_city, s.seller_state
FROM sellers s
WHERE s.seller_zip_code_prefix NOT IN (
    SELECT geolocation_zip_code_prefix FROM geolocation
);

-- Adding Foreign Keys
ALTER TABLE customers
ADD CONSTRAINT fk_customer_zip
FOREIGN KEY (customer_zip_code_prefix)
REFERENCES geolocation(geolocation_zip_code_prefix);

ALTER TABLE sellers
ADD CONSTRAINT fk_seller_zip
FOREIGN KEY (seller_zip_code_prefix)
REFERENCES geolocation(geolocation_zip_code_prefix);
