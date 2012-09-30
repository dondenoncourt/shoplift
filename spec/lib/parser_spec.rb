require 'spec_helper'
require 'fakeweb'
include FakePage

FakeWeb.register_uri(:get, "http://www.kettlerusa.com/fitness/exercise-bikes/2761", :body => getRace(), :content_type => "text/html")
FakeWeb.register_uri(:get, "http://bags.bcoutlet.com/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439", :body => getBcOutlet(), :content_type => "text/html")
# fake web has issues with the real url of: http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap?ID=596838&CategoryID=17367#fn=spp%3D1%26ppp%3D96%26sp%3D1%26rid%3D19^
FakeWeb.register_uri(:get, "http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap", :body => getBloomingdales(), :content_type => "text/html")

describe 'Parse' do

  let(:parsed) do
    Parser.parse(url)
  end

  subject { parsed }

  describe " on Kettler " do
    let(:url) { 'http://www.kettlerusa.com/fitness/exercise-bikes/2761' }

    its([:retailer]) { should match(/www.kettlerusa.com/) }
    its([:price])    { should == 1499 }
  end

  describe "on bcoutlet" do
    let(:url) do
      'http://bags.bcoutlet.com/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439'
    end

    its([:price]) { should == 89 }
    its([:price]) { should == 115.15 }
  end
end
