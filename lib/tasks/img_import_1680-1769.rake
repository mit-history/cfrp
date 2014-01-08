require 'date'

namespace :img do
  desc "Imports Puce & Plume Images for seasons from 1680 to 1744"
  task :import => :environment do |t, args|
  seasons = {
	# '12' => { season: "1680-1681", period: 'none' },
	# '13' => { season: "1681-1682", period: '1680-81 to 1685-86' },
	# '14' => { season: "1682-1683", period: '1680-81 to 1685-86' },
	# '15' => { season: "1683-1684", period: '1680-81 to 1685-86' },
	# '16' => { season: "1684-1685", period: '1680-81 to 1685-86' },
	# '17' => { season: "1685-1686", period: '1680-81 to 1685-86' },
	# '18' => { season: "1686-1687", period: '1686-87 to 1754-55' },
	# '19' => { season: "1687-1688", period: 'none' },
	'20' => { season: "1687-1688", period: '1686-87 to 1754-55' },
	# '21' => { season: "1688-1689", period: '1686-87 to 1754-55' },
	'22' => { season: "1688-1689", period: '1686-87 to 1754-55' },
	'23' => { season: "1689-1690", period: '1686-87 to 1754-55' },
	# '24' => { season: "1689-1690", period: '1686-87 to 1754-55' },
	'25' => { season: "1690-1691", period: '1686-87 to 1754-55' },
	# '26' => { season: "1690-1691", period: '1686-87 to 1754-55' },
	'27' => { season: "1691-1692", period: '1686-87 to 1754-55' },
	# '28' => { season: "1691-1692", period: '1686-87 to 1754-55' },
	'29' => { season: "1692-1693", period: '1686-87 to 1754-55' },
	# '30' => { season: "1692-1693", period: '1686-87 to 1754-55' },
	'31' => { season: "1693-1694", period: '1686-87 to 1754-55' },
	# '32' => { season: "1693-1694", period: '1686-87 to 1754-55' },
	# '33' => { season: "1694-1695", period: '1686-87 to 1754-55' },
	'34' => { season: "1694-1695", period: '1686-87 to 1754-55' },
	# '35' => { season: "1695-1696", period: '1686-87 to 1754-55' },
	'36' => { season: "1695-1696", period: '1686-87 to 1754-55' },
	# '37' => { season: "1696-1697", period: '1686-87 to 1754-55' },
	'38' => { season: "1696-1697", period: '1686-87 to 1754-55' },
	# '39' => { season: "1697-1698", period: '1686-87 to 1754-55' },
	'40' => { season: "1697-1698", period: '1686-87 to 1754-55' },
	# '41' => { season: "1698-1699", period: '1686-87 to 1754-55' },
	'42' => { season: "1698-1699", period: '1686-87 to 1754-55' },
	# '43' => { season: "1699-1700", period: '1686-87 to 1754-55' },
	'44' => { season: "1700-1701", period: '1686-87 to 1754-55' },
	# '45' => { season: "1700-1701", period: '1686-87 to 1754-55' },
	'46' => { season: "1701-1702", period: '1686-87 to 1754-55' },
	# '47' => { season: "1701-1702", period: '1686-87 to 1754-55' },
	# '48' => { season: "1702-1703", period: '1686-87 to 1754-55' },
	# '49' => { season: "1703-1704", period: '1686-87 to 1754-55' },
	# '50' => { season: "1704-1705", period: '1686-87 to 1754-55' },
	# '51' => { season: "1705-1706", period: '1686-87 to 1754-55' },
	# '52' => { season: "1706-1707", period: '1686-87 to 1754-55' },
	'53' => { season: "1707-1708", period: '1686-87 to 1754-55' },
	# '54' => { season: "1707-1708", period: '1686-87 to 1754-55' },
	'55' => { season: "1708-1709", period: '1686-87 to 1754-55' },
	# '56' => { season: "1708-1709", period: '1686-87 to 1754-55' },
	'57' => { season: "1709-1710", period: '1686-87 to 1754-55' },
	# '58' => { season: "1709-1710", period: '1686-87 to 1754-55' },
	'59' => { season: "1710-1711", period: '1686-87 to 1754-55' },
	# '60' => { season: "1710-1711", period: '1686-87 to 1754-55' },
	'61' => { season: "1711-1712", period: '1686-87 to 1754-55' },
	# '62' => { season: "1711-1712", period: '1686-87 to 1754-55' },
	# '63' => { season: "1712-1713", period: '1686-87 to 1754-55' },
	'64' => { season: "1712-1713", period: '1686-87 to 1754-55' },
	'65' => { season: "1713-1714", period: '1686-87 to 1754-55' },
	# '66' => { season: "1713-1714", period: '1686-87 to 1754-55' },
	'67' => { season: "1714-1715", period: '1686-87 to 1754-55' },
	# '68' => { season: "1714-1715", period: '1686-87 to 1754-55' },
	'69' => { season: "1715-1716", period: '1686-87 to 1754-55' },
	# '70' => { season: "1715-1716", period: '1686-87 to 1754-55' },
	'71' => { season: "1716-1717", period: '1686-87 to 1754-55' },
	# '72' => { season: "1716-1717", period: '1686-87 to 1754-55' },
	'73' => { season: "1717-1718", period: '1686-87 to 1754-55' },
	# '74' => { season: "1717-1718", period: 'none' },
	# '75' => { season: "1718", period: 'none' },
	# '751' => { season: "octobre 1718", period: 'none' },
	# '76' => { season: "1718-1719*", period: 'none' },
	# '77' => { season: "1718-1719*", period: 'none' },
	# '78	'Registre 1719*", period: 'none' },
	# '79	'Registre 1719*", period: 'none' },
	# '80' => { season: "1719-1720", period: 'none' },
	# '81	'Registre 1720", period: 'none' },
	# '82' => { season: "1720-1721", period: 'none' },
	# '83' => { season: "1721-1722", period: '1686-87 to 1754-55' },
	# '84	'Registre 1722", period: 'none' },
	# '85' => { season: "1722-1723", period: 'none' },
	# '86' => { season: "1723-1724", period: '1686-87 to 1754-55' },
	# '87' => { season: "1724-1725", period: '1686-87 to 1754-55' },
	# '88' => { season: "1725-1726", period: '1686-87 to 1754-55' },
	# '89' => { season: "1726-1727", period: '1686-87 to 1754-55' },
	# '90' => { season: "1727-1728", period: '1686-87 to 1754-55' },
	# '91' => { season: "1728-1729", period: '1686-87 to 1754-55' },
	# '92' => { season: "1729-1730", period: '1686-87 to 1754-55' },
	# '93' => { season: "1730-1731", period: '1686-87 to 1754-55' },
	# '94' => { season: "1731-1732", period: '1686-87 to 1754-55' },
	# '95' => { season: "1732-1733", period: '1686-87 to 1754-55' },
	# '96' => { season: "1733-1734", period: '1686-87 to 1754-55' },
	# '97' => { season: "1734-1735", period: '1686-87 to 1754-55' },
	# '98' => { season: "1735-1736", period: '1686-87 to 1754-55' },
	# '99' => { season: "1736-1737", period: '1686-87 to 1754-55' },
	# '100' => { season: "1737", period: 'none' },
	# '101' => { season: "1737-1738", period: '1686-87 to 1754-55' },
	# '102' => { season: "1738-1739", period: '1686-87 to 1754-55' },
	# '103' => { season: "1740-1741", period: '1686-87 to 1754-55' },
	# '104' => { season: "1741-1742", period: '1686-87 to 1754-55' },
	# '105' => { season: "1742-1743", period: '1686-87 to 1754-55' },
	# '106' => { season: "1743-1744", period: '1686-87 to 1754-55' },
  }
    def season_images(dirnum, season, period)
      image_dir = "images/puceplume"
      season_dir = "#{image_dir}/M119_02_R#{dirnum}"

      year = season.split("-")[0].to_i
      period = RegisterPeriod.find_by_period(period)
      date = DateTime.parse("#{year}-05-01")

      # binding.pry

      Dir.new("public/#{season_dir}").select {|f| f =~ /\.jpg$/}.each do |file|
	    # binding.pry
        if file =~ /M119_02_R(\d{2})_(\d{3})r\.jpg/
	      #binding.pry

          register = Register.new({ date:                  date,
                                    season:                season,
                                    register_period_id:    period.id,
                                    verification_state_id: 5 })
          register.save
          # puts "\n Register:"
          puts register.inspect
          # puts "\n Image 1:"

          imgnum = $2
          versa_file = "M119_02_R#{dirnum}_#{"%03d" % (imgnum.to_i + 1)}v.jpg"

          ri_r = RegisterImage.new({ register_id: register.id,
                                     filepath:    "#{season_dir}/#{file}" })
          ri_v = RegisterImage.new({ register_id: register.id,
                                     filepath:    "#{season_dir}/#{versa_file}" })

          ri_r.save
          puts ri_r.inspect
          # puts "\n Image 2:"
          ri_v.save
          puts ri_v.inspect
          puts "\n"
          # puts "\n\n"
        end
      end
    end

    seasons.keys.each do |season|

      season_images(season, seasons[season][:season], seasons[season][:period])
    end
  end
end


## Jeff Cell: 781-234-8777