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
  BRAND_IDENTIFIERS = %w(.brandLink .header-logo #logo)
  ITEM_IDENTIFIERS = %w(.product-name h1 h2 #btAsinTitle)
  PRICE_IDENTIFIERS = %w(#actualPriceValue .priceLarge .select-sale-single .price-single .priceSale .offer-price .cat-glo-tex-saleP .cat-pro-price .price)

  # TODO maybe...
  # some things from removed parsing in bookmarklet.js.erb
  #
  #// See if we have a price in the description or title
  #// Grab the title from meta tag if not already set
  #// Grab description from meta tag if not set already
  #// Use the referrer for url

  # bookmarklet.js.erb still has parsing for keywords/tags that ought to be in here...
  def parse(url)
    agent = Mechanize.new
    agent.user_agent_alias = 'Windows Mozilla'
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

end
