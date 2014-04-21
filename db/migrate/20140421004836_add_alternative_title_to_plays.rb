class AddAlternativeTitleToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :alternative_title, :string
  end
end
