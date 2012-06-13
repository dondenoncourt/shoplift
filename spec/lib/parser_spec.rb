require 'spec_helper'
include Parser

describe 'Parse' do

  # TODO use mocking for html

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
