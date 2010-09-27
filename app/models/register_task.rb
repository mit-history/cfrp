# == Schema Information
# Schema version: 20100927135806
#
# Table name: register_tasks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class RegisterTask < ActiveRecord::Base
end
