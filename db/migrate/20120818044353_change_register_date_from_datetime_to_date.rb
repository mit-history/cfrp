class ChangeRegisterDateFromDatetimeToDate < ActiveRecord::Migration
  def up
    change_column :registers, :date, :date
  end

  def down
    change_column :registers, :date, :datetime
  end
end
