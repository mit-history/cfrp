class LagrangeDoc < ActiveRecord::Base
  attr_accessible :ext_id, :etype, :title, :title2, :subtitle, :imgref, :imgurl, :url


  has_one :lagrange_doc_author
  has_one :lagrange_author, through: :lagrange_doc_author

  accepts_nested_attributes_for :lagrange_doc_author

end
