require 'spec_helper'

describe UsersController do
  fixtures :users

  before(:each) do
    @user = users(:users_001)
  end

    def valid_attributes
      {
       :email => "test@test.com",
       :password => "testing",
       :password_confirmation => "testing",
       :username => "tester",
       :full_name => "Test Tester",
       :zipcode => "23238",
       :sex => true
      }
    end

  describe "GET following" do
    it "returns is_following false" do
     sign_in @user
     get :following, :id => 99, :format => :json
     json = JSON.parse(response.body)
     json['is_following'].should == false
    end
  end

  describe "GET users" do
    it "returns status code of 200" do
      sign_in @user
      get :show, :format => :json, :id => @user.id
      response.should be_ok
    end

    it "returns a list of followee_ids" do
      sign_in @user
      get :show, :format => :json, :id => @user.id
      json = JSON.parse(response.body)
      json['user']['followees'].map(&:to_i).should =~ @user.followee_ids
      response.should be_ok
    end

    it "returns a list of item_ids" do
      sign_in @user
      get :show, :format => :json, :id => @user.id
      json = JSON.parse(response.body)
      json['user']['items'].should =~ @user.item_ids
      response.should be_ok
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        sign_in @user
        User.any_instance.should_receive(:update_attributes).with({"full_name" => "New Name"})
        put :update, :id => users(:users_001).id, :user => {:full_name => "New Name"}, :format => :json
      end

      it "returns status code of 200" do
        sign_in @user
        put :update, :id => users(:users_001).id, :user => {:full_name => "New Name", :zipcode => "23238", :sex => true}, :format => :json
        response.should be_ok
      end
    end

    describe "with invalid params" do
      it "returns status code of 406" do
        sign_in @user
        User.any_instance.stub(:save).and_return(false)
        put :update, :id => users(:users_001).id, :user => {}, :format => :json
        response.response_code.should == 406
      end
    end
  end

  describe "POST update" do
    describe "with valid params" do
      it "updates the requested user" do
        sign_in @user
        User.any_instance.should_receive(:update_attributes).with({"full_name" => "New Name"})
        post :update, :id => users(:users_001).id, :user => {:full_name => "New Name"}, :format => :json
      end

      it "returns status code of 200" do
        sign_in @user
        post :update, :id => users(:users_001).id, :user => {:full_name => "New Name", :zipcode => "23238", :sex => true}, :format => :json
        response.should be_ok
      end
    end

    describe "with invalid params" do
      it "returns status code of 406" do
        sign_in @user
        User.any_instance.stub(:save).and_return(false)
        post :update, :id => users(:users_001).id, :user => {}, :format => :json
        response.response_code.should == 406
      end
    end
  end
end
