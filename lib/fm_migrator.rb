require 'nokogiri'

module CFRP
  class FMMigrator
    REGISTER_FIELDS = [
                       :date,
                       :weekday,
                       :season,
                       :register_num,
                       :payment_notes,
                       :page_text,
                       :total_receipts_recorded_l,
                       :total_receipts_recorded_s,
                       :representation,
                       :for_editor_notes,
                       :misc_notes,
                       :register_period_id
                      ]

    attr_reader :season_spec

    def initialize(xml, season)
      @doc = Nokogiri::XML.parse(xml)
      @season_spec = SeasonSpec.retrieve_for season
    end

    def fieldsets
      @doc.css("FMPXMLRESULT RESULTSET ROW").reduce([]) do |fieldsets, r|
        k = r.css("COL")
        #puts "#{k[2]}" if fieldsets.empty?
        fieldsets << FieldSet.new(k, @season_spec)
      end
    end

    def registers
      fieldsets.reduce([]) do |registers, f|
        registers <<
          Register.new(fields(f).merge({ :verification_state_id => 2 }))
      end
    end

    def fields(fieldset)
      REGISTER_FIELDS.reduce({}) do |fields, name|
        value = fieldset.send(name)
        if name == :total_receipts_recorded_l ||
            name == :total_receipts_recorded_s
          value = value.to_i
        end
        fields.merge({ name => value })
      end
    end
  end
end
