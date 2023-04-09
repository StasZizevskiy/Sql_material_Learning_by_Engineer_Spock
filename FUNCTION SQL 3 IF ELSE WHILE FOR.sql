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






