# == Schema Information
#
# Table name: register_images
#
#  id          :integer         not null, primary key
#  filepath    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#  register_id :integer
#

class RegisterImage < ActiveRecord::Base
  has_attached_file :image,
    :styles =>{
      :thumb  => "100x100",
      :medium => "200x200",
      :large => "600x400"
  }
  has_one :register, counter_cache: true
  validates_attachment_content_type :image,
    content_type: [ 'image/jpg', 'image/jpeg' ]
  validates_inclusion_of :orientation, in: ['left', 'recto','verso'],
    allow_blank: true

  attr_accessible :orientation, :filepath, :register_id, :image
end

# Define thumb styles for paperclip
