class CreatePageDeGauche < ActiveRecord::Migration
  def change
  	create_table(:page_de_gauches) do |t|
  		t.string :category, null: false
  		t.timestamps
  	end
  end
end
