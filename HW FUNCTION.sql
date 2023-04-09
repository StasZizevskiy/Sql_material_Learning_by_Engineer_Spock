--СОЗДАНИЕ БЭКААПА ТАБЛИЦЫ customers С ЗАТИРАНИЕМ ПРЕДЫДУЩИХ ДАННЫХ
CREATE OR REPLACE FUNCTION back_up_customers() RETURNS void as $$
	DROP TABLE IF EXISTS back_up_customers;
	
	--SELECT * INTO back_up_customers
	--FROM customers
	CREATE TABLE back_up_customers as
	SELECT * FROM customers;
$$ LANGUAGE SQL;

SELECT COUNT(*) FROM customers;

-- создать фукцию, вычисляющую средний фракт по всем заказам
CREATE OR REPLACE FUNCTION get_avg_freight() RETURNS float8 as $$
	SELECT AVG(freight)
	FROM orders;
$$ LANGUAGE SQL;

SELECT * FROM get_avg_freight()

--создать функцию, принимающую два целочисленных числа как верхнюю и нижнюю границы для 
--вычислению в их интервале случайного числа
CREATE OR REPLACE FUNCTION random_between(low int, high int) RETURNS int as $$
BEGIN
	RETURN floor(random() * (high-low+1)+low);
END
$$ LANGUAGE plpgsql;

SELECT random_between(1,3)
FROM generate_series(1,5)

--функция, которая генерирует самую высокую и низкую зарплату заданного города
CREATE OR REPLACE FUNCTION get_salary_bounds_by_city(emp_city varchar, out min_salary numeric, out max_salary numeric) 
as $$ -- не прописывается RETURNS Т.К. возвращает через out
	SELECT MIN(salary), MAX(salary)
	FROM employees
	WHERE city = emp_city;
$$ LANGUAGE SQL;

SELECT * FROM get_salary_bounds_by_city('london')

--создать функцию, которая повышает зарплату на коэффициент, если она меньше определенного показателя
CREATE OR REPLACE FUNCTION correct_salary(upper_boundary numeric DEFAULT 70, correction_rate numeric DEFAULT 0.15)
RETURNS void as $$
	UPDATE employees
	SET salary = salary + (salary*correction_rate)
	WHERE salary <=upper_boundary;
$$ LANGUAGE SQL;

SELECT correct_salary(); 

--модифицировать предыдущую функцию, чтобы она выводила измененные записи
DROP FUNCTION IF EXISTS correct_salary()
CREATE OR REPLACE FUNCTION correct_salary(upper_boundary numeric DEFAULT 70, correction_rate numeric DEFAULT 0.15)
RETURNS SETOF employees as $$
	UPDATE employees
	SET salary = salary + (salary*correction_rate)
	WHERE salary <=upper_boundary
	RETURNING *;
$$ LANGUAGE SQL;

--модифицировать функцию, чтобы она возвращала только определенные столбцы
DROP FUNCTION IF EXISTS correct_salary()
CREATE OR REPLACE FUNCTION correct_salary(upper_boundary numeric DEFAULT 70, correction_rate numeric DEFAULT 0.15)
RETURNS TABLE (last_name text, first_name text, title text, salary numeric) as $$
	UPDATE employees
	SET salary = salary + (salary*correction_rate)
	WHERE salary <=upper_boundary
	RETURNING last_name, first_name, title, salary;
$$ LANGUAGE SQL;

--создать функцию, которая принимает метод доставки 
--и возвращает записи где фракт меньше определенного алгоритма заданного заранее

CREATE OR REPLACE FUNCTION get_orders_by_shipping(ship_method int) RETURNS SETOF orders as $$
DECLARE 
	average numeric;
	maximum numeric;
	middle numeric;
BEGIN
	SELECT MAX(freight) INTO maximum
	FROM orders
	WHERE ship_via=ship_method;
	
	SELECT AVG(freight) INTO average
	FROM orders
	WHERE ship_via=ship_method;
	
	maximum = maximum - (maximum*0.3);
	
	middle = (maximum+average)/2;
	
	RETURN QUERY 
	SELECT *
	FROM orders
	WHERE freight < middle;
END
$$ LANGUAGE plpgsql;

SELECT COUNT(*) FROM get_orders_by_shipping(1);


--СОЗДАТЬ ФУНКЦИЮ, КОТОРАЯ ПРОВЕРЯЕТ НУЖНО ЛИ ПОВЫСИТЬ ЗАРПЛАТУ И ВЫВОДИТЬ BOOL
CREATE OR REPLACE FUNCTION should_increase_salary(
	cur_salary numeric,
	max_salary numeric DEFAULT 80,
	min_salary numeric DEFAULT 30,
	increase_rate numeric DEFAULT 0.2)
RETURNS bool as $$
DECLARE 
	new_salary numeric;
BEGIN
	IF cur_salary >=max_salary OR cur_salary>=min_salary THEN
		RETURN false;
	END IF;
	
	IF cur_salary < min_salary THEN
		new_salary = cur_salary + (cur_salary*increase_rate);
	END IF;
	
	IF new_salary>max_salary THEN
		RETURN FALSE;
	ELSE
		RETURN TRUE;
	END IF;
END
$$ LANGUAGE plpgsql;

SELECT should_increase_salary(40,80,30,0.2)
SELECT should_increase_salary(79,81,80,0.2)
SELECT should_increase_salary(79,95,80,0.2)




