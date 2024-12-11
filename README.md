# Lib API

## Fork

This is a fork of the REST API that was the result of this wonderful [video](https://youtu.be/I8WiIXMDydw)

See the URL to the source of this fork in the description of that video.

## Goals

- Try to make it work without PIP or a Virtual Environment,
  using only Debian packages
- Use [Flyway](https://www.red-gate.com/products/flyway/)
  in Docker for migrations
  (DDL scripts to create and change database objects);
  this can replace generating database objects using SQLModel's tools
- Make it run in a Docker container
- Add more tables to the schema,
  so it can be used as a base for future projects
- Target for experiments,
  since I'm still learning to use FastAPI and SQLModel

## Prerequisites

- Python >=3.10
- PostgreSQL database, schema and user available
- Docker
- GNU Make

## Pip still required

Unfortunately the use of Pip is still required.
Python library Pydantic as packaged for Debian Bookworm is still major version 1,
while the examples in the forked linbrary make use of features available in major version 2.
Switching to Debian Trixie as a base for development is at the moment not an option,
since this version of Debian currently (2024-11-23) at least does not even have the SQLModel package.
As soon as Trixie is a viable base image for this and has all the necessary packages available
in a recent version, I will ditch Pip and use Debian packages exclusively.

## How to run the service

### 1. Prepare the database

Make sure that a database, a database user and an empty schema
are available where this service has access to.
The database user must have rights to create tables etc.
Flyway will create an extra table in the schema to maintain migration version data.

### 2. Create a file .env

```bash
POSTGRES_HOST=
POSTGRES_DATABASE=
POSTGRES_USER=
POSTGRES_PASSWORD=
POSTGRES_SCHEMA=
```

In a Dockerized environment use the hostname of the Postgres container as DATABASE_HOST.

### 3. Generate database objects

```shell
$ make migrations
```
### 4. Run the service
