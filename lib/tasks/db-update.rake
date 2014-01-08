namespace :filepath do
  desc "Changes the RegisterImage filepaths to work with S3"
  task :truncate => :environment do |t, args|
	RegisterImage.all.each do |ri|
		puts "Old path: " + ri.filepath
		newpath = ""
		case ri.filepath
		when /images\/jpeg\-150\-80\/([A-Za-z0-9\_\/]*\.jpg)/
			newpath = "#{$1}"
		when /images\/puceplume\/([A-Za-z0-9\_\/]*\.jpg)/
			newpath = "#{$1}"
		when /images\/azentis\-2013\/([A-Za-z0-9\_\/]*\.jpg)/
			newpath = "#{$1}"
		when /images\/10\.09\.photos\/([A-Za-z0-9\_\.\-\/]*\.JPG)/
			newpath = "#{$1}"
		else
		    newpath = ri.filepath # leave it alone
		end
		ri.filepath = newpath
		ri.save!
		puts "New path: " + ri.filepath
		puts "\n"
	end
  end
end
