class ApplicationController < ActionController::Base
  protect_from_forgery
  # Return 404 when record is not found
  rescue_from ActiveRecord::RecordNotFound, :with => :render_active_record_error
 
  # Fetch all Room objects with boundaries
  #
  # * *Args*    :
  #   - :status -> HTTP status code
  #   - :content -> String to be returned
  #
 def render_error(http_status_code = params[:status], content = params[:content])
    if http_status_code.blank?
      http_status_code = 404
    end
    
    if content.blank?
      case http_status_code
        when 300
          content = "Multiple Choices" 
        when 301
          content = "Moved Permanently"
        when 304
          content = "Not Modified"
        when 307
          content = "Temporary Redirect"
        when 400
          content = "Bad Request"  
        when 401
          content = "Unauthorized"
        when 403
          content = "Forbidden"
        when 404
          content = "Not Found"
        when 405
          content = "Method Not Allowed"
        when 406
          content = "Not Acceptable" 
        when 410
          content = "Gone"
        when 500
          content = "Internal Server Error"
        # else
          # content = "Not Found"
      end  
    end
    render :json => "#{ http_status_code } #{ content }", :status => http_status_code
  end
  
  # Render 404 error when no record founds
  #
  # * *Args*    :
  #   - void
  #
  def render_active_record_error
    render :json => "404 Not Found", :status => 404
  end
  
  # Fetch all Room objects with boundaries
  #
  # * *Args*    :
  #   - :object -> Instance object with errors
  #   - :notiuce -> String to be returned
  #
  def return_error_messages(object,notice = "")
    object.errors.full_messages.each do |k, v|
      notice << " | #{k} #{v} "
    end
    return render_error(406,notice)  
  end
 
  private
      def after_sign_up_path_for(resource)
        page_follow_interests_path
      end
end
