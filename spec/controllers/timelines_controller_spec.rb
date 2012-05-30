require 'spec_helper'

describe TimelinesController do
  fixtures :items, :posts, :hashtags, :hashtag_values, :users

  before do
    @user = users(:users_001)
  end

  describe "GET index" do
    it "returns status code of 200" do
     sign_in @user
     get :index, :format => :json
      response.response_code.should == 200
    end

    it "returns recent items" do
      pending 'in progress'
      sign_in @user
      get :index, :format => :json
      response.body.should =~ /"id":#{Item.find_by_user_id(@user.id).id}/m
    end

    it "does not return private item user" do
     sign_in users(:users_002)
     get :index, :format => :json
      response.body.should_not =~ /"username":"#{users(:users_003).username}"/m
    end

    describe "with above and below parameters" do
      it "returns only item ids in given range" do
       sign_in @user
       get :index, :above => 1, :below => 6, :format => :json
        response.body.should_not =~ /"id":#{items(:items_007).id},"name":"#{posts(:posts_004).name}"/m
      end

      describe "when only above parameter is passed" do
        it "returns status code of 406" do
          pending
          sign_in @user
          get :index, :above => 1, :format => :json
          response.response_code.should == 406
        end

        it "returns " do
          pending
          sign_in @user
          get :index, :above => 1, :format => :json
          response.body.should == "406 A below value is required if above is set"
        end
      end

      describe "when only below parameter is passed" do
        it "returns status code of 406" do
          pending
          sign_in @user
          get :index, :below => 1, :format => :json
          response.response_code.should == 406
        end

        it "returns " do
          pending
          sign_in @user
          get :index, :below => 1, :format => :json
          response.body.should == "406 An above value is required if below is set"
        end
      end
    end
  end

  describe "GET show_user" do
    it "returns status code of 200" do
     get :show_user, :id => @user.id, :format => :json
      response.response_code.should == 200
    end

    it "returns recent items" do
      get :show_user, :id => @user.id, :format => :json
      response.body.should =~ /"id":#{Item.find_by_user_id(@user.id).id}/m
    end
  end

  describe "GET show_recent" do
    it "returns status code of 200" do
     get :show_recent, :format => :json
      response.response_code.should == 200
    end

    it "returns recent items" do
      get :show_recent, :format => :json
      response.body.should =~ /"id":#{Item.find_by_user_id(@user.id).id}/m
    end

    it "should not display private item user" do
     get :show_recent, :format => :json
      response.body.should_not =~ /"username":"#{users(:users_003).username}"/m
    end
  end

  describe "GET show_hashtags" do
    it "returns status code of 200" do
     get :show_hashtags, :name => hashtag_values(:hashtag_values_001).value, :format => :json
      response.response_code.should == 200
    end

    it "returns recent items" do
      get :show_hashtags, :name => hashtag_values(:hashtag_values_001).value, :format => :json
      response.body.should =~ /"value":"#{hashtag_values(:hashtag_values_001).value}"/m
    end
  end

end
