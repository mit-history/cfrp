class AddAliasToPeople < ActiveRecord::Migration
  def change
    add_column :people, :alias, :string
  end
end
