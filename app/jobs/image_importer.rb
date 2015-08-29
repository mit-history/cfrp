class ImageImporter
  attr_reader :register_image_id

  def initialize(register_image_id)
    @register_image_id = register_image_id
  end

  def perform
    register_image = RegisterImage.find(@register_image_id)
    print "\n\n============\n #{register_image_id} \n"
    save_register_image(register_image, 'recto')
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
      if (ENV['PAPERCLIP_ACTIVE'] == true)
        register_image.save!
        print "Register Image Saved. \n"
      end
      print "Register Image: #{register_image.inspect} \n"
    rescue StandardError => e
      puts e.inspect
    end
  end

end
