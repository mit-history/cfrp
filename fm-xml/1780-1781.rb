#!/Users/ddellacosta/.rvm/rubies/ruby-1.9.3-p327/bin/ruby
# -*- coding: utf-8 -*-

require 'nokogiri'

doc = Nokogiri::XML(open('1780-1781-bk.xml'))

#puts (doc.methods - 1.methods).sort
#puts (doc.css("FMPXMLRESULT METADATA FIELD")[0].methods - 1.methods).sort
#puts doc.css("FMPXMLRESULT METADATA FIELD")[0].attr('NAME')

key = {}

doc.css("FMPXMLRESULT METADATA FIELD").each_with_index do |f, i|
  key[i] = f.attr('NAME')
end

#puts key.keys.reduce("") { |s, k| s = "#{s} #{k} : #{key[k]}\n" }

doc.css("FMPXMLRESULT RESULTSET ROW").each do |r|
  cols = r.css("COL")

  # REGISTER DATA:
  puts "2 : Attached text document: #{cols[2].content}\n"
  puts "3 : By (recettes): #{cols[3].content}\n"
  puts "4 : Date : #{cols[4].content}\n"
  puts "5 : date created recettes : #{cols[5].content}\n"
  puts "6 : date last modified recettes : #{cols[6].content}\n"
  puts "10 : Miscellaneous revenue category : #{cols[10].content}\n"
  puts "13 : notes recettes : #{cols[13].content}\n"
  puts "53 : Record ID : #{cols[53].content}\n"
  puts "54 : register number : #{cols[54].content}\n"
  puts "55 : représentation : #{cols[55].content}\n"
  puts "56 : season : #{cols[56].content}\n"
  puts "57 : status recettes : #{cols[57].content}\n"

  puts "101 : Total Receipts livre: #{cols[101].content}\n"
  puts "102 : Total Receipts sous : #{cols[102].content}\n"
  puts "103 : Total Receipts Text : #{cols[103].content}\n"
  puts "104 : Weekday : #{cols[104].content}\n"

  puts "73 : Total miscellaneous revenue category livre : #{cols[73].content}\n"
  puts "74 : Total miscellaneous revenue category sous : #{cols[74].content}\n"

#  puts "#{cols[55].content} #{cols[4].content} #{cols[104].content} #{cols[56].content} #{cols[54].content} #{cols[10].content} #{cols[3].content}"

  puts "PLAY DATA"

  # PLAY DATA:
  puts "ADDITIONAL: #{cols[0].content} | #{cols[1].content}\n"
  puts "PLAY 1: (NEW? #{cols[11].content}) #{cols[71].content.split(' | ')}\n"
  puts "PLAY 2: (NEW? #{cols[12].content}) #{cols[72].content.split(' | ')}\n"
  puts "\n"
end
  
__END__

PLAY DATA
 0 : Additional Actor Name
 1 : Additional Actor Name Text

 11 : New play 1
 12 : New play 2

 71 : Title|Genre|Author 1
 72 : Title|Genre|Author 2

IMAGE DATA

 7 : Image File Name BACK
 8 : Image File Name FRONT
 9 : Image No.

REGISTER DATA
 2 : Attached text document
 3 : By (recettes)
 4 : Date
 5 : date created recettes
 6 : date last modified recettes

 10 : Miscellaneous revenue category

 13 : notes recettes

 53 : Record ID
 54 : register number
 55 : représentation
 56 : season
 57 : status recettes

 101 : Total Receipts livre
 102 : Total Receipts sous
 103 : Total Receipts Text
 104 : Weekday

 73 : Total miscellaneous revenue category livre
 74 : Total miscellaneous revenue category sous


TICKET DATA
 14 : Number Tickets Sold 1
 15 : Number Tickets Sold 10
 16 : Number Tickets Sold 11
 17 : Number Tickets Sold 12
 18 : Number Tickets Sold 13
 19 : Number Tickets Sold 2
 20 : Number Tickets Sold 3
 21 : Number Tickets Sold 4
 22 : Number Tickets Sold 5
 23 : Number Tickets Sold 6
 24 : Number Tickets Sold 7
 25 : Number Tickets Sold 8
 26 : Number Tickets Sold 9

 27 : Price per Tickets Sold 1 livre
 28 : Price per Tickets Sold 1 sous
 29 : Price per Tickets Sold 10 livre
 30 : Price per Tickets Sold 10 sous
 31 : Price per Tickets Sold 11 livre
 32 : Price per Tickets Sold 11 sous
 33 : Price per Tickets Sold 12 livre
 34 : Price per Tickets Sold 12 sous
 35 : Price per Tickets Sold 13 livre
 36 : Price per Tickets Sold 13 sous
 37 : Price per Tickets Sold 2 livre
 38 : Price per Tickets Sold 2 sous
 39 : Price per Tickets Sold 3 livre
 40 : Price per Tickets Sold 3 sous
 41 : Price per Tickets Sold 4 livre
 42 : Price per Tickets Sold 4 sous
 43 : Price per Tickets Sold 5 livre
 44 : Price per Tickets Sold 5 sous
 45 : Price per Tickets Sold 6 livre
 46 : Price per Tickets Sold 6 sous
 47 : Price per Tickets Sold 7 livre
 48 : Price per Tickets Sold 7 sous
 49 : Price per Tickets Sold 8 livre
 50 : Price per Tickets Sold 8 sous
 51 : Price per Tickets Sold 9 livre
 52 : Price per Tickets Sold 9 sous

 58 : Ticket category 1
 59 : Ticket category 10
 60 : Ticket category 11
 61 : Ticket category 12
 62 : Ticket category 13
 63 : Ticket category 2
 64 : Ticket category 3
 65 : Ticket category 4
 66 : Ticket category 5
 67 : Ticket category 6
 68 : Ticket category 7
 69 : Ticket category 8
 70 : Ticket category 9

 75 : Total of Tickets Sold 1 livre
 76 : Total of Tickets Sold 1 sous
 77 : Total of Tickets Sold 10 livre
 78 : Total of Tickets Sold 10 sous
 79 : Total of Tickets Sold 11 livre
 80 : Total of Tickets Sold 11 sous
 81 : Total of Tickets Sold 12 livre
 82 : Total of Tickets Sold 12 sous
 83 : Total of Tickets Sold 13 livre
 84 : Total of Tickets Sold 13 sous
 85 : Total of Tickets Sold 2 livre
 86 : Total of Tickets Sold 2 sous
 87 : Total of Tickets Sold 3 livre
 88 : Total of Tickets Sold 3 sous
 89 : Total of Tickets Sold 4 livre
 90 : Total of Tickets Sold 4 sous
 91 : Total of Tickets Sold 5 livre
 92 : Total of Tickets Sold 5 sous
 93 : Total of Tickets Sold 6 livre
 94 : Total of Tickets Sold 6 sous
 95 : Total of Tickets Sold 7 livre
 96 : Total of Tickets Sold 7 sous
 97 : Total of Tickets Sold 8 livre
 98 : Total of Tickets Sold 8 sous
 99 : Total of Tickets Sold 9 livre
 100 : Total of Tickets Sold 9 sous

### DATABASE DATA

# 4 date                      | date                        | 
# 104 weekday                   | character varying(255)      | 
# 56 season                    | character varying(255)      | 
# 54 register_num
#  payment_notes             | text                        | 
#  page_text                 | text                        | 
#  total_receipts_recorded_l | integer                     | 
#  total_receipts_recorded_s | integer                     | 
# 55 representation            | integer                     | 
#  signatory                 | character varying(255)      | 
#  misc_notes                | text                        | 
#  for_editor_notes          | text                        | 
#  ouverture                 | boolean                     | 
#  cloture                   | boolean                     | 
#  created_at                | timestamp without time zone | 
#  updated_at                | timestamp without time zone | 
#  register_image_id         | integer                     | 
#  register_period_id        | integer                     | 
#  verification_state_id     | integer                     | 
# 10 irregular_receipts_name   | character varying(255)      | 
