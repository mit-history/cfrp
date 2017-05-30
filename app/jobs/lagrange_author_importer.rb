class LagrangeAuthorImporter
  attr_reader :ext_id

  def initialize(line)
    @fields = line.to_hash
  end

  def perform
    lagrange_author = LagrangeAuthor.new(@fields)
    save_lagrange_author(lagrange_author)
  end

  private

  def save_lagrange_author(lagrange_author)
    begin
      lagrange_author.save!
      print "Lagrange Author Saved: \n"
      print lagrange_author.inspect
    rescue StandardError => e
      puts e.inspect
    end
  end
end
