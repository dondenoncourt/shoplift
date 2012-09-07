require 'spec_helper'
require 'fakeweb'
include Parser
include FakePage

FakeWeb.register_uri(:get, "http://www.kettlerusa.com/fitness/exercise-bikes/2761", :body => getRace(), :content_type => "text/html")
FakeWeb.register_uri(:get, "http://bags.bcoutlet.com/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439", :body => getBcOutlet(), :content_type => "text/html")
# fake web has issues with the real url of: http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap?ID=596838&CategoryID=17367#fn=spp%3D1%26ppp%3D96%26sp%3D1%26rid%3D19^
FakeWeb.register_uri(:get, "http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap", :body => getBloomingdales(), :content_type => "text/html")

describe 'Parse' do

  describe " on Kettler " do
    it "returns a " do
      post = parse 'http://www.kettlerusa.com/fitness/exercise-bikes/2761'
      post[:retailer].should match(/www.kettlerusa.com/)
    end
  end

  describe "on kettler" do
    it "returns a price of $1,499" do
      post = parse 'http://www.kettlerusa.com/fitness/exercise-bikes/2761'
      post[:price].should == 1499
    end
  end

  describe "on bcoutlet" do
    it "returns a price of $89" do
      post = parse 'http://bags.bcoutlet.com/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439'
      post[:price].should == 89
    end
  end

  describe "on bloomingdales" do
    it "returns a price of $235.99" do
      post = parse 'http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap'
      puts post[:price]
      post[:price].should == 115.15
    end
  end

end
