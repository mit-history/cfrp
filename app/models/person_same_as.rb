class PersonSameAs < ActiveRecord::Base
  attr_accessible :person_id, :person, :url

  belongs_to :person, :foreign_key => :ext_id, :primary_key => :ext_id
end
