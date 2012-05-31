require 'spec_helper'

describe CategoriesController do
  fixtures :users

  before do
    sign_in users(:users_001)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
