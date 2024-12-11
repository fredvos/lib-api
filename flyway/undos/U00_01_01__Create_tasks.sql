SET SEARCH_PATH = libapi;

DROP TABLE tasks;
DROP TABLE projects;
DROP TYPE status_type;
DROP DOMAIN rating_type;

DELETE FROM flyway_schema_history WHERE version = '00.01.01';
