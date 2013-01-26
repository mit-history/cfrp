require_relative '../fm_migrator'

namespace :fm_migrator do
  desc "Dumps out raw XML fieldsets for specified season (e.g. '1780-1781')"
  task :dump_fieldsets, [:season] => :environment do |t, args|
    path = "fm-xml/#{args.season}.xml"
    fm_migration = CFRP::FMMigrator.new(open(path), args.season)
    puts fm_migration.fieldsets
  end

  desc "Imports XML via creation and saving of CFRP Model instances"
  task :import, [:season] => :environment do |t, args|
    path = "fm-xml/#{args.season}.xml"
    fm_migration = CFRP::FMMigrator.new(open(path), args.season)
    registers = fm_migration.registers
    puts registers.inspect
  end

  desc "Dump keys for season passed in (e.g. '1780-1781')"
  task :dump_keys, [:season] do |t, args|
    doc = Nokogiri::XML(open("fm-xml/#{args.season}.xml"))
    key = {}
    doc.css("FMPXMLRESULT METADATA FIELD").each_with_index do |f, i|
      key[i] = f.attr('NAME')
    end
    puts key.keys.reduce("") { |s, k| s = "#{s} #{k} : #{key[k]}\n" }
  end

  # move this into fm_migrator?
  desc "Dump ticket categories (seating) for season passed in (e.g. '1780-1781')"
  task :dump_seating, [:season] do |t, args|
    doc = Nokogiri::XML(open("fm-xml/#{args.season}.xml"))
    key = {}

    doc.css("FMPXMLRESULT METADATA FIELD").each_with_index do |f, i|
      key[i] = f.attr('NAME')
    end

    first_cols = doc.css("FMPXMLRESULT RESULTSET ROW").first.css("COL")

    scs = key.keys.reduce([]) do |s, k|
      if key[k].match(/Ticket category/i)
        s << "#{first_cols[k].content} : #{k}, #{key[k]}\n"
      else
        s
      end
    end

    puts scs.sort_by { |a| a.gsub(/.* Ticket category (\d*)$/, '\1').to_i }
  end
end
