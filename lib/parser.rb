=begin documentation
The parser takes a URL and returns an map of brand, item name, and price
It contains relatively static code that uses very common XHTML id attribute values to retreive brand/name/price.
But it also uses xpaths from a table (called xpaths) to search for 

1) Use open graph (meta tags with standardized identifiers) to attempt to get:
images, name, and description

2) use other, relatively standard, meta tages to get:
images and name

3) use xpaths rows specific to the retailer to get:
brand, price, and name
Note, if there are multiple xpaths for price, the parser uses the smallest value
brand and name, on the otherhand, uses the first value that is retrieved.

4) use common hard-coded tags and tag attributes to get:
brand, price, and name

5) use image tag urls to get:
images

=end

module Parser

  REGISTERED_TRADEMARK = "\u00AE"

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
  ITEM_IDENTIFIERS = %w(#btAsinTitle .product-name h1 h2 )
  PRICE_IDENTIFIERS = %w(#actualPriceValue .priceLarge .select-sale-single .price-single .priceSale .offer-price .cat-glo-tex-saleP .cat-pro-price .price)

  # TODO maybe...
  #// See if we have a price in the description or title
  #// Grab the title from meta tag if not already set
  #// Grab description from meta tag if not set already
  # brand, if none is found, maybe the retailer is the brand?

  # bookmarklet.js.erb still has parsing for keywords/tags that ought to be in here...
  def parse(url)
    retailer = url.split('/')[2]
    agent = Mechanize.new
    #agent.user_agent_alias = 'Windows Mozilla'
    begin
      agent.get(url) do |page|
        images = []
        # try Open Graph first
        images << page.search("//meta[@property='#{OPEN_GRAPH[:image]}']/@content").map(&:value)
        name = page.search("//meta[@property='#{OPEN_GRAPH[:name]}']/@content")
        description = page.search("//meta[@property='#{OPEN_GRAPH[:description]}']/@content")

        images += page.search("link[@rel='image_src']/@href").map(&:value)
        images = page.image_urls if images.flatten!.empty? rescue nil # can't get images from Amazon for some reason

        price = get_price(page, retailer) if price.blank?
        name = get_name(page, retailer) if name.blank?
        name = page.search("//meta[@itemprop='name']/@content") if name.blank?
        name = page.search("//meta[@name='title']/@content") if name.blank?

        name = name.to_s.gsub(/Amazon.com:/, '') if name

        brand = get_brand(page, retailer)

        # strip brand off item name prefix and remove slash anything else
        name = name.to_s.gsub(brand.to_s, '').gsub(/^\s*/,'').gsub(/\|.*/,'')

        return { brand: brand.to_s, retailer: url.split('/')[2], name: name.to_s, price: price.to_s.to_d, images: images, description: description.to_s, url: url.to_s }
      end
    rescue => ex
      Rails.logger.error ex.message
      Rails.logger.error ex.backtrace
      "Error: #{ex.message}"
      return { brand: 'invalid URL', retailer: url.split('/')[2], name: 'invalid URL', price: '', images: nil, description: '', url: 'invalid URL' }
    end
  end

  def get_price(page, retailer)
    xpathPrices = []
    # if multiple xpaths for price exist, get all of them then return the lowest
    xpaths = Xpath.find_all_by_retailer(retailer, :conditions => "price IS NOT NULL")
    xpaths.each do |xpath|
      node = page.parser.xpath(xpath.price)
      begin
        price = BigDecimal(node[0].to_s.gsub(/[^\d.]/, ''))
        xpathPrices << price if price > 0
      rescue
        Rails.logger.error "thought we had a price but it could not be converted to a big decimal"
      end
    end

    if xpathPrices.length > 0
      return xpathPrices.sort[0]
    end


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

  def get_name(page, retailer)
    name = nil
    xpaths = Xpath.find_all_by_retailer(retailer, :conditions => "name IS NOT NULL")
    xpaths.each do |xpath|
      node = page.parser.xpath(xpath.name)
      Rails.logger.debug "get_name by #{xpath.name}"
      if node
        Rails.logger.debug "found name node: #{node} = page.parser.xpath(#{xpath.name})"
        name = node[0].text
        break
      end
    end

    return name.gsub(/\$\d*\.*\d*/,'') if name

    ITEM_IDENTIFIERS.each do |field|
      item_field = page.search(field).first
      name = item_field.text if item_field.present?
      return name.strip if name.present?
    end
    nil
  end

  def get_brand(page, retailer)
    brand = nil
    xpaths = Xpath.find_all_by_retailer(retailer, :conditions => "brand IS NOT NULL")
    xpaths.each do |xpath|
      node = page.parser.xpath(xpath.brand)
      brand = find_brand_in_db(node)
      Rails.logger.debug "#{brand} brand found by #{xpath.brand}" if brand
      break if brand
    end
    return brand.strip if brand.present?
    #if !brand           #use of registered trademark needs more testing
      #reg = page.body.match(/>.*&reg;/)
      #Rails.logger.debug "#{reg} brand found by registered trademark" if reg
      #return reg.to_s.gsub(/>/,'').gsub(/&reg;/, REGISTERED_TRADEMARK) if reg
    #end
    if !brand
        brand = page.search("//meta[@property='#{OPEN_GRAPH[:brand]}']/@content")
        Rails.logger.debug "#{brand} brand found by //meta[@property='#{OPEN_GRAPH[:brand]}']/@content" if brand
    end
    if !brand
      BRAND_IDENTIFIERS.each do |field|
        brand_field = page.search(field).first
        brand = brand_field.text if brand_field.present?
        Rails.logger.debug "#{brand} brand found by BRAND_IDENTIFIERS[#{field}]" if brand
        return brand.strip if brand.present?
      end
    end
    brand
  end

  def find_brand_in_db(node)
    text = ''
    node.children.each { |node| text << node.text+' '}
    text = text.gsub(/^\s+/, '')
    text.split(' ').size().downto(1).each do |words|
      first_words = first_x_words(text, words)
      #brand = Brand.find_by_name(first_words)
      brand = Brand.find(:first, :conditions => [ "lower(name) = ?", first_words.downcase ])
      return first_words if brand
    end
    text.split(' ').size().downto(1).each do |words|
      last_words = last_x_words(text, words)
      brand = Brand.find_by_name(last_words)
      return last_words if brand
    end
    nil
  end


  def first_x_words(str,n=10)
    str.split(' ')[0,n].inject{|sum,word| sum + ' ' + word}
  end

  def last_x_words(str,n=10)
    words = str.split(' ').size()
    str.split(' ')[n-1, words-1].inject{|sum,word| sum + ' ' + word}
  end

end
