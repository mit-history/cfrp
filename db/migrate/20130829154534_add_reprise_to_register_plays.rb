class AddRepriseToRegisterPlays < ActiveRecord::Migration
  def change
    add_column :register_plays, :reprise, :boolean
  end
end
