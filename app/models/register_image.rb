# == Schema Information
# Schema version: 20100927135806
#
# Table name: register_images
#
#  id         :integer         not null, primary key
#  filepath   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class RegisterImage < ActiveRecord::Base
end
