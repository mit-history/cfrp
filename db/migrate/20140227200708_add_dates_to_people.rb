class AddDatesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :dates, :string
  end
end
