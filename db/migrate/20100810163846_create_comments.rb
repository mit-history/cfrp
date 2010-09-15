class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :name
      t.text :value
      t.integer :register_id
      t.integer :comment_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
