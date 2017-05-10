class CreatePersonAltlabels < ActiveRecord::Migration
  def change
    create_table :person_altlabels do |t|
      t.integer :person_id
      t.string  :label

      t.timestamps
    end
  end
end
