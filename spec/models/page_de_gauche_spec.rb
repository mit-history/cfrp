require 'spec_helper'

describe PageDeGauche do
	it "requires a category" do
		page_de_gauche = described_class.new
		
		expect(page_de_gauche).not_to be_valid
	end
end