require 'spec_helper'

describe RegistersController do
  render_views

  describe "for non-signed-in users" do
    it "should allow access to index" do
      get :index
      response.should be_success
    end

    it "should have a season facet" do
      get :index
      response.should have_selector("div#season")
    end

    it "should have a weekday facet" do
      get :index
      response.should have_selector("div#weekday")
    end

    it "should have a play 1 author facet" do
      get :index
      response.should have_selector("div#author1")
    end

    it "should have a play 2 author facet" do
      get :index
      response.should have_selector("div#author2")
    end

    it "should have a play 1 title facet" do
      get :index
      response.should have_selector("div#title1")
    end

    it "should have a play 2 title facet" do
      get :index
      response.should have_selector("div#title2")
    end

    it "should have a first balcony facet"
#      get :index
#      response.should have_selector("div#firstbalcony")
#    end

    it "should have parterre facet"
#      get :index
#      response.should have_selector("div#parterre")
#    end

    it "should have total spectators facet"
#      get :index
#      response.should have_selector("div#total_spectators")
#    end

    it "should have total receipts facet" do
      get :index
      response.should have_selector("div#total_receipts_recorded_l")
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
  end
end




