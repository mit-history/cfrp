# -*- coding: utf-8 -*-
require_relative 'season_spec_template'

module CFRP
  class SeasonSpec_1781_1782 < SeasonSpecTemplate

    # Stuff I've not accounted for yet?
    # 58 : Tally Livres
    # 59 : Tally Sous

    def initialize
      @weekday = 106
      @date = 4
      @season = 56
      @register_num = 54
      @payment_notes = 10
      @page_text = 105
      @total_receipts_recorded_l = 103
      @total_receipts_recorded_s = 104
      @representation = 55
      @for_editor_notes = 13
      @misc_notes = 2
      @register_period_id = 2
      @play1 = 73
      @play2 = 74
      @play1_firstrun = 11
      @play2_firstrun = 12
      @newactor = 0
      @actorrole = 1
      @image_front = 8
      @image_back = 7
      @irregular_receipts_l = 75
      @irregular_receipts_s = 76
    end

    private

    def ticket_sales_keys
      [
       [14, 27, 28, 'Premières Loges 1', 77, 78],
       [19, 37, 38, 'Premières Loges 2', 87, 88],
       [20, 39, 40, 'Premières Loges 3', 89, 90],
       [21, 41, 42, 'Premières Loges 4', 91, 92],
       [22, 43, 44, 'Secondes Loges 1', 93, 94],
       [23, 45, 46, 'Secondes Loges 2', 95, 96],
       [24, 47, 48, 'Secondes Loges 3', 97, 98],
       [25, 49, 50, 'Troisièmes Loges', 99, 100],
       [26, 51, 52, 'Petites Loges', 101, 102],
       [15, 29, 30, 'Premières Places', 79, 80],
       [16, 31, 32, 'Secondes Places', 81, 82],
       [17, 33, 34, 'Troisièmes Places', 83, 84],
       [18, 35, 36, 'Places de Parterre', 85, 86]
      ]
    end
  end
end
