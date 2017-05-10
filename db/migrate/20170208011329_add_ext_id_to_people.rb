class AddExtIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :ext_id, :integer
  end
end
