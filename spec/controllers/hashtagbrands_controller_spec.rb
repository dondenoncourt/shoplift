require 'spec_helper'

describe HashtagbrandsController do
  fixtures :hashtags,:hashtag_values,:users,:items,:posts, :hashtagbrands

  before(:each) do
    @user = users(:users_001)
    sign_in @user
  end

  describe "GET index" do
    it "returns status code of 416" do
      sign_in @user
      get :index, :format => :json
      response.response_code.should == 416
    end

    it "returns status code of 200" do
      sign_in @user
      get :index, :ids => ['1','2','5'], :format => :json
      response.response_code.should == 200
    end

    it "returns 3 hashtagbrands" do
      sign_in @user
      get :index, :ids => ['1','2','5'], :format => :json
      json = JSON.parse(response.body)
      json['hashtagbrands'].size.should == 3
    end

    it "returns a brand in index 3 and a hashtag in index 2" do
      sign_in @user
      get :index, :ids => ['1','2','5'], :format => :json
      json = JSON.parse(response.body)
      json['hashtagbrands'][2]['value'].should == 'Lorem ipsum dolor'
      json['hashtagbrands'][1]['value'].should == 'polo'
    end

  end

  describe "GET show" do
    it "returns status code of 200" do
      sign_in @user
      get :show, :id => 1, :format => :json
      response.response_code.should == 200
    end

    it "returns jeans" do
      sign_in @user
      get :show, :id => 1, :format => :json
      json = JSON.parse(response.body)
      json['hashtagbrand']['value'].should == 'jeans'
    end
  end

  describe "GET search" do
    it "returns status code of 200" do
      sign_in @user
      get :search, :query => 'jeans', :format => :json
      response.response_code.should == 200
    end

    it "returns a hashtagbrand id of 1" do
      sign_in @user
      get :search, :query => 'jeans', :format => :json
      json = JSON.parse(response.body)
      json['hashtagbrands'][0]['hashtag_value_id'].should == 1
    end
  end

  describe "GET related" do
    it "returns status code of 200" do
      sign_in @user
      get :related, :id => 1, :format => :json
      response.response_code.should == 200
    end

    it "returns a hashtagbrand id of 5 for a brand" do
      sign_in @user
      get :related, :id => 1, :format => :json
      json = JSON.parse(response.body)
      json['hashtagbrands'][0]['id'].should == 5
      json['hashtagbrands'][0]['value'].should == 'Lorem ipsum dolor'
    end
  end

end
