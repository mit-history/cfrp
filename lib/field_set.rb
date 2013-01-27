# -*- coding: utf-8 -*-
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
        extract_date
      when :weekday
        fix_weekday
      else
        @season_spec.send(name).nil? ? '' : @fields[@season_spec.send(name)]
      end
    end

    private

    def extract_date
      if @season_spec.date.nil?
        Date.new(@fields[@season_spec.year].to_i,
                 month_index(@fields[@season_spec.month]),
                 @fields[@season_spec.day].to_i)
      else
        Date.parse(@fields[@season_spec.date])
      end
    end

    def fix_weekday
      @fields[@season_spec.weekday].gsub(/y$/, 'i')
    end

    def month_index(month_name)
      French_months[month_name.downcase]
    end

    def ticket_sales(ticket_sales_keys)
      all_ts = ticket_sales_keys.reduce([]) do |ts_vals, ts_ks|
        args = [@fields[ts_ks.total_sold].to_i,
                @fields[ts_ks.price_per_ticket_l].to_i,
                @fields[ts_ks.price_per_ticket_s].to_i,
                get_seating_category_id(ts_ks.seating_category_name),
                @fields[ts_ks.recorded_total_l].to_i,
                @fields[ts_ks.recorded_total_s].to_i]
        ts_vals << TicketSaleValueSet.new(*args)
      end

      unless @fields[@season_spec.irregular_receipts_l].empty? &&
          @fields[@season_spec.irregular_receipts_s].empty?
        all_ts << TicketSaleValueSet.new(*[0,
                                           0,
                                           0,
                                           get_seating_category_id('Irregular Receipts'),
                                           @fields[@season_spec.irregular_receipts_l].to_i,
                                           @fields[@season_spec.irregular_receipts_s].to_i])
      end
      all_ts
    end

    French_months = {
      'janvier' => 1,
      'février' => 2,
      'fevrier' => 2,
      'mars' => 3,
      'avril' => 4,
      'may' => 5,
      'mai' => 5,
      'juin' => 6,
      'juillet' => 7,
      'août' => 8,
      'aout' => 8,
      'septembre' => 9,
      'september' => 9,
      'octobre' => 10,
      'november' => 11,
      'novembre' => 11,
      'décembre' => 12,
      'decembre' => 12,
      'december' => 12
    }

    TicketSaleValueSet = Struct.new(:total_sold,
                                    :price_per_ticket_l,
                                    :price_per_ticket_s,
                                    :seating_category_id,
                                    :recorded_total_l,
                                    :recorded_total_s)

    def get_seating_category_id(name)
      rp = RegisterPeriod.find_by_id(@season_spec.register_period_id)
      rpsc = rp.register_period_seating_categories.find {|rpsc| rpsc.seating_category.name == name}
      rpsc.seating_category.id
    end
  end
end
