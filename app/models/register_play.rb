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
  accepts_nested_attributes_for :play
  attr_accessible :play, :play_attributes, :ordering, :firstrun, :newactor, :actorrole, :firstrun_perfnum

  def play_attributes=(attrs)
    logger.info "we are updating the play_attributes via register_play?"
    play = Play.where(["author = ? AND title = ? AND genre = ?",
                       attrs[:author], attrs[:title], attrs[:genre]]
                      ).first
    unless play.nil?
      self.play = play
    else
      self.play = Play.new(attrs)
    end
  end
end
