# -*- coding: utf-8 -*-
require 'spec_helper'

describe RegistersController do
  render_views

  describe "index for non-signed-in users" do
    it "should allow access" do
      get :index
      response.should be_success
    end

    it "should have a season facet" do
      get :index
      response.body.should have_selector('div#season')
    end

    it "should have a weekday facet" do
      get :index
      response.body.should have_selector("div#weekday")
    end

    it "should have a play 1 author facet" do
      get :index
      response.body.should have_selector("div#author1")
    end

    it "should have a play 2 author facet" do
      get :index
      response.body.should have_selector("div#author2")
    end

    it "should have a play 1 title facet" do
      get :index
      response.body.should have_selector("div#title1")
    end

    it "should have a play 2 title facet" do
      get :index
      response.body.should have_selector("div#title2")
    end

    it "should have total receipts facet" do
      get :index
      response.body.should have_selector("div#total_receipts_recorded_l")
    end
  end

  describe "for signed-in users" do
    before(:each) do
      @user = User.create(:email => 'tester@example.com', :shortname => 'testuser', :password => 'password')
      sign_in @user
    end

    describe "GET 'index'" do
      it "should be successful" do
        get :index
        response.should be_success
      end
    end

    describe "Authenticated actions" do
      before(:each) do
        @rp = RegisterPeriod.create(:period => 'testing!')

        @register = Register.new( :register_num => 1,
                                  :date => '1750-01-01',
                                  :season => '1749-1750',
                                  :register_period_id => @rp.id)

        @play1 = Play.new( :author => 'Bob Smith',
                           :title => 'Bob\'s First Play',
                           :genre => 'tragedy' )
        @play2 = Play.new( :author => 'Bob Smith',
                           :title => 'Bob\'s Second Play',
                           :genre => 'comedy' )
        @register.register_plays << RegisterPlay.new( :play => @play2,
                                                      :ordering => 2 )
        @register.register_plays << RegisterPlay.new( :play => @play1,
                                                      :ordering => 1 )

        @sc1 = SeatingCategory.create(:name => 'Petites Loges')
        @sc2 = SeatingCategory.create(:name => 'Places de Parterre')
        @sc3 = SeatingCategory.create(:name => 'Fake Seating Category')
        @rt_sc1 = RegisterPeriodSeatingCategory.create({:ordering => 0,
                                                      :register_period_id => @rp.id,
                                                      :seating_category_id => @sc3.id})
        @rt_sc2 = RegisterPeriodSeatingCategory.create({:ordering => 1,
                                                      :register_period_id => @rp.id,
                                                      :seating_category_id => @sc2.id})
        @rt_sc3 = RegisterPeriodSeatingCategory.create({:ordering => 2,
                                                      :register_period_id => @rp.id,
                                                      :seating_category_id => @sc1.id})


        @register.ticket_sales.build({:total_sold => 0,
                                       :price_per_ticket_l => 0,
                                       :price_per_ticket_s => 0,
                                       :recorded_total_l => 0,
                                       :recorded_total_s => 0,
                                       :seating_category_id => @sc1.id})

        @register.ticket_sales.build({:total_sold => 1,
                                       :price_per_ticket_l => 1,
                                       :price_per_ticket_s => 1,
                                       :recorded_total_l => 1,
                                       :recorded_total_s => 1,
                                       :seating_category_id => @sc2.id})

        @register.ticket_sales.build({:total_sold => 5,
                                       :price_per_ticket_l => 5,
                                       :price_per_ticket_s => 5,
                                       :recorded_total_l => 5,
                                       :recorded_total_s => 5,
                                       :seating_category_id => @sc3.id})
        @register.save
      end

      describe "for non-signed-in users" do
        it "redirects new to sign-in" do
          sign_out @user
          get :new
          response.should be_redirect
          response.header["Location"].should match 'sign_in$'
        end

        it "redirects edit to sign-in" do
          sign_out @user
          get :create, :id => @register.id
          response.should be_redirect
          response.header["Location"].should match 'sign_in$'
        end

        it "redirects create to sign-in" do
          sign_out @user
          get :create, :params => {}
          response.should be_redirect
          response.header["Location"].should match 'sign_in$'
        end

        it "redirects update to sign-in" do
          sign_out @user
          get :update, :id => @register.id, :params => {}
          response.should be_redirect
          response.header["Location"].should match 'sign_in$'
        end
      end

      describe "GET 'new'" do
      end

      describe "GET 'edit'" do
        it "should be successful" do
          get :edit, :id => @register.id
          response.should be_success
        end

        it "should have the play titles" do
          get :edit, :id => @register.id
          response.body.should have_selector('input#play_title')
        end

        it "should have the play authors" do
          get :edit, :id => @register.id
          response.body.should have_selector('input#play_author')
        end

        it "should present plays ordered by the register_play ordering" do
          get :edit, :id => @register.id
          # Kind of convoluted...easier way to do this? Probably...
          doc = Nokogiri::XML::DocumentFragment.parse(response.body)
          ordering = doc.css('div#play_fields').css('input#register_play_ordering').collect {|i| i[:value]}
          ordering.should == ["1", "2"]
        end

        it "should present ticket sales ordered by the seating categories" do
          get :edit, :id => @register.id
          ordering = []
          response.body.split("\n").each do |l|
            n = [@sc1.name, @sc2.name, @sc3.name].detect {|n| l.include? n}
            ordering << n if n
          end
          ordering.should == [@sc3.name, @sc2.name, @sc1.name]
        end
      end

      describe "POST 'create'" do
      end

      describe "PUT 'update'" do
        # TEST FOR FAILURE!
        #it "does nothing with a message on failure" do
        #  get :update, :id => @register.id, :register => {}
        #  response. ?
        #end

        it "updates the date" do
          date = { "date(1i)"=>"1751", "date(2i)"=>"3", "date(3i)"=>"2" }
          put :update, :id => @register.id, :register => date
          Register.find(@register.id).date.should == Date.new(1751, 3, 2)
        end

        it "updates the associated plays" do
          plays = { 
            :register_plays_attributes => {
              "0" => {
                "ordering" => "0",
                "play_attributes" => {
                  "title" => "Les Femmes savantes",
                  "author" => "Jean-Baptiste Poquelin dit Molière" },
                "id" => @register.register_plays[0]
              },

              "1" => {
                "ordering" => "1",
                "play_attributes" => {
                  "title" => "La Comtesse d'Escarbagnas",
                  "author" => "Jean-Baptiste Poquelin dit Molière" },
                "id" => @register.register_plays[1]
              }
            }}

          put :update, :id => @register.id, :register => plays
          rps = Register.find(@register.id).register_plays
          rps[0].play.title.should match 'Les Femmes savantes'
          rps[0].play.author.should match 'Jean-Baptiste Poquelin dit Molière'
          rps[1].play.title.should match 'La Comtesse d\'Escarbagnas'
          rps[1].play.author.should match 'Jean-Baptiste Poquelin dit Molière'
        end

        it "updates the ticket sales" do
          ts1_id = @register.ticket_sales[0].id
          ts2_id = @register.ticket_sales[1].id

          register = {
            :ticket_sales_attributes => {
              "0" => {
                "total_sold" => "1",
                "price_per_ticket_l" => "2",
                "price_per_ticket_s" => "3",
                "recorded_total_l" => "4",
                "recorded_total_s" => "5",
                "id" => ts1_id
              },

              "1" => {
                "total_sold" => "10",
                "price_per_ticket_l" => "10",
                "price_per_ticket_s" => "10",
                "recorded_total_l" => "10",
                "recorded_total_s" => "10",
                "id" => ts2_id
              }
            }
          }

          put :update, :id => @register.id, :register => register

          ts = TicketSale.find(ts1_id)
          ts.total_sold.should == 1
          ts.price_per_ticket_l.should == 2
          ts.price_per_ticket_s.should == 3
          ts.recorded_total_l.should == 4
          ts.recorded_total_s.should == 5

          ts2 = TicketSale.find(ts2_id)
          ts2.total_sold.should == 10
          ts2.price_per_ticket_l.should == 10
          ts2.price_per_ticket_s.should == 10
          ts2.recorded_total_l.should == 10
          ts2.recorded_total_s.should == 10
        end

        it "redirects to edit on a successful update" do
          date = { "date(1i)"=>"1751", "date(2i)"=>"3", "date(3i)"=>"2" }
          put :update, :id => @register.id, :register => date
          response.should be_redirect
          response.header["Location"].should match "#{@register.id}/edit"
        end
      end

      describe "DELETE 'destroy'" do
      end
    end
  end
end
