# update steps

# get faceting working
rake db:migrate

# move existing images to new s3/paperclip
rake filepath:migrate_to_paperclip

# import six more seasons
rake img:import
