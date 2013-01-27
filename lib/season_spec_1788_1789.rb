# -*- coding: utf-8 -*-
require_relative 'season_spec_template'

module CFRP
  class SeasonSpec_1788_1789 < SeasonSpecTemplate
    def initialize

      # Stuff I'm not using at the moment.
      # (the following map to Filemaker field names)

      # 3 : By (recettes)
      # 4 : Crédit de la comédie
      # 5 : credit livres
      # 6 : credit sous
      # 7 : date created recettes
      # 8 : date last modified recettes
      # 14 : Image No.
      # 81 : Record ID
      # 84 : Representation Number
      # 85 : Reprise 1
      # 86 : Reprise 2
      # 87 : Reprise Number
      # 91 : Tally livres
      # 92 : Tally sous

      @weekday = 162
      @day = 9
      @month = 16
      @year = 163
      @season = 88
      @register_num = 82
      @payment_notes = 15               # Miscellaneous revenue category
      @page_text = 90                   # Not sure if it's right, but: status recettes
      @total_receipts_recorded_l = 160
      @total_receipts_recorded_s = 161
      @representation = 83              # représentation
      @for_editor_notes = 17            # notes recettes
      @misc_notes = 2                   # Attached text document
      @register_period_id = RegisterPeriod.find_by_period('1786 to 1792').id
      @signatory = 89
      @play1 = 114
      @play2 = 115
      @play1_firstrun = 10
      @play2_firstrun = 11
      @newactor = 0
      @actorrole = 1
      @image_front = 13
      @image_back = 12
      @irregular_receipts_l = 116        # Total miscellaneous revenue category livre
      @irregular_receipts_s = 117        # Total miscellaneous revenue category sous
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
       [18, 39, 40, 'Premieres Loges à 6 places, à 6 liv.', 118, 119],
       [29, 61, 62, 'Premieres Loges à 5 places, à 6 liv.', 140, 141],
       [32, 67, 68, 'Premieres Loges à places, à 6 liv.', 146, 147],
       [33, 69, 70, 'Loges au Rez-de-chaussée, à pl. à 6 l.', 148, 149],
       [34, 71, 72, 'Loges au Rez-de-chaussée, à pl. à 6 l.', 150, 151],
       [35, 73, 74, 'Loges au Rez-de-chaussée, à pl. à 6 l.', 152, 153],
       [36, 75, 76, 'Secondes Loges à 4 places, à 3 liv 15 sous', 154, 155],
       [37, 77, 78, 'Secondes Loges à 3 places, à 3 liv 15 sous', 156, 157],
       [38, 79, 80, 'Troisiemes Loges à 8 places, à 2 l. 10 s.', 158, 159],
       [19, 41, 42, 'Troisiemes Loges à 6 places, à 2 l. 10 s.', 120, 121],
       [20, 43, 44, 'Troisiemes Loges à 4 places, à 2 l. 10 s.', 122, 123],
       [21, 45, 46, 'Troisiemes Loges à 3 places, à 2 l. 10 s.', 124, 125],
       [22, 47, 48, 'Troisiemes Loges à places, à 2 l. 10 s.', 126, 127],
       [23, 49, 50, 'Quatriemes Loges à 4 places, à 3 l. 15 s.', 128, 129],
       [24, 51, 52, 'Quatriemes Loges à 3 places, à 3 l. 15 s.', 130, 131],
       [25, 53, 54, 'Places de Premieres à 6 liv.', 132, 133],
       [26, 55, 56, 'Places de Galerie à 4 liv.', 134, 135],
       [27, 57, 58, 'Places de Secondes à 3 liv.', 136, 137],
       [28, 59, 60, 'Places de Parquet à 2 liv. 8 sous.', 138, 139],
       [30, 63, 64, 'Places de Troisiemes à 2 liv.', 142, 143],
       [31, 65, 66, 'Places de Paradis à 1 liv 10 sous', 144, 145] 
      ]
    end
  end
end

__END__

 0 : Additional Actor Name
 1 : Additional Actor Name Text
 2 : Attached text document
 3 : By (recettes)
 4 : Crédit de la comédie
 5 : credit livres
 6 : credit sous
 7 : date created recettes
 8 : date last modified recettes
 9 : Day
 10 : First Run 1
 11 : First Run 2
 12 : Image File Name BACK
 13 : Image File Name FRONT
 14 : Image No.
 15 : Miscellaneous revenue category
 16 : Month
 17 : notes recettes
 18 : Number Tickets Sold 1
 19 : Number Tickets Sold 10
 20 : Number Tickets Sold 11
 21 : Number Tickets Sold 12
 22 : Number Tickets Sold 13
 23 : Number Tickets Sold 14
 24 : Number Tickets Sold 15
 25 : Number Tickets Sold 16
 26 : Number Tickets Sold 17
 27 : Number Tickets Sold 18
 28 : Number Tickets Sold 19
 29 : Number Tickets Sold 2
 30 : Number Tickets Sold 20
 31 : Number Tickets Sold 21
 32 : Number Tickets Sold 3
 33 : Number Tickets Sold 4
 34 : Number Tickets Sold 5
 35 : Number Tickets Sold 6
 36 : Number Tickets Sold 7
 37 : Number Tickets Sold 8
 38 : Number Tickets Sold 9
 39 : Price per Tickets Sold 1 livre
 40 : Price per Tickets Sold 1 sous
 41 : Price per Tickets Sold 10 livre
 42 : Price per Tickets Sold 10 sous
 43 : Price per Tickets Sold 11 livre
 44 : Price per Tickets Sold 11 sous
 45 : Price per Tickets Sold 12 livre
 46 : Price per Tickets Sold 12 sous
 47 : Price per Tickets Sold 13 livre
 48 : Price per Tickets Sold 13 sous
 49 : Price per tickets sold 14 livre
 50 : Price per tickets sold 14 sous
 51 : Price per tickets sold 15 livre
 52 : Price per tickets sold 15 sous
 53 : Price per tickets sold 16 livre
 54 : Price per tickets sold 16 sous
 55 : Price per tickets sold 17 livre
 56 : Price per tickets sold 17 sous
 57 : Price per tickets sold 18 livre
 58 : Price per tickets sold 18 sous
 59 : Price per tickets sold 19 livre
 60 : Price per tickets sold 19 sous
 61 : Price per Tickets Sold 2 livre
 62 : Price per Tickets Sold 2 sous
 63 : Price per tickets sold 20 livre
 64 : Price per tickets sold 20 sous
 65 : Price per tickets sold 21 livre
 66 : Price per tickets sold 21 sous
 67 : Price per Tickets Sold 3 livre
 68 : Price per Tickets Sold 3 sous
 69 : Price per Tickets Sold 4 livre
 70 : Price per Tickets Sold 4 sous
 71 : Price per Tickets Sold 5 livre
 72 : Price per Tickets Sold 5 sous
 73 : Price per Tickets Sold 6 livre
 74 : Price per Tickets Sold 6 sous
 75 : Price per Tickets Sold 7 livre
 76 : Price per Tickets Sold 7 sous
 77 : Price per Tickets Sold 8 livre
 78 : Price per Tickets Sold 8 sous
 79 : Price per Tickets Sold 9 livre
 80 : Price per Tickets Sold 9 sous
 81 : Record ID
 82 : register number
 83 : représentation
 84 : Representation Number
 85 : Reprise 1
 86 : Reprise 2
 87 : Reprise Number
 88 : season
 89 : Signatory
 90 : status recettes
 91 : Tally livres
 92 : Tally sous
 93 : Ticket category 1
 94 : Ticket category 10
 95 : Ticket category 11
 96 : Ticket category 12
 97 : Ticket category 13
 98 : Ticket category 14
 99 : Ticket category 15
 100 : Ticket Category 16
 101 : Ticket Category 17
 102 : Ticket Category 18
 103 : Ticket Category 19
 104 : Ticket category 2
 105 : Ticket Category 20
 106 : Ticket Category 21
 107 : Ticket category 3
 108 : Ticket category 4
 109 : Ticket category 5
 110 : Ticket category 6
 111 : Ticket category 7
 112 : Ticket category 8
 113 : Ticket category 9
 114 : Title|Genre|Author 1
 115 : Title|Genre|Author 2
 116 : Total miscellaneous revenue category livre
 117 : Total miscellaneous revenue category sous
 118 : Total of Tickets Sold 1 livre
 119 : Total of Tickets Sold 1 sous
 120 : Total of Tickets Sold 10 livre
 121 : Total of Tickets Sold 10 sous
 122 : Total of Tickets Sold 11 livre
 123 : Total of Tickets Sold 11 sous
 124 : Total of Tickets Sold 12 livre
 125 : Total of Tickets Sold 12 sous
 126 : Total of Tickets Sold 13 livre
 127 : Total of Tickets Sold 13 sous
 128 : Total of Tickets Sold 14 livre
 129 : Total of Tickets Sold 14 sous
 130 : Total of Tickets Sold 15 livre
 131 : Total of Tickets Sold 15 sous
 132 : Total of Tickets Sold 16 livre
 133 : Total of Tickets Sold 16 sous
 134 : Total of Tickets Sold 17 livre
 135 : Total of Tickets Sold 17 sous
 136 : Total of Tickets Sold 18 livre
 137 : Total of Tickets Sold 18 sous
 138 : Total of Tickets Sold 19 livre
 139 : Total of Tickets Sold 19 sous
 140 : Total of Tickets Sold 2 livre
 141 : Total of Tickets Sold 2 sous
 142 : Total of Tickets Sold 20 livre
 143 : Total of Tickets Sold 20 sous
 144 : Total of Tickets Sold 21 livre
 145 : Total of Tickets Sold 21 sous
 146 : Total of Tickets Sold 3 livre
 147 : Total of Tickets Sold 3 sous
 148 : Total of Tickets Sold 4 livre
 149 : Total of Tickets Sold 4 sous
 150 : Total of Tickets Sold 5 livre
 151 : Total of Tickets Sold 5 sous
 152 : Total of Tickets Sold 6 livre
 153 : Total of Tickets Sold 6 sous
 154 : Total of Tickets Sold 7 livre
 155 : Total of Tickets Sold 7 sous
 156 : Total of Tickets Sold 8 livre
 157 : Total of Tickets Sold 8 sous
 158 : Total of Tickets Sold 9 livre
 159 : Total of Tickets Sold 9 sous
 160 : Total Receipts livre
 161 : Total Receipts sous
 162 : Weekday
 163 : Year
