class CreateRegisterPeriods < ActiveRecord::Migration
  def self.up
    create_table :register_periods do |t|
      t.string :period

      t.timestamps
    end

    change_table :registers do |t|
      t.references :register_period
    end
  end

  def self.down
    drop_table :register_periods

    change_table :registers do |t|
      t.remove :register_period_id
    end
  end
end
