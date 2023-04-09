CREATE TABLE exam
(
	exam_id serial UNIQUE NOT NULL,
	name varchar(32) NOT NULL,
	date date
);

DROP TABLE exam

ALTER TABLE exam
DROP CONSTRAINT exam_exam_id_key

ALTER TABLE exam
ADD CONSTRAINT pk_exam_id PRIMARY KEY (exam_id)

DROP TABLE person

CREATE TABLE person
(
	person_id int NOT NULL,
	first_name varchar(24),
	last_name varchar(24),
	
	CONSTRAINT PK_person_id PRIMARY KEY (person_id)
);

CREATE TABLE passport
(
	passport_id int PRIMARY KEY,
	serial_number int NOT NULL,
	registration int, 
	
	CONSTRAINT fk_registration_person_person_id FOREIGN KEY (registration) REFERENCES person (person_id)
);

CREATE TABLE book
(
	book_id serial PRIMARY KEY,
	name varchar(24)
)

ALTER TABLE book
ADD COLUMN weight int

ALTER TABLE book
ADD CONSTRAINT chk_weight CHECK (weight> 0 and weight<100)

ALTER TABLE book
DROP CONSTRAINT chk_weight

INSERT INTO book 
VALUES (2, 'name2', 102)

SELECT * FROM student

DROP TABLE IF EXISTS student 

CREATE TABLE student
(
	student_id serial NOT NULL,
	full_name varchar(128),
	course int DEFAULT 1
);
DROP SEQUENCE student_student_id_seq

CREATE SEQUENCE IF NOT EXISTS student_student_id_seq
START WITH 1 OWNED BY student.student_id;

ALTER TABLE student
ALTER COLUMN student_id 
SET DEFAULT nextval('student_student_id_seq');

INSERT INTO student
VALUES
(1, 'Zizevskiy Stas'),
(2, 'Zizevskaya Olga')

ALTER TABLE student
ALTER COLUMN course 
DROP DEFAULT




