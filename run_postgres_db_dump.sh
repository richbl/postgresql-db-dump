#!/bin/bash

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
# A bash script front-end to call postgres_db_dump.sh
# version: 0.1.0
#
# requirements:
#  --access to postgres_db_dump.sh
#
# inputs:
#  --none (runs with no inputs)
#
# outputs:
#  --none (side effect is the completion of the called script)
#

#
/bin/bash /home/USER/development/bash_scripts/postgres_db_dump.sh -h example.com -u USERNAME -p 'PASSWORD' -d DATABASE -o /home/USER/db_dump
