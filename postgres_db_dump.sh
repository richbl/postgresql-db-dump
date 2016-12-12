#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# -----------------------------------------------------------------------------
# Copyright (C) Business Learning Incorporated (businesslearninginc.com)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.
# -----------------------------------------------------------------------------
#
# A bash script to dump a remote PostgreSQL database
# version: 0.3.0
#
# requirements:
#  --preexisting database
#  --jq program installed: used to parse /data/config.json
#  --pg_dump (part of a PostgreSQL package install)
#
# inputs:
#  --host (e.g., www.website.com or IP address)
#  --username (must have appropriate permissions as PostgreSQL user/role on host)
#  --password
#  --database name to dump
#  --output directory to save dumped file (absolute path)
#
# outputs:
#  --a compressed (gz) dump file
#  --notification of script success/failure
#

# -----------------------------------------------------------------------------
# script declarations
#
shopt -s extglob
EXEC_DIR="$(dirname "$0")"
. ${EXEC_DIR}/lib/args

ARGS_FILE="${EXEC_DIR}/data/config.json"

declare -a REQ_PROGRAMS=('jq' 'pg_dump')

# -----------------------------------------------------------------------------
# perform script configuration, arguments parsing, and validation
#
check_program_dependencies "REQ_PROGRAMS[@]"
display_banner
scan_for_args "$@"
check_for_args_completeness

# -----------------------------------------------------------------------------
# generate dump file
#
mkdir -p "$(get_config_arg_value output_dir)"
RESULTS="$(get_config_arg_value database)"-database-"$(date +"%Y%m%d%H%M%S")".gz

echo "Starting database dump now... this could take some time depending on database size."
echo

# dump to $(get_config_arg_value database).sql file to catch pg_dump return code (if success, gzip and move file
# else, rm $(get_config_arg_value database).sql file and go home)
#
export PGPASSWORD="$(get_config_arg_value password)"
pg_dump -h "$(get_config_arg_value host)" -U "$(get_config_arg_value username)" "$(get_config_arg_value database)" > "/tmp/$(get_config_arg_value database).sql"
RETURN_CODE=$?

if [ $RETURN_CODE -ne 0 ]; then
  rm "/tmp/$(get_config_arg_value database).sql"
  echo
  echo "Error: pg_dump exited with error code "${RETURN_CODE}"."
  quit 1
else
  gzip -q "/tmp/$(get_config_arg_value database).sql"
  mv "/tmp/$(get_config_arg_value database).sql.gz" "$(get_config_arg_value output_dir)/${RESULTS}"
  echo "Success: PostgreSQL dump completed. Results file (${RESULTS}) created in $(get_config_arg_value output_dir)."
  quit 0
fi
