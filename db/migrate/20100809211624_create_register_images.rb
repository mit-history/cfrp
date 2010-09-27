class CreateRegisterImages < ActiveRecord::Migration
  def self.up
    create_table :register_images do |t|
      t.string :filepath

      t.timestamps
    end

    change_table :registers do |t|
      t.references :register_image
    end
  end

  def self.down
    drop_table :register_images

    change_table :registers do |t|
      t.remove :register_image_id
    end
  end
end
