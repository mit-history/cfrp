class Person < ActiveRecord::Base
  include Repertoire::Faceting::Model

  facet :pseudonym
  facet :alias
  facet :last_name
  facet :honorific

  attr_accessible :first_name, :full_name, :honorific,
  :last_name, :pseudonym, :url, :alias, :societaire_pensionnaire, :dates

  # validates_presence_of :full_name

  def self.unique_persons
    order(:pseudonym).uniq(:pseudonym).pluck(:pseudonym)
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Person.create! row.to_hash
    end
  end
end
