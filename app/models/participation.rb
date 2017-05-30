class Participation < ActiveRecord::Base
  attr_accessible :character, :debut, :person_id, :person, :register_play_id, :register_play, :role

  belongs_to :person
  belongs_to :register_play

end
