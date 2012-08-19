class RenameRegisterTypeSeatingCategoryToRegisterPeriodSeatingCategory < ActiveRecord::Migration
  def up
    rename_table :register_type_seating_categories, :register_period_seating_categories
    rename_column :register_period_seating_categories, :register_type_id, :register_period_id
  end

  def down
    rename_table :register_period_seating_categories, :register_type_seating_categories
    rename_column :register_type_seating_categories, :register_period_id, :register_type_id
  end
end
