# == Schema Information
# Schema version: 20100927135806
#
# Table name: seating_categories
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class SeatingCategory < ActiveRecord::Base
  has_many :ticket_sales

  attr_accessible :name, :description
end
