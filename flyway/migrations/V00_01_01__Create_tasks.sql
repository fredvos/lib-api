/*
 * Simplified example of a schema with two related tables.
 */

SET SEARCH_PATH = libapi;

/*
 * RATING_TYPE
 */
CREATE DOMAIN rating_type AS SMALLINT CHECK(value >= 1 AND value <= 5);
COMMENT ON DOMAIN rating_type IS 'A 1..5 rating type; 1=very low and 5 is very high';

/*
 * STATUS_TYPE
 */
CREATE TYPE status_type AS ENUM ('N', 'P', '*', 'X', 'V');
COMMENT ON TYPE status_type IS 'Status of a task, project etc; New, Planned, Doing, Canceled, Done';

/*
 * PROJECTS
 */

CREATE TABLE projects (
  uid                  UUID          NOT NULL,
  title                TEXT          NOT NULL,
  status               status_type   NOT NULL DEFAULT 'N',
  created_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW(), 
  updated_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW(), 

  CONSTRAINT projects_pk                PRIMARY KEY (uid)
);

COMMENT ON TABLE projects IS 'A set of related tasks';
COMMENT ON COLUMN projects.title IS 'What';
COMMENT ON COLUMN projects.status IS 'Status of the project';
COMMENT ON COLUMN projects.created_at IS 'Creation date of this record; does not change';
COMMENT ON COLUMN projects.updated_at IS 'Change date of this record - responsibility of API';

/*
 * TASKS
 */

CREATE TABLE tasks (
  uid                  UUID          NOT NULL,
  project_uid          UUID,
  title                TEXT          NOT NULL,
  due                  TIMESTAMPTZ,
  priority             rating_type   NOT NULL DEFAULT 1,
  estimated_minutes    INTEGER,
  work_minutes         INTEGER,
  status               status_type   NOT NULL DEFAULT 'N',
  created_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW(), 
  updated_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW(), 

  CONSTRAINT tasks_pk                PRIMARY KEY (uid),
  CONSTRAINT tasks_fk1               FOREIGN KEY (project_uid) REFERENCES projects(uid)
);

COMMENT ON TABLE tasks IS 'Units of work to do or done';
COMMENT ON COLUMN tasks.project_uid IS 'If task is part of a project, this is the link to the project';
COMMENT ON COLUMN tasks.title IS 'What';
COMMENT ON COLUMN tasks.due IS 'When must it be finished';
COMMENT ON COLUMN tasks.priority IS 'How much does it hurt if/while the task is not finished (in time)';
COMMENT ON COLUMN tasks.estimated_minutes IS 'How much time in minutes is needed to finish job';
COMMENT ON COLUMN tasks.work_minutes IS 'How much time in minutes did it actually cost';
COMMENT ON COLUMN tasks.status IS 'Status of the task';
COMMENT ON COLUMN tasks.created_at IS 'Creation date of this record; does not change';
COMMENT ON COLUMN tasks.updated_at IS 'Change date of this record - responsibility of API';
