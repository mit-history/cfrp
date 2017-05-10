class Authorship < ActiveRecord::Base
  attr_accessible :person_id, :ext_id, :person, :play_id, :play

  belongs_to :person, :foreign_key => :ext_id, :primary_key => :ext_id
  belongs_to :play
end
