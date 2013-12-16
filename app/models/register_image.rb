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
  has_one :register, :counter_cache => true
  attr_accessible :filepath, :register_id
end
