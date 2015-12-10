class ChangeLogeColumnToBoolean < ActiveRecord::Migration
  def up
	change_column :seating_categories, :loge, 'boolean USING CAST(loge AS boolean)'
  end

  def down
  end
end
