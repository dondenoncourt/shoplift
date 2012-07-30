require 'spec_helper'
include Parser
include ParserAudit

describe 'Visit various retail sites:' do


  # empty xpaths table
  # parse(url)
  #   check response (which doesn't matter too much)
  # parse_audit() passing hard-coded changes
  #   check xpaths added rows
  # re-run parse(url)
  #   check brand, name, price
  describe "parser" do
    sites = File.open("spec/fixtures/retail_sites.yml", "r") {|f| YAML.load(f)}
    it "should learn" do
      Brand.all.collect{|x| x.delete}
      Brand.count.should == 0
      sites.each_with_index do |(site, attr), index|
        puts "#{index.to_s} #{attr['retailer']}"
        brand = Brand.find_or_create_by_name(attr['brand'])
        Brand.find_by_name(attr['brand']).name.should == attr['brand']
        post_params = parse(attr['page'])
        audit_params = {retailer: attr['retailer'], url: attr['page'], brand: attr['brand'], name: attr['page'], price: attr['price']}
        parser_audit(audit_params)
        #Xpath.count.should == 1
        post_params = parse(attr['page'])
        #post_params.delete(:images) # post_controller does this because the javascript then does it
        #p post_params
        post_params[:brand].downcase.should == attr['brand'].downcase
        "$#{post_params[:price]}".gsub(/0*$/, '').should == attr['price'].gsub(/0*$/,'')
      end
    end
  end


end
