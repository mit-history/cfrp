class AddIrregularRecieptsNameToRegisters < ActiveRecord::Migration
  def self.up
    add_column :registers, :irregular_receipts_name, :string
  end

  def self.down
    add_column :registers, :irregular_receipts_name
  end
end
