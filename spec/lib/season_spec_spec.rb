# -*- coding: utf-8 -*-
require_relative '../spec_helper'

module CFRP
  describe SeasonSpec do
    let(:season) { '1780-1781' }
    let(:season_spec) { SeasonSpec.retrieve_for season }

    it 'returns numeric index key when sent names' do
      season_spec.date.should == 4
      season_spec.weekday.should == 104
    end

    describe "1780-1781 Seating/Ticket Sales" do
      it 'returns a set of TicketSales' do
        season_spec.ticket_sales.count.should == 13
      end

      it 'sets each TicketSale to a set of keys for that entry' do
        season_spec.ticket_sales[0].total_sold.should == 14
        season_spec.ticket_sales[0].price_per_ticket_l.should == 27
        season_spec.ticket_sales[0].price_per_ticket_s.should == 28
        season_spec.ticket_sales[0].seating_category_name.should == 'Premières Loges 1'
        season_spec.ticket_sales[0].recorded_total_l.should == 75
        season_spec.ticket_sales[0].recorded_total_s.should == 76
      end
    end
  end
end
