class LhpCategoryAssignment < ActiveRecord::Base
	belongs_to :register
	belongs_to :page_de_gauche

	attr_accessible :page_de_gauche, :register, :page_de_gauche_id, :register_id

  accepts_nested_attributes_for :page_de_gauche

	validates_presence_of :register
	validates_presence_of :page_de_gauche_id

	# def build_lhp_category_assignments=(attrs)
	# 	new_lhp_category_assignment = LhpCategoryAssignment.find(attrs[:page_de_gauche_id])
	# 	unless new_page_de_gauche.nil?
	# 	  self.lhp_category_assignment = new_lhp_category_assignment
	# 	end
	# end
end
