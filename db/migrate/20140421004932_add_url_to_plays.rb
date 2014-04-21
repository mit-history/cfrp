class AddUrlToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :url, :string
  end
end
