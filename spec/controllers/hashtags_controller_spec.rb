require 'spec_helper'

describe HashtagsController do
  fixtures :hashtags,:hashtag_values,:users,:items,:posts

  before(:each) do
    sign_in users(:users_001)
  end
  
  describe "DELETE destroy" do
    it "deactivate the requested hashtag" do
      delete :destroy, :id => hashtags(:hashtags_001).id, :format => :json
      Hashtag.find(hashtags(:hashtags_001).id).status.should == 0
    end

    it "returns status code of 200" do
      delete :destroy, :id => hashtags(:hashtags_001).id, :format => :json
      response.response_code.should == 200
    end
    
    it "returns hashtag details" do
      delete :destroy, :id => hashtags(:hashtags_001).id, :format => :json
      JSON.parse(response.body)[:status] == 0
    end
  end

  describe "POST create" do
    it "returns status code of 201" do
      post :create, :hashtag_value => 'test tag', :item_id => items(:items_001).id, :format => :json
      response.response_code.should == 201
    end

    it "returns status code of 500" do
      @existing_hashtag_value = hashtag_values(:hashtag_values_001)
      post :create, :hashtag_value => @existing_hashtag_value.value , :item_id => items(:items_001).id, :format => :json
      response.response_code.should == 500
    end

    it "returns status code of 403 forbidden" do
      @post = items(:items_001).post
      @post.should_not be_nil
      @post.hashtags_allowed = false
      @post.save!
      post :create, :hashtag_value => 'test tag', :item_id => items(:items_001).id, :format => :json
      response.response_code.should == 403
    end
  end

end
