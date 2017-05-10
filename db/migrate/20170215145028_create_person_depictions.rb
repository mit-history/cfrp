class CreatePersonDepictions < ActiveRecord::Migration
  def change
    create_table :person_depictions do |t|
      t.integer :person_id
      t.string  :url

      t.timestamps
    end
  end
end
