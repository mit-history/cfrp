class CreateRegisterPlays < ActiveRecord::Migration
  def self.up
    create_table :register_plays do |t|
      t.integer :register_id
      t.integer :play_id
      t.boolean :firstrun
      t.string :newactor
      t.string :actorrole
      t.boolean :editor_flag
      t.integer :firstrun_perfnum

      t.timestamps
    end
  end

  def self.down
    drop_table :register_plays
  end
end
