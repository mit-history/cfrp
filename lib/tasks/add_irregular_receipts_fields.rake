# For existing data:
# rake db:migrate && rake seating_categories:irregular_receipts
# this adds a number of new irregular_receipts columns to the register table
# then adds rows to the RPSC table to map those new SCs to all RPs
# this allows the addition of new irregular receipts to any register, up to 10 total.
# not the cleanest or best solution to this problem, but 'twill serve 

namespace :seating_categories do
	desc "Adds irregular receipt seating category rows"
	task :irregular_receipts => :environment do
		seating_categories = [2, 3, 4, 5, 6, 7, 8, 9, 10].map do |i|
			SeatingCategory.where(:name => "Irregular Receipts #{i}").first_or_create!(:name => "Irregular Receipts #{i}", :description => "Irregular Receipts #{i}")
		end

		RegisterPeriod.all.each do |register_period|
			seating_categories.each do |seating_category|
				RegisterPeriodSeatingCategory.create!(
					:register_period_id => register_period.id,
					:seating_category_id => seating_category.id,
					:ordering => RegisterPeriodSeatingCategory.where(
						register_period_id: register_period.id
						).maximum(:ordering).to_i + 1
				)
			end
		end

	end
end
