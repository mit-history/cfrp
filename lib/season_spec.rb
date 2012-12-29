require_relative 'season_spec_1780_1781'
require_relative 'season_spec_1781_1782'

module CFRP
  class SeasonSpec
    SEASONS = {
      '1780-1781' => CFRP::SeasonSpec_1780_1781,
      '1781-1782' => CFRP::SeasonSpec_1781_1782
    }

    def self.retrieve_for season
      SEASONS[season].send(:new)
    end
  end
end
