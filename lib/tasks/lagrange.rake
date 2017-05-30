namespace :lagrange do

  desc 'enqueue Lagrange Authors for import'
  task import_authors: :environment do
    csv = CSV.open(
      "db/rcf_ui/data/lagrange_authors.csv",
      { 
        :col_sep =>"|",
        :headers => true,
        :converters=> lambda {|f| f ? f.strip : nil}
      }
    )
    csv.each do |line|
      Delayed::Job.enqueue LagrangeAuthorImporter.new(line)
    end
  end

  desc 'enqueue Lagrange Docs for import'
  task import_docs: :environment do
    csv = CSV.open(
      "db/rcf_ui/data/lagrange_docs.csv",
      { 
        :col_sep =>"|",
        :headers => true,
        :converters=> lambda {|f| f ? f.strip : nil}
      }
    )
    csv.each do |line|
      Delayed::Job.enqueue LagrangeDocImporter.new(line)
    end
  end

  desc 'enqueue Lagrange Doc Authors for import'
  task import_doc_authors: :environment do
    csv = CSV.open(
      "db/rcf_ui/data/lagrange_doc_authors.csv",
      { 
        :col_sep =>"|",
        :headers => true,
        :converters=> lambda {|f| f ? f.strip : nil}
      }
    )
    csv.each do |line|
      Delayed::Job.enqueue LagrangeDocAuthorImporter.new(line)
    end
  end

  desc 'enqueue RCF Lagrange Authors for import'
  task import_rcf_lagrange_authors: :environment do
    csv = CSV.open(
      "db/rcf_ui/data/rcf_lagrange_authors.csv",
      { 
        :col_sep =>"|",
        :headers => true,
        :converters=> lambda {|f| f ? f.strip : nil}
      }
    )
    csv.each do |line|
      Delayed::Job.enqueue RCFLagrangeAuthorImporter.new(line)
    end
  end

  desc 'Copy primary keys for all lagrange data'
  task copy_doc_author_join_keys: :environment do

    LagrangeDocAuthor.find_each do |record|
      puts "Original join record: #{record.inspect}"

      doc = LagrangeDoc.find_by_ext_id(record.lagrange_doc_ext_id)
      puts "Doc: #{doc.inspect}"

      author = LagrangeAuthor.find_by_ext_id(record.lagrange_author_ext_id)
      puts "Author: #{author.inspect}"

      if doc.present?
        record.lagrange_doc_id = doc.id
      end

      if author.present?
        record.lagrange_author_id = author.id
      end

      record.save!
      puts "Updated join record: #{record.inspect}"
    end
  end

  desc 'Copy primary keys for all lagrange data'
  task copy_rcf_lagrange_author_join_keys: :environment do

    RcfLagrangeAuthor.all().each() do |record|
      puts "Original join record: #{record.inspect}"

      # person_id has the old ext_id values, because we've renamed that column
      # so we can look up a person by that ext_id value before updating person_id with the actual internal primary key
      person = Person.find_by_ext_id(record.person_id)
      puts "Person: #{person.inspect}"

      author = LagrangeAuthor.find_by_ext_id(record.lagrange_author_ext_id)
      puts "Author: #{author.inspect}"

      if person.present?
        # Move imported id value from renamed person_id column to a renamed holding column
        record.rcf_ext_id = record.person_id
        # Copy the db id value to the correct column
        record.person_id = person.id
      end

      if author.present?
        record.lagrange_author_ext_id = author.ext_id
        record.lagrange_author_id = author.id
      end

      record.save!
      puts "Updated join record: #{record.inspect}"
    end
  end
end
