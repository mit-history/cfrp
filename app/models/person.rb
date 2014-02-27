class Person < ActiveRecord::Base
  attr_accessible :first_name, :full_name, :honorific,
  :last_name, :pseudonym, :url, :alias, :societaire_pensionnaire, :dates

  # validates_presence_of :full_name

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Person.create! row.to_hash
    end
  end
end
