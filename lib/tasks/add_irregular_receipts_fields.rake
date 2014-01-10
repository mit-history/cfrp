require 'date'

namespace :seating_categories do
  desc "Adds irregular receipt seating category rows"
  task :irregular_receipts => :environment do
    [2, 3, 4, 5, 6, 7, 8, 9, 10].each do |i|
      SeatingCategory.where(:name => "Irregular Receipts #{i}").first_or_create!(:name => "Irregular Receipts #{i}", :description => "Irregular Receipts #{i}")
    end
  end
end
