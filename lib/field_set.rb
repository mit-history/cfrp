module CFRP
  class FieldSet
    def initialize(cols, season_spec)
      @fields = cols.reduce([]) do |fields, c|
        fields << c.content.gsub(/^\s*/, '').gsub(/\s*$/, '')
      end

      @season_spec = season_spec
    end

    def method_missing(name, *args, &block)
      return @season_spec.send(name) if name == :register_period_id
      value = @fields[@season_spec.send(name)]
      name == :date ? Date.parse(value) : value
    end
  end
end
