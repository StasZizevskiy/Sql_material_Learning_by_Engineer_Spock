CREATE FUNCTION get_season(month_number int) RETURNS text as $$
DECLARE 
	season text;
BEGIN 
	IF month_number not between 1 and 12 then
		raise exception 'Invalid month. You passed: (%)', month_number USING HINT='Allowed from 1 up to 12', ERRCODE = 12882;
	END IF;
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

CREATE OR REPLACE FUNCTION get_season_caller(month_number int) returns text AS $$ --ОТЛОВ ИСКЛЮЧЕНИЯ, ЧТОБЫ НЕ БЫЛО ПРЕРЫВАНИЯ ИСПОЛНЕНИЯ ОСНОВНОЙ ФУНКЦИИ
DECLARE
	err_ctx text;
	err_msg text;
	err_details text;
	err_code text;
BEGIN 
	return get_season(month_number);
EXCEPTION WHEN SQLSTATE '12882' THEN
	GET STACKED DIAGNOSTICS 
		err_ctx = PG_EXCEPTION_CONTEXT,
		err_msg = MESSAGE_TEXT,
		err_details = PG_EXCEPTION_DETAIL,
		err_code = RETURNED_SQLSTATE;
	RAISE INFO 'My custom handler';
	RAISE INFO 'Error msg:%', err_msg; --выводит дополнительную информацию, которая будет доступна в разделе MESSAGES
	RAISE INFO 'Error ctx:%', err_ctx;
	RAISE INFO 'Error details:%', err_details;
	RAISE INFO 'Error code:%', err_code;
	RAISE INFO 'A problem, nothing special'; --СООБЩЕНИЕ ВЫВОДИТСЯ В MESSAGES
	RETURN null;
END;
$$ LANGUAGE PLPGSQL;

SELECT get_season_caller2(15);

CREATE OR REPLACE FUNCTION get_season_caller2(month_number int) returns text AS $$ --ОТЛОВ ИСКЛЮЧЕНИЯ, ЧТОБЫ НЕ БЫЛО ПРЕРЫВАНИЯ ИСПОЛНЕНИЯ ОСНОВНОЙ ФУНКЦИИ
BEGIN 
	return get_season(month_number);
EXCEPTION 
WHEN SQLSTATE '12885' THEN
	RAISE INFO 'My custom handler';
	RAISE INFO 'Error Name:%', SQLERRM;
	RAISE INFO 'Error details:%', SQLSTATE;
	RETURN null;
WHEN OTHERS THEN
	RAISE INFO 'My custom handler OTHERS';
	RAISE INFO 'Error Name:%', SQLERRM;
	RAISE INFO 'Error details:%', SQLSTATE;
	RETURN null;
END;
$$ LANGUAGE PLPGSQL;









