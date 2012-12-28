# -*- coding: utf-8 -*-
require 'nokogiri'
require_relative '../spec_helper'

module CFRP
  describe FMMigrator do
    let(:fm_xml) { open('fm-xml/1780-1781.xml') }

    let(:season) { '1780-1781' }
    let(:subject) { FMMigrator.new(fm_xml, season) }

    it 'loads XML' do
      Nokogiri::XML.should_receive(:parse).with(fm_xml)
      subject
    end

    it 'splits cols up into separate fieldsets' do
      subject.fieldsets[0].should_not be_nil
    end

    it 'sets the SeasonSpec for the FieldSet' do
      SeasonSpec.should_receive(:retrieve_for).with(season)
      subject
    end

    it 'extracts Register from fieldset' do
      subject.registers[0].should_not be_nil
    end

    it 'sets values for a new Register from fieldset' do
      first_reg = subject.registers[0]
      first_reg.date.should == Date.new(1780, 4, 4)
      first_reg.weekday.should == 'Mardy'
      first_reg.season.should == '1780-1781'
      first_reg.register_num.should == 1

      # Need to find one to test to confirm...
      first_reg.payment_notes.should == ''

      first_reg.page_text.should == 'Arrêté par nous Semainiers la Recette de ce jour 4 Avril mil sept cent quatre-vingt, montant à la somme de quinze cent soixante seize livres. Courville'

      first_reg.total_receipts_recorded_l.should == 1576
      first_reg.total_receipts_recorded_s.should == 0

      first_reg.representation.should == 1

      # NO
      #  signatory                 :string(255)

      first_reg.for_editor_notes.should == 'Unable to read, but appears to say “Le Complement par M. Vanhove”'

      first_reg.misc_notes.should == "L’ouverture\nalso see Notes for Editor"

      # NO
      #  ouverture                 :boolean
      #  cloture                   :boolean

      first_reg.register_period_id.should == 2
      first_reg.verification_state_id.should == 2

      # NO
      #  irregular_receipts_name   :string(255)

    end
  end
end
