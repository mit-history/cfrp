class ChangeRegisterAndRegisterImagesToHasOneToMany < ActiveRecord::Migration
  def up
    add_column :register_images, :register_id, :integer
    RegisterImage.all.each do |ri|
      r = Register.find_by_register_image_id(ri.id)
      unless r.nil?
        ri.register_id = r.id
        ri.save!
      end
    end
  end

  def down
    remove_column :register_images, :register_id
  end
end
