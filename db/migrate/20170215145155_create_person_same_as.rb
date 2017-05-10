class CreatePersonSameAs < ActiveRecord::Migration
  def change
    create_table :person_same_as do |t|
      t.integer :person_id
      t.string  :url

      t.timestamps
    end
  end
end
