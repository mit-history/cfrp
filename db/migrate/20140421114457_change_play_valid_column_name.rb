class ChangePlayValidColumnName < ActiveRecord::Migration
  def up
  	rename_column :plays, :valid, :expert_validated
  end

  def down
  end
end
