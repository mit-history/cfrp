class LagrangeDocAuthor < ActiveRecord::Base
  attr_accessible :lagrange_author_id, :lagrange_doc_id, :lagrange_author_ext_id, :lagrange_doc_ext_id

  belongs_to :lagrange_author
  belongs_to :lagrange_doc

  accepts_nested_attributes_for :lagrange_author
  accepts_nested_attributes_for :lagrange_doc
end
