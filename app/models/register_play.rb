# == Schema Information
#
# Table name: register_plays
#
#  id               :integer         not null, primary key
#  register_id      :integer
#  play_id          :integer
#  firstrun         :boolean
#  newactor         :string(255)
#  actorrole        :string(255)
#  firstrun_perfnum :integer
#  created_at       :datetime
#  updated_at       :datetime
#  ordering         :integer
#

class RegisterPlay < ActiveRecord::Base
  belongs_to :register
  belongs_to :play
end
