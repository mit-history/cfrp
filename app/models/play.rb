# == Schema Information
# Schema version: 20100927135806
#
# Table name: plays
#
#  id         :integer         not null, primary key
#  author     :string(255)
#  title      :string(255)
#  genre      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Play < ActiveRecord::Base
  has_many :register_plays
  has_many :registers, :through => :register_plays
end
