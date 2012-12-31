#!/bin/sh

psql -Upostgres -c 'drop database cfrp_development;'
psql -Upostgres -c 'create database cfrp_development;'
psql -Upostgres -c 'alter database cfrp_development owner to cfrp;'
bundle exec rake db:faceting:build
psql -Upostgres cfrp_development < ~/projects/mit-work/cfrp_production.27.12.2012.sql
bundle exec rake db:migrate
