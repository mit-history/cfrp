# == Schema Information
#
# Table name: register_period_seating_categories
#
#  id                  :integer         not null, primary key
#  register_period_id  :integer
#  seating_category_id :integer
#  ordering            :integer         not null
#  created_at          :datetime
#  updated_at          :datetime
#

class RegisterPeriodSeatingCategory < ActiveRecord::Base
  belongs_to :register_period
  belongs_to :seating_category

  attr_accessible :ordering, :register_period_id, :seating_category_id
end
