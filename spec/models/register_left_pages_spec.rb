require 'spec_helper'

describe RegisterLeftPage do
	it "requires a register" do
		register_left_page = described_class.new

		register_left_page.valid?

		expect(register_left_page.errors.full_messages).to include("Register can't be blank")
	end

	it "requires a PageDeGauche" do
		register_left_page = described_class.new

		register_left_page.valid?

		expect(register_left_page.errors.full_messages).to include("Page de gauche can't be blank")
	end	
end