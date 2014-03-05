# == Schema Information
#
# Table name: verification_states
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#

class VerificationState < ActiveRecord::Base
  has_many :registers

  def self.unique_states
    order(:name).uniq(:name).pluck(:name)
  end
end
