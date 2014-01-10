require 'open-uri'
require 'nokogiri'

namespace :people do
  desc "Imports people from the cesar2 website"
  task :import => :environment do
    doc = Nokogiri::HTML(
      open('http://cesar.org.uk/cesar2/troupes/troupes.php?fct=edit&company_UOID=311629')
    )

    doc.css('a[href*="javascript:editMember("]').each do |person_node|
      next if person_node.text =~ /\[edit\]/

      person_id = person_node['href'].match(/(\d+)/)[0]

      honorific = find_honorific(person_node.text)
      name = person_node.css('b:first').map{|n| n.text}.join(' ')
      url = "http://cesar.org.uk/cesar2/people/people.php?fct=edit&person_UOID=#{person_id}"

      Person.where(
        honorific: honorific,
        full_name: name.strip,
        url: url
      ).first_or_create!
    end

    puts "#{Person.count} total people"
  end

  def find_honorific(name)
    valid_honorifics = {
      'mlle' => 'Mlle',
      'm.' => 'M.'
    }
    first_segment = name.split(' ')[0]
    valid_honorifics[first_segment.downcase] || ''
  end
end
