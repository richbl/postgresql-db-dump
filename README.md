##postgresql-db-dump

`postgres_dump_db.sh` was written intially to permit for the remote dump of a PostgreSQL database. It takes a number of command-line parameters, and if run successfully, returns a date-and-time-stamped file (useful for a running backup archive). This script expects that the host is properly configured to accept remote logins, and that the Postgres user (technically called a role in Postgres) is apppropriately associated with the database in question.
####run_postgres_dump_db.sh
`run_postgres_dump.sh` is really just a front-end script that calls into `postgres_dump_db.sh` with a predefined set of parameters passed in.
