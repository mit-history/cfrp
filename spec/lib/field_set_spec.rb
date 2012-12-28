require_relative '../spec_helper'

module CFRP
  describe FieldSet do
    let(:fm_xml) { open('fm-xml/1780-1781.xml') }
    let(:doc) { Nokogiri::XML.parse(fm_xml) }
    let(:first) { doc.css("FMPXMLRESULT RESULTSET ROW")[0].css("COL") }

    let(:season) { '1780-1781' }
    let(:season_spec) { SeasonSpec.retrieve_for season }

    it 'converts a set of XML nodes to attributes' do
      fs = FieldSet.new(first, season_spec)
      fs.weekday.should == 'Mardy'
    end

    it 'converts date fields to Dates' do
      fs = FieldSet.new(first, season_spec)
      fs.date.should == Date.new(1780, 4, 4)
    end
  end
end

