SELECT * FROM author

UPDATE author
SET full_name = 'Elice', rating = 5
WHERE author_id = 1

DELETE FROM author
WHERE rating<4.5

DELETE FROM author -- оставляет информацию в логах об удаленных строках

TRUNCATE TABLE author -- удаляет быстрее, информации не остаётся







