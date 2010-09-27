class CreateRegisterTypeSeatingCategories < ActiveRecord::Migration
  def self.up
    create_table :register_type_seating_categories do |t|
      t.integer :register_type_id
      t.integer :seating_category_id
      t.integer :ordering, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :register_type_seating_categories
  end
end
