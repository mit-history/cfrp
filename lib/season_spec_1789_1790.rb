# -*- coding: utf-8 -*-
require_relative 'season_spec_template'

module CFRP
  class SeasonSpec_1789_1790 < SeasonSpecTemplate
    def initialize

      # Stuff I'm not using at the moment.
      # (the following map to Filemaker field names)

      # 3 : By (recettes)
      # 4 : date created recettes
      # 5 : date last modified recettes
      # 11 : Image No.
      # 78 : Record ID
      # 81 : Representation Number
      # 82 : Reprise 1
      # 83 : Reprise 2
      # 84 : Reprise Number
      # 88 : Tally livres
      # 89 : Tally sous

      @weekday = 159
      @day = 6
      @month = 13
      @year = 160
      @season = 85
      @register_num = 79
      @payment_notes = 12               # Miscellaneous revenue category
      @page_text = 87                   # Not sure if it's right, but: status recettes
      @total_receipts_recorded_l = 157
      @total_receipts_recorded_s = 158
      @representation = 80              # représentation
      @for_editor_notes = 14            # notes recettes
      @misc_notes = 2                   # Attached text document
      @register_period_id = RegisterPeriod.find_by_period('1786 to 1792').id
      @signatory = 86
      @play1 = 111
      @play2 = 112
      @play1_firstrun = 7
      @play2_firstrun = 8
      @newactor = 0
      @actorrole = 1
      @image_front = 10
      @image_back = 9
      @irregular_receipts_l = 113        # Total miscellaneous revenue category livre
      @irregular_receipts_s = 114        # Total miscellaneous revenue category sous
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
       [15, 36, 37, 'Premieres Loges à 6 places, à 6 liv.', 115, 116],
       [26, 58, 59, 'Premieres Loges à 5 places, à 6 liv.', 137, 138],
       [29, 64, 65, 'Premieres Loges à places, à 6 liv.', 143, 144],
       [30, 66, 67, 'Loges au Rez-de-chaussée, à pl. à 6 l.', 145, 146],
       [31, 68, 69, 'Loges au Rez-de-chaussée, à pl. à 6 l.', 147, 148],
       [32, 70, 71, 'Loges au Rez-de-chaussée, à pl. à 6 l.', 149, 150],
       [33, 72, 73, 'Secondes Loges à 4 places, à 3 liv 15 sous', 151, 152],
       [34, 74, 75, 'Secondes Loges à 3 places, à 3 liv 15 sous', 153, 154],
       [35, 76, 77, 'Troisiemes Loges à 8 places, à 2 l. 10 s.', 155, 156],
       [16, 38, 39, 'Troisiemes Loges à 6 places, à 2 l. 10 s.', 117, 118],
       [17, 40, 41, 'Troisiemes Loges à 4 places, à 2 l. 10 s.', 119, 120],
       [18, 42, 43, 'Troisiemes Loges à 3 places, à 2 l. 10 s.', 121, 122],
       [19, 44, 45, 'Troisiemes Loges à places, à 2 l. 10 s.', 123, 124],
       [20, 46, 47, 'Quatriemes Loges à 4 places, à 3 l. 15 s.', 125, 126],
       [21, 48, 49, 'Quatriemes Loges à 3 places, à 3 l. 15 s.', 127, 128],
       [22, 50, 51, 'Places de Premieres à 6 liv.', 129, 130],
       [23, 52, 53, 'Places de Galerie à 4 liv.', 131, 132],
       [24, 54, 55, 'Places de Secondes à 3 liv.', 133, 134],
       [25, 56, 57, 'Places de Parquet à 2 liv. 8 sous.', 135, 136],
       [27, 60, 61, 'Places de Troisiemes à 2 liv.', 139, 140],
       [28, 62, 63, 'Places de Paradis à 1 liv 10 sous', 141, 142]
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
 28 : Number Tickets Sold 21
 29 : Number Tickets Sold 3
 30 : Number Tickets Sold 4
 31 : Number Tickets Sold 5
 32 : Number Tickets Sold 6
 33 : Number Tickets Sold 7
 34 : Number Tickets Sold 8
 35 : Number Tickets Sold 9
 36 : Price per Tickets Sold 1 livre
 37 : Price per Tickets Sold 1 sous
 38 : Price per Tickets Sold 10 livre
 39 : Price per Tickets Sold 10 sous
 40 : Price per Tickets Sold 11 livre
 41 : Price per Tickets Sold 11 sous
 42 : Price per Tickets Sold 12 livre
 43 : Price per Tickets Sold 12 sous
 44 : Price per Tickets Sold 13 livre
 45 : Price per Tickets Sold 13 sous
 46 : Price per tickets sold 14 livre
 47 : Price per tickets sold 14 sous
 48 : Price per tickets sold 15 livre
 49 : Price per tickets sold 15 sous
 50 : Price per tickets sold 16 livre
 51 : Price per tickets sold 16 sous
 52 : Price per tickets sold 17 livre
 53 : Price per tickets sold 17 sous
 54 : Price per tickets sold 18 livre
 55 : Price per tickets sold 18 sous
 56 : Price per tickets sold 19 livre
 57 : Price per tickets sold 19 sous
 58 : Price per Tickets Sold 2 livre
 59 : Price per Tickets Sold 2 sous
 60 : Price per tickets sold 20 livre
 61 : Price per tickets sold 20 sous
 62 : Price per tickets sold 21 livre
 63 : Price per tickets sold 21 sous
 64 : Price per Tickets Sold 3 livre
 65 : Price per Tickets Sold 3 sous
 66 : Price per Tickets Sold 4 livre
 67 : Price per Tickets Sold 4 sous
 68 : Price per Tickets Sold 5 livre
 69 : Price per Tickets Sold 5 sous
 70 : Price per Tickets Sold 6 livre
 71 : Price per Tickets Sold 6 sous
 72 : Price per Tickets Sold 7 livre
 73 : Price per Tickets Sold 7 sous
 74 : Price per Tickets Sold 8 livre
 75 : Price per Tickets Sold 8 sous
 76 : Price per Tickets Sold 9 livre
 77 : Price per Tickets Sold 9 sous
 78 : Record ID
 79 : register number
 80 : représentation
 81 : Representation Number
 82 : Reprise 1
 83 : Reprise 2
 84 : Reprise Number
 85 : season
 86 : Signatory
 87 : status recettes
 88 : Tally livres
 89 : Tally sous
 90 : Ticket category 1
 91 : Ticket category 10
 92 : Ticket category 11
 93 : Ticket category 12
 94 : Ticket category 13
 95 : Ticket category 14
 96 : Ticket category 15
 97 : Ticket Category 16
 98 : Ticket Category 17
 99 : Ticket Category 18
 100 : Ticket Category 19
 101 : Ticket category 2
 102 : Ticket Category 20
 103 : Ticket Category 21
 104 : Ticket category 3
 105 : Ticket category 4
 106 : Ticket category 5
 107 : Ticket category 6
 108 : Ticket category 7
 109 : Ticket category 8
 110 : Ticket category 9
 111 : Title|Genre|Author 1
 112 : Title|Genre|Author 2
 113 : Total miscellaneous revenue category livre
 114 : Total miscellaneous revenue category sous
 115 : Total of Tickets Sold 1 livre
 116 : Total of Tickets Sold 1 sous
 117 : Total of Tickets Sold 10 livre
 118 : Total of Tickets Sold 10 sous
 119 : Total of Tickets Sold 11 livre
 120 : Total of Tickets Sold 11 sous
 121 : Total of Tickets Sold 12 livre
 122 : Total of Tickets Sold 12 sous
 123 : Total of Tickets Sold 13 livre
 124 : Total of Tickets Sold 13 sous
 125 : Total of Tickets Sold 14 livre
 126 : Total of Tickets Sold 14 sous
 127 : Total of Tickets Sold 15 livre
 128 : Total of Tickets Sold 15 sous
 129 : Total of Tickets Sold 16 livre
 130 : Total of Tickets Sold 16 sous
 131 : Total of Tickets Sold 17 livre
 132 : Total of Tickets Sold 17 sous
 133 : Total of Tickets Sold 18 livre
 134 : Total of Tickets Sold 18 sous
 135 : Total of Tickets Sold 19 livre
 136 : Total of Tickets Sold 19 sous
 137 : Total of Tickets Sold 2 livre
 138 : Total of Tickets Sold 2 sous
 139 : Total of Tickets Sold 20 livre
 140 : Total of Tickets Sold 20 sous
 141 : Total of Tickets Sold 21 livre
 142 : Total of Tickets Sold 21 sous
 143 : Total of Tickets Sold 3 livre
 144 : Total of Tickets Sold 3 sous
 145 : Total of Tickets Sold 4 livre
 146 : Total of Tickets Sold 4 sous
 147 : Total of Tickets Sold 5 livre
 148 : Total of Tickets Sold 5 sous
 149 : Total of Tickets Sold 6 livre
 150 : Total of Tickets Sold 6 sous
 151 : Total of Tickets Sold 7 livre
 152 : Total of Tickets Sold 7 sous
 153 : Total of Tickets Sold 8 livre
 154 : Total of Tickets Sold 8 sous
 155 : Total of Tickets Sold 9 livre
 156 : Total of Tickets Sold 9 sous
 157 : Total Receipts livre
 158 : Total Receipts sous
 159 : Weekday
 160 : Year
