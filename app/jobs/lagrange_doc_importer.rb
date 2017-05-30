class LagrangeDocImporter
  attr_reader :ext_id

  def initialize(line)
    @fields = line.to_hash
  end

  def perform
    lagrange_doc = LagrangeDoc.new(@fields)
    save_lagrange_doc(lagrange_doc)
  end

  private

  def save_lagrange_doc(lagrange_doc)
    begin
      lagrange_doc.save!
      print "Lagrange Doc Saved: \n"
      print lagrange_doc.inspect
    rescue StandardError => e
      puts e.inspect
    end
  end
end
