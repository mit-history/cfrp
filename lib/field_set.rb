require_relative '../app/models/seating_category.rb'

module CFRP
  class FieldSet
    def initialize(cols, season_spec)
      @fields = cols.reduce([]) do |fields, c|
        fields << c.content.gsub(/^\s*/, '').gsub(/\s*$/, '')
      end

      @season_spec = season_spec
    end

    def method_missing(name, *args, &block)
      case name
      when :ticket_sales
        ticket_sales(@season_spec.ticket_sales)
      when :register_period_id
        @season_spec.send(name)
      when :date
        Date.parse(@fields[@season_spec.send(name)])
      else
        @fields[@season_spec.send(name)]
      end
    end

    private

    def ticket_sales(ticket_sales_keys)
      ticket_sales_keys.reduce([]) do |ts_vals, ts_ks|
        args = [@fields[ts_ks.total_sold].to_i,
                @fields[ts_ks.price_per_ticket_l].to_i,
                @fields[ts_ks.price_per_ticket_s].to_i,
                get_seating_category_id(ts_ks.seating_category_name),
                @fields[ts_ks.recorded_total_l].to_i,
                @fields[ts_ks.recorded_total_s].to_i]
        ts_vals << TicketSaleValueSet.new(*args)
      end
    end

    TicketSaleValueSet = Struct.new(:total_sold,
                                    :price_per_ticket_l,
                                    :price_per_ticket_s,
                                    :seating_category_id,
                                    :recorded_total_l,
                                    :recorded_total_s)

    def get_seating_category_id(name)
      SeatingCategory.find_by_name(name).id
    end
  end
end
