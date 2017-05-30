class RcfLagrangeAuthor < ActiveRecord::Base
  attr_accessible :person_id, :lagrange_author_id, :rcf_ext_id, :lagrange_author_ext_id

  belongs_to :lagrange_author
  belongs_to :person
end
