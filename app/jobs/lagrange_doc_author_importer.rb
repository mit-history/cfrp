class LagrangeDocAuthorImporter
  attr_reader :ext_id

  def initialize(line)
    @fields = line.to_hash
  end

  def perform
    lagrange_doc_author = LagrangeDocAuthor.new(@fields)
    save_lagrange_doc_author(lagrange_doc_author)
  end

  private

  def save_lagrange_doc_author(lagrange_doc_author)
    begin
      lagrange_doc_author.save!
      print "Lagrange Doc Author Saved: \n"
      print lagrange_doc_author.inspect
    rescue StandardError => e
      puts e.inspect
    end
  end
end
