namespace :filepath do
  desc 'enqueue Registers for migration'
  # task migrate_all_two_image_registers_to_paperclip: :environment do
  #   Register.two_images.find_each do |register|
  #     Delayed::Job.enqueue RegisterImporter.new(register.id)
  #   end
  # end
  # task add_left_to_1758_1759_registers: :environment do
  #   Register.season('1758-1759').unentered.find_each do |register|
  #     Delayed::Job.enqueue RegisterImporter.new(register.id)
  #   end
  # end
  task migrate_seventies_nineties: :environment do
    Register.volume_number.between?(134,158).find_each do |register|
      Delayed::Job.enqueue RegisterImporter.new(register.id)
    end
  end
end
