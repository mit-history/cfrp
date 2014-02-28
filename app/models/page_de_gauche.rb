class PageDeGauche < ActiveRecord::Base
	validates :category, presence: true
	has_many :lhp_category_assignments
	has_many :registers, through: :lhp_category_assignments
end
