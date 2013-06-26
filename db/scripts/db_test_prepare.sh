#!/bin/bash

# This basically substitutes for running
#
# bundle exec rake db:test:prepare
#
# ...because the postgres extensions in place for faceting 
# won't let you run the import if you are not postgres admin.
# Perhaps there is a way to strip those out when dumping?

# THIS MUST BE RUN IN RAILS ROOT OF PROJECT!

POSTGRES_BINPATH=/opt/local/lib/postgresql84/bin
PROJECT_NAME=cfrp
TEST_DATABASE=cfrp_test

bundle exec rake db:structure:dump
$POSTGRES_BINPATH/dropdb -Upostgres $TEST_DATABASE
$POSTGRES_BINPATH/createdb -Upostgres $TEST_DATABASE
$POSTGRES_BINPATH/psql -Upostgres -c "ALTER DATABASE $TEST_DATABASE OWNER TO $PROJECT_NAME"
$POSTGRES_BINPATH/psql -Upostgres $TEST_DATABASE < db/development_structure.sql

# This updates all the tables so they are owned by $PROJECT_NAME.  Thanks to:
# http://bytes.com/topic/postgresql/answers/172978-sql-command-list-tables
# There may be a more simple way to do this, but I am not aware of it...
for i in `$POSTGRES_BINPATH/psql -Upostgres $TEST_DATABASE -q -t -c "SELECT c.relname FROM pg_catalog.pg_class c LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace WHERE c.relkind IN ('r', '') AND n.nspname NOT IN ('pg_catalog', 'pg_toast') AND pg_catalog.pg_table_is_visible(c.oid)"`; do $POSTGRES_BINPATH/psql -Upostgres $TEST_DATABASE -c "ALTER TABLE $i OWNER TO $PROJECT_NAME"; done
