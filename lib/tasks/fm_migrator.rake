require_relative '../fm_migrator'

namespace :fm_migrator do
  desc "Dumps out raw XML fieldsets for 1780-1781 season"
  task :dump_fieldsets_1780_1781 => :environment do
    path = '/Users/ddellacosta/projects/mit-work/cfrp/fm-xml/1780-1781-2.xml'
    fm_migration = CFRP::FMMigrator.new(open(path), '1780-1781')
    registers = fm_migration.registers
    puts registers.inspect
  end

  desc "Dumps out raw XML fieldsets for 1781-1782 season"
  task :dump_fieldsets_1781_1782 => :environment do
    path = '/Users/ddellacosta/projects/mit-work/cfrp/fm-xml/1781-1782.xml'
    fm_migration = CFRP::FMMigrator.new(open(path), '1781-1782')
    registers = fm_migration.registers
    puts registers.inspect
  end

  desc "Dump keys for 1781-1782 season"
  task :dump_keys_1781_1782 do
    doc = Nokogiri::XML(open('fm-xml/1781-1782.xml'))
    key = {}
    doc.css("FMPXMLRESULT METADATA FIELD").each_with_index do |f, i|
      key[i] = f.attr('NAME')
    end
    puts key.keys.reduce("") { |s, k| s = "#{s} #{k} : #{key[k]}\n" }
  end
end
