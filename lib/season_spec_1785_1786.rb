# -*- coding: utf-8 -*-
require_relative 'season_spec_template'

module CFRP
  class SeasonSpec_1785_1786 < SeasonSpecTemplate
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

      # 70 : Tally livres
      # 71 : Tally sous

      @weekday = 123
      @day = 6
      @month = 13
      @year = 124
      @season = 67
      @register_num = 61
      @payment_notes = 12               # Miscellaneous revenue category
      @page_text = 105
      @total_receipts_recorded_l = 121
      @total_receipts_recorded_s = 122
      @representation = 61              # Actually there is just one field used for Register Number and Representation!
      @for_editor_notes = 14            # notes recettes
      @misc_notes = 2                   # Attached text document
      @register_period_id = 6
      @play1 = 87
      @play2 = 88
      @play1_firstrun = 7
      @play2_firstrun = 8
      @newactor = 0
      @actorrole = 1
      @image_front = 10
      @image_back = 9
      @irregular_receipts_l = 89        # Total miscellaneous revenue category livre
      @irregular_receipts_s = 90        # Total miscellaneous revenue category sous
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
       [15, 30, 31, 'Premieres loges à 6 places', 91, 92],
       [22, 44, 45, 'Premieres loges à 5 places', 105, 106],
       [23, 46, 47, 'Secondes Loges à 4 places', 107, 108],
       [24, 48, 49, 'Secondes Loges à 3 places', 109, 110],
       [25, 50, 51, 'Troisièmes Loges à 6 places', 111, 112],
       [26, 52, 53, 'Troisièmes Loges à 4 places', 113, 114],
       [27, 54, 55, 'Troisièmes Loges à', 115, 116],
       [28, 56, 57, 'Petites Loges', 117, 118],
       [29, 58, 59, 'Petites loges à', 119, 120],
       [16, 32, 33, 'Galeries à 4 livres', 93, 94],
       [17, 34, 35, 'Premieres Places à 6 livres', 95, 96],
       [18, 36, 37, 'Secondes Places à 3 livres', 97, 98],
       [19, 38, 39, 'Troisièmes Places à 2 livres', 99, 100],
       [20, 40, 41, 'Parterre assis à 2 livres 8 s', 101, 102],
       [21, 42, 43, 'Paradis à 1 livre 10', 103, 104]
      ]
    end
  end
end
