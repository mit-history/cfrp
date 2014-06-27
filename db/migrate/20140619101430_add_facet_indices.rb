class AddFacetIndices < ActiveRecord::Migration
  def up
    # Set the list of indexed facets. Will add _packed_id if necessary.
    Register.index_facets([:season, :weekday, :title1, :title2, :author1, :author2])
    # Hereafter, to refresh facet indices a cron-type task will need to execute 'Register.index_facets'
    # (see the new 'rake db:facets:refresh' task)
    # (see https://devcenter.heroku.com/articles/scheduler)
  end

  def down
    # Set the list of indexed facets to []. Will add or remove _packed_id as necessary.
    Register.index_facets([])
  end
end
