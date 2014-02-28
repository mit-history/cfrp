class AddIndexesToRegisters < ActiveRecord::Migration
  def change
  	add_index :registers, :verification_state_id
  end
end
