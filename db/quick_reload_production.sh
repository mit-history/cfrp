#!/bin/sh

psql -Upostgres -c 'drop database cfrp_production;'
psql -Upostgres -c 'create database cfrp_production;'
psql -Upostgres -c 'alter database cfrp_production owner to cfrp;'
bundle exec rake db:faceting:build RAILS_ENV=production
psql -Upostgres cfrp_production < cfrp_production.backup-31.12.2012.sql
bundle exec rake db:migrate RAILS_ENV=production
