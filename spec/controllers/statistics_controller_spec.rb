require 'spec_helper'

describe StatisticsController do
  fixtures :users, :items, :posts

  before(:each) do
    sign_in users(:users_001)
  end

  describe "GET show_user" do
    it "returns status code of 200" do
      get :show_user, :id => 1, :format => :json
      response.response_code.should == 200
    end

    it "returns current user's items" do
      get :show_user, :id => 1, :format => :json
      response.body.should =~ /"total_items"/m
    end
  end

  describe "GET show_item" do
    it "returns status code of 200" do
      get :show_item, :id => 1, :format => :json
      response.response_code.should == 200
    end

    it "returns item statistics" do
      get :show_item, :id => 1, :format => :json
      response.body.should =~ /"relifts"/m
    end
  end

end
