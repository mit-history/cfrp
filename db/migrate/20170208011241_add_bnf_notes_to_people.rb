class AddBnfNotesToPeople < ActiveRecord::Migration
  def change
    add_column :people, :bnf_notes, :text
  end
end
