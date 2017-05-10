class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.integer :play_id
      t.integer :person_id

      t.timestamps
    end
  end
end
