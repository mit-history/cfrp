class CreatePlays < ActiveRecord::Migration
  def self.up
    create_table :plays do |t|
      t.string :author
      t.string :title
      t.string :genre

      t.timestamps
    end
  end

  def self.down
    drop_table :plays
  end
end
