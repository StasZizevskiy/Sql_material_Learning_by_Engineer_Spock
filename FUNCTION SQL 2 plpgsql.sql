CREATE OR REPLACE FUNCTION get_total_number_of_goods() RETURNS bigint AS $$
BEGIN
	RETURN SUM(units_in_stock)
	FROM products;
END;
$$ LANGUAGE PLPGSQL;

SELECT get_total_number_of_goods()

CREATE OR REPLACE FUNCTION get_max_price_from_discontinued() RETURNS real AS $$
BEGIN
	RETURN max(unit_price)
	FROM products
	WHERE discontinued=1;
END;
$$ LANGUAGE PLPGSQL;

SELECT get_max_price_from_discontinued();

CREATE OR REPLACE FUNCTION get_price_boundaries (OUT max_price real, OUT min_price real) AS $$
BEGIN
	--max_price := MAX(unit_price) FROM products;
	--min_price := MIN(unit_price) FROM products;
	SELECT MAX(unit_price), MIN(unit_price)
	INTO max_price, min_price
	FROM products;
END;
$$ LANGUAGE plpgsql; 

SELECT * FROM get_price_boundaries()

CREATE OR REPLACE FUNCTION get_sum(x int, y int, out result int) AS $$
BEGIN
	result:= x+y; -- := можно заменить на =
	RETURN; --для завершения функции принудительно. не обязательно
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM get_sum(2,3)

DROP FUNCTION get_customers_by_country;
CREATE FUNCTION get_customers_by_country(customer_country varchar) RETURNS SETOF customers AS $$
BEGIN
	RETURN QUERY -- для использования в теле функции 
	SELECT *
	FROM customers
	WHERE country = customer_country;
END
$$ LANGUAGE plpgsql;

SELECT * FROM get_customers_by_country('USA');

CREATE FUNCTION get_square(ab real, bc real, ac real) RETURNS real as $$
DECLARE
	perimetr real;
BEGIN
	perimetr = (ab+bc+ac)/2;
	return sqrt(perimetr* (perimetr-ab)*(perimetr-bc)*(perimetr-ac));
END
$$ LANGUAGE plpgsql;

SELECT get_square(6,6,6);

CREATE FUNCTION calc_middle_price() RETURNS SETOF products AS $$
DECLARE --задаем переменные и их тип данных
	avg_price real;
	low_price real;
	high_price real;
BEGIN
	SELECT AVG(unit_price) INTO avg_price -- вычисляем среднее
	FROM products;
	
	low_price = avg_price*0.75;
	high_price = avg_price*1.25;
	
	RETURN QUERY 
	SELECT * FROM products
	WHERE unit_price BETWEEN low_price and high_price;
END
$$ LANGUAGE plpgsql;
	
SELECT * FROM calc_middle_price();

















