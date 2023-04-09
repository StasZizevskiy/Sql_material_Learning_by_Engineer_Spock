SELECT *
FROM customers;

SELECT *
INTO tmp_customers
FROM customers;

SELECT *
FROM tmp_customers;

UPDATE tmp_customers
SET region = 'unknown'
WHERE region is null;

CREATE OR REPLACE FUNCTION fix_customer_region() RETURNS void AS $$
	UPDATE tmp_customers
	SET region = 'unknown'
	WHERE region is null
$$ LANGUAGE SQL;

SELECT fix_customer_region();

CREATE OR REPLACE FUNCTION get_total_number_of_goods() RETURNS bigint AS $$
	SELECT SUM(units_in_stock)
	FROM products
$$ LANGUAGE SQL;

SELECT get_total_number_of_goods() as total_goods;

CREATE OR REPLACE FUNCTION get_avg_price() RETURNS float8 AS $$
	SELECT AVG(unit_price)
	FROM products
$$ LANGUAGE SQL;

SELECT get_avg_price() AS avg_price;

CREATE OR REPLACE FUNCTION get_product_price_by_name(prod_name varchar) RETURNS real as $$
	SELECT unit_price
	FROM products
	WHERE product_name=prod_name
$$ LANGUAGE SQL;

SELECT get_product_price_by_name('Chocolade') AS price;

CREATE OR REPLACE FUNCTION get_price_boundaries_by_discontinuity(IN is_discontinued int DEFAULT 1, OUT max_price real, OUT min_price real) AS $$
	SELECT MAX(unit_price), MIN(unit_price)
	FROM products
	WHERE discontinued = is_discontinued
$$ LANGUAGE SQL;

SELECT get_price_boundaries_by_discontinuity(1);
SELECT * FROM get_price_boundaries_by_discontinuity(1);

CREATE OR REPLACE FUNCTION get_average_prices_by_prod_categories()
		RETURNS SETOF double precision as $$
	SELECT AVG(unit_price)
	FROM products
	GROUP BY category_id
$$ LANGUAGE SQL;

SELECT * FROM get_average_prices_by_prod_categories() AS average_prices;

CREATE OR REPLACE FUNCTION get_avg_prices_by_prod_cats(out sum_price real, OUT avg_price float8)
		RETURNS SETOF RECORD AS $$
	SELECT SUM(unit_price), AVG(unit_price)
	FROM products
	GROUP BY category_id
$$ LANGUAGE SQL;

SELECT sum_price FROM get_avg_prices_by_prod_cats()
SELECT sum_price, avg_price FROM get_avg_prices_by_prod_cats()

CREATE OR REPLACE FUNCTION get_customers_by_country(customer_country varchar)
		RETURNS TABLE (char_code char, company_name varchar) as $$
	SELECT customer_id, company_name
	FROM customers
	WHERE country = customer_country
$$ LANGUAGE SQL;	

SELECT * FROM get_customers_by_country('USA');
SELECT company_name FROM get_customers_by_country('USA');

DROP FUNCTION get_customers_by_country;
CREATE OR REPLACE FUNCTION get_customers_by_country(customer_country varchar)
		RETURNS SETOF customers as $$
		--won't work SELECT company_name, contact_name 
	SELECT *
	FROM customers
	WHERE country = customer_country
$$ LANGUAGE SQL;

SELECT * FROM get_customers_by_country('USA');
SELECT company_name FROM get_customers_by_country('USA');











