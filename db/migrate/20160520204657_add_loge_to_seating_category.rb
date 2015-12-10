class AddLogeToSeatingCategory < ActiveRecord::Migration
  def change
    add_column :seating_categories, :boolean, :string
  end
end
