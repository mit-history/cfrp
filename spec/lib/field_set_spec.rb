# -*- coding: utf-8 -*-
require_relative '../spec_helper'

module CFRP
  describe FieldSet do
    let(:fm_xml) { open('fm-xml/1780-1781.xml') }
    let(:doc) { Nokogiri::XML.parse(fm_xml) }
    let(:first) { doc.css("FMPXMLRESULT RESULTSET ROW")[0].css("COL") }

    let(:season) { '1780-1781' }
    let(:season_spec) { SeasonSpec.retrieve_for season }

    let(:subject) { FieldSet.new(first, season_spec) }

    it 'converts a set of XML nodes to attributes' do
      subject.weekday.should == 'Mardy'
    end

    it 'converts date fields to Dates' do
      subject.date.should == Date.new(1780, 4, 4)
    end

    describe 'Ticket Sales' do
      it 'returns an array of TicketSales' do
        subject.ticket_sales.count.should == 13
      end

      it 'looks up the value for the TicketSale keys provided by the SeasonSpec' do
        subject.ticket_sales[12].total_sold.should == 450
        subject.ticket_sales[12].price_per_ticket_l.should == 1
        subject.ticket_sales[12].price_per_ticket_s.should == 0
        subject.ticket_sales[12].seating_category_id.should == 18
        subject.ticket_sales[12].recorded_total_l.should == 450
        subject.ticket_sales[12].recorded_total_s.should == 0
      end
    end
  end
end

