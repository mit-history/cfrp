class CreateRegisterLeftPages < ActiveRecord::Migration
  def change
  	create_table(:register_left_pages) do |t|
  		t.integer :register_id, null: false
  		t.integer :page_de_gauche_id, null: false
  		t.timestamps
  	end
  end
end
