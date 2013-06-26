#!/usr/bin/ruby
#encoding: utf-8

# Quick and dirty script to change weekday endings from 'y' to 'i' (old French -> new French) 
# uncomment conn.exec() line below to turn it on.

require 'pg'

conn = PGconn.open(:user => 'cfrp', :password => 'cfrp$02139', :dbname => 'cfrp_development')

weekday_pairs = { 'Vendredy' => 'Vendredi', 'Samedy' => 'Samedi', 'Mardy' => 'Mardi', 'Lundy' => 'Lundi', 'Jeudy' => 'Jeudi', 'Mercredy' => 'Mercredi' }

weekday_pairs.each do |ywd|
  weekday_update = "UPDATE registers SET weekday = '#{ywd[1]}' WHERE weekday = '#{ywd[0]}'"
  puts weekday_update
#  conn.exec(weekday_update)
end
