require 'date'

namespace :img do
  desc "Imports Azentis Images for seasons from 1744 to 1769"
  task :import_old => :environment do |t, args|

    seasons = {
      # '107-117' => '1744-45 to 1754-55'
      '107' => { season: "1744-1745", period: '1744-45 to 1754-55' },
      '108' => { season: "1745-1746", period: '1744-45 to 1754-55' },
      '109' => { season: "1746-1747", period: '1744-45 to 1754-55' },
      '110' => { season: "1747-1748", period: '1744-45 to 1754-55' },
      '111' => { season: "1748-1749", period: '1744-45 to 1754-55' },
      '112' => { season: "1749-1750", period: '1744-45 to 1754-55' },
      '113' => { season: "1750-1751", period: '1744-45 to 1754-55' },
      '114' => { season: "1751-1752", period: '1744-45 to 1754-55' },
      '115' => { season: "1752-1753", period: '1744-45 to 1754-55' },
      '116' => { season: "1753-1754", period: '1744-45 to 1754-55' },
      '117' => { season: "1754-1755", period: '1744-45 to 1754-55' },

      # '118-120' => '1755-56 to 1757-58',
      '118' => { season: "1755-1756", period: '1755-56 to 1757-58' },
      '119' => { season: "1756-1757", period: '1755-56 to 1757-58' },
      '120' => { season: "1757-1758", period: '1755-56 to 1757-58' },

      # '121' => '1758-59',
      '121' => { season: "1758-1759", period: '1758-59' },

      # '122-124' => '1759-60 to 1762-63',
      '122' => { season: "1759-1760", period: '1759-60 to 1762-63' },
      '123' => { season: "1760-1761", period: '1759-60 to 1762-63' },
      '124' => { season: "1761-1762", period: '1759-60 to 1762-63' },
      '126' => { season: "1762-1763", period: '1759-60 to 1762-63' },

      # '128-129' => '1763-64 to 1764-65',
      '128' => { season: "1763-1764", period: '1763-64 to 1764-65' },
      '129' => { season: "1764-1765", period: '1763-64 to 1764-65' },

      # '130' => '1765-66',
      '130' => { season: "1765-1766", period: '1765-66' },

      # '131-133' => '1766-67 to 1768-69'
      '131' => { season: "1766-1767", period: '1766-67 to 1768-69' },
      '132' => { season: "1767-1768", period: '1766-67 to 1768-69' },
      '133' => { season: "1768-1769", period: '1766-67 to 1768-69' }
    }

    def season_images(dirnum, season, period)
      image_dir = "images/azentis-2013"
      season_dir = "#{image_dir}/M119_02_R#{dirnum}"

      year = season.split("-")[0].to_i
      period = RegisterPeriod.find_by_period(period)
      date = DateTime.parse("#{year}-05-01")

      Dir.new("public/#{season_dir}").select {|f| f =~ /\.jpg$/}.each do |file|
        if file =~ /M119_02_R(\d{3})_(\d{3})r\.jpg/
          register = Register.new({ date:                  date,
                                    season:                season,
                                    register_period_id:    period.id,
                                    verification_state_id: 5 })
          register.save
          puts register.inspect

          imgnum = $2
          versa_file = "M119_02_R#{dirnum}_#{"%03d" % (imgnum.to_i + 1)}v.jpg"

          ri_r = RegisterImage.new({ register_id: register.id,
                                     filepath:    "#{season_dir}/#{file}" })
          ri_v = RegisterImage.new({ register_id: register.id,
                                     filepath:    "#{season_dir}/#{versa_file}" })

          ri_r.save
          puts ri_r.inspect
          ri_v.save
          puts ri_v.inspect
        end
      end
    end

    seasons.keys.each do |season|
      season_images(season, seasons[season][:season], seasons[season][:period])
    end
  end
end
