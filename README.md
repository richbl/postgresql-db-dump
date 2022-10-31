# Postgresql-Db-Dump

**Postgresql-Db-Dump** (`postgres_dump_db.sh`) permits for the remote dump of a PostgreSQL database. It takes a number of command-line parameters, and if run successfully, returns a date-and-time-stamped compressed file (useful for a running backup archive).

This script expects that the host is properly configured to accept remote logins, and that the Postgres user (technically called a *role* in Postgres) is apppropriately associated with the database in question.

## Run_postgres_dump_db.sh
The associated script, `run_postgres_dump.sh`, is really just a front-end script that calls into `postgres_dump_db.sh` with a predefined set of parameters passed in. Useful for automating the dump process (*e.g.*, executing via a cronjob).

## [<img src="https://cloud.githubusercontent.com/assets/10182110/18208786/ae5d76b2-70e5-11e6-9663-cfe47d13f4d9.png" width="150" />](https://github.com/richbl/a-bash-template)Developed with a Bash Template (BaT)

**Postgresql-Db-Dump** uses a bash template (BaT) called **[A-Bash-Template](https://github.com/richbl/a-bash-template)** designed to make script development and command line argument management more robust, easier to implement, and easier to maintain. Here are a few of those features:

- Dependencies checker: a routine that checks all external program dependencies (*e.g.*, [sshpass](http://linux.die.net/man/1/sshpass) and [jq](https://stedolan.github.io/jq/))
- Arguments and script details--such as script description and syntax--are stored in the [JSON](http://www.json.org/) file format (*i.e.*, `config.json`)
- JSON queries (using [jq](https://stedolan.github.io/jq/)) handled through wrapper functions
- A script banner function automates banner generation, reading directly from `config.json`
- Command line arguments are parsed and tested for completeness using both short and long-format argument syntax (*e.g.*, `-u|--username`)
- Optional command line arguments are permissible and managed through the JSON configuration file
- Template functions organized into libraries to minimize code footprint in the main script

For more details about using a bash template, [check out the BaT sources here](https://github.com/richbl/a-bash-template).

## Basic Usage
**Postgresql-Db-Dump** is run through an interactive command line interface, so all of the command options are made available there.

Here's the default response when running `postgres_dump_db.sh` with no arguments:


	 |
	 | A bash script to dump a remote PostgreSQL database
	 |   0.2.0
	 |
	 | Usage:
	 |   postgres_db_dump -h host -u username -p password -d database -o output_dir
	 |
	 |   -h, --host 	website URL or IP address
	 |   -u, --username 	user name
	 |   -p, --password 	password
	 |   -d, --database 	PostgreSQL database name
	 |   -o, --output_dir 	absolute directory path to save dumped file
	 |

	Error: host argument (-h|--host) missing.
	Error: username argument (-u|--username) missing.
	Error: database argument (-d|--database) missing.
	Error: output_dir argument (-o|--output_dir) missing.

In this example, the program responds by indicating that the required script arguments must be set before proper operation.

When arguments are correctly passed, the script provides feedback on the success or failure of the remote folder copy:

	$ ./postgres_db_dump.sh -h example.com -u remote_user -p 'pass123' -d dbname -o /home/user

	 |
	 | A bash script to dump a remote PostgreSQL database
	 |   0.2.0
	 |
	 | Usage:
	 |   postgres_db_dump -h host -u username -p password -d database -o output_dir
	 |
	 |   -h, --host 	website URL or IP address
	 |   -u, --username 	user name
	 |   -p, --password 	password
	 |   -d, --database 	PostgreSQL database name
	 |   -o, --output_dir 	absolute directory path to save dumped file
	 |

	Starting database dump now... this could take some time depending on database size.

	Success: PostgreSQL dump completed. Results file (dbname-database-20160414082441.gz) created in /home/user.

## IMPORTANT: This Project Uses Git Submodules <img src="https://user-images.githubusercontent.com/10182110/198916805-2c139481-8d92-4484-b92e-1d440df68045.jpg" width="150" />

This project uses a Git [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules) project, specifically the `bash-lib` folder to keep this project up-to-date without manual intervention.

So, be sure to clone this project with the `--recursive` switch (`git clone --recursive https://github.com/richbl/this_project`) so any submodule project(s) will be automatically cloned as well. If you clone into this project without this switch, you'll likely see empty submodule project folders (depending on your version of Git).
