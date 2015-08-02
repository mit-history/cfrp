namespace :seating_categories do
  desc "Flips the seating_categories for Parterre assis a 2 livres and Troisieme place a 2 livres"
  task :flip => :environment do |t, args|
  	changed_reg_count = 0
  	untouched_reg_count = 0
	Register.where("season = ? OR season = ?", '1783-1784', '1784-1785').each do |reg|
		puts "Register ID: " + reg.id.to_s + "\n"
		reg.ticket_sales.each do |sale|
			old_cat = sale.seating_category_id
			case old_cat
			when 40
				new_cat = 39
				changed_reg_count += 1
				puts "Old seating_category_id was: " + old_cat.to_s
				puts "New seating_category_id is: " + new_cat.to_s
			when 39
				new_cat = 40
				changed_reg_count += 1
				puts "Old seating_category_id was: " + old_cat.to_s
				puts "New seating_category_id is: " + new_cat.to_s
			else
				untouched_reg_count += 1
				next
			end
			sale.seating_category_id = new_cat
			sale.save!
			puts "\n\n"
		end
	end
	puts "changed_reg_count: " + changed_reg_count.to_s
	puts "untouched_reg_count: " + untouched_reg_count.to_s
  end
end


# Register.where(:season => '1783-1784').ticket_sales.update_all("seating_category_id = 40", :seating_category_id => 400)