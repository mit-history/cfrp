module CFRP
  class SeasonSpecTemplate
    attr_reader :date,
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
                :register_period_id,
                :signatory,
                :play1,
                :play2,
                :play1_firstrun,
                :play2_firstrun,
                :newactor,
                :actorrole,
                :image_front,
                :image_back,
                :irregular_receipts_l,
                :irregular_receipts_s,

    # for post 1782
                :day,
                :month,
                :year

    def ticket_sales
      ticket_sales_keys.reduce([]) do |ticket_sales, keyset|
        ticket_sales << TicketSaleKeySet.new(*keyset)
      end
    end

    private

    def ticket_sales_keys
      []
    end

    TicketSaleKeySet = Struct.new(:total_sold,
                                  :price_per_ticket_l,
                                  :price_per_ticket_s,
                                  :seating_category_name,
                                  :recorded_total_l,
                                  :recorded_total_s)

  end
end
