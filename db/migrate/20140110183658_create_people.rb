class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :pseudonym
      t.string :honorific
      t.string :url

      t.timestamps
    end
  end
end
