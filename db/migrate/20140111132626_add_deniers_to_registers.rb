class AddDeniersToRegisters < ActiveRecord::Migration
  def change
    add_column :registers, :total_receipts_recorded_d, :integer
  end
end
