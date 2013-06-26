#!/Library/WebServer/Deployment/.rvm/rubies/ruby-1.9.3-p194/bin/ruby

#ENV['RAILS_ENV'] = "production" # Set to your desired Rails environment name
#require '~/cfrp/config/environment.rb'
#require_relative '../app/models/register_image'

require 'pg'

db_fix = 'cfrp_production2'

load_sql = ''

conn = PG.connect( dbname: db_fix )

id_array = []

File.open('gabes_registers_to_restore.txt', 'r').each do |l|
  id, date = l.split('|').reduce([]) {|m, p| m << p.gsub(/\s*([^\s]*)\s*/, '\1')}
  id_array << id

  conn.exec( "SELECT id FROM registers WHERE date = '#{date}'") do |result|
    result.each do |row|
      conn.exec( "SELECT filepath from register_images where register_id = #{row['id']}" ) do |res2|
        res2.each do |row2|
          load_sql << "INSERT INTO register_images (register_id, filepath, created_at, updated_at) VALUES (#{id}, '#{row2['filepath']}', NOW(), NOW());\n"
        end
      end

      conn.exec( "SELECT * from register_plays where register_id = #{row['id']}" ) do |res3|
        res3.each do |row3|
          conn.exec( "SELECT * FROM plays WHERE id = #{row3['play_id']}" ) do |res4|
            res4.each do |row4|
              #load_sql << "INSERT INTO plays (author, title, genre) VALUES ('#{row4['author']}', '#{row4['title']}', '#{row4['genre']}');\n"
            end
            # "id"=>"45", "register_id"=>"3368", "play_id"=>"477", "firstrun"=>"t", "newactor"=>"", "actorrole"=>"", "firstrun_perfnum"=>"3", "created_at"=>"2013-01-06 11:30:55.671253", "updated_at"=>"2013-01-06 11:30:55.671253", "ordering"=>"1"

            firstrun_perfnum = row3['firstrun_perfnum'].nil? ? 0 : row3['firstrun_perfnum']

            load_sql << "INSERT INTO register_plays (register_id, play_id, firstrun, newactor, actorrole, firstrun_perfnum, ordering, updated_at, created_at) VALUES (#{id}, #{row3['play_id']}, '#{row3['firstrun']}', '#{row3['newactor']}', '#{row3['actorrole']}', #{firstrun_perfnum}, '#{row3['ordering']}', NOW(), NOW());\n"
          end
        end
      end

      conn.exec( "SELECT * from ticket_sales where register_id = #{row['id']}" ) do |res5|
        res5.each do |row5|
          # "id"=>"411", "total_sold"=>"42", "register_id"=>"4045", "seating_category_id"=>"17", "price_per_ticket_l"=>"2", "price_per_ticket_s"=>"0", "recorded_total_l"=>"84", "recorded_total_s"=>"0", "created_at"=>"2013-01-06 20:09:33.976695", "updated_at"=>"2013-01-06 20:09:33.976695"

          load_sql << "INSERT INTO ticket_sales (register_id, total_sold, seating_category_id, price_per_ticket_l, price_per_ticket_s, recorded_total_l, recorded_total_s, created_at, updated_at) VALUES (#{id}, '#{row5['total_sold']}', '#{row5['seating_category_id']}', '#{row5['price_per_ticket_l']}', '#{row5['price_per_ticket_s']}', '#{row5['recorded_total_l']}', '#{row5['recorded_total_s']}', NOW(), NOW());\n"
        end
      end

      load_sql << "\n\n"
    end
  end

  #conn.exec( "SELECT * FROM register_images WHERE register_id IN (?)",  ) 
end

puts load_sql
#puts id_array.join(', ')
