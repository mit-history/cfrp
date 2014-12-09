# == Schema Information
#
# d5b04fp5hk0mk9=> \d plays
#                                            Table "public.plays"
#         Column         |            Type             |                     Modifiers
# -----------------------+-----------------------------+----------------------------------------------------
#  id                    | integer                     | not null default nextval('plays_id_seq'::regclass)
#  author                | character varying(255)      |
#  title                 | character varying(255)      |
#  genre                 | character varying(255)      |
#  created_at            | timestamp without time zone |
#  updated_at            | timestamp without time zone |
#  acts                  | integer                     |
#  prose_vers            | character varying(255)      |
#  prologue              | boolean                     |
#  musique_danse_machine | boolean                     |
#  alternative_title     | character varying(255)      |
#  url                   | character varying(255)      |
#  date_de_creation      | date                        |
#  expert_validated      | boolean                     |
# Indexes:
#     "plays_pkey" PRIMARY KEY, btree (id)

class Play < ActiveRecord::Base
  include Repertoire::Faceting::Model

  has_many :register_plays
  has_many :registers, :through => :register_plays

  attr_accessible :author, :title, :genre, :acts, :prose_vers, :prologue,
  :musique_danse_machine, :created_at, :updated_at, :alternative_title, :url,
  :date_de_creation, :expert_validated

  scope :tragédie, where(:genre => "tragédie").order("id asc")
  scope :comédie, where(:genre => "comédie").order("id asc")
  scope :expert_validated, where(:expert_validated => "true")

  before_create :set_packed_id # from: http://stackoverflow.com/a/11731205/271192

  facet :acts
  facet :genre
  facet :author

  def self.unique_titles
    expert_validated.order(:title).uniq(:title).pluck(:title)
  end

  def self.unique_authors
    expert_validated.order(:author).uniq(:author).pluck(:author)
  end

  # from: http://stackoverflow.com/a/11731205/271192
  def set_packed_id
    self._packed_id = self.class.connection.select_value("SELECT nextval('plays__packed_id_seq'::regclass)")
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Play.create! row.to_hash
    end
  end
end
