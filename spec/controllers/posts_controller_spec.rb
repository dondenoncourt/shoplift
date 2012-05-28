require 'spec_helper'

describe PostsController do
  fixtures :users

  before do
    sign_in users(:users_001)
  end

  describe "GET new" do
    it "returns status code of 200" do
      get :new
      response.response_code.should == 200
    end
  end
end