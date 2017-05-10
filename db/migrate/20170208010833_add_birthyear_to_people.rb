class AddBirthyearToPeople < ActiveRecord::Migration
  def change
    add_column :people, :birthyear, :integer
  end
end
