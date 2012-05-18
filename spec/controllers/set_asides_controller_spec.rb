require 'spec_helper'

describe SetAsidesController do
  fixtures :users, :subscriptions, :items, :posts, :hashtags, :hashtag_values, :set_asides

  before(:each) do
    sign_in users(:users_001)
  end
  
  describe "GET index" do
    it "returns status code of 200" do
      get :index, :format => :json
      response.response_code.should == 200
    end
    
    it "returns current user's set asides" do
      get :index, :format => :json
      response.body.should =~ /"id":#{set_asides(:set_asides_001).item_id}/m
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new set aside" do
        expect {
          post :create, :item_id => 3, :format => :json
        }.to change(SetAside, :count).by(1)
      end

      it "returns status code of 201" do
        post :create, :item_id => 3, :format => :json
        response.response_code.should == 201
      end
      
      it "returns set aside details" do
        post :create, :item_id => 3, :format => :json
        response.body.should =~ /"id":3/m
      end
    end
  end

  describe "DELETE destroy" do
    it "deactivate the requested item" do
      delete :destroy, :id => set_asides(:set_asides_001).item_id, :format => :json
      @set_aside = set_asides(:set_asides_001)
      @se_aside.should == nil
    end

    it "returns status code of 200" do
      delete :destroy, :id => set_asides(:set_asides_001).item_id, :format => :json
      response.response_code.should == 200
    end
    
    it "returns subscription details" do
      delete :destroy, :id => set_asides(:set_asides_001).item_id, :format => :json
      response.response_code.should == 200
      #response.body.should == "Set aside successfully deleted"
    end
  end

end
