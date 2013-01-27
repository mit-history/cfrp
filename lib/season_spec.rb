require_relative 'season_spec_1780_1781'
require_relative 'season_spec_1781_1782'
require_relative 'season_spec_1782_1783'
require_relative 'season_spec_1783_1784'
require_relative 'season_spec_1784_1785'
require_relative 'season_spec_1785_1786'
require_relative 'season_spec_1786_1787'
require_relative 'season_spec_1787_1788'
require_relative 'season_spec_1788_1789'
require_relative 'season_spec_1789_1790'
require_relative 'season_spec_1790_1791'
require_relative 'season_spec_1791_1792'

module CFRP
  class SeasonSpec
    SEASONS = {
      '1780-1781' => CFRP::SeasonSpec_1780_1781,
      '1781-1782' => CFRP::SeasonSpec_1781_1782,
      '1782-1783' => CFRP::SeasonSpec_1782_1783,
      '1783-1784' => CFRP::SeasonSpec_1783_1784,
      '1784-1785' => CFRP::SeasonSpec_1784_1785,
      '1785-1786' => CFRP::SeasonSpec_1785_1786,
      '1786-1787' => CFRP::SeasonSpec_1786_1787,
      '1787-1788' => CFRP::SeasonSpec_1787_1788,
      '1788-1789' => CFRP::SeasonSpec_1788_1789,
      '1789-1790' => CFRP::SeasonSpec_1789_1790,
      '1790-1791' => CFRP::SeasonSpec_1790_1791,
      '1791-1792' => CFRP::SeasonSpec_1791_1792
    }

    def self.retrieve_for season
      SEASONS[season].send(:new)
    end
  end
end
