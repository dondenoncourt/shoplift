require 'spec_helper'

describe FollowersController do
  fixtures :users, :subscriptions

  before(:each) do
    sign_in users(:users_002)
  end
  
  def valid_attributes
    {
      :user_id => 3
    }
  end  
  
  describe "GET index" do
    it "returns status code of 200" do
      get :index, :format => :json
      response.response_code.should == 200
    end
    
    it "returns current user's followers" do
      get :index, :format => :json
      response.body.should =~ /"id":1/m
    end
  end
  
  describe "GET show pending" do
    it "returns status code of 200" do
     get :show_pending, :id => subscriptions(:subscriptions_001).follower_id, :format => :json
      response.response_code.should == 200
    end
    
    it "returns user's pending followers" do
      get :show_pending, :id => subscriptions(:subscriptions_001).follower_id, :format => :json
      response.body.should =~ /"id":3/m
    end
  end
  
  describe "GET show" do
    it "returns status code of 200" do
     get :show, :id => subscriptions(:subscriptions_004).user_id, :format => :json
      response.response_code.should == 200
    end
    
    it "returns user's subscriptions" do
      get :show, :id => subscriptions(:subscriptions_004).user_id, :format => :json
      response.body.should =~ /"id":#{subscriptions(:subscriptions_004).follower_id}/m
    end
  end

  describe "PUT approve" do
    describe "with valid params" do
      it "creates a new Subscription" do
        post :approve, :user_id => valid_attributes[:user_id], :format => :json
        Subscription.find(subscriptions(:subscriptions_001).id).status.should == 1
      end

      it "returns status code of 201" do
        post :approve, :user_id => valid_attributes[:user_id], :format => :json
        response.response_code.should == 200
      end
      
      it "returns subscription details" do
        post :approve, :user_id => valid_attributes[:user_id], :format => :json
        response.body.should =~ /"id":#{valid_attributes[:user_id]}/m
      end
    end

    describe "with invalid params" do
      it "returns status code of 406" do
        Subscription.any_instance.stub(:save).and_return(false)
        post :approve, :user_id => {}, :format => :json
        response.response_code.should == 404
      end
      
      it "returns validation error" do
        post :approve, :user_id => {}, :format => :json
        response.body.should =~ /404 Not Found/m
      end
    end
  end

  describe "DELETE destroy" do
    it "deactivate the requested item" do
      delete :destroy, :id => subscriptions(:subscriptions_007).follower_id, :format => :json
      Subscription.find(subscriptions(:subscriptions_007).id).status.should == 0
    end

    it "returns status code of 200" do
      delete :destroy, :id => subscriptions(:subscriptions_007).follower_id, :format => :json
      response.response_code.should == 200
    end
    
    it "returns subscription details" do
      delete :destroy, :id => subscriptions(:subscriptions_007).follower_id, :format => :json
      response.body.should == "Follower successfully deleted"
    end
  end

end
