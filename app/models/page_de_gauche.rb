class PageDeGauche < ActiveRecord::Base
	validates :category, presence: true
	has_many :register_left_pages
	has_many :registers, through: :register_left_pages
end