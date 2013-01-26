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

__END__

Premieres loges à 6 places : 72, Ticket category 1
Premieres loges à 5 places : 79, Ticket category 2
Secondes Loges à 4 places : 80, Ticket category 3
Secondes Loges à 3 places : 81, Ticket category 4
Troisième Loges à 6 places : 82, Ticket category 5
Troisième Loges à 4 places : 83, Ticket category 6
Troisièmes Loges à  : 84, Ticket category 7
Petites Loges : 85, Ticket category 8
Petites loges à : 86, Ticket category 9
Galeries à 4 livres : 73, Ticket category 10
Premiers Places à 6 livres : 74, Ticket category 11
Secondes Places à 3 livres : 75, Ticket category 12
Parterre assis à 2 livres 8 s : 76, Ticket category 13
Troisième Places à 2 livres : 77, Ticket category 14
Paradis à 1 livre 10 : 78, Ticket category 15


 0 : Additional Actor Name
 1 : Additional Actor Name Text
 2 : Attached text document
 3 : By (recettes)
 4 : date created recettes
 5 : date last modified recettes
 6 : Day
 7 : First Run 1
 8 : First Run 2
 9 : Image File Name BACK
 10 : Image File Name FRONT
 11 : Image No.
 12 : Miscellaneous revenue category
 13 : Month
 14 : notes recettes
 15 : Number Tickets Sold 1
 16 : Number Tickets Sold 10
 17 : Number Tickets Sold 11
 18 : Number Tickets Sold 12
 19 : Number Tickets Sold 13
 20 : Number Tickets Sold 14
 21 : Number Tickets Sold 15
 22 : Number Tickets Sold 2
 23 : Number Tickets Sold 3
 24 : Number Tickets Sold 4
 25 : Number Tickets Sold 5
 26 : Number Tickets Sold 6
 27 : Number Tickets Sold 7
 28 : Number Tickets Sold 8
 29 : Number Tickets Sold 9
 30 : Price per Tickets Sold 1 livre
 31 : Price per Tickets Sold 1 sous
 32 : Price per Tickets Sold 10 livre
 33 : Price per Tickets Sold 10 sous
 34 : Price per Tickets Sold 11 livre
 35 : Price per Tickets Sold 11 sous
 36 : Price per Tickets Sold 12 livre
 37 : Price per Tickets Sold 12 sous
 38 : Price per Tickets Sold 13 livre
 39 : Price per Tickets Sold 13 sous
 40 : Price per tickets sold 14 livre
 41 : Price per tickets sold 14 sous
 42 : Price per tickets sold 15 livre
 43 : Price per tickets sold 15 sous
 44 : Price per Tickets Sold 2 livre
 45 : Price per Tickets Sold 2 sous
 46 : Price per Tickets Sold 3 livre
 47 : Price per Tickets Sold 3 sous
 48 : Price per Tickets Sold 4 livre
 49 : Price per Tickets Sold 4 sous
 50 : Price per Tickets Sold 5 livre
 51 : Price per Tickets Sold 5 sous
 52 : Price per Tickets Sold 6 livre
 53 : Price per Tickets Sold 6 sous
 54 : Price per Tickets Sold 7 livre
 55 : Price per Tickets Sold 7 sous
 56 : Price per Tickets Sold 8 livre
 57 : Price per Tickets Sold 8 sous
 58 : Price per Tickets Sold 9 livre
 59 : Price per Tickets Sold 9 sous
 60 : Record ID
 61 : register number
 62 : représentation
 63 : Representation Number
 64 : Reprise 1
 65 : Reprise 2
 66 : Reprise Number
 67 : season
 68 : Signatory
 69 : status recettes
 70 : Tally livres
 71 : Tally sous
 72 : Ticket category 1
 73 : Ticket category 10
 74 : Ticket category 11
 75 : Ticket category 12
 76 : Ticket category 13
 77 : Ticket category 14
 78 : Ticket category 15
 79 : Ticket category 2
 80 : Ticket category 3
 81 : Ticket category 4
 82 : Ticket category 5
 83 : Ticket category 6
 84 : Ticket category 7
 85 : Ticket category 8
 86 : Ticket category 9
 87 : Title|Genre|Author 1
 88 : Title|Genre|Author 2
 89 : Total miscellaneous revenue category livre
 90 : Total miscellaneous revenue category sous
 91 : Total of Tickets Sold 1 livre
 92 : Total of Tickets Sold 1 sous
 93 : Total of Tickets Sold 10 livre
 94 : Total of Tickets Sold 10 sous
 95 : Total of Tickets Sold 11 livre
 96 : Total of Tickets Sold 11 sous
 97 : Total of Tickets Sold 12 livre
 98 : Total of Tickets Sold 12 sous
 99 : Total of Tickets Sold 13 livre
 100 : Total of Tickets Sold 13 sous
 101 : Total of Tickets Sold 14 livre
 102 : Total of Tickets Sold 14 sous
 103 : Total of Tickets Sold 15 livre
 104 : Total of Tickets Sold 15 sous
 105 : Total of Tickets Sold 2 livre
 106 : Total of Tickets Sold 2 sous
 107 : Total of Tickets Sold 3 livre
 108 : Total of Tickets Sold 3 sous
 109 : Total of Tickets Sold 4 livre
 110 : Total of Tickets Sold 4 sous
 111 : Total of Tickets Sold 5 livre
 112 : Total of Tickets Sold 5 sous
 113 : Total of Tickets Sold 6 livre
 114 : Total of Tickets Sold 6 sous
 115 : Total of Tickets Sold 7 livre
 116 : Total of Tickets Sold 7 sous
 117 : Total of Tickets Sold 8 livre
 118 : Total of Tickets Sold 8 sous
 119 : Total of Tickets Sold 9 livre
 120 : Total of Tickets Sold 9 sous
 121 : Total Receipts livre
 122 : Total Receipts sous
 123 : Weekday
 124 : Year
