class AddRegisterImagesCountToRegisters < ActiveRecord::Migration
  def self.up
    add_column :registers, :register_images_count, :integer, :default => 0

    # per http://railscasts.com/episodes/23-counter-cache-column
    Register.reset_column_information
    Register.find(:all).each do |r|
    	r.update_attribute :register_images_count, r.register_images.length
    end
  end

  def self.down
    remove_column :registers, :register_images_count
  end
end
