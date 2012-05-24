require 'spec_helper'

describe ItemsController do
  fixtures :items, :posts, :hashtags, :hashtag_values, :users
  
  before(:each) do
    @user = users(:users_001)
  end
  
  def valid_attributes
    {
      :user_id => 1,
      :name => "Item 1",
      :description => "Lorem ipsum dolor sit amet, aliquet feugiat. 
                       Convallis morbi fringilla gravida, phasellus  
                       velit nunc, pulvinar eget sollicitudin.",
      :brand => "Lorem ipsum dolor sit amet",
      :retailer => "Lorem ipsum dolor sit amet",
      :url => "http://www.jcrew.com/index.jsp",
      :price => "1.1",
      :comment => nil,
      :photo => File.new("#{Rails.root}/spec/fixtures/product-large-dress.jpg"),
      :hashtags_allowed => true,
      :hashtags => {
        "1" => {
          :id => 1,
          :value => "jeans"
        },
        "2" => {
          :id => 2,
          :value => "polo"
        }
      }
    }
  end
  
  def valid_attributes_string
    item = ""
    valid_attributes.each do |k,v|
      item << "\"#{k}\" => #{v},"
    end
    return item
  end
  
  describe "GET show" do
    describe "for public user without login" do
      it "returns status code of 200" do
        get :show, :id => items(:items_001).id, :format => :json
        response.response_code.should == 200
      end
      
      it "returns item's details" do
        get :show, :id => items(:items_001).id, :format => :json
        response.body.should =~ /"id":#{items(:items_001).id}/m
      end
    end
    
    describe "for private user with valid login" do
      it "returns status code of 200" do
        sign_in @user
        get :show, :id => items(:items_003).id, :format => :json
        response.response_code.should == 200
      end
      
      it "returns item's details" do
        sign_in @user
        get :show, :id => items(:items_003).id, :format => :json
        response.body.should =~ /"id":#{items(:items_003).id}/m
      end
    end
    
    describe "for private user without valid login" do
      it "returns status code of 404" do
        sign_in users(:users_002)
        get :show, :id => items(:items_003).id, :format => :json
        response.response_code.should == 404
      end
      
      it "returns item not found" do
        sign_in users(:users_002)
        get :show, :id => items(:items_003).id, :format => :json
        response.body.should == "404 Item not found"
      end
    end
    
    describe "for public inactive user without login" do
      it "returns status code of 404" do
        get :show, :id => items(:items_012).id, :format => :json
        response.response_code.should == 404
      end
      
      it "returns item not found" do
        sign_in users(:users_002)
        get :show, :id => items(:items_012).id, :format => :json
        response.body.should == "404 Not Found"
      end
    end
    
    describe "for private user without login" do
      it "returns status code of 401" do
        get :show, :id => items(:items_003).id, :format => :json
        response.response_code.should == 401
      end
    end
  end
  
  describe "GET visit" do
    describe "for public user without login" do
      it "returns status code of 200" do
        get :visit, :id => items(:items_001).id, :format => :json
        response.response_code.should == 200
      end
      
      it "returns item's url" do
        get :visit, :id => items(:items_001).id, :format => :json
        response.body.should == "#{items(:items_001).post.url}"
      end
    end
    
    describe "for private user with valid login" do
      it "returns status code of 200" do
        sign_in @user
        get :visit, :id => items(:items_003).id, :format => :json
        response.response_code.should == 200
      end
      
      it "returns item's url" do
        sign_in @user
        get :visit, :id => items(:items_003).id, :format => :json
        response.body.should == "#{items(:items_003).post.url}"
      end
    end
    
    describe "for private user without valid login" do
      it "returns status code of 404" do
        sign_in users(:users_002)
        get :visit, :id => items(:items_003).id, :format => :json
        response.response_code.should == 404
      end
      
      it "returns item not found" do
        sign_in users(:users_002)
        get :visit, :id => items(:items_003).id, :format => :json
        response.body.should == "404 Item not found"
      end
    end
    
    describe "for public inactive user without login" do
      it "returns status code of 404" do
        get :visit, :id => items(:items_012).id, :format => :json
        response.response_code.should == 404
      end
      
      it "returns item not found" do
        get :visit, :id => items(:items_012).id, :format => :json
        response.body.should == "404 Not Found"
      end
    end
    
    describe "for private user without login" do
      it "returns status code of 401" do
        get :show, :id => items(:items_003).id, :format => :json
        response.response_code.should == 401
      end
    end
  end
  
  describe "POST create" do
    
    describe "with valid params" do
      it "creates a new Item" do
        sign_in @user
        expect {
          post :create, :item => valid_attributes, :format => :json
        }.to change(Item, :count).by(1)
      end

      it "returns status code of 201" do
        sign_in @user
        post :create, :item => valid_attributes, :format => :json
        response.response_code.should == 201
      end
      
      it "returns item's details" do
        sign_in @user
        post :create, :item => valid_attributes, :format => :json
        response.body.should =~ /"price":"#{valid_attributes[:price]}"/m
      end
      
    end

    describe "with invalid params" do
      it "returns status code of 406" do
        sign_in @user
        Item.any_instance.stub(:save).and_return(false)
        post :create, :item => {}, :format => :json
        response.response_code.should == 406
      end
      
      it "returns validation error" do
        sign_in @user
        post :create, :item => {}, :format => :json
        response.body.should =~ /Name can't be blank/m
      end
    end
    
    describe "with invalid login" do
      it "returns status code of 401" do
        Item.any_instance.stub(:save).and_return(false)
        post :create, :item => {}, :format => :json
        response.response_code.should == 401
      end
    end
  end
  
  describe "POST relift" do
    it "returns status code of 201" do
      sign_in @user
      post :relift, :id => items(:items_003).id, :format => :json
      response.response_code.should == 201
    end
    
    it "returns item's details" do
      sign_in @user
      post :relift, :id => items(:items_003).id, :format => :json
      response.body.should =~ /"relift":/m
    end
      
  end

  describe "PUT update" do
    describe "with valid params" do
      it "returns status code of 200" do
        sign_in @user
        put :update, :id => items(:items_001).id, :item => valid_attributes, :format => :json
        response.response_code.should == 200
      end
      
      it "returns item's details" do
        sign_in @user
        put :update, :id => items(:items_001).id, :item => valid_attributes, :format => :json
        response.body.should =~ /"price":"#{valid_attributes[:price]}"/m
      end
    end

    describe "with invalid params" do
      it "returns status code of 406" do
        sign_in @user
        Item.any_instance.stub(:save).and_return(false)
        put :update, :id => items(:items_001).id, :item => {}, :format => :json
        response.response_code.should == 406
      end
      
      it "returns validation error" do
        sign_in @user
        put :update, :id => items(:items_001).id, :item => {}, :format => :json
        response.body.should =~ /Failed to update item/m
      end
    end
  end
  
  describe "POST update" do
    describe "with valid params" do
      it "returns status code of 200" do
        sign_in @user
        post :update, :id => items(:items_001).id, :item => valid_attributes, :format => :json
        response.response_code.should == 200
      end
      
      it "returns item's details" do
        sign_in @user
        post :update, :id => items(:items_001).id, :item => valid_attributes, :format => :json
        response.body.should =~ /"price":"#{valid_attributes[:price]}"/m
      end
    end

    describe "with invalid params" do
      it "returns status code of 406" do
        sign_in @user
        Item.any_instance.stub(:save).and_return(false)
        post :update, :id => items(:items_001).id, :item => {}, :format => :json
        response.response_code.should == 406
      end
      
      it "returns validation error" do
        sign_in @user
        post :update, :id => items(:items_001).id, :item => {}, :format => :json
        response.body.should =~ /Failed to update item/m
      end
    end
  end

  describe "DELETE destroy" do
    it "deactivate the requested item" do
      sign_in @user
      delete :destroy, :id => items(:items_001).id, :format => :json
      Item.find(items(:items_001).id).status.should == 0
    end
    
     it "deactivate the requested post" do
      sign_in @user
      delete :destroy, :id => items(:items_001).id, :format => :json
      #Item.find(items(:items_001).id).post.blank?.should == false
      # denoncourt: it seems to me this is correct....
      Item.find(items(:items_001).id).post.blank?.should == true
    end

    it "returns status code of 200" do
      sign_in @user
      post :destroy, :id => items(:items_001).id, :format => :json
      response.response_code.should == 200
    end
    
    it "returns item details" do
      sign_in @user
      post :destroy, :id => items(:items_001).id, :format => :json
      response.body.should == "Item successfully deleted"
    end
  end

end
