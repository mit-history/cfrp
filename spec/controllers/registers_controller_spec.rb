require 'spec_helper'

describe RegistersController do
  render_views

  describe "display for non-signed-in users" do
    it "should allow access" do
      get :index
      response.should be_success
    end

# Okay, these are rendered via JS, so I guess I need to test them w/Jasmine?
#    it "should not have edit options" do
#      get :index
#      response.should_not have_selector("a#edit_action")
#    end
#
#    it "should not have delete options" do
#      get :index
#      response.should_not have_selector("a#delete_action")
#    end

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

# (See above also) test with Jasmine?
#      it "should have edit options" do
#        get :index
#        response.should have_selector("a#edit_action")
#      end

#      it "should have delete options" do
#        get :index
#        response.should have_selector("a#delete_action")
#      end

    end

    describe "GET 'edit'" do

      before(:each) do
        @register = Register.new( :register_num => 1, :date => '1750-01-01', :season => '1749-1750' )
        @play1 = Play.new( :author => 'Bob Smith', :title => 'Bob\'s First Play', :genre => 'tragedy' )
        @play2 = Play.new( :author => 'Bob Smith', :title => 'Bob\'s Second Play', :genre => 'comedy' )
        @register.register_plays << RegisterPlay.new( :play => @play2, :ordering => 2 )
        @register.register_plays << RegisterPlay.new( :play => @play1, :ordering => 1 )
        @register.save
      end

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

      it "should be ordered by the play ordering" do
        get :edit, :id => @register.id
        # Kind of convoluted...easier way to do this? Probably...
        doc = Nokogiri::XML::DocumentFragment.parse(response.body)
        ordering = doc.css('div#play_fields').css('input#register_play_ordering').collect {|i| i[:value]}
        ordering.should == ["1", "2"]
      end
    end
  end
end
