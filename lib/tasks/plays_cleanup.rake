# -*- coding: utf-8 -*-
# require 'CSV'

namespace :plays do
  desc "Adds cleaned-up plays to database while creating a new CSV file with DB ids"
  task :import_clean => :environment do |t, args|
    f = CSV.open "db/data/new-play-list-2013.05.02.csv", { headers: true, header_converters: :symbol }

    CSV.open("db/data/imported-id_map-of-clean-plays_1740-1793.csv", "wb") do |csv|

      csv << ['mapping_id','real_id']

      f.each do |line|
        p = Play.new( title:                 line[:title],
                      author:                line[:author],
                      genre:                 line[:genre],
                      acts:                  line[:nombre_dactes],
                      prose_vers:            line[:prosevers],
                      prologue:              !line[:prologue].nil?,
                      musique_danse_machine: !line[:musique_danse_machine].nil? )

        if not p.valid?
          puts "GOT AN INVALID ONE! #{p.inspect}"
        end

        p.save
        puts "saving: #{p.inspect}"
        csv << [line[:id], p.id]
        puts "----------------------------\n\n"
      end
    end
  end

  desc "Update plays with new info"
  task :update => :environment do |t, args|

    mapping_lines_read = 0
    participations_created = 0

    # open data file
    # fix_up = CSV.open "db/data/to_be_added_2014.04.20.csv", { headers: true, header_converters: :symbol }

    # Walk through the data file
    #   - opening each play
    #   - updating if the id in the data file exists
    #   - creating if it doesn't

    file = "db/data/to_be_added_2014.04.20.csv"
    CSV.foreach(file, headers: true) do |row|
      play = Play.find_by_id(row["id"])
      play.attributes = row.to_hash.slice(Play.accessible_attributes)
      play.save!
      puts play.inspect
    end
  end


  desc "Fixes current plays using updated cleaned-up plays"
  task :daves_fixes => :environment do |t, args|

    # 0) open id mapping of CSV file IDs to the IDs the professors created,
    #    and open up the "play fix-up" file
    mapping = CSV.read "db/data/imported-id_map-of-clean-plays_1740-1793.csv", { headers: true, header_converters: :symbol }

    # :mapping_id
    # :real_id

    # may need to make sure the header fields are entered correctly here,
    # or you'll get some sort of "can't encode" error
    fix_up = CSV.open "db/data/play-cleanup-list-2013.05.02.csv", { headers: true, header_converters: :symbol }

    CSV.open("missing-new-plays_1740-1793.csv", "wb") do |csv|
      fix_up.each do |line|

        # if new_id is nil, we have one that is not figured out yet.  Move to the next one.
        next if line[:new_id].nil?

        # 1) find all register_plays with the id of the old play
        register_plays = RegisterPlay.find_all_by_play_id(line[:id])

        # 2) Find the real_id of the play we have in our line value of new_id
        real_id = mapping.detect {|m| m[:mapping_id] == line[:new_id]}

        # 2a) If we don't have it for some reason, fail out.
        if real_id.nil?
          csv << [line[:id], line[:new_id], line[:title], line[:author], line[:genre], line[:g2], line[:g3]]
          puts "DON'T HAVE THIS ENTRY? #{line.inspect}"
        else

          # 3) Find the actual play which we already entered via this real_id
          play = Play.find(real_id[:real_id]) if not real_id.nil?

          # 4) Reset the RegisterPlays Play to match the corrected, new version.
          register_plays.each do |rp|
            old_play = rp.play
            rp.play = play
            rp.save

            # 5) Delete the old, crust play!
            #puts "#{old_play.inspect}\n"
            unless old_play.nil?
              old_play.delete
            end
          end
        end
      end
    end
  end
end

# Current_Schema
# t.string   "author"
# t.string   "title"
# t.string   "genre"
# t.datetime "created_at"
# t.datetime "updated_at"
# t.integer  "acts"
# t.string   "prose_vers"
# t.boolean  "prologue"
# t.boolean  "musique_danse_machine"
# t.string   "alternative_title"
# t.string   "url"
# t.date     "date_de_creation"
