require 'date'

namespace :img do
  desc "Imports Puce & Plume Images for seasons from 1680 to 1744"
  task :import => :environment do |t, args|

    seasons = {
      # '12' => { season: "1680-1681", period: '1680-81 to 1685-86' },
      # '76' => { season: "1718-1719", period: '1686-87 to 1754-55' },
      # '77' => { season: "1718-1719", period: '1686-87 to 1754-55' },
      '120' => { season: "1758-1759", period: '1758-59' },
      # '78' => { season: "1719-1720", period: '1686-87 to 1754-55' },
      # '80' => { season: "1719-1720", period: '1686-87 to 1754-55' },
      # '81' => { season: "1720-1721", period: '1686-87 to 1754-55' },
      # '82' => { season: "1720-1721", period: '1686-87 to 1754-55' },
      # '84' => { season: "1722-1723", period: '1686-87 to 1754-55' },
      # '85' => { season: "1722-1723", period: '1686-87 to 1754-55' },
      # 1739-1740: The season for which the register has been lost for over a century.
    }

    def season_images(dirnum, season, period)
      bucket_url = "https://s3.amazonaws.com/last-six-seasons"
      season_dir = "M119_02_R#{dirnum}"
      year = season.split("-")[0].to_i
      period = RegisterPeriod.find_by_period(period)
      date = DateTime.parse("#{year}-05-01")
      s3 = AWS::S3.new
      bucket_name = 'last-six-seasons'
      bucket = s3.buckets[bucket_name] # no request made

      # Go through every image in the directory, creating a register and two ri's for each.
      bucket.objects.with_prefix(season_dir).collect(&:key).sort.each do |recto_file|
        # skip ones that have already been done
        recto_file =~ /(M119_02_R\d{3}(_II_1)?_\d{3}r\.jpg)/
        puts $1
        next if RegisterImage.find_by_image_file_name($1)
        puts "...not found, processing..."

        if recto_file =~ /M119_02_R(\d{3})(_II_1)?_(\d{3})r\.jpg/
          register = Register.new(
            {
              date:                  date,
              season:                season,
              register_period_id:    period.id,
              verification_state_id: 5
            }
          )
          register.save

          imgnum = $2
          recto_url = bucket_url + '/' + recto_file
          verso_file = season_dir + '/' + "M119_02_R#{dirnum}(_II_1)?_#{"%03d" % (imgnum.to_i + 1)}v.jpg"
          verso_url = bucket_url + '/' + verso_file

          puts "\n Register:"
          puts register.inspect
          puts "\n Image 1 URL: " + recto_url
          puts "\n Image 1 Object Key: " + recto_file

          if bucket.objects[recto_file].exists?
            ri_r = RegisterImage.new(
            	orientation: 'recto',
            	register_id: register.id,
            	image: recto_url
           	)
            ri_r.save
            puts ri_r.inspect
          end

          puts "\n Image 2 URL: " + verso_url
          puts "\n Image 2 Object Key: " + verso_file

          if bucket.objects[verso_file].exists?
            ri_v = RegisterImage.new(
            	orientation: 'verso',
            	register_id: register.id,
            	image: verso_url
           	)
            ri_v.save
            puts ri_v.inspect
          end

          if (!register.previous.nil? and !register.previous.verso_image.nil?)
            ri_l = RegisterImage.new(
              orientation: 'left',
              register_id: register.id,
              image: register.previous.verso_image.image.url
            )
            ri_r.save
            puts ri_r.inspect
          end

          puts "\n"
          puts "\n\n"
        end
      end
    end

    seasons.keys.each do |volume|
      season_images(volume, seasons[volume][:season], seasons[volume][:period])
    end
  end
end
