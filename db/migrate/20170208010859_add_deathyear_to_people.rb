class AddDeathyearToPeople < ActiveRecord::Migration
  def change
    add_column :people, :deathyear, :integer
  end
end
