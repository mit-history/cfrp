namespace :authorship do
  desc "Insert primary person key into Authorship records"
  task :update => :environment do |t, args|
    Authorship.find_each do | a |
      a.person_id = a.person.id
      a.save!
      puts "Updated Authorship: " + a.person.name
      puts "\n"
    end
  end
end
