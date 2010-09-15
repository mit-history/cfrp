class Register < ActiveRecord::Base
  include Repertoire::Faceting::Model

  belongs_to :register_image

  has_many :ticket_sales
  has_many :register_plays
  has_many :plays, :through => :register_plays

  accepts_nested_attributes_for :register_plays
  accepts_nested_attributes_for :plays

  facet :season
  facet :weekday

  # examples from nobelists example
  # facet :nobel_year, order('nobel_year asc')
  # facet :degree, joins(:affiliations).order('degree asc', 'count desc')
  # facet :birth_place, group(:birth_country, :birth_state, :birth_city).order('count desc', 'birth_place asc')
  # facet :birth_decade, group('((EXTRACT(year FROM birthdate)::integer / 10::integer) * 10)').order('birth_decade asc')
end
