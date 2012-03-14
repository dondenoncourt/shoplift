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
       :username => "tester",
       :full_name => "Test Tester"
      }
    end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        sign_in @user
        expect {
          post :create, :user => valid_attributes, :format => :json
        }.to change(User, :count).by(1)
      end

      it "returns status code of 201" do
        sign_in @user
        post :create, :user => valid_attributes, :format => :json
        response.response_code.should == 201
      end
    end

    describe "with invalid params" do
      it "returns status code of 404" do
        sign_in @user
        User.any_instance.stub(:save).and_return(false)
        post :create, :user => {}, :format => :json
        response.response_code.should == 406
      end
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
        put :update, :id => users(:users_001).id, :user => {:full_name => "New Name"}, :format => :json
        response.response_code.should == 200
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
        post :update, :id => users(:users_001).id, :user => {:full_name => "New Name"}, :format => :json
        response.response_code.should == 200
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

  describe "DELETE destroy" do
    it "destroys the requested user" do
      sign_in @user
      delete :destroy, :id => users(:users_001).id, :format => :json
      User.find(users(:users_001).id).status.should == 0
    end

    it "returns status code of 200" do
      sign_in @user
      delete :destroy, :id => users(:users_001).id, :format => :json
      response.response_code.should == 200
    end
  end
  
  describe "POST destroy" do
    it "destroys the requested user" do
      sign_in @user
      post :destroy, :id => users(:users_001).id, :format => :json
      User.find(users(:users_001).id).status.should == 0
    end

    it "returns status code of 200" do
      sign_in @user
      post :destroy, :id => users(:users_001).id, :format => :json
      response.response_code.should == 200
    end
  end

end
