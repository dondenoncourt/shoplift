class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in @user
      redirect_to @user.is_following_enough? ? root_path : shoplifters_path
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    @user = User.find_for_twitter_oauth(request.env['omniauth.auth'], params)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Twitter'
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.failure', kind: 'Twitter', reason: 'User not found'
      redirect_to new_user_session_path
    end
  end

end
