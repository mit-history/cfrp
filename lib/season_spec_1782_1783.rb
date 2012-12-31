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
      # 86 : Total miscellaneous revenue category livre
      # 87 : Total miscellaneous revenue category sous

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
       [25, 50, 51, 'Troisième Loges à 6 places', 108, 109],
       [26, 52, 53, 'Troisième Loges à 4 places', 110, 111],
       [27, 54, 55, 'Troisièmes Loges à', 112, 113],
       [28, 56, 57, 'Petites Loges', 114, 115],
       [29, 58, 59, 'Petites loges à', 116, 117],
       [16, 32, 33, 'Galeries à 4 livres', 90, 91],
       [17, 34, 35, 'Premiers Places à 6 livres', 92, 93],
       [18, 36, 37, 'Secondes Places à 3 livres', 94, 95],
       [19, 38, 39, 'Parterre assis à 2 livres 8 s', 96, 97],
       [20, 40, 41, 'Troisième Places à 2 livres', 98, 99],
       [21, 42, 43, 'Paradis à 1 livre 10', 100, 101]
      ]
    end
  end
end

 # 0 : Additional Actor Name
 # 1 : Additional Actor Name Text
 # 2 : Attached text document
 # 3 : By (recettes)
 # 4 : date created recettes
 # 5 : date last modified recettes
 # 6 : Day
 # 7 : First Run 1
 # 8 : First Run 2
 # 9 : Image File Name BACK
 # 10 : Image File Name FRONT
 # 11 : Image No.
 # 12 : Miscellaneous revenue category
 # 13 : Month
 # 14 : notes recettes
 # 15 : Number Tickets Sold 1
 # 16 : Number Tickets Sold 10
 # 17 : Number Tickets Sold 11
 # 18 : Number Tickets Sold 12
 # 19 : Number Tickets Sold 13
 # 20 : Number Tickets Sold 14
 # 21 : Number Tickets Sold 15
 # 22 : Number Tickets Sold 2
 # 23 : Number Tickets Sold 3
 # 24 : Number Tickets Sold 4
 # 25 : Number Tickets Sold 5
 # 26 : Number Tickets Sold 6
 # 27 : Number Tickets Sold 7
 # 28 : Number Tickets Sold 8
 # 29 : Number Tickets Sold 9
 # 30 : Price per Tickets Sold 1 livre
 # 31 : Price per Tickets Sold 1 sous
 # 32 : Price per Tickets Sold 10 livre
 # 33 : Price per Tickets Sold 10 sous
 # 34 : Price per Tickets Sold 11 livre
 # 35 : Price per Tickets Sold 11 sous
 # 36 : Price per Tickets Sold 12 livre
 # 37 : Price per Tickets Sold 12 sous
 # 38 : Price per Tickets Sold 13 livre
 # 39 : Price per Tickets Sold 13 sous
 # 40 : Price per tickets sold 14 livre
 # 41 : Price per tickets sold 14 sous
 # 42 : Price per tickets sold 15 livre
 # 43 : Price per tickets sold 15 sous
 # 44 : Price per Tickets Sold 2 livre
 # 45 : Price per Tickets Sold 2 sous
 # 46 : Price per Tickets Sold 3 livre
 # 47 : Price per Tickets Sold 3 sous
 # 48 : Price per Tickets Sold 4 livre
 # 49 : Price per Tickets Sold 4 sous
 # 50 : Price per Tickets Sold 5 livre
 # 51 : Price per Tickets Sold 5 sous
 # 52 : Price per Tickets Sold 6 livre
 # 53 : Price per Tickets Sold 6 sous
 # 54 : Price per Tickets Sold 7 livre
 # 55 : Price per Tickets Sold 7 sous
 # 56 : Price per Tickets Sold 8 livre
 # 57 : Price per Tickets Sold 8 sous
 # 58 : Price per Tickets Sold 9 livre
 # 59 : Price per Tickets Sold 9 sous
 # 60 : Record ID
 # 61 : register number
 # 62 : Representation Number
 # 63 : Reprise 1
 # 64 : Reprise 2
 # 65 : Reprise Number
 # 66 : season
 # 67 : Signatory
 # 68 : status recettes
 # 69 : Ticket category 1
 # 70 : Ticket category 10
 # 71 : Ticket category 11
 # 72 : Ticket category 12
 # 73 : Ticket category 13
 # 74 : Ticket category 14
 # 75 : Ticket category 15
 # 76 : Ticket category 2
 # 77 : Ticket category 3
 # 78 : Ticket category 4
 # 79 : Ticket category 5
 # 80 : Ticket category 6
 # 81 : Ticket category 7
 # 82 : Ticket category 8
 # 83 : Ticket category 9
 # 84 : Title|Genre|Author 1
 # 85 : Title|Genre|Author 2
 # 86 : Total miscellaneous revenue category livre
 # 87 : Total miscellaneous revenue category sous
 # 88 : Total of Tickets Sold 1 livre
 # 89 : Total of Tickets Sold 1 sous
 # 90 : Total of Tickets Sold 10 livre
 # 91 : Total of Tickets Sold 10 sous
 # 92 : Total of Tickets Sold 11 livre
 # 93 : Total of Tickets Sold 11 sous
 # 94 : Total of Tickets Sold 12 livre
 # 95 : Total of Tickets Sold 12 sous
 # 96 : Total of Tickets Sold 13 livre
 # 97 : Total of Tickets Sold 13 sous
 # 98 : Total of Tickets Sold 14 livre
 # 99 : Total of Tickets Sold 14 sous
 # 100 : Total of Tickets Sold 15 livre
 # 101 : Total of Tickets Sold 15 sous
 # 102 : Total of Tickets Sold 2 livre
 # 103 : Total of Tickets Sold 2 sous
 # 104 : Total of Tickets Sold 3 livre
 # 105 : Total of Tickets Sold 3 sous
 # 106 : Total of Tickets Sold 4 livre
 # 107 : Total of Tickets Sold 4 sous
 # 108 : Total of Tickets Sold 5 livre
 # 109 : Total of Tickets Sold 5 sous
 # 110 : Total of Tickets Sold 6 livre
 # 111 : Total of Tickets Sold 6 sous
 # 112 : Total of Tickets Sold 7 livre
 # 113 : Total of Tickets Sold 7 sous
 # 114 : Total of Tickets Sold 8 livre
 # 115 : Total of Tickets Sold 8 sous
 # 116 : Total of Tickets Sold 9 livre
 # 117 : Total of Tickets Sold 9 sous
 # 118 : Total Receipts livre
 # 119 : Total Receipts sous
 # 120 : Weekday
 # 121 : Year

# Premieres loges à 6 places : 69, Ticket category 1
# Premieres loges à 5 places : 76, Ticket category 2
# Secondes Loges à 4 places : 77, Ticket category 3
# Secondes Loges à 3 places : 78, Ticket category 4
# Troisième Loges à 6 places : 79, Ticket category 5
# Troisième Loges à 4 places : 80, Ticket category 6
# Troisièmes Loges à  : 81, Ticket category 7
# Petites Loges : 82, Ticket category 8
# Petites loges à : 83, Ticket category 9
# Galeries à 4 livres : 70, Ticket category 10
# Premiers Places à 6 livres : 71, Ticket category 11
# Secondes Places à 3 livres : 72, Ticket category 12
# Parterre assis à 2 livres 8 s : 73, Ticket category 13
# Troisième Places à 2 livres : 74, Ticket category 14
# Paradis à 1 livre 10 : 75, Ticket category 15
