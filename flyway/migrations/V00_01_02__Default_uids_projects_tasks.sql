/*
 * Generate default primary keys.
 */

SET SEARCH_PATH = libapi;

ALTER TABLE ONLY projects ALTER COLUMN uid SET DEFAULT gen_random_uuid();
ALTER TABLE ONLY tasks ALTER COLUMN uid SET DEFAULT gen_random_uuid();
