-- Имеется следующая функция, которую мы написали в разделе, посвящённом, собственно, функциям:

create or replace function should_increase_salary(
	cur_salary numeric,
	max_salary numeric DEFAULT 80, 
	min_salary numeric DEFAULT 30,
	increase_rate numeric DEFAULT 0.2
	) returns bool AS $$
declare
	new_salary numeric;
begin
	if cur_salary >= max_salary or cur_salary >= min_salary then 		
		return false;
	end if;
	
	if cur_salary < min_salary then
		new_salary = cur_salary + (cur_salary * increase_rate);
	end if;
	
	if new_salary > max_salary then
		return false;
	else
		return true;
	end if;	
end;
$$ language plpgsql;

--Задание:

--Модифицировать функцию should_increase_salary разработанную в секции по функциям таким образом, чтобы запретить (выбрасывая исключения) передачу аргументов так, что:

--минимальный уровень з/п превышает максимальный

--ни минимальный, ни максимальный уровень з/п не могут быть меньше нуля

--коэффициент повышения зарплаты не может быть ниже 5%

--Протестировать реализацию, передавая следующие значения аргументов (с - уровень "проверяемой" зарплаты, r - коэффициент повышения зарплаты):

--c = 79, max = 10, min = 80, r = 0.2

--c = 79, max = 10, min = -1, r = 0.2

--c = 79, max = 10, min = 10, r = 0.04

create or replace function should_increase_salary(
	cur_salary numeric,
	max_salary numeric DEFAULT 80, 
	min_salary numeric DEFAULT 30,
	increase_rate numeric DEFAULT 0.2
	) returns bool AS $$
declare
	new_salary numeric;
begin
	IF min_salary>max_salary THEN 
		RAISE EXCEPTION 'Min salary should not exceed max salary. Min is %, max is %', min_salary, max_salary;
	ELSEIF min_salary<0 or max_salary<0 THEN
		RAISE EXCEPTION 'Min or max salary should not <= 0. Min is %, max is %', min_salary, max_salary;
	ELSEIF increase_rate<0.05 THEN
		RAISE EXCEPTION 'Increase rate should be >= 0.05. You passed in %', increase_rate;
	END IF;	
	if cur_salary >= max_salary or cur_salary >= min_salary then 		
		return false;
	end if;
	if cur_salary < min_salary then
		new_salary = cur_salary + (cur_salary * increase_rate);
	end if;
	if new_salary > max_salary then
		return false;
	else
		return true;
	end if;	
end;
$$ language plpgsql;

select should_increase_salary(79,10,80,0.2);
select should_increase_salary(79,10,-1,0.2);
select should_increase_salary(79,10,10,0.04);

