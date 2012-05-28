class CustomFailure < Devise::FailureApp
  def redirect_url
    root_url(:login_failed => true)
  end

  def respond
    if http_auth?
      http_auth
    else
      params
      redirect
    end
  end
end