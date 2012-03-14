require 'spec_helper'

describe SubscriptionsController do
  fixtures :users, :subscriptions

  before(:each) do
    sign_in users(:users_002)
  end
  
  def valid_attributes
    {
      :user_id => 2
    }
  end  
  
  describe "GET index" do
    it "returns status code of 200" do
      get :index, :format => :json
      response.response_code.should == 200
    end
    
    it "returns current user's subscriptions" do
      get :index, :format => :json
      response.body.should =~ /"id":#{subscriptions(:subscriptions_004).user_id}/m
    end
  end
  
  describe "GET show" do
    it "returns status code of 200" do
     get :show, :id => subscriptions(:subscriptions_004).follower_id, :format => :json
      response.response_code.should == 200
    end
    
    it "returns user's subscriptions" do
      get :show, :id => subscriptions(:subscriptions_004).follower_id, :format => :json
      response.body.should =~ /"id":#{subscriptions(:subscriptions_004).user_id}/m
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Subscription" do
        expect {
          post :create, :user_id => valid_attributes[:user_id], :format => :json
        }.to change(Subscription, :count).by(1)
      end

      it "returns status code of 201" do
        post :create, :user_id => valid_attributes[:user_id], :format => :json
        response.response_code.should == 201
      end
      
      it "returns subscription details" do
        post :create, :user_id => valid_attributes[:user_id], :format => :json
        response.body.should =~ /"id":#{valid_attributes[:user_id]}/m
      end
    end
  end

  describe "DELETE destroy" do
    it "deactivate the requested item" do
      delete :destroy, :id => subscriptions(:subscriptions_004).user_id, :format => :json
      Subscription.find(subscriptions(:subscriptions_004).id).status.should == 0
    end

    it "returns status code of 200" do
      delete :destroy, :id => subscriptions(:subscriptions_004).user_id, :format => :json
      response.response_code.should == 200
    end
    
    it "returns subscription details" do
      delete :destroy, :id => subscriptions(:subscriptions_004).user_id, :format => :json
      response.body.should == "Subscription successfully deleted"
    end
  end

end
