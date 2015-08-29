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
  validates_attachment_content_type :image, content_type: [ 'image/jpg', 'image/jpeg' ]
  validates_inclusion_of :orientation, in: ['left', 'recto','verso'], allow_blank: true
  attr_accessible :orientation, :filepath, :register_id, :image

  default_scope order('orientation ASC')

  scope :volume, ->(number) { where("filepath ~ ?", "M119_02_R#{number}") }

  def image_filename
    if !self.filepath.nil?
      filepath = self.filepath
    else
      filepath = self.image_file_name
    end
  end

  def rv_flag
    result   = self.image_file_name || self.filepath
    result &&= result[/M119_02_R\d{2,3}(_II_1)?_\d{3}([rv])?.jpg/, 2]
    if result.nil?
      result &&= result[/M119_02_R\d{2,3}_\d{3}([rv])?.jpg/, 1]
    end
    result
  end

end

# Define thumb styles for paperclip
