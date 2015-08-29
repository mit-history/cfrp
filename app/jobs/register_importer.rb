class RegisterImporter
  attr_reader :register_id

  def initialize(register_id)
    @register_id = register_id
  end

  def perform
    register = Register.find(@register_id)
    # if there's an orientation on the first image, it's been processed; skip it.
    print "\n\n============\n #{register.id} \n"
    
    next if (!register.register_images[0].orientation.nil?)

    puts "...not processed yet, processing..."
    recto = register.recto_image
    # verso = register.verso_image
    # left = register.left_image

    # if verso.nil?
    #   print "Verso was nil for register: #{register.id} \n"
    # else
    #   save_register_image(verso, 'verso')
    # end

    if recto.nil?
      print "Recto was nil for register: #{register.id} \n"
    else
      save_register_image(recto, 'recto')
    end

    # if left.nil?
    #   print "Left was nil for register: #{register.id} \n"
    # else
    #   create_register_image(register, left, 'left')
    # end
  end

  private

  def save_register_image(register_image, orientation)
    begin
      print "\n******* \n Existing\n"
      print "Register: #{register_image.register_id} \n"
      print "Register image: #{register_image.id} \n"
      print "Register image filepath: #{register_image.filepath} \n"
      print "Requested orientation: #{orientation} \n"
      print "Register image rv flag: #{register_image.rv_flag} \n"

      register_image.orientation = orientation
      register_image.image = "https://s3.amazonaws.com/seventies-nineties/#{register_image.image_filename}"
      print "Register image: #{register_image.inspect} \n"
      # register_image.save!
    rescue StandardError => e
      puts e.inspect
    end
  end

  # def create_register_image(register, register_image, orientation)
  #   begin
  #     print "\n++++++ \n New\n"
  #     print "Previous Register: #{register.id} \n"
  #     print "Old register image: #{register_image.id} \n"
  #     print "Requested orientation: #{orientation} \n"
  #     print "Register image rv flag: #{register_image.rv_flag} \n"

  #     new_image = RegisterImage.new(
  #       orientation: orientation,
  #       register_id: register.id,
  #       # image: "http://images.cfregisters.org/#{register_image.image_filename}",
  #       image: "http://images.cfregisters.org/#{register.left_image.image_filename}",
  #       image_content_type: "image/jpeg"
  #     )

  #     print "New register image: #{new_image.inspect} \n"
  #     new_image.save!
  #   rescue StandardError => e
  #     puts e.inspect
  #   end
  # end
end
