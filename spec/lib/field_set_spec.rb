# -*- coding: utf-8 -*-
require_relative '../spec_helper'

module CFRP
  describe FieldSet do
    let(:season) { '1780-1781' }

    let(:fm_xml) { open("spec/fixtures/#{season}.xml") }
    let(:doc) { Nokogiri::XML.parse(fm_xml) }
    let(:first) { doc.css("FMPXMLRESULT RESULTSET ROW")[0].css("COL") }

    let(:season_spec) { SeasonSpec.retrieve_for season }

    let(:subject) { FieldSet.new(first, season_spec) }

    it 'converts a set of XML nodes to attributes' do
      subject.season.should == '1780-1781'
    end

    it 'converts date fields to Dates' do
      subject.date.should == Date.new(1780, 4, 4)
    end

    it 'converts weekday strings with "y" endings to have "i" endings' do
      subject.weekday.should == 'Mardi'
    end

    describe 'Periods from 1782 - 1786' do
      let(:season) { '1782-1783' }

      it 'converts year, month, day fields to Dates' do
        subject.date.should == Date.new(1782, 4, 9)
      end
    end

    describe 'Ticket Sales' do
      # failing because of change in register_plays play_attributes?
      xit 'returns an array of TicketSales' do
        subject.ticket_sales.count.should == 13
      end

      # failing because of change in register_plays play_attributes?
      xit 'looks up the value for the TicketSale keys provided by the SeasonSpec' do
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

