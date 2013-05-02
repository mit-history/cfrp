# == Schema Information
#
# Table name: plays
#
#  id                    :integer         not null, primary key
#  author                :string(255)
#  title                 :string(255)
#  genre                 :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  acts                  :integer
#  prose_vers            :string(255)
#  prologue              :boolean
#  musique_danse_machine :boolean
#

class Play < ActiveRecord::Base
  has_many :register_plays
  has_many :registers, :through => :register_plays

  attr_accessible :author, :title, :genre, :acts, :prose_vers, :prologue, :musique_danse_machine
end
