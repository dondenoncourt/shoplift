require 'spec_helper'

describe FlagsController do
  fixtures :users, :post_flags
  
  before(:each) do
    sign_in users(:users_001)
  end
  
  describe "GET index" do
    it "returns status code of 200" do
      get :index, :format => :json
      response.response_code.should == 200
    end

    it "returns flag of current user" do
      get :index, :format => :json
      response.body.should =~ /"name":"Item 1"/m
    end
  end
  
  describe "POST create_item" do
    it "returns status code of 201" do
      post :create_item, :format => :json, :flag_type_id => 2, :id => 1
      response.response_code.should == 201
    end
  
    it "returns flag of current user" do
      post :create_item, :format => :json, :flag_type_id => 2, :id => 1
      response.body.should =~ /"id":1/m
    end
    
    it "creates a new PostFlag" do
      expect {
        post :create_item, :format => :json, :flag_type_id => 2, :id => 1
      }.to change(PostFlag, :count).by(1)
    end
  end
  
  describe "POST create_hashtag" do
    it "returns status code of 201" do
      post :create_hashtag, :format => :json, :flag_type_id => 2, :id => 2
      response.response_code.should == 201
    end
  
    it "returns flag of current user" do
      get :create_hashtag, :format => :json, :flag_type_id => 2, :id => 2
      response.body.should =~ /"id":2/m
    end
    
    it "creates a new HashtagFlag" do
      expect {
        post :create_hashtag, :format => :json, :flag_type_id => 2, :id => 2
      }.to change(HashtagFlag, :count).by(1)
    end
  end  
end  
