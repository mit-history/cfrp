# == Schema Information
# Schema version: 20100927135806
#
# Table name: register_contributors
#
#  id          :integer         not null, primary key
#  register_id :integer
#  task_id     :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class RegisterContributor < ActiveRecord::Base
  belongs_to :register
  has_one :user
end
