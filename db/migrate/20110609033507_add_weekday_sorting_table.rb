class AddWeekdaySortingTable < ActiveRecord::Migration
  def self.up
    create_table :weekday_ordering do |t|
      t.string :name
      t.integer :ordering
    end
  end

  def self.down
    drop_table :weekday_ordering
  end
end
