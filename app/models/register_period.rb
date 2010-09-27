# == Schema Information
# Schema version: 20100927135806
#
# Table name: register_periods
#
#  id         :integer         not null, primary key
#  period     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class RegisterPeriod < ActiveRecord::Base
end
