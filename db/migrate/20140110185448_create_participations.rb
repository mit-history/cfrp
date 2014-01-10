class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.string :role
      t.integer :person_id
      t.boolean :debut
      t.string :character
      t.integer :register_play_id

      t.timestamps
    end

    add_index(:participations, :person_id)
    add_index(:participations, :register_play_id)
  end
end
