#!/usr/bin/ruby
#encoding: utf-8

# Quick and dirty cleanup script for weekday dupes
# (some appear to have line feed endings which screw up faceting results).

require 'pg'

conn = PGconn.open(:user => 'cfrp', :password => 'cfrp$02139', :dbname => 'cfrp_development')

weekday_select = 'SELECT DISTINCT(weekday) FROM registers'

res = conn.exec(weekday_select)

if res.count > 0
  res.each do |wd|
    if wd['weekday'] =~ /\r$/
      clean_weekday = "UPDATE registers SET weekday = '#{wd['weekday'].gsub(/\r$/, '')}' WHERE weekday = '#{wd['weekday']}'"
      puts clean_weekday
      # UNCOMMENT THIS LINE TO CLEAN UPA
      # conn.exec(clean_weekday)
    end
  end
else
  print "FAILURE\n"
end
