require 'spec_helper'

describe FollowersController do
  fixtures :users

  before do
    sign_in users(:users_002)
  end

  def valid_attributes
    { :user_id => 3 }
  end

  describe "GET index" do
    it "returns status code of 200" do
      get :index, valid_attributes
      response.response_code.should == 200
    end
  end

end
