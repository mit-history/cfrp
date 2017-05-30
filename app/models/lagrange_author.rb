class LagrangeAuthor < ActiveRecord::Base
	attr_accessible :ext_id, :etype, :birth_death_years, :mainrole, :mainform, :firstname, :firstname1, :formcompl, :lastname, :firstname2, :computedform, :url

	has_many :lagrange_doc_authors
	has_many :lagrange_docs, through: :lagrange_doc_authors

	accepts_nested_attributes_for :lagrange_doc_authors

end
