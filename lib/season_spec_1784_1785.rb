# -*- coding: utf-8 -*-
require_relative 'season_spec_template'

module CFRP
  class SeasonSpec_1784_1785 < SeasonSpecTemplate
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

      @weekday = 122
      @day = 6
      @month = 13
      @year = 123
      @season = 66
      @register_num = 61
      @payment_notes = 12               # Miscellaneous revenue category
      @page_text = 105
      @total_receipts_recorded_l = 120
      @total_receipts_recorded_s = 121
      @representation = 61              # Actually there is just one field used for Register Number and Representation!
      @for_editor_notes = 14            # notes recettes
      @misc_notes = 2                   # Attached text document
      @register_period_id = 6
      @play1 = 86
      @play2 = 87
      @play1_firstrun = 7
      @play2_firstrun = 8
      @newactor = 0
      @actorrole = 1
      @image_front = 10
      @image_back = 9
      @irregular_receipts_l = 88        # Total miscellaneous revenue category livre
      @irregular_receipts_s = 89        # Total miscellaneous revenue category sous
    end

    private

    # Order:
    # 15 : Number Tickets Sold 1
    # 30 : Price per Tickets Sold 1 livre
    # 31 : Price per Tickets Sold 1 sous
    # .. : Ticket category 1
    # 90 : Total of Tickets Sold 1 livre
    # 91 : Total of Tickets Sold 1 sous

    def ticket_sales_keys
      [
       [15, 30, 31, 'Premieres loges à 6 places', 90, 91],
       [22, 44, 45, 'Premieres loges à 5 places', 104, 105],
       [23, 46, 47, 'Secondes Loges à 4 places', 106, 107],
       [24, 48, 49, 'Secondes Loges à 3 places', 108, 109],
       [25, 50, 51, 'Troisièmes Loges à 6 places', 110, 111],
       [26, 52, 53, 'Troisièmes Loges à 4 places', 112, 113],
       [27, 54, 55, 'Troisièmes Loges à', 114, 115],
       [28, 56, 57, 'Petites Loges', 116, 117],
       [29, 58, 59, 'Petites loges à', 118, 119],
       [16, 32, 33, 'Galeries à 4 livres', 92, 93],
       [17, 34, 35, 'Premieres Places à 6 livres', 94, 95],
       [18, 36, 37, 'Secondes Places à 3 livres', 96, 97],
       [19, 38, 39, 'Troisièmes Places à 2 livres', 98, 99],
       [20, 40, 41, 'Parterre assis à 2 livres 8 s', 100, 101],
       [21, 42, 43, 'Paradis à 1 livre 10', 102, 103]
      ]
    end
  end
end
