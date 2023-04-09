DROP TABLE IF EXISTS book;

CREATE TABLE book
(
	book_id int GENERATED ALWAYS AS IDENTITY not null,
	title text not null,
	isbn varchar(32) not null,
	publisher_id int not null,
	
	CONSTRAINT PK_book_book_id PRIMARY KEY (book_id)
)
SELECT * FROM book

CREATE SEQUENCE IF NOT EXISTS book_book_id_seq
START WITH 1 OWNED BY book.book_id

INSERT INTO book (title, isbn, publisher_id)
VALUES ('title', 'isbn', 1)

ALTER TABLE book
ALTER COLUMN book_id SET DEFAULT nextval('book_book_id_seq') 







