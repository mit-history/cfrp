namespace :filepath do
  desc 'enqueue RegisterImages for migration'
  task migrate_all_two_image_registers_to_paperclip: :environment do
    Register.two_images.find_each do |register|
      Delayed::Job.enqueue RegisterImporter.new(register.id)
    end
  end
  task add_left_to_1758_1759_registers: :environment do
    Register.season('1758-1759').unentered.find_each do |register|
      Delayed::Job.enqueue RegisterImporter.new(register.id)
    end
  end
  task migrate_seventies_nineties: :environment do
    (142..157).each do |number|
      RegisterImage.volume(number).unmigrated.orientation('r').find_each do |image|
        Delayed::Job.enqueue ImageImporter.new(image.id)
        # puts image.id
      end
    end
  end
  task fix_recto_versos_1778_79: :environment do
    csv = CSV.open "db/data/78-79-registers.csv", { headers: true, header_converters: :symbol }
    csv.each do |line|
      Delayed::Job.enqueue RectoFixer.new(line[:id])
    end
  end
end
