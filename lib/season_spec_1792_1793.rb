# -*- coding: utf-8 -*-
require_relative 'season_spec_template'

module CFRP
  class SeasonSpec_1792_1793 < SeasonSpecTemplate
    def initialize

      # Stuff I'm not using at the moment.
      # (the following map to Filemaker field names)

      # 3 : By (recettes)
      # 4 : date created recettes
      # 5 : date last modified recettes
      # 11 : Image No.
      # 75 : Record ID
      # 78 : Representation Number
      # 79 : Reprise 1
      # 80 : Reprise 2
      # 81 : Reprise Number
      # 85 : Tally livres
      # 86 : Tally sous

      @weekday = 153
      @day = 6
      @month = 13
      @year = 154
      @season = 82
      @register_num = 76
      @payment_notes = 12               # Miscellaneous revenue category
      @page_text = 84                   # Not sure if it's right, but: status recettes
      @total_receipts_recorded_l = 151
      @total_receipts_recorded_s = 152
      @representation = 77              # représentation
      @for_editor_notes = 14            # notes recettes
      @misc_notes = 2                   # Attached text document
      @register_period_id = RegisterPeriod.find_by_period('1792-1793').id
      @signatory = 83
      @play1 = 107
      @play2 = 108
      @play1_firstrun = 7
      @play2_firstrun = 8
      @newactor = 0
      @actorrole = 1
      @image_front = 10
      @image_back = 9
      @irregular_receipts_l = 109        # Total miscellaneous revenue category livre
      @irregular_receipts_s = 110        # Total miscellaneous revenue category sous
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
       [15, 35, 36, 'Premieres Loges à 6 places, à 6 liv.', 111, 112],
       [26, 57, 58, 'Premieres Loges à 5 places, à 6 liv.', 133, 134],
       [28, 61, 62, 'Premieres Loges à places, à 6 liv.', 137, 138],
       [29, 63, 64, 'Loges au Rez-de-chaussée, à pl. à 6 l.', 139, 140],
       [30, 65, 66, 'Loges au Rez-de-chaussée, à pl. à 6 l.', 141, 142],
       [31, 67, 68, 'Loges au Rez-de-chaussée, à pl. à 6 l.', 143, 144],
       [32, 69, 70, 'Secondes Loges à 4 places, à 3 liv 15 sous', 145, 146],
       [33, 71, 72, 'Secondes Loges à 3 places, à 3 liv 15 sous', 147, 148],
       [34, 73, 74, 'Troisiemes Loges à 8 places, à 2 l. 10 s.', 149, 150],
       [16, 37, 38, 'Troisiemes Loges à 6 places, à 2 l. 10 s.', 113, 114],
       [17, 39, 40, 'Troisiemes Loges à 4 places, à 2 l. 10 s.', 115, 116],
       [18, 41, 42, 'Troisiemes Loges à 3 places, à 2 l. 10 s.', 117, 118],
       [19, 43, 44, 'Troisiemes Loges à places, à 2 l. 10 s.', 119, 120],
       [20, 45, 46, 'Quatriemes Loges à 4 places, à 2 l. 10 s.', 121, 122],
       [21, 47, 48, 'Quatriemes Loges à 3 places, à 2 l. 10 s.', 123, 124],
       [22, 49, 50, 'Places de Premieres à 6 liv.', 125, 126],
       [23, 51, 52, 'Places de Galerie & Secondes à 3 liv.', 127, 128],
       [24, 53, 54, 'Places de Parquet à 1 liv. 16 sous.', 129, 130],
       [25, 55, 56, 'Places de Troisiemes à 2 liv.', 131, 132],
       [27, 59, 60, 'Places de Paradis à 1 liv 10 sous', 135, 136]
      ]
    end
  end
end

__END__

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
 22 : Number Tickets Sold 16
 23 : Number Tickets Sold 17
 24 : Number Tickets Sold 18
 25 : Number Tickets Sold 19
 26 : Number Tickets Sold 2
 27 : Number Tickets Sold 20
 28 : Number Tickets Sold 3
 29 : Number Tickets Sold 4
 30 : Number Tickets Sold 5
 31 : Number Tickets Sold 6
 32 : Number Tickets Sold 7
 33 : Number Tickets Sold 8
 34 : Number Tickets Sold 9
 35 : Price per Tickets Sold 1 livre
 36 : Price per Tickets Sold 1 sous
 37 : Price per Tickets Sold 10 livre
 38 : Price per Tickets Sold 10 sous
 39 : Price per Tickets Sold 11 livre
 40 : Price per Tickets Sold 11 sous
 41 : Price per Tickets Sold 12 livre
 42 : Price per Tickets Sold 12 sous
 43 : Price per Tickets Sold 13 livre
 44 : Price per Tickets Sold 13 sous
 45 : Price per tickets sold 14 livre
 46 : Price per tickets sold 14 sous
 47 : Price per tickets sold 15 livre
 48 : Price per tickets sold 15 sous
 49 : Price per tickets sold 16 livre
 50 : Price per tickets sold 16 sous
 51 : Price per tickets sold 17 livre
 52 : Price per tickets sold 17 sous
 53 : Price per tickets sold 18 livre
 54 : Price per tickets sold 18 sous
 55 : Price per tickets sold 19 livre
 56 : Price per tickets sold 19 sous
 57 : Price per Tickets Sold 2 livre
 58 : Price per Tickets Sold 2 sous
 59 : Price per tickets sold 20 livre
 60 : Price per tickets sold 20 sous
 61 : Price per Tickets Sold 3 livre
 62 : Price per Tickets Sold 3 sous
 63 : Price per Tickets Sold 4 livre
 64 : Price per Tickets Sold 4 sous
 65 : Price per Tickets Sold 5 livre
 66 : Price per Tickets Sold 5 sous
 67 : Price per Tickets Sold 6 livre
 68 : Price per Tickets Sold 6 sous
 69 : Price per Tickets Sold 7 livre
 70 : Price per Tickets Sold 7 sous
 71 : Price per Tickets Sold 8 livre
 72 : Price per Tickets Sold 8 sous
 73 : Price per Tickets Sold 9 livre
 74 : Price per Tickets Sold 9 sous
 75 : Record ID
 76 : register number
 77 : représentation
 78 : Representation Number
 79 : Reprise 1
 80 : Reprise 2
 81 : Reprise Number
 82 : season
 83 : Signatory
 84 : status recettes
 85 : Tally livres
 86 : Tally sous
 87 : Ticket category 1
 88 : Ticket category 10
 89 : Ticket category 11
 90 : Ticket category 12
 91 : Ticket category 13
 92 : Ticket category 14
 93 : Ticket category 15
 94 : Ticket Category 16
 95 : Ticket Category 17
 96 : Ticket Category 18
 97 : Ticket Category 19
 98 : Ticket category 2
 99 : Ticket Category 20
 100 : Ticket category 3
 101 : Ticket category 4
 102 : Ticket category 5
 103 : Ticket category 6
 104 : Ticket category 7
 105 : Ticket category 8
 106 : Ticket category 9
 107 : Title|Genre|Author 1
 108 : Title|Genre|Author 2
 109 : Total miscellaneous revenue category livre
 110 : Total miscellaneous revenue category sous
 111 : Total of Tickets Sold 1 livre
 112 : Total of Tickets Sold 1 sous
 113 : Total of Tickets Sold 10 livre
 114 : Total of Tickets Sold 10 sous
 115 : Total of Tickets Sold 11 livre
 116 : Total of Tickets Sold 11 sous
 117 : Total of Tickets Sold 12 livre
 118 : Total of Tickets Sold 12 sous
 119 : Total of Tickets Sold 13 livre
 120 : Total of Tickets Sold 13 sous
 121 : Total of Tickets Sold 14 livre
 122 : Total of Tickets Sold 14 sous
 123 : Total of Tickets Sold 15 livre
 124 : Total of Tickets Sold 15 sous
 125 : Total of Tickets Sold 16 livre
 126 : Total of Tickets Sold 16 sous
 127 : Total of Tickets Sold 17 livre
 128 : Total of Tickets Sold 17 sous
 129 : Total of Tickets Sold 18 livre
 130 : Total of Tickets Sold 18 sous
 131 : Total of Tickets Sold 19 livre
 132 : Total of Tickets Sold 19 sous
 133 : Total of Tickets Sold 2 livre
 134 : Total of Tickets Sold 2 sous
 135 : Total of Tickets Sold 20 livre
 136 : Total of Tickets Sold 20 sous
 137 : Total of Tickets Sold 3 livre
 138 : Total of Tickets Sold 3 sous
 139 : Total of Tickets Sold 4 livre
 140 : Total of Tickets Sold 4 sous
 141 : Total of Tickets Sold 5 livre
 142 : Total of Tickets Sold 5 sous
 143 : Total of Tickets Sold 6 livre
 144 : Total of Tickets Sold 6 sous
 145 : Total of Tickets Sold 7 livre
 146 : Total of Tickets Sold 7 sous
 147 : Total of Tickets Sold 8 livre
 148 : Total of Tickets Sold 8 sous
 149 : Total of Tickets Sold 9 livre
 150 : Total of Tickets Sold 9 sous
 151 : Total Receipts livre
 152 : Total Receipts sous
 153 : Weekday
 154 : Year
