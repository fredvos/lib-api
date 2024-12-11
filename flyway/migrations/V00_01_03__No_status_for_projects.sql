/*
 * Status of project can be derived from undelying tasks, so remove.
 */

SET SEARCH_PATH = libapi;

ALTER TABLE ONLY projects DROP COLUMN status;
