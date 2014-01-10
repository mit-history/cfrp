class Person < ActiveRecord::Base
  attr_accessible :first_name, :full_name, :honorific, :last_name, :pseudonym, :url

  validates_presence_of :full_name
end
