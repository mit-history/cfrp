class CreateSeatingCategories < ActiveRecord::Migration
  def self.up
    create_table :seating_categories do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :seating_categories
  end
end
