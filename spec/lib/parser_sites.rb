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
    sites = File.open("spec/lib/retail_sites.yml", "r") {|f| YAML.load(f)}
    it "should learn" do
      Brand.all.collect{|x| x.delete}
      Brand.count.should == 0
      sites.each do |site, attr|
        retailer = attr['page'].split('/')[2]
        puts retailer
        brand = Brand.find_or_create_by_name(attr['brand'])
        Brand.find_by_name(attr['brand']).name.should == attr['brand']
        post_params = parse(attr['page'])
        audit_params = {retailer: retailer, url: attr['page'], brand: attr['brand'], name: attr['page'], price: attr['price']}
        parser_audit(audit_params)
        if attr['brand_xpath']
          puts " hard-coded brand_xpath"
          xpath = Xpath.find_or_create_by_retailer(retailer)
          xpath.brand = attr['brand_xpath']
          xpath.save!
        end
        post_params = parse(attr['page'])
        #post_params.delete(:images) # post_controller does this because the javascript then does it
        #p post_params
        #puts "$"+post_params[:price].to_s.gsub(/0*$/, '')+".should == "+attr['price'].gsub(/0*$/,'')
        #post_params[:price].to_s.gsub(/0*$/, '').should == attr['price'].gsub(/0*$/,'').gsub(/[$,]/,'')
        post_params[:price].to_s.should == BigDecimal.new(attr['price'].gsub(/[$,]/,'')).to_s
      end
    end
  end


end
