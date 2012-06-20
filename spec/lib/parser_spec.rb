require 'spec_helper'
require 'fakeweb'
include Parser
include FakePage

FakeWeb.register_uri(:get, "http://www.kettlerusa.com/fitness/exercise-bikes/2761", :body => getRace(), :content_type => "text/html")

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

end
