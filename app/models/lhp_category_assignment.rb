class LhpCategoryAssignment < ActiveRecord::Base
	belongs_to :register
	belongs_to :page_de_gauche

	validates_presence_of :register
	validates_presence_of :page_de_gauche
end
