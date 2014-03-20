class InstallFaceting < ActiveRecord::Migration
  def self.up
    if Rails.env.production?
      execute('CREATE SCHEMA facet')
      execute( faceting_api_sql(:bytea, 'facet') )
    else
      execute('CREATE EXTENSION faceting')
    end
  end

  def self.down
    if Rails.env.production?
      execute('DROP SCHEMA facet CASCADE')
    else
      execute('DROP EXTENSION faceting CASCADE')
    end
  end
end
