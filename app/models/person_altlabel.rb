class PersonAltlabel < ActiveRecord::Base
  attr_accessible :person_id, :person, :label

  belongs_to :person, :foreign_key => :ext_id, :primary_key => :ext_id
end
