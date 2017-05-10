class AddOrigLabelToPeople < ActiveRecord::Migration
  def change
    add_column :people, :orig_label, :string
  end
end
