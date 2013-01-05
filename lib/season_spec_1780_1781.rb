# -*- coding: utf-8 -*-
require_relative 'season_spec_template'

module CFRP
  class SeasonSpec_1780_1781 < SeasonSpecTemplate
    def initialize

      # Stuff I'm not using at the moment.
      # (the following map to Filemaker field names)
      # 3 : By (recettes)
      # 5 : date created recettes
      # 6 : date last modified recettes
      # 9 : Image No.
      # 57 : status recettes
      # 53 : Record ID
      # 73 : Total miscellaneous revenue category livre
      # 74 : Total miscellaneous revenue category sous

      @weekday = 104
      @date = 4
      @season = 56
      @register_num = 54
      @payment_notes = 10                # Miscellaneous revenue category
      @page_text = 103                   # Total Receipts Text
      @total_receipts_recorded_l = 101
      @total_receipts_recorded_s = 102
      @representation = 55
      @for_editor_notes = 13             # notes recettes
      @misc_notes = 2                    # Attached text document
      @register_period_id = 2
      @play1 = 71
      @play2 = 72
      @play1_firstrun = 11
      @play2_firstrun = 12
      @newactor = 0
      @actorrole = 1
      @image_front = 8
      @image_back = 7
      @irregular_receipts_l = 73         # Total miscellaneous revenue category livre
      @irregular_receipts_s = 74         # Total miscellaneous revenue category sous
    end

    private

    # Order:
    # [ Number Tickets Sold 1,
    #   Price per Tickets Sold 1 livre,
    #   Price per Tickets Sold 1 sous,
    #   Ticket category 1,
    #   Total of Tickets Sold 1 livre,
    #   Total of Tickets Sold 1 sous ]

    def ticket_sales_keys
      [
       [14, 27, 28, 'Premières Loges 1', 75, 76],
       [19, 37, 38, 'Premières Loges 2', 85, 86],
       [20, 39, 40, 'Premières Loges 3', 87, 88],
       [21, 41, 42, 'Premières Loges 4', 89, 90],
       [22, 43, 44, 'Secondes Loges 1', 91, 92],
       [23, 45, 46, 'Secondes Loges 2', 93, 94],
       [24, 47, 48, 'Secondes Loges 3', 95, 96],
       [25, 49, 50, 'Troisièmes Loges', 97, 98],
       [26, 51, 52, 'Petites Loges', 99, 100],
       [15, 29, 30, 'Premières Places', 77, 78],
       [16, 31, 32, 'Secondes Places', 79, 80],
       [17, 33, 34, 'Troisièmes Places', 81, 82],
       [18, 35, 36, 'Places de Parterre', 83, 84]
      ]
    end
  end
end
