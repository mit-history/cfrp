class ChangeLogeColumnTypeAndName < ActiveRecord::Migration
  def up
	rename_column :seating_categories, :boolean, :loge
  end

  def down
  end
end
