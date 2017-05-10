class AddPrefLabelToPeople < ActiveRecord::Migration
  def change
    add_column :people, :pref_label, :string
  end
end
