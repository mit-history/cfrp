require 'spec_helper'

describe LhpCategoryAssignment do
	it "requires a register" do
		lhp_category_assignment = described_class.new

		lhp_category_assignment.valid?

		expect(lhp_category_assignment.errors.full_messages).to include("Register can't be blank")
	end

	it "requires a PageDeGauche" do
		lhp_category_assignment = described_class.new

		lhp_category_assignment.valid?

		expect(lhp_category_assignment.errors.full_messages).to include("Page de gauche can't be blank")
	end	
end
