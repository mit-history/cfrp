# -*- coding: utf-8 -*-
# require 'CSV'

namespace :register_play_newactor do
  desc "Creates a new participation from an existing newactor value on an existing register_play."
  task :convert_to_participation => :environment do |t, args|

    mapping_lines_read = 0
    participations_created = 0

    # open mapping file
    fix_up = CSV.open "db/data/people_id_to_rp_newactor_map.csv", { :headers => true, :header_converters => :symbol, :converters => :all }

    # :people_id
    # :rp_newactor_name

    # Walk through
    #   - opening each register play
    #   - creating a new participation with the person id from the mapping file
    #   - flag the rp as corrected.
    fix_up.each do |line|
      # if rp_newactor_name is nil, move to the next one.

      mapping_lines_read += 1
      puts line

      next if line[:rp_newactor_name].nil?

      # 1) find all register_plays with the id of the old play
      register_plays = RegisterPlay.find_all_by_newactor(line[:rp_newactor_name])
      person = Person.find(line[:people_id])

      # Do stuff
      register_plays.each do |rp|
        actorrole = rp.actorrole
        newactor = rp.newactor
        debut = rp.debut

        # :character, :debut, :person_id, :person, :register_play_id, :register_play, :role
        participation = Participation.new(:character => actorrole, :debut => debut, :person => person, :register_play => rp, :role => "Actor")

        participation.save
        participations_created += 1
        puts participation.inspect

      end
    end

    puts "================"
    puts "mapping_lines_read: " + mapping_lines_read.to_s
    puts "participations_created: " + participations_created.to_s

  end
end
