=begin documentation
When a user clicks the bookmarlet, the parser attempts to get brand, name, price, and description
The popup then presents those for modification
If the user modifies brand, name, or price, the parser audit routine is invoked to "learn"
the xpath for the specific retail site using the value keyed by the user.

For brand, the following is used to find an xpath for a discrete set of tags (such as h1, h2, h3, span) whose text:
1) contains ONLY the user-keyed brand
2) starts with the user-keyed brand and contains the item name
3) starts with the user-keyed brand
4) contains the user-keyed brand anywhere
n) Otherwise look for any tag that contains ONLY the user-keyed brand
Note, the xpath is saved only if there is one xpath that matches the user-keyed brand

For price, the following is used to find an xpath for a discrete set of tags whose text:
1) contains ONLY the user-keyed price
2) contains the user-keyed price anywhere in its text
Note, the xpath is saved only if there is one tag that matches the user-keyed price

For item name, the following is used to find an xpath for a discrete set of tags whose  text:
1) contains ONLY the user-keyed name
2) starts with the user-keyed name
2) contains the user-keyed name anywhere in its text
n) otherwise look for any tag that contains the user-keyed name
Note, the xpath is saved only if there is one tag that matches the user-keyed name


General note:
The final xpath is reduced to be as simple as possible so it may be used for page variants from that retail site

=end

module ParserAudit

  # Add log for issues for humans to review
  #   one area of concern is user changing when there already is "learned" data
  #
  # handle brand being in the prefix of the item name
  #     if brand changed and the new brand is in the item name, add a regex?
  #
  def parser_audit(post_params)
    xpaths = Hash.new
    agent = Mechanize.new
    #agent.user_agent_alias = 'Windows Mozilla'
    begin
      agent.get(post_params[:url]) do |page|
        if post_params[:brand]
          Rails.logger.debug "looking for brand "+post_params[:brand]
          xpath = get_brand_xpath(page, post_params)
          xpaths[:brand] = xpath if xpath
        end
        if post_params[:price]
          Rails.logger.debug "looking for price "+post_params[:price]
          xpath = get_price_xpath(page, post_params[:price])
          xpaths[:price] = xpath if xpath
        end
        if post_params[:name] && post_params[:parsed_name] != post_params[:name]
          Rails.logger.debug "looking for name "+post_params[:name]
          xpath = get_name_xpath(page, post_params[:name])
          xpaths[:name] = xpath if xpath
        end

      end
    rescue => ex
      puts ex.message
      puts ex.backtrace
    end
    # if found by retailer and attribute (brand|name|price), no need to update
    # else if found by retailer and attribute is null, set attribute
    # otherwise add a new xpath
    xpaths.each do |key, value|
      if Xpath.where("retailer = ? and #{key.to_sym} = ?", post_params[:retailer], value).length == 0
        xpath_row = Xpath.find_by_retailer(post_params[:retailer], :conditions => "#{key.to_sym} IS NULL")
        if xpath_row
          xpath_row[key.to_sym] = value
          xpath_row.save
        else
          Xpath.create({retailer: post_params[:retailer], key.to_sym => value})
        end
      end
    end

    xpaths

  end

  private

  def get_price_xpath(page, value)
    value = value.gsub(/\$/,'')
    # try with/without the doller, and with and without the cents
    ["$#{value}", value, "$#{value[/\d*\./]}", value[/\d*\./] ].each do |price|
      %w{h1 h2 h3 span div strong span p}.each do |tag|
        node = page.parser.xpath("//#{tag}[contains(text(),'#{price}')]")
        node = page.parser.xpath("//#{tag}[contains(text()[last()],'#{price}')]") if node.length == 0
        return buildXpath(page, node[0], __method__) if node.length > 0
      end
    end
    nil
  end

  def get_name_xpath(page, value)
    node = tag_has_only_text(page, %w{title h1 h2 h3 span div}, value)
    Rails.logger.debug "#{node} name tag found by tag_has_only_name" if node
    return buildXpath(page, node[0], __method__) if node

    node = tag_starts_with_text(page, %w{title h1 h2 h3 span div}, value)
    Rails.logger.debug "#{node} name tag found by tag_starts_with_text" if node
    return buildXpath(page, node[0], __method__) if node

    node = tag_contains_text(page, %w{title h1 h2 h3 span div}, value)
    Rails.logger.debug "#{node} name tag found by tag_contains_text" if node
    return buildXpath(page, node[0], __method__) if node

    node = text_nodes_for_text(page, value)
    Rails.logger.debug "#{node} name tag found by text_nodes_for_text" if node
    return buildXpath(page, node[0], __method__) if node
    nil
  end

  def get_brand_xpath(page, post_params)
    node = tag_has_only_text(page, %w{h1 h2 h3 span div}, post_params[:brand])
    Rails.logger.debug "#{node} brand tag found by tag_has_only_text" if node
    return buildXpath(page, node[0], __method__) if node

    node = tag_starts_with_brand_contains_name(page, %w{h1 h2 h3 span div}, post_params[:brand], post_params[:name])
    Rails.logger.debug "#{node} brand tag found by tag_starts_with_brand_contains_name" if node
    return buildXpath(page, node[0], __method__) if node

    node = tag_starts_with_text(page, %w{h1 h2 h3 span div}, post_params[:brand])
    Rails.logger.debug "#{node} brand tag found by tag_starts_with_text" if node
    return buildXpath(page, node[0], __method__) if node

    node = tag_contains_text(page, %w{h1 h2 h3 span div}, post_params[:brand])
    Rails.logger.debug "#{node} brand tag found by tag_contains_text" if node
    return buildXpath(page, node[0], __method__) if node

    node = text_nodes_for_text(page, post_params[:brand])
    Rails.logger.debug "#{node} brand tag found by text_nodes_for_brand" if node
    return buildXpath(page, node[0], __method__) if node
    nil
  end

  def printNode(node, method)
    if !node.blank?
      Rails.logger.debug "#{method} found #{node.length.to_s}: #{node.to_s.gsub(/\s\s/, ' ')}"
      Rails.logger.debug "node.path: #{node[0].path()}"
    end
  end

  def buildXpath(page, node, method)
    if node.attributes.length > 0
      xpath = "//#{node.name}"
      # for price only, use the full path
      if method.to_s.include? "_price_"
        xpath = '/'+node.path()
      end
      attributes = ''
      attributes += '['
      node.attributes.each_with_index do |(attr,value), idx|
        attributes += " and " if idx > 0
        attributes += "@#{attr}='#{value}'"
      end
      attributes += ']'
      xpath += attributes
      if !method.to_s.include? "_price_"
        if page.parser.xpath(xpath).length > 1
          xpath = '/'+node.path()+attributes
        end
      end
    else # if no attributes, use full path
      xpath = '/'+node.path()
    end
    xpath
  end

  def regex(page, str) 
    page.body.match /#{str}/
  end

  def tag_has_only_text(page, tags, text)
    tags.each do |tag|
      node = page.parser.xpath("//#{tag}[translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = '#{text.downcase}']")
      if !node.blank? && node.length == 1
        printNode(node, __method__)
        return node
      end
    end
    nil
  end
  
  def tag_starts_with_text(page, tags, text)
    tags.each do |tag|
      node = page.parser.xpath("//#{tag}[starts-with(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{text.downcase}')]")
      if !node.blank? && node.length == 1
        printNode(node, __method__)
        return node
      end
    end
    nil
  end
  
  def tag_contains_text(page, tags, text)
    tags.each do |tag|
      node = page.parser.xpath("//#{tag}[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{text.downcase}')]")
      if !node.blank? && node.length == 1
        printNode(node, __method__)
        return node
      end
    end
    nil
  end
  
  def tag_starts_with_brand_contains_name(page, tags, brand, name)
    %w{h1 h2 h3 span div}.each do |tag|
      node = page.parser.xpath("//#{tag}[starts-with(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{brand.downcase}')]")
      if !node.blank?
        #node = page.parser.xpath("/#{tag}[contains(translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),\""+name.downcase+"\")]")
        #if !node.blank? && node.length == 1
        goodNode = nil
        [0..(node.length-1)].each do |idx|
          if node && node[idx].text.downcase =~ /#{brand.downcase}.*#{name.downcase}/
            printNode(node[idx], __method__)
            goodNode = node[idx]
            break
          end
        end
        return goodNode
      end
    end
    nil
  end

  def text_nodes_for_text(page, text)
    begin
      node = page.parser.xpath("//*[translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = '#{text.downcase}']")
      return node if !node.blank? && node.length == 1
    rescue
      puts "       Note: could not translate text to lowercase, using standard case sensitive xpath..."
      page.parser.xpath("//*[text()='#{text.downcase}']")
    end
  end

end
