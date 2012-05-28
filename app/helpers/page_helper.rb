module PageHelper
  def full_title(page_title)
    base_title = "Home"
    if page_title.empty?
      base_title
    else
      "#{page_title}"
    end
  end

  def pageless(total_pages, url=nil, container=nil)
    opts = {
      :totalPages => total_pages,
      :url        => url,
      :loaderMsg  => 'Loading more results'
    }

    container && opts[:container] ||= container

    javascript_tag("$('#results').pageless(#{opts.to_json});")
  end

  # Devise helpers for login form
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
