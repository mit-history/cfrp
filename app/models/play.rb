class Play < ActiveRecord::Base
  has_many :register_plays
  has_many :registers, :through => :register_plays
end
