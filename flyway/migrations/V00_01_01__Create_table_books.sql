/* Version 0.0.1 */

SET SEARCH_PATH = libapi;

/*
 * BOOKS
 */

CREATE TABLE books (
  uid                  UUID        NOT NULL,
  title                TEXT        NOT NULL,
  author               TEXT        NOT NULL,
  isbn                 TEXT        NOT NULL,
  description          TEXT        NOT NULL,
  created_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(), 
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT NOW(), 
  
  CONSTRAINT books_pk              PRIMARY KEY (uid)
);

COMMENT ON TABLE books IS 'Books in the collection';
COMMENT ON COLUMN books.title IS 'Title of the book';
COMMENT ON COLUMN books.author IS 'Author of the book';
COMMENT ON COLUMN books.isbn IS 'ISBN of the book';
COMMENT ON COLUMN books.description IS 'Wat is the book about';
COMMENT ON COLUMN books.created_at IS 'Creation date of this record; does not change';
COMMENT ON COLUMN books.updated_at IS 'Change date of this record - responsibility of API';
