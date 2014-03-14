class AddAttachmentImageToRegisterImages < ActiveRecord::Migration
  def self.up
    change_table :register_images do |t|
      t.attachment :image
      t.string :orientation
    end
  end

  def self.down
    drop_attached_file :register_images, :image
    remove_column :register_images, :orientation
  end
end
