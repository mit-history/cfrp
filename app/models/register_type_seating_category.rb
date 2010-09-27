# == Schema Information
# Schema version: 20100927135806
#
# Table name: register_type_seating_categories
#
#  id                  :integer         not null, primary key
#  register_type_id    :integer
#  seating_category_id :integer
#  ordering            :integer         not null
#  created_at          :datetime
#  updated_at          :datetime
#

class RegisterTypeSeatingCategory < ActiveRecord::Base
end
