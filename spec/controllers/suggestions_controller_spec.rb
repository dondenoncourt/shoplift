require 'spec_helper'

describe SuggestionsController do
  fixtures :users, :subscriptions

  before(:each) do
    sign_in users(:users_003)
  end

  describe "GET index" do
    it "returns status code of 200" do
      get :index, :format => :json
      response.response_code.should == 200
    end

    it "returns current user's subscriptions" do
      get :index, :format => :json
      response.body.should =~ /"Item 1"/m
    end
  end

end
