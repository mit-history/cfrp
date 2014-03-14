namespace :filepath do
  desc 'Migrate images to paperclip-managed storage'
  task migrate_to_paperclip: :environment do
    Register.order('random()').limit(50).each do |register|
      recto = register.register_images[0]
      verso = register.register_images[1]

      unless verso.nil?
        save_register_image(verso, 'verso')
      end

      unless recto.nil?
        save_register_image(recto, 'recto')
      end
    end
    puts
  end
end

def save_register_image(register_image, orientation)
  begin
    print '.'
    register_image.orientation = orientation
    register_image.image = "http://images.cfregisters.org/#{register_image.filepath}"
    register_image.save!
  rescue StandardError => e
    puts "\nCouldn't save #{register_image.errors.full_messages.join(',')}"
  end
end
