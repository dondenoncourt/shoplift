include Parser
module ParserAudit

  # if the user overrode and values returned from parser
  # attempt to retrieve and save the xpath and regex to retrieve those values
  # Notes:
  #  a new post was already created so, in the update/changed, then we 
  #  can get the changed parameters (try dirty object rails method)
  #  http://archives.ryandaigle.com/articles/2008/3/31/what-s-new-in-edge-rails-dirty-objects
  # delayed jobs??? gem 
  #   set up a worker task 
  #   has its own database table
  #   would not need a web request
  # would save "learned" results on a site (or even more detailed)
  #
  # Add log for issues for humans to review
  #   one area of concern is user changing when there already is "learned" data
  #   mispellings 
  #
  # Alfie: only add if the parser returns a blank!
  #
  # handle brand being in the prefix of the item name
  #     if brand changed and the new brand is in the item name, add a regex?
  # "scoring" points on a page (above the fold)
  # h1 has more weight than h3
  # text in a hyper-link -- for google
  # span with and id
  # use font sizes or bold, is the included css file info available?
  #
  # if the brand is in the post.itemName or the xml item name has the brand in it
  #    then use the brand prefix in the item name from the xml
  # brand node weights:
  # h1|h2|h3 has only brand
  # h1|h2|h3 starts-with brand and contains item name
  # h1|h2|h3 starts-with brand
  # h1|h2|h3|span only brand
  #
  #
  def parser_audit(post)
puts "parser_audit(post) with "+post.to_s
    xpaths = Hash.new
    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Mozilla'
    begin
      agent.get(post[:url]) do |page|
        if post[:brand]
          xpath = get_brand_xpath(page, post)
          xpaths[:brand] = xpath if xpath
        end
        if post[:price]
          xpath = get_price_xpath(page, post)
          xpaths[:price] = xpath if xpath
        end

      end
    rescue => ex
      puts ex.message
      puts ex.backtrace
    end
    xpaths

  end

  private

  def get_price_xpath(page, post)
    %w{h1 span}.each do |tag|
      node = page.parser.xpath("//#{tag}[text()='$#{post[:price]}']")
      puts "#{node} = page.parser.xpath(\"//#{tag}[text()='$#{post[:price]}']\")"
      if node.blank? || node.length > 1
        node = page.parser.xpath("//#{tag}[contains(text(), '#{post[:price]}')]")
        puts "#{node} = page.parser.xpath(\"//#{tag}[contains(), '#{post[:price]}']\")"
      end
      if !node.blank? && node.length == 1
        printNode(node)
        return buildXpath(node[0])
      end
    end

  end

  def get_brand_xpath(page, post)
    node = tag_has_only_brand(page, %w{h1 h2 h3 span}, post[:brand])
    return buildXpath(node[0]) if node

    node = tag_starts_with_brand_contains_name(page, %w{h1 h2 h3 span}, post[:brand], post[:name])
    return buildXpath(node[0]) if node

    node = tag_starts_with_brand(page, %w{h1 h2 h3 span}, post[:brand])
    return buildXpath(node[0]) if node

    node = tag_contains_brand(page, %w{h1 h2 h3 span}, post[:brand])
    return buildXpath(node[0]) if node

    node = text_nodes_for_brand(page, post[:brand])
    return buildXpath(node[0]) if node
    nil
  end

  def printNode(node)
    if !node.blank?
      puts ("     found #{node.length.to_s}:")
      puts ('     '+node.to_s.gsub(/\s\s/, ' '))
    end
  end

  def buildXpath(node)
    xpath = "//#{node.name}"
    if node.attributes.length > 0
      xpath += '['
      node.attributes.each_with_index do |(attr,value), idx| 
        xpath += " and " if idx > 0
        xpath += "@#{attr}='#{value}'"
      end
      xpath += ']'
    end
    xpath
  end

  def regex(page, str) 
    page.body.match /#{str}/
  end

  def tag_has_only_brand(page, tags, brand)
    tags.each do |tag|
      node = page.parser.xpath("//#{tag}[translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = '#{brand.downcase}']")
      if !node.blank? && node.length == 1
        printNode(node)
        return node
      end
    end
    nil
  end
  
  def tag_starts_with_brand(page, tags, brand)
    tags.each do |tag|
      node = page.parser.xpath("//#{tag}[starts-with(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{brand.downcase}')]")
      if !node.blank? && node.length == 1
        printNode(node)
        return node
      end
    end
    nil
  end
  
  def tag_contains_brand(page, tags, brand)
    tags.each do |tag|
      node = page.parser.xpath("//#{tag}[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{brand.downcase}')]")
      if !node.blank? && node.length == 1
        printNode(node)
        return node
      end
    end
    nil
  end
  
  def tag_starts_with_brand_contains_name(page, tags, brand, name)
    %w{h1 h2 h3 span}.each do |tag|
      node = page.parser.xpath("//#{tag}[starts-with(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{brand.downcase}')]")
      if !node.blank?
        node = page.parser.xpath("//#{tag}[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),\""+name.downcase+"\")]")
        if !node.blank? && node.length == 1
          printNode(node)
          return node
        end
      end
    end
    nil
  end

  def text_nodes_for_brand(page, brand)
    begin
      node = page.parser.xpath("//*[translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = '#{brand.downcase}']")
      return node if !node.blank? && node.length == 1
    rescue
      puts "       Note: could not translate text to lowercase, using standard case sensitive xpath..."
      page.parser.xpath("//*[text()='#{brand.downcase}']")
    end
  end

  # http://stackoverflow.com/questions/2279513/how-can-i-create-a-nokogiri-case-insensitive-xpath-selector
  def case_insensitive_equals(node_set, str_to_match)
    node_set.find_all {|node| node.to_s.downcase == str_to_match.to_s.downcase }
  end

  # top retailer clothing sites:
  # http://www.fashionbug.com/
  # http://www.redoute.com/
  # http://www.oldnavy.com/
  # http://www.bcoutlet.com/
  # http://www.getheavenly.com/
  # http://www.spiegel.com/
  # http://www.modcloth.com/
  # http://www.nyandcompany.com/
  # http://www.wetseal.com/
  # http://www.urbanladiesoutfits.com/

  def run_some()
    @sites = [
      {brand: 'Tignanello', name: 'Multi Pocket Organizer Crossbody', url: 'http://bags.bcoutlet.com/product/tignanello/multi-pocket-organizer-crossbody/130799/p/1338439'},
      {brand: 'Russell Athletic', name: "Men's Crew Neck T-Shirt", url: 'http://www.sears.com/russell-athletic-men-s-crew-neck-t-shirt/p-043M6725000P?prdNo=2&blockNo=2&blockType=G2'},
      {brand: 'miss me jeans', name: "Miss Me Jeans Fleur-de-Lis Bermuda Denim Shorts", url:'http://www.dillards.com/product/Miss-Me-Jeans-FleurdeLis-Bermuda-Denim-Shorts_301_-1_301_503199762'},
      {brand: 'Theodora & Callum', name:'Primaballet with Ankle Strap', url:'http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap?ID=596838&CategoryID=17367#fn=spp%3D1%26ppp%3D96%26sp%3D1%26rid%3D19'}
      #'http://fashionbug.lanebryant.com/shoes/boots/13833c5116/index.cat?intid=LPxSH060312xL4',
      #'http://oldnavy.gap.com/browse/product.do?cid=82576&vid=1&pid=106420',
      #'http://www.getheavenly.com/Co-Sheer-Stroke-Blouse-Orange/dp/B0074W34SC',
      #'http://www.spiegel.com/long-asymmetrical-dress.html',
      #'http://www.modcloth.com/shop/blouses/coach-tour-top-in-sand'

    ]
    xpaths = Hash.new
    @sites.each do |post|
      p post
      hash = parser_audit(post)
      hash.each do |retailer, xpath|
        xpaths[retailer] = xpath
      end
    end
    puts "List all URLs and their brand xpaths"
    xpaths.each do |retailer, xpath|
      puts "url: #{retailer} xpath: #{xpath}"
    end
    #reparse the sites using the xpaths
    # and figure out how to get the darn brand out of the returned nodes?
    # database should flag full match
    # otherwise search in string for substring that is in the brand database
    #  but how to do that, and effectively...
    #  figure all text starts with domain
    #  use first word to get a list from the domain database
    #  then check each returned brand name with the xml text
    #  once there's a hit, we got our domain????
    #  or we could find_all that match two words/nodes from the xml until we no longer get rows
    @sites.each do |post|
      retailer = post[:url].split('/')[2]
      agent = Mechanize.new
      agent.user_agent_alias = 'Windows Mozilla'
      begin
        agent.get(post[:url]) do |page|
          node = page.parser.xpath(xpaths[retailer])
          puts node
          brand = find_brand(node)
          puts ">>>>>>>>>>found one"+brand.name if brand
        end
      rescue => ex
        puts ex.message
        puts ex.backtrace
      end
    end
  end

end
