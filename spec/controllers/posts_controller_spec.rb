require 'spec_helper'
require 'fakeweb'
include Parser
include FakePage

FakeWeb.register_uri(:get, "http://bags.bcoutlet.com/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439", :body => getBcOutlet(), :content_type => "text/html")
# fake web has issues with the real url of: http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap?ID=596838&CategoryID=17367#fn=spp%3D1%26ppp%3D96%26sp%3D1%26rid%3D19^
FakeWeb.register_uri(:get, "http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap", :body => getBloomingdales(), :content_type => "text/html")

describe PostsController do
  fixtures :users

  before do
    @user = users(:users_001)
    sign_in @user
  end

  describe "POST create" do
    it "returns new post with retailer of bloomingdales" do
      post :create, {url:'http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap'}
      response.should have_selector('input#post_brand', :value => "Bloomingdale's")
    end
  end

  describe "POST create" do
    it "returns status code of 200" do
      post :create, {url:'http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap'}
      response.response_code.should == 200
    end
  end

  describe "POST update for bloomingdales" do
    it "creates a new xpath" do
      post :create, {url:'http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap'}
      xpathCount = Xpath.count
      @post = Post.first(:order => 'id DESC')
      post :update, {id: @post.id, parser_brand: '', parser_price: '123.45', 
                    post:{id: @post.id,
                          retailer: 'www1.bloomingdales.com',
                          brand:'Theodora & Callum Flats', name: 'Primaballet with Ankle Strap',
                          price: '164.50',
                          url:'http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap'
                         }
                    }
      xpathCount.should < Xpath.count
      Xpath.first().brand.should == "//h1"
      Xpath.first().price.should == "//span[@class='priceBig']"
    end
  end

end
