CREATE FUNCTION convert_temp_to (temperature real, to_celsius bool DEFAULT true) RETURNS real as $$
DECLARE 
	result_temp real;
BEGIN
	IF to_celsius THEN -- ЗАПИСЬ to_celsius аналогична to_celsius=true
		result_temp = (5.0/9.0)*(temperature-32);
	ELSE 
		result_temp = (9*temperature+(32*5))/5.0;
	END IF;
	
	RETURN result_temp;
END
$$ LANGUAGE plpgsql;

SELECT * FROM convert_temp_to(80);
SELECT * FROM convert_temp_to(26.7, FALSE);

CREATE FUNCTION get_season(month_number int) RETURNS text as $$
DECLARE 
	season text;
BEGIN 
	IF month_number BETWEEN 3 AND 5 THEN
		season = 'Spring';
	ELSEIF month_number BETWEEN 6 AND 8 THEN
		season = 'Summer';
	ELSEIF month_number BETWEEN 9 AND 11 THEN
		season = 'Autumn';
	ELSE 
		season = 'Winter';
	END IF;
	
	RETURN season;
END
$$ LANGUAGE plpgsql;

SELECT * FROM get_season(3)

CREATE OR REPLACE FUNCTION fib(n int) RETURNS int AS $$
DECLARE 
	counter int = 0;
	i int = 0;
	j int =1;
BEGIN
	IF n<1 THEN 
		RETURN 0;
	END IF;
	
	WHILE counter<n
	LOOP
		counter = counter+1;
		SELECT j, i+j INTO i, j;
	END LOOP;
	
	RETURN i;
END	
$$ LANGUAGE plpgsql;

SELECT fib(10);

CREATE OR REPLACE FUNCTION fib(n int) RETURNS int AS $$
DECLARE 
	counter int = 0;
	i int = 0;
	j int =1;
BEGIN
	IF n<1 THEN 
		RETURN 0;
	END IF;
	
	LOOP
		EXIT WHEN counter > n ;
		counter = counter+1;
		SELECT j, i+j INTO i, j;
	END LOOP;
	
	RETURN i;
END	
$$ LANGUAGE plpgsql;

DO $$ --аноноимный кусок кода, использующийся для тестов или проверок
BEGIN 
	FOR counter IN 1..5
	LOOP
		RAISE NOTICE 'Counter = %', counter;
	END LOOP;
END$$;

DO $$ --аноноимный кусок кода, использующийся для тестов или проверок
BEGIN 
	FOR counter IN REVERSE 5..1
	LOOP
		RAISE NOTICE 'Counter = %', counter;
	END LOOP;
END$$;

DO $$ --аноноимный кусок кода, использующийся для тестов или проверок
BEGIN 
	FOR counter IN 1..10 BY 2
	LOOP
		RAISE NOTICE 'Counter = %', counter;
	END LOOP;
END$$;






