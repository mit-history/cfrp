class CreateRegisterTasks < ActiveRecord::Migration
  def self.up
    create_table :register_tasks do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :register_tasks
  end
end
