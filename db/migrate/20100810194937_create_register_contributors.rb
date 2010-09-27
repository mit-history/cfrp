class CreateRegisterContributors < ActiveRecord::Migration
  def self.up
    create_table :register_contributors do |t|
      t.integer :register_id
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :register_contributors
  end
end
