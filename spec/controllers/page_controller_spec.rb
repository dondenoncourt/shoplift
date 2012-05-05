require 'spec_helper'

describe PageController do
  fixtures :users

  before(:each) do
    sign_in users(:users_001)
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

end
