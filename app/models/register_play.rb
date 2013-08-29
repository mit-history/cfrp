# == Schema Information
#
# Table name: register_plays
#
#  id                :integer         not null, primary key
#  register_id       :integer
#  play_id           :integer
#  firstrun          :boolean
#  reprise           :boolean
#  newactor          :string(255)
#  actorrole         :string(255)
#  firstrun_perfnum  :integer
#  created_at        :datetime
#  updated_at        :datetime
#  ordering          :integer
#  free_access       :boolean
#  ex_attendance     :string(255)
#  ex_representation :string(255)
#  ex_place          :string(255)
#

class RegisterPlay < ActiveRecord::Base
  belongs_to :register
  belongs_to :play
  accepts_nested_attributes_for :play
  attr_accessible :play, :play_attributes, :ordering, :firstrun, :reprise, :reprise_perfnum, :debut, :newactor, :actorrole, :firstrun_perfnum, :free_access, :ex_attendance, :ex_representation, :ex_place

  after_initialize :init

  def init
    self.ordering ||= 1
  end

  def play_attributes=(attrs)
    new_play = Play.find(attrs[:play_id])
    unless new_play.nil?
      self.play = new_play
    end
  end
end
