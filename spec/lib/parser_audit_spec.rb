require 'spec_helper'
require 'fakeweb'
include ParserAudit
include FakePage

FakeWeb.register_uri(:get, "http://www.kettlerusa.com/fitness/exercise-bikes/2761", :body => getRace(), :content_type => "text/html")
FakeWeb.register_uri(:get, "http://bags.bcoutlet.com/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439", :body => getBcOutlet(), :content_type => "text/html")
FakeWeb.register_uri(:get, "http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap?ID=596838&CategoryID=17367#fn=spp%3D1%26ppp%3D96%26sp%3D1%26rid%3D19", :body => getBloomingdales(), :content_type => "text/html")

describe 'Parser_Audit' do

  describe "on kettler" do
    it "returns xpath" do
      response = parser_audit({url: 'http://www.kettlerusa.com/fitness/exercise-bikes/2761',
                              brand: 'kettler',
                              name: 'race'})
      response.should == {}
    end
  end

  describe "on bcoutlet.com" do
    it "returns xpath" do
      response = parser_audit(
        {brand: 'Tignanello', 
         name: 'Multi Pocket Organizer Crossbody', 
         url: 'http://bags.bcoutlet.com/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439'
        }
      )
      response.should == {"bags.bcoutlet.com"=>"//span[@class='ebagsBrand']"}
    end
  end

  describe "on bloomingdales.com" do
    it "returns xpath" do
      response = parser_audit(
          {brand: 'Theodora & Callum', 
           name:'Primaballet with Ankle Strap', 
           url:'http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap?ID=596838&CategoryID=17367#fn=spp%3D1%26ppp%3D96%26sp%3D1%26rid%3D19'}
      )
      response.should == {"www1.bloomingdales.com"=>"//h1"}
    end
  end

end
