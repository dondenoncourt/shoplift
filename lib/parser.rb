module Parser

  OPEN_GRAPH = {
    name: 'og:title',
    image: 'og:image',
    brand: 'og:site_name',
    description: 'og:description',
    url: 'og:url'
  }

  # known elements from sites like:
  # Amazon, eBay, Nordstroms, Macys, J. Crew, Abercrombie, ThinkGeek, Overstock, Zappos
  # these can later be replaced by 'learned' elements stored elsewhere
  BRAND_IDENTIFIERS = %w(.brandLink .header-logo #logo .brand )
  ITEM_IDENTIFIERS = %w(.product-name h1 h2 #btAsinTitle)
  PRICE_IDENTIFIERS = %w(#actualPriceValue .priceLarge .select-sale-single .price-single .priceSale .offer-price .cat-glo-tex-saleP .cat-pro-price .price)

  # TODO maybe...
  # some things from removed parsing in bookmarklet.js.erb
  #
  #// See if we have a price in the description or title
  #// Grab the title from meta tag if not already set
  #// Grab description from meta tag if not set already
  #// Use the referrer for url
  # I'm thinking for brand, if none is found, maybe the retailer is the brand?

  # bookmarklet.js.erb still has parsing for keywords/tags that ought to be in here...
  def parse(url)
    agent = Mechanize.new
    #agent.user_agent_alias = 'Windows Mozilla'
    begin
      agent.get(url) do |page|
        images = []
        # try Open Graph first
        images << page.search("//meta[@property='#{OPEN_GRAPH[:image]}']/@content").map(&:value)
        name = page.search("//meta[@property='#{OPEN_GRAPH[:name]}']/@content")
        brand = page.search("//meta[@property='#{OPEN_GRAPH[:brand]}']/@content")
        description = page.search("//meta[@property='#{OPEN_GRAPH[:description]}']/@content")
        # the passed URL is what I think we need...
        #url = page.search("//meta[@property='#{OPEN_GRAPH[:url]}']/@content")

        # try other tags
        images += page.search("link[@rel='image_src']/@href").map(&:value)
        name = page.search("//meta[@itemprop='name']/@content") if name.blank?
        name = page.search("//meta[@name='title']/@content") if name.blank?
        #url = page.canonical_uri if url.blank?

        # last resort...
        images = page.image_urls if images.flatten!.empty? rescue nil # can't get images from Amazon for some reason
        price = get_price(page) if price.blank?
        name = get_name(page) if name.blank?
        brand = get_brand(page) if brand.blank?

        return { brand: brand.to_s, retailer: url.split('/')[2], name: name.to_s, price: price.to_s.to_f, images: images, description: description.to_s, url: url.to_s }
      end
    rescue => ex
      puts ex.message
      puts ex.backtrace
      "Error: #{ex.message}"
    end
  end

  def get_price(page)
    PRICE_IDENTIFIERS.each do |field|
      price_field = page.search(field).first
      price = price_field.text if price_field.present?
      if price.present?
        return price.match(/\d[\d.,]*/).to_s.gsub(/,/,'')
      end
    end
    price ||= page.body.match(/\$\d*\,*\d*\.\d+/) # try stricter regex first
    price ||= page.body.match(/\$\d[\d.,]*/)
    price = price.to_s.match(/\d[\d.,]*/).to_s.gsub(/,/,'')
  end

  def get_name(page)
    ITEM_IDENTIFIERS.each do |field|
      item_field = page.search(field).first
      name = item_field.text if item_field.present?
      return name.strip if name.present?
    end
    nil
  end

  def get_brand(page)
    BRAND_IDENTIFIERS.each do |field|
      brand_field = page.search(field).first
      brand = brand_field.text if brand_field.present?
      return brand.strip if brand.present?
    end
    nil
  end

  UPPER = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  LOWER = 'abcdefghijklmnopqrstuvwxyz'

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
    xpaths = []
    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Mozilla'
    begin
      agent.get(post[:url]) do |page|

        puts "tag_has_only_brand(page, %w{h1 h2 h3 span}, #{post[:brand]})"
        has_only_brand = tag_has_only_brand(page, %w{h1 h2 h3 span}, post[:brand])
        printNode(has_only_brand)
        has_only_brand.each {|node| xpaths << buildXpath(node)} if has_only_brand

        puts "tag_starts_with_brand_contains_name(page, %w{h1 h2 h3 span}, #{post[:brand]}, #{post[:name]})"
        starts_with_brand_contains_name = tag_starts_with_brand_contains_name(page, %w{h1 h2 h3 span}, post[:brand], post[:name])
        printNode(starts_with_brand_contains_name)
        starts_with_brand_contains_name.each {|node| xpaths << buildXpath(node)} if starts_with_brand_contains_name

        puts "tag_starts_with_brand(page, %w{h1 h2 h3 span}, #{post[:brand]})"
        starts_with_brand = tag_starts_with_brand(page, %w{h1 h2 h3 span}, post[:brand])
        printNode(starts_with_brand)
        starts_with_brand.each {|node| xpaths << buildXpath(node)} if starts_with_brand

        puts "text_nodes_for_brand(page,  #{post[:brand]})"
        text_nodes_for_brand = text_nodes_for_brand(page, post[:brand])
        printNode(text_nodes_for_brand)
        text_nodes_for_brand.each {|node| xpaths << buildXpath(node)} if text_nodes_for_brand
      end
    rescue => ex
      puts ex.message
      puts ex.backtrace
    end
    xpathMap = Hash.new
    xpaths.each do |xpath|
      retailer = post[:url].split('/')[2]
      xpathMap[retailer] = xpath
    end
    xpathMap

  end

  private

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
      node.attributes.each { |attr,value| xpath += "@#{attr}='#{value}'"}
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
      return node if !node.blank? && node.length == 1
    end
    nil
  end
  
  def tag_starts_with_brand(page, tags, brand)
    tags.each do |tag|
      node = page.parser.xpath("//#{tag}[starts-with(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{brand.downcase}')]")
      return node if !node.blank? && node.length == 1
    end
    nil
  end
  
  def tag_starts_with_brand_contains_name(page, tags, brand, name)
    %w{h1 h2 h3 span}.each do |tag|
      node = page.parser.xpath("//#{tag}[starts-with(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{brand.downcase}')]")
      if node
        node = page.parser.xpath("//#{tag}[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),\""+name.downcase+"\")]")
        return node if !node.blank? && node.length == 1
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
      {brand: 'miss me jeans', name: "Miss Me Jeans Fleur-de-Lis Bermuda Denim Shorts", url:'http://www.dillards.com/product/Miss-Me-Jeans-FleurdeLis-Bermuda-Denim-Shorts_301_-1_301_503199762'}
      #'http://fashionbug.lanebryant.com/shoes/boots/13833c5116/index.cat?intid=LPxSH060312xL4',
      #'http://oldnavy.gap.com/browse/product.do?cid=82576&vid=1&pid=106420',
      #'http://www.getheavenly.com/Co-Sheer-Stroke-Blouse-Orange/dp/B0074W34SC',
      #'http://www.spiegel.com/long-asymmetrical-dress.html',
      #'http://www.modcloth.com/shop/blouses/coach-tour-top-in-sand'
      #http://www1.bloomingdales.com/shop/product/theodora-callum-flats-primaballet-with-ankle-strap?ID=596838&CategoryID=17367#fn=spp%3D1%26ppp%3D96%26sp%3D1%26rid%3D19

    ]
    @sites.each do |post|
      p post
      xpathsMap = parser_audit(post)

    end
    xpathsMap.each do |url, xpath|
      puts "url: #{url} xpath: #{xpath}"
    end
  end
end
