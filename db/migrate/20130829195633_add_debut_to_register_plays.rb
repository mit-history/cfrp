class AddDebutToRegisterPlays < ActiveRecord::Migration
  def change
    add_column :register_plays, :debut, :boolean
  end
end
