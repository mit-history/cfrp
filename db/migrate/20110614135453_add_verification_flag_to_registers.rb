class AddVerificationFlagToRegisters < ActiveRecord::Migration
  def self.up
    create_table :verification_states do |t|
      t.string :name
      t.string :description
    end

    add_column :registers, :verification_state_id, :integer
  end

  def self.down
    drop_table :verification_states
    remove_column :registers, :verification_state_id
  end
end
