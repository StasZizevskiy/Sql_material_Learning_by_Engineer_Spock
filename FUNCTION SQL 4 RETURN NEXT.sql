CREATE FUNCTION return_ints() RETURNS SETOF int as $$
BEGIN
	RETURN NEXT 1;
	RETURN NEXT 2;
	RETURN NEXT 3;
END

$$ LANGUAGE plpgsql;

SELECT * FROM return_ints()

CREATE FUNCTION after_christmas_sale() RETURNS SETOF products as $$
DECLARE 
	product record;
BEGIN
	FOR product IN SELECT * FROM products
	LOOP
		if product.category_id IN (1,4,8) THEN
			product.unit_price = product.unit_price * 0.8;
		elseif product.category_id IN (2,3,7) THEN
			product.unit_price = product.unit_price * 0.75;
		else 
			product.unit_price = product.unit_price * 1.1;
		END IF;
		RETURN NEXT product;
	END LOOP;
END 
$$ LANGUAGE plpgsql;

SELECT * FROM after_christmas_sale()











