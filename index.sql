DROP TABLE perf_test
CREATE TABLE perf_test(
	id int,
	reason text COLLATE "C",
	annotation text COLLATE "C"
);

INSERT INTO perf_test(id, reason, annotation)
SELECT s.id, md5(random()::text), null
FROM generate_series(1, 10000000) AS s(id)
ORDER BY random();

UPDATE perf_test
SET annotation = UPPER(md5(random()::text));

SELECT * FROM perf_test 
LIMIT 10;

EXPLAIN
SELECT *
FROM perf_test
WHERE id=3700000;

CREATE INDEX idx_perf_test_id ON perf_test(id);

EXPLAIN 
SELECT *
FROM perf_test
WHERE reason LIKE 'bc%' AND annotation LIKE 'AB%';

--ANALYZE perf_test;

CREATE INDEX idx_perf_test_reason_annotation ON perf_test(reason, annotation);

EXPLAIN
SELECT * 
FROM perf_test
WHERE reason LIKE 'bc%';

EXPLAIN
SELECT * 
FROM perf_test
WHERE annotation LIKE 'BC%'; -- ПРИ СОЗДАНИИ ИНДЕКСА МОЖНО ДЕЛАТЬ индексный поиск по обоим столбам, 
--либо по первому столбцу отдельно. При этом отдельно по второму столбцу делать индексный поиск не получится.
--для этого нужно создавать отдельный индекс на второй столбец

EXPLAIN
SELECT *
FROM perf_test
WHERE annotation LIKE 'AB%';

CREATE INDEX idx_perf_test_annotation ON perf_test(annotation);

EXPLAIN
SELECT * 
FROM perf_test
WHERE LOWER(annotation) LIKE ('ab%');

CREATE INDEX idx_perf_test_annotation_lower ON perf_test(LOWER(annotation));

EXPLAIN ANALYZE
SELECT *
FROM perf_test
WHERE reason LIKE '%dfe%';

CREATE EXTENSION pg_trgm;

CREATE INDEX trgm_idx_perf_test_reason ON perf_test USING gin (reason gin_trgm_ops);

















