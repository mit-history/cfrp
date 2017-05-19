heroku pg:psql < db/data/author_inserts.sql -a cfrp-staging
heroku pg:psql < db/data/authorships.sql -a cfrp-staging
heroku pg:psql < db/data/people_associations.sql -a cfrp-staging
