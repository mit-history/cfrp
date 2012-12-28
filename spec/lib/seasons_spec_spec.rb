require_relative '../spec_helper'

module CFRP
  describe SeasonSpec do
    let(:season) { '1780-1781' }
    let(:season_spec) { SeasonSpec.retrieve_for season }

    it 'returns numeric index key when sent names' do
      season_spec.date.should == 4
      season_spec.weekday.should == 104
    end
  end
end
