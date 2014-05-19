# == Schema Information
#
# Table name: register_plays
#
# t.integer  "register_id"
# t.integer  "play_id"
# t.boolean  "firstrun"
# t.string   "newactor"
# t.string   "actorrole"
# t.integer  "firstrun_perfnum"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.integer  "ordering"
# t.boolean  "free_access"
# t.string   "ex_attendance"
# t.string   "ex_representation"
# t.string   "ex_place"
# t.boolean  "reprise"
# t.boolean  "debut"
# t.integer  "reprise_perfnum"

class RegisterPlay < ActiveRecord::Base
  has_many :participations
  has_many :people, through: :participations

  belongs_to :register
  belongs_to :play
  accepts_nested_attributes_for :play

  accepts_nested_attributes_for :participations, reject_if: proc { |attributes| attributes['person_id'].blank? }, allow_destroy: true
  attr_accessible :play, :play_attributes, :participations_attributes, :ordering, :firstrun, :reprise, :reprise_perfnum, :debut, :newactor, :actorrole, :firstrun_perfnum, :free_access, :ex_attendance, :ex_representation, :ex_place

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

  def build_participations=(attrs)
    new_participation = Participation.find(attrs[:register_play_id])
    unless new_participation.nil?
      self.participation = new_participation
    end
  end
end
