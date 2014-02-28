class CreateLhpCategoryAssignments < ActiveRecord::Migration
  def change
  	create_table(:lhp_category_assignments) do |t|
  		t.integer :register_id, null: false
  		t.integer :page_de_gauche_id, null: false
  		t.timestamps
  	end
  end
end
