# -*- coding: utf-8 -*-
require_relative 'season_spec_template'

module CFRP
  class SeasonSpec_1782_1783 < SeasonSpecTemplate
    def initialize

      # Stuff I'm not using at the moment.
      # (the following map to Filemaker field names)
      # 3 : By (recettes)
      # 4 : date created recettes
      # 5 : date last modified recettes
      # 11 : Image No.
      # 60 : Record ID
      # 62 : Representation Number  <-- Misleadingly named!
      # 63 : Reprise 1
      # 64 : Reprise 2
      # 65 : Reprise Number
      # 67 : Signatory
      # 68 : status recettes

      @weekday = 120
      @day = 6
      @month = 13
      @year = 121
      @season = 66
      @register_num = 61
      @payment_notes = 12               # Miscellaneous revenue category
      @page_text = 105
      @total_receipts_recorded_l = 118
      @total_receipts_recorded_s = 119
      @representation = 61              # Actually there is just one field used for Register Number and Representation!
      @for_editor_notes = 14            # notes recettes
      @misc_notes = 2                   # Attached text document
      @register_period_id = 6
      @play1 = 84
      @play2 = 85
      @play1_firstrun = 7
      @play2_firstrun = 8
      @newactor = 0
      @actorrole = 1
      @image_front = 10
      @image_back = 9
      @irregular_receipts_l = 86
      @irregular_receipts_s = 87
    end

    private

    # Order:
    # 15 : Number Tickets Sold 1
    # 30 : Price per Tickets Sold 1 livre
    # 31 : Price per Tickets Sold 1 sous
    # 69 : Ticket category 1
    # 88 : Total of Tickets Sold 1 livre
    # 89 : Total of Tickets Sold 1 sous

    def ticket_sales_keys
      [
       [15, 30, 31, 'Premieres loges à 6 places', 88, 89],
       [22, 44, 45, 'Premieres loges à 5 places', 102, 103],
       [23, 46, 47, 'Secondes Loges à 4 places', 104, 105],
       [24, 48, 49, 'Secondes Loges à 3 places', 106, 107],
       [25, 50, 51, 'Troisièmes Loges à 6 places', 108, 109],
       [26, 52, 53, 'Troisièmes Loges à 4 places', 110, 111],
       [27, 54, 55, 'Troisièmes Loges à', 112, 113],
       [28, 56, 57, 'Petites Loges', 114, 115],
       [29, 58, 59, 'Petites loges à', 116, 117],
       [16, 32, 33, 'Galeries à 4 livres', 90, 91],
       [17, 34, 35, 'Premieres Places à 6 livres', 92, 93],
       [18, 36, 37, 'Secondes Places à 3 livres', 94, 95],
       [19, 38, 39, 'Troisièmes Places à 2 livres', 96, 97],
       [20, 40, 41, 'Parterre assis à 2 livres 8 s', 98, 99],
       [21, 42, 43, 'Paradis à 1 livre 10', 100, 101]
      ]
    end
  end
end
