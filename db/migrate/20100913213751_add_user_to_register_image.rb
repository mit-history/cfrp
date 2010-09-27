class AddUserToRegisterImage < ActiveRecord::Migration
  def self.up
    add_column :register_images, :user_id, :integer
  end

  def self.down
    remove_column :register_images, :user_id
  end
end
