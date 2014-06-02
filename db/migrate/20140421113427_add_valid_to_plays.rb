class AddValidToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :valid, :boolean
  end
end
