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
      response.body.should == "Hashtag successfully deleted"
    end
  end

end
