#!/Users/ddellacosta/.rvm/rubies/ruby-1.9.3-p327/bin/ruby

require 'csv'

counter = {}

CSV.open("R138-141-IDmatching.txt", "r") do |file|
  while line = file.gets
    fields = line[0].split("\t")
    unless fields[1] == 'post it note?'
      if counter[fields[1]].nil?
        puts "DELETE FROM register_images WHERE register_id = #{fields[1]};"
        counter[fields[1]] ||= 1
      end

      # Format:
      # images/jpeg-150-80/M119_02_R134/M119_02_R134_0000r.jpg

      filepath = 'images/jpeg-150-80/' << fields[0].gsub(/_\d*[rv]*\.jpg$/, '') << '/' << fields[0]

      puts "INSERT INTO register_images (register_id, filepath, created_at, updated_at) VALUES (#{fields[1]}, '#{filepath}', NOW(), NOW());"
    end
  end
end
