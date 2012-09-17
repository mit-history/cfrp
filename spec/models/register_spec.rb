# -*- coding: utf-8 -*-

require 'spec_helper'

describe Register do
  before :each do
    @register = Register.new( :register_num => 1, :date => '1750-01-01', :season => '1749-1750' )
    @play1 = Play.new( :author => 'Bob Smith', :title => 'Bob\'s First Play', :genre => 'tragedy' )
    @play2 = Play.new( :author => 'Bob Smith', :title => 'Bob\'s Second Play', :genre => 'comedy' )
    @register.register_plays << RegisterPlay.new( :play => @play1, :ordering => 1 )
    @register.register_plays << RegisterPlay.new( :play => @play2, :ordering => 2 )
    @sc1 = SeatingCategory.create(:name => "seating 1")
    @sc2 = SeatingCategory.create(:name => "seating 2")
    @register.ticket_sales << TicketSale.new(:seating_category_id => @sc1.id)
    @register.save

    # FYI, this attribute mass-assignment syntax doesn't work as I expected apparently:
    # @register.register_plays << RegisterPlay.new( :play_id => @play1.id, :ordering => 1 )
  end

  it "saves related model data automatically" do
    @register.register_plays[0].play_id.should_not be_nil
    @register.register_plays[1].play_id.should_not be_nil
  end

  it "has play data for each register, if it exists." do
    @register.register_plays[0].play.title.should match('Bob\'s First Play')
  end

  it "updates related model data automatically" do
    plays = { 
      :register_plays_attributes => {
        "0" => {
          "id" => @register.register_plays[0].id,
          "ordering" => "0",
          "play_attributes" => {
            "title" => "Les Femmes savantes",
            "author" => "Bill Jones"
          }
        },

        "1" => {
          "id" => @register.register_plays[1].id,
          "ordering" => "1",
          "play_attributes" => {
            "title" => "La Comtesse d'Escarbagnas",
            "author" => "Jenny Smith"
          },
        }
      }
    }

    @register.update_attributes!(plays)
    register_plays = Register.find(@register.id).register_plays
    register_plays[0].play.title.should match 'Les Femmes savantes'
    register_plays[0].play.author.should match 'Bill Jones'
    register_plays[1].play.title.should match 'La Comtesse d\'Escarbagnas'
    register_plays[1].play.author.should match 'Jenny Smith'
  end

  describe "Ticket Sales" do
    before(:each) do
      @ticket_sales_attributes = {
        "0" => { "id" => @register.ticket_sales[0].id,
          "seating_category_id" => @register.ticket_sales[0].seating_category_id,
          "total_sold" => @register.ticket_sales[0].attributes[:total_sold],
          "price_per_ticket_l" => @register.ticket_sales[0].attributes[:price_per_ticket_l],
          "price_per_ticket_s" => @register.ticket_sales[0].attributes[:price_per_ticket_s],
          "recorded_total_l" => @register.ticket_sales[0].attributes[:recorded_total_l],
          "recorded_total_s" => @register.ticket_sales[0].attributes[:recorded_total_s] },

        "1" => { "id" => 10,
          "seating_category_id" => @sc2.id,
          "total_sold" => 10,
          "price_per_ticket_l" => 11,
          "price_per_ticket_s" => 12,
          "recorded_total_l" => 13,
          "recorded_total_s" => 14 }}
    end

    it "saves new ticket sales data automatically" do
      @register.ticket_sales_attributes = @ticket_sales_attributes
      @register.ticket_sales.length.should equal 2
    end

    it "saves the seating_category_id for current ticket_sales" do
      @register.ticket_sales_attributes = @ticket_sales_attributes
      @register.ticket_sales.detect {|ts| ts.id == @register.ticket_sales[0].id }.seating_category_id.should equal @sc1.id
    end

    it "saves the seating_category_id for new ticket_sales" do
      @register.ticket_sales_attributes = @ticket_sales_attributes
      @register.ticket_sales.detect {|ts| ts.id != @register.ticket_sales[0].id }.seating_category_id.should equal @sc2.id
    end
  end
end

# == Schema Information
#
# Table name: registers
#
#  id                        :integer         not null, primary key
#  date                      :date
#  weekday                   :string(255)
#  season                    :string(255)
#  register_num              :integer
#  payment_notes             :text
#  page_text                 :text
#  total_receipts_recorded_l :integer
#  total_receipts_recorded_s :integer
#  representation            :integer
#  signatory                 :string(255)
#  misc_notes                :text
#  for_editor_notes          :text
#  ouverture                 :boolean
#  cloture                   :boolean
#  created_at                :datetime
#  updated_at                :datetime
#  register_image_id         :integer
#  register_period_id        :integer
#  verification_state_id     :integer
#  irregular_receipts_name   :string(255)
#

