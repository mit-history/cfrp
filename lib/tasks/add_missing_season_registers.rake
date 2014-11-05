namespace :missing_seasons do
	desc "Adds a an entry form page per day for 1739-1740, for which there are no registers."
	task :add => :environment do
    start_date = Date.new(1739,05,01)

		(0..364).step(1) do |day|
      newreg = Register.new(
        date: (start_date + day).to_s,
        season: '1739-1740',
        verification_state_id: 5
      )
      newreg.save!
      puts newreg.inspect
		end
	end
end
