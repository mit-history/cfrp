require 'date'

namespace :img do
  desc "Imports Azentis Images for seasons from 1744 to 1769"
  task :import => :environment do |t, args|

    seasons = {
      '107-117' => '1744-45 to 1754-55',
      '118-120' => '1755-56 to 1757-58',
      '121' => '1758-59',
      '122-124' => '1759-60 to 1762-63',
      '126' => '1759-60 to 1762-63',
      '128-129' => '1763-64 to 1764-65',
      '130' => '1765-66',
      '131-133' => '1766-67 to 1768-69'
    }

    def year_from_dirnum(first_dirnum, dirnum, period)
      diff = dirnum.to_i - first_dirnum.to_i
      period.split("-")[0].to_i + diff
    end

    def season_images(season, first_dirnum, dirnum)
      image_dir = "public/images/azentis-2013/"
      season_dir = "#{image_dir}M119_02_R#{dirnum}"

      year = year_from_dirnum(first_dirnum, dirnum, season)
      period = RegisterPeriod.find_by_period(season)
      date = DateTime.parse("#{year}-05-01")
      season_string = "#{year}-#{year+1}"

      Dir.new(season_dir).select {|f| f =~ /\.jpg$/}.each do |file|
        register = Register.new({ date:               date,
                                  season:             season_string,
                                  register_period_id: period.id})
        #puts register.inspect
        if file =~ /M119_02_R(\d{3})_(\d{3})r\.jpg/
          #puts "dirnum #{$1}, imgnum #{$2}"
          imgnum = $2
          versa_file = "M119_02_R#{dirnum}_#{imgnum.to_i - 1}v.jpg"
          #puts "File: #{file}, Versa File #{versa_file}"

          ri_r = RegisterImage.new({ register_id: register.id,
                                     filepath:    "#{image_dir}#{season_dir}/#{file}" })
          ri_v = RegisterImage.new({ register_id: register.id,
                                     filepath:    "#{image_dir}#{season_dir}/#{versa_file}" })

          puts season
          puts season_string
          puts date.to_s
          puts dirnum
          puts ri_r.filepath
          puts ri_v.filepath
        end
        #puts "#{period.period} : #{file}"
      end
    end

    seasons.keys.each do |season|
      range = season.split("-")
      if range.length > 1
        Range.new(range[0], range[1]).to_a.each do |s_range|
          season_images(seasons[season], range[0], s_range)
        end
      else
        season_images(seasons[season], range[0], range[0])
      end
    end
  end
end

