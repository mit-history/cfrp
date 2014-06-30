namespace :filepath do
  desc 'enqueue Registers for migration'
  task migrate_registers_to_paperclip: :environment do
    Register.two_images.find_each do |register|
      Delayed::Job.enqueue RegisterImporter.new(register.id)
    end
  end
end
