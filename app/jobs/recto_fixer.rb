class RectoFixer
  attr_reader :register_id

  def initialize(register_id)
    @register_id = register_id
  end

  def perform
    register = Register.find(@register_id)
    print "\n\n============\n #{register_id} \n"
    save_register_image(register)
  end

  private

  def save_register_image(register)
    begin
      # print "\n******* \n Register:\n"
      # print "#{register.inspect} \n"
      register_image = register.recto_image

      # print "\n******* \n Register Image:\n"
      # print "#{register_image.inspect} \n"

      print "\n******* \n Change this:\n"
      print "Register image image: #{register_image.image} \n"
      print "Register image image_file_name: #{register_image.image_file_name} \n"
      print "Register image filepath: #{register_image.filepath} \n"
      print "Register image orientation: #{register_image.orientation} \n"
      print "Register image rv flag: #{register_image.rv_flag} \n"

      # get current, off by one image filename integer.
      old_image_int = register_image.filepath[/M119_02_R\d{2,3}_(\d{3})[rv].jpg/, 1].to_i
      # print "Old Image Int: #{old_image_int} \n"

      # create new, correct image filename integer.
      new_image_int = old_image_int -= 1
      # print "New Image Int: #{new_image_int} \n"

      # craft desired image filename
      desired_image_filename = "M119_02_R143/M119_02_R143_#{new_image_int}v.jpg"

      # get desired file from s3.
      register_image.image = "https://s3.amazonaws.com/seventies-nineties/#{desired_image_filename}"

      # new_image_filename = "M119_02_R143_#{new_image_int}r.jpg"

      # # this may not be necessary:
      # # craft new image filename to be, 
      # register_image.image.instance_write :file_name, new_image_filename

      print "\n\n******* \n To this:\n"
      print "Register image image: #{register_image.image} \n"
      print "Register image image_file_name: #{register_image.image_file_name} \n"
      print "Register image filepath: #{register_image.filepath} \n"
      print "Register image orientation: #{register_image.orientation} \n"
      print "Register image rv flag: #{register_image.rv_flag} \n"

      # save new file to s3
      # register_image.image = "https://s3.amazonaws.com/seventies-nineties/#{register_image.image_filename}"

      # register_image.orientation = orientation # shouldn't change

      register_image.save!
      print "Register Image Saved. \n"

      # print "\n\n******* \n Register Image Object:\n"
      # print "#{register_image.inspect} \n"
    rescue StandardError => e
      puts e.inspect
    end
  end
end
