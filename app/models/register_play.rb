class RegisterPlay < ActiveRecord::Base
  has_many :registers
  has_many :plays
end
