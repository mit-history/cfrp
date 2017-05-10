class RenameAuthorsToAuthorships < ActiveRecord::Migration
  def change
    rename_table :authors, :authorships
  end 
end
