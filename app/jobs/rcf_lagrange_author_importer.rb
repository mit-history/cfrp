class RCFLagrangeAuthorImporter
  attr_reader :ext_id

  def initialize(line)
    @fields = line.to_hash
  end

  def perform
    rcf_lagrange_author = RcfLagrangeAuthor.new(@fields)
    save_rcf_lagrange_author(rcf_lagrange_author)
  end

  private

  def save_rcf_lagrange_author(rcf_lagrange_author)
    begin
      rcf_lagrange_author.save!
      print "RCF Lagrange Author Saved: \n"
      print rcf_lagrange_author.inspect
    rescue StandardError => e
      puts e.inspect
    end
  end
end
