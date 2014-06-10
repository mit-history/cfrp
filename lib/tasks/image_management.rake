namespace :filepath do
  desc 'Migrate images to paperclip-managed storage'
  task migrate_to_paperclip: :environment do
    Register.order(:id).offset(9990).limit(100).find_each do |register|
      print "\n\n============\n #{register.id} \n"


      recto = register.recto_image
      verso = register.verso_image
      left = register.left_image

      if verso.nil?
        print "Verso was nil for register: #{register.id} \n"
      else
        save_register_image(verso, 'verso')
      end

      if recto.nil?
        print "Recto was nil for register: #{register.id} \n"
      else
        save_register_image(recto, 'recto')
      end

      if left.nil?
        print "Left was nil for register: #{register.id} \n"
      else
        create_register_image(register, left, 'left')
      end
    end
    # puts
  end
end

def save_register_image(register_image, orientation)
  begin
    print "\n******* \n Existing\n"
    print "Register: #{register_image.register_id} \n"
    print "Register image: #{register_image.id} \n"
    print "Register image filepath: #{register_image.filepath} \n"
    print "Requested orientation: #{orientation} \n"
    print "Register image rv flag: #{register_image.rv_flag} \n"

    register_image.orientation = orientation
    register_image.image = "http://images.cfregisters.org/#{register_image.filepath}"
    print "Register image: #{register_image.inspect} \n"
    register_image.save!
  rescue StandardError => e
    puts e.inspect
  end


  def create_register_image(register, register_image, orientation)
    begin
      print "\n++++++ \n New\n"
      print "Previous Register: #{register.id} \n"
      print "Old register image: #{register_image.id} \n"
      print "Requested orientation: #{orientation} \n"
      print "Register image rv flag: #{register_image.rv_flag} \n"

      new_image = RegisterImage.new(
        orientation: orientation,
        register_id: register.id,
        image: "http://images.cfregisters.org/#{register_image.filepath}"
      )

      print "New register image: #{new_image.inspect} \n"
      new_image.save!
    rescue StandardError => e
        puts e.inspect
    end
  end
end
