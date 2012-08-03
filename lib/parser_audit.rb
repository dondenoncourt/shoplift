=begin documentation
When a user clicks the bookmarlet, the parser attempts to get brand, name, price, and description
The popup then presents those for modification
If the user modifies brand, name, or price, the parser audit routine is invoked to attempt to find
an xpath for that retail site.

For brand, the following is used to find an xpath for an h1, h2, h3, or span tag whose text:
1) contains ONLY the user-keyed brand
2) contains the user-keyed brand anywhere
3) starts with the user-keyed brand
Otherwise look for any tag that contains ONLY the user-keyed brand
Note, the xpath is saved only if there is one tag that matches the user-keyed brand

For price, the following is used to find an xpath for an h1, h2, h3, or span tag whose text:
1) contains ONLY the user-keyed price
2) contains the user-keyed price anywhere
Note, the xpath is saved only if there is one tag that matches the user-keyed price

For name, the following is used to find an xpath for an h1, h2, h3, or span tag whose text:
1) contains ONLY the user-keyed name
2) contains the user-keyed name anywhere
Note, the xpath is saved only if there is one tag that matches the user-keyed name

Note that m.ziray suggest a rating, which is planned to be added as we refine the learning parser

=end

include Parser
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
    agent.user_agent_alias = 'Windows Mozilla'
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
        if post_params[:parsed_name] != post_params[:name]
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
    %w{h1 h2 h3 span div}.each do |tag|
      node = page.parser.xpath("//#{tag}[contains(text(),'#{value}')]")
      node = page.parser.xpath("//#{tag}[text()='#{value.gsub(/\$/,'')}']") if !node
      return buildXpath(page, node[0], __method__) if node.length > 0
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

  # http://stackoverflow.com/questions/2279513/how-can-i-create-a-nokogiri-case-insensitive-xpath-selector
  def case_insensitive_equals(node_set, str_to_match)
    node_set.find_all {|node| node.to_s.downcase == str_to_match.to_s.downcase }
  end

end
