require 'CSV'

namespace :reg_images_sync do
  desc "Syncs up register images for last three seasons of un-synced entries"
  task :seasons_1777_1780 => :environment do |t, args|
    files = ["db/data/register-images-1777_1778.csv",
             "db/data/register-images-1778_1779.csv",
             "db/data/register-images-1779_1780.csv"]

    files.each do |csvfile|
      csv = CSV.open csvfile, { headers: true, header_converters: :symbol }

      csv.each do |line|
        if not line[:record_id].to_i.zero?
          #
          # M119_02_R142_677v.jpg ->
          #   images/jpeg-150-80/M119_02_R142/M119_02_R142_677v.jpg
          #
          matches = line[:file_name].match(/(M119_02_R\d*)_/)
          filepath = "images/jpeg-150-80/#{$1}/#{line[:file_name]}"

          ri = RegisterImage.new(register_id: line[:record_id],
                                 filepath:    filepath)

          puts "Saving new RegisterImage with register_id - filepath: #{ri.register_id} - #{ri.filepath}\n"
          # puts "Errors: #{ri.errors.full_messages}\n"
          output = ri.save
          # puts "Save output: #{output}\n"

          # This should happen the first time around only...
          ris_to_wipe = RegisterImage.find_all_by_register_id(line[:record_id])

          if not ris_to_wipe.empty?
            ris_to_wipe.each do |ri_to_wipe|
              if ri_to_wipe.filepath =~ /10\.09\.photos/
                puts "Deleting old RegisterImage record with register_id - filepath: #{ri_to_wipe.register_id} - #{ri_to_wipe.filepath}\n"
                ri_to_wipe.destroy
              end
            end
          end

          puts "-----------\n\n"
        end
      end
    end
  end
end
