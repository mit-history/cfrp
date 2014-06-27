#
# N.B. Information in the faceted browser reflects the facet indices, not the model table.
#      Update periodically via this task.

desc "This task is called by the Heroku scheduler add-on"
# Should be invoked via a cron-style script. On Heroku, follow this recipe:
#   https://devcenter.heroku.com/articles/scheduler

namespace :db do
  namespace :facets do
    # See the AddFacetIndices migration (db/migrate/20140619101430_add_facet_indices.rb)
    # This task refreshes the indices declared in the migration
    task :refresh => :environment do
      puts "Updating Register facet indices..."
      Register.index_facets
      puts "Updating Play facet indices..."
      Play.index_facets
      puts "done."
    end
  end
end
